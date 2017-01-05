defmodule Ebayka.Request do
  alias Ebayka.Gateway

  def build(nil, _body) do
    raise "You should set name of Ebay method"
  end

  def build(_name, nil) do
    raise "You should set body of Ebay method"
  end

  def build(name, body) do
    Gateway.make_request(name, body)
  end
end
