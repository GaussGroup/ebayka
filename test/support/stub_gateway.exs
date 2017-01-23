defmodule Ebayka.StubGateway do
  def make_request("AddItem", {:Item, nil, [ {:Title, nil, "Ebay Product Title"} ] }) do
    {:ok,
      %HTTPoison.Response{
        status_code: 200,
        body: "<?xml version=\"1.0\" encoding=\"utf-8\"?>
               <AddItemResponse xmlns=\"urn:ebay:apis:eBLBaseComponents\">
                 <Ack>Failure</Ack>
                 <Errors>
                   <LongMessage>This Listing is a duplicate of your item: New product 2 (110185886058).</LongMessage>
                 </Errors>
               </AddItemResponse>"
      }
    }
  end
end
