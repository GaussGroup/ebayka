defmodule Ebayka.Request do
  def make(nil, _body), do: raise(Ebayka.RequestError, message: "You should set name of Ebay method")
  def make(_name, nil), do: raise(Ebayka.RequestError, message: "You should set body of Ebay method")

  def make(name, body), do: gateway.make_request(name, body)
  def make(name, body, response), do: make(name, body) |> handle_make(response)

  defp handle_make({:ok, %HTTPoison.Response{status_code: 200, body: body}}, response) do
    base_response = Ebayka.Response.build(body)
    if success?(base_response) do
      { :ok, response.build(body) }
    else
      { :error, response.errors }
    end
  end
  defp handle_make(_, _), do: { :error, nil }

  defp success?(%{ack: "Success"}), do: true
  defp success?(_), do: false

  defp gateway, do: config[:gateway] || Ebayka.Gateway
  defp config, do: Application.get_env(:ebayka, Ebayka)
end
