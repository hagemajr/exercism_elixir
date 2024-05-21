defmodule Newsletter do
  def read_emails(path) do
    File.open!(path, [:read])
    |> IO.read(:all)
    |> String.split("\n", trim: true)
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    p = open_log(log_path)
    read_emails(emails_path)
    |> Enum.map(fn e ->
        result = send_fun.(e)
        if result == :ok do
          log_sent_email(p, e)
        end
      end)
    close_log(p)
  end
end
