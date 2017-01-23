defmodule Ebayka.Gateway do
  use HTTPoison.Base

  def make_request(method, body) do
    post(url, prepare_body(method, body), headers(method), options)
  end

  def prepare_body(method, body) do
    "<?xml version=\"1.0\" encoding=\"utf-8\"?>
    <#{ method }Request xmlns=\"urn:ebay:apis:eBLBaseComponents\">
      <RequesterCredentials>
        <eBayAuthToken>#{ config[:auth_token] }</eBayAuthToken>
      </RequesterCredentials>
      #{ body |> XmlBuilder.generate }
    </#{ method }Request>"
  end

  defp headers(method) do
    %{
      "Content-type" => "application/xml",
      "X-EBAY-API-CALL-NAME" => method,
      "X-EBAY-API-COMPATIBILITY-LEVEL" => config[:level],
      "X-EBAY-API-SITEID" => config[:site_id],
      "X-EBAY-API-APP-NAME" => config[:app_id],
      "X-EBAY-API-DEV-NAME" => config[:dev_id],
      "X-EBAY-API-CERT-NAME" => config[:cert_id]
    }
  end

  defp options do
    [
      connect_timeout: config[:connect_timeout] || 100_000,
      recv_timeout: config[:recv_timeout] || 100_000
    ]
  end

  defp url, do: config[:url]
  defp config, do: Application.get_env(:ebayka, Ebayka)
end
