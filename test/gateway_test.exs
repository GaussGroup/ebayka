defmodule Ebayka.GatewayTest do
  alias Ebayka.Gateway
  use ExUnit.Case, async: false
  import Mock

  @request {:Item, nil, [ {:Title, nil, "Ebay Product Title"} ] }

  def trim_xml(string), do: string |> String.replace(~r/\r|\n|\t|\s/, "")

  test "prepare body" do
    assert(Gateway.prepare_body("AddItem", @request) |> trim_xml ==
      "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <AddItemRequest xmlns=\"urn:ebay:apis:eBLBaseComponents\">
        <RequesterCredentials>
          <eBayAuthToken>ebay_auth_token</eBayAuthToken>
        </RequesterCredentials>
        <Item>
          <Title>Ebay Product Title</Title>
        </Item>
      </AddItemRequest>" |> trim_xml
    )
  end

  test "make request" do
    with_mock HTTPotion, [post: fn(_method, _body, _headers, _options) -> "<response></response>" end] do
      assert called Gateway.make_request("AddItem", @request)
    end
  end
end
