defmodule Ebayka.Request do
  def make(nil, _body), do: raise(Ebayka.RequestError, message: "You should set name of Ebay method")
  def make(_name, nil), do: raise(Ebayka.RequestError, message: "You should set body of Ebay method")

  def make(name, body), do: gateway.make_request(name, body)
  def make(name, body, mapper), do: make(name, body) |> handle_make(mapper)

  defp handle_make({:ok, %HTTPoison.Response{status_code: 200, body: body}}, mapper) do
    Ebayka.Response.build(body) |> map(body, mapper)
  end
  defp handle_make(_, _), do: { :error, nil }

  defp map(%{ack: "Success"}, body, mapper), do: { :ok, mapper.build(body) }
  defp map(response, _body, _mapper), do: { :error, response }

  defp gateway, do: config[:gateway] || Ebayka.Gateway
  defp config, do: Application.get_env(:ebayka, Ebayka)
end
