defmodule Ebayka.ResponseTest do
  alias Ebayka.Response
  use ExUnit.Case, async: false

  @body """
<?xml version=\"1.0\" encoding=\"utf-8\"?>
<VerifyAddItemResponse xmlns=\"urn:ebay:apis:eBLBaseComponents\">
<Ack>Failure</Ack>
<Errors>
  <ShortMessage>The category selected is not a leaf category.</ShortMessage>
</Errors>
<Errors>
  <ShortMessage>Please enter a valid price for your item (e.g. $0.01).</ShortMessage>
</Errors>
<Errors>
  <ErrorCode>1047</ErrorCode>
</Errors>
</VerifyAddItemResponse>
"""

  test "parse Ebay response" do
    response = Response.build(@body)

    assert response.ack == "Failure"
    assert response.errors == ["The category selected is not a leaf category.", "Please enter a valid price for your item (e.g. $0.01)."]
    assert response.code == "1047"
  end
end
