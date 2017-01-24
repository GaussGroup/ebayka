defmodule Ebayka.StubGateway do
  def make_request("AddItem", {:Item, nil, [ {:Title, nil, "Ebay Product Title"} ] }) do
    {:ok,
      %HTTPoison.Response{
        status_code: 200,
        body: "<?xml version=\"1.0\" encoding=\"utf-8\"?>
              <AddItemResponse xmlns=\"urn:ebay:apis:eBLBaseComponents\">
                <Ack>Success</Ack>
                <ItemID>110185886058</ItemID>
              </AddItemResponse>"
      }
    }
  end

  def make_request("VerifyAddItem", "<Request></Request>") do
    {:ok,
      %HTTPoison.Response{
        status_code: 200,
        body: "<?xml version=\"1.0\" encoding=\"utf-8\"?>
              <VerifyAddItemResponse xmlns=\"urn:ebay:apis:eBLBaseComponents\">
                <Ack>Failure</Ack>
                <Errors>
                  <LongMessage>The category selected is not a leaf category.</LongMessage>
                </Errors>
                <Errors>
                  <LongMessage>Please enter a valid price for your item (e.g. $0.01).</LongMessage>
                </Errors>
              </VerifyAddItemResponse>"
      }
    }
  end

    def make_request("VerifyAddItem", _body) do
      {:ok,
        %HTTPoison.Response{
          status_code: 200,
          body: "<?xml version=\"1.0\" encoding=\"utf-8\"?>
                <VerifyAddItemResponse xmlns=\"urn:ebay:apis:eBLBaseComponents\">
                  <Ack>Success</Ack>
                </VerifyAddItemResponse>"
        }
      }
    end
end
