defmodule Ebayka.Response do
  import SweetXml

  @schema [
    ack: ~x"//*//Ack/text()"s,
    errors: ~x"//*//Errors//LongMessage/text()"ls,
  ]

  def build(body) do
    body |> xmap(@schema)
  end
end
