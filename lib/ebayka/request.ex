defmodule Ebayka.Request do
  alias Ebayka.Gateway

  def make(nil, _body), do: raise "You should set name of Ebay method"
  def make(_name, nil), do: raise "You should set body of Ebay method"

  def make(name, body), do: Gateway.make_request(name, body)
end
