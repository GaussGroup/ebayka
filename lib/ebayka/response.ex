defmodule Ebayka.Response do
  import SweetXml

  @schema [
    ack: ~x"//*//Ack/text()"s,
    errors: ~x"//*//Errors//LongMessage/text()"ls,
    code: ~x"//*//Errors//ErrorCode/text()"s
  ]

  def build(body) do
    body |> xmap(@schema)
  end
end
