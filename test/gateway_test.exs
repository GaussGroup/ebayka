defmodule Ebayka.GatewayTest do
  use ExUnit.Case
  doctest Ebayka

  @request {:Item, nil, [ {:Title, nil, "Ebay Product Title"} ] }

  def trim_xml(string), do: string |> String.replace(~r/\r|\n|\t|\s/, "")

  test "prepare body" do
    assert(Ebayka.Gateway.prepare_body("AddItem", @request) |> trim_xml ==
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
end
