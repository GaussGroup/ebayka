defmodule Ebayka.RequestTest do
  alias Ebayka.Request
  use ExUnit.Case, async: false

  @request {:Item, nil, [ {:Title, nil, "Ebay Product Title"} ] }

  test "#make when name is nil" do
    assert_raise Ebayka.RequestError, "You should set name of Ebay method", fn ->
      Request.make(nil, @request)
    end
  end

  test "#make when body is nil" do
    assert_raise Ebayka.RequestError, "You should set body of Ebay method", fn ->
      Request.make("AddItem", nil)
    end
  end

  test "#make" do
    assert {:ok, %HTTPoison.Response{ status_code: 200, body: _body }} = Request.make("AddItem", @request)
  end
end
