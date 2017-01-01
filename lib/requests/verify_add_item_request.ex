defmodule Ebayka.VerifyAddItemRequest do
  import XmlBuilder

  def serialize(item) do
    item |> attributes
  end

  defp attributes(item) do
    element(:Item, item_id_nodes(item) ++ [
      element(:Title, item.title),
      element(:Description, item.description),
      element(:PrimaryCategory, [ element(:CategoryID, item.category_id) ]),
      element(:StartPrice, DecimalSerializer.serialize(item.price)),
      element(:CategoryMappingAllowed, true),
      element(:ConditionID, 4000),
      element(:Country, "US"),
      element(:Currency, "USD"),
      element(:DispatchTimeMax, Application.get_env(:ebayka)[:dispatch_time_max]),
      element(:ListingDuration, "GTC"),
      element(:ListingType, "FixedPriceItem"),
      element(:PaymentMethods, "PayPal"),
      element(:PayPalEmailAddress, Application.get_env(:ebayka)[:pay_pal_email]),
      element(:PictureDetails, [
        element(:PictureURL, item.picture_url)
      ]),
      element(:PostalCode, Application.get_env(:ebayka)[:postal_code]),
      element(:Quantity, item.quantity),
      element(:ReturnPolicy, [
        element(:ReturnsAcceptedOption, "ReturnsAccepted"),
        element(:RefundOption, "MoneyBack"),
        element(:ReturnsWithinOption, "Days_30"),
        element(:Description, Application.get_env(:ebayka)[:return_description]),
        element(:ShippingCostPaidByOption, "Buyer")
      ]),
      element(:ShippingDetails, [
        element(:ShippingType, "Flat"),
        element(:ShippingServiceOptions, [
          element(:ShippingServicePriority, 1),
          element(:ShippingService, "USPSMedia"),
          element(:ShippingServiceCost, 2.50),
          element(:ShippingServiceAdditionalCost, 2.50)
        ]),
      ]),
      element(:Site, "US")
    ])
  end

  defp item_id_nodes(%{id: id}) do
    [ element(:ItemID, id) ]
  end

  defp item_id_nodes(_) do
    []
  end
end
