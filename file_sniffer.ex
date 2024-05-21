defmodule FileSniffer do

  @file_types %{
    "ELF" => %{extension: "exe", media_type: "application/octet-stream", signature_size: 4, binary_signature: <<0x7F, 0x45, 0x4C, 0x46>>},
    "BMP" => %{extension: "bmp", media_type: "image/bmp", signature_size: 2, binary_signature: <<0x42, 0x4D>>},
    "PNG" => %{extension: "png", media_type: "image/png", signature_size: 8, binary_signature: <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>},
    "JPG" => %{extension: "jpg", media_type: "image/jpg", signature_size: 3, binary_signature: <<0xFF, 0xD8, 0xFF>>},
    "GIF" => %{extension: "gif", media_type: "image/gif", signature_size: 3, binary_signature: <<0x47, 0x49, 0x46>>}
  }

  def type_from_extension(extension) do
    Map.new(@file_types, fn {_, v} -> {v.extension, v} end)[extension][:media_type]
  end

  def type_from_binary(file_binary) when not is_binary(file_binary), do: nil

  def type_from_binary(<<signature::binary-size(2), rest::binary>>) do
    d = Map.new(@file_types, fn {_, v} ->
      <<two_byte_signature::binary-size(2), _::binary>> = v.binary_signature
      {two_byte_signature, v}
    end)

    full_media_sig = d[signature][:binary_signature]
    sig_size = d[signature][:signature_size]
    if byte_size(signature <> rest) < sig_size do
      nil
    else
      <<full_file_sig::binary-size(sig_size), _::binary>> = signature <> rest
      if full_file_sig == full_media_sig do
        d[signature][:media_type]
      else
        nil
      end
    end
  end

  def type_from_binary(_) do
    nil
  end

  def verify(file_binary, extension) do
    if type_from_binary(file_binary) == type_from_extension(extension) and type_from_extension(extension) != nil do
      {:ok, type_from_extension(extension)}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
