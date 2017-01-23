defmodule Ebayka.RequestError do
  defexception message: "runtime error"
end

defmodule Ebayka.Request do
  def make(nil, _body), do: raise(Ebayka.RequestError, message: "You should set name of Ebay method")
  def make(_name, nil), do: raise(Ebayka.RequestError, message: "You should set body of Ebay method")

  def make(name, body), do: gateway.make_request(name, body)

  defp gateway, do: config[:gateway] || Ebayka.Gateway
  defp config, do: Application.get_env(:ebayka, Ebayka)
end
