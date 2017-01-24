defmodule Ebayka.Response do
  import SweetXml

  @schema [
    ack: ~x"//AddItemResponse//Ack/text()"s,
    errors: ~x"//AddItemResponse//Errors//LongMessage/text()"ls,
  ]

  def build(body) do
    body |> xmap(@schema)
  end
end
