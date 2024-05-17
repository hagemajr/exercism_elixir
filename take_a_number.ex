defmodule TakeANumber do
  def start() do
    spawn(fn -> loop(0) end)
  end

  defp loop(ticket_num) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, ticket_num)
        loop(ticket_num)
      {:take_a_number, sender_pid} ->
        send(sender_pid, ticket_num + 1)
        loop(ticket_num + 1)
      :stop -> ticket_num
      _ -> loop(ticket_num)
    end
  end
end

p = TakeANumber.start()

send(p, {:report_state, self()})

receive do
  ticket -> IO.puts(ticket)
end

send(p, {:take_a_number, self()})

receive do
  ticket -> IO.puts(ticket)
end

send(p, {:take_a_number, self()})

receive do
  ticket -> IO.puts(ticket)
end

send(p, {:take_a_number, self()})

receive do
  ticket -> IO.puts(ticket)
end

send(p, {:take_a_number, self()})

receive do
  ticket -> IO.puts(ticket)
end

send(p, "lskdalskdlasd")
send(p, :stop)
