use Mix.Config

config :ebayka, Ebayka,
  url: "url",
  app_id:  "ebay_app_id",
  dev_id:  "ebay_dev_id",
  cert_id: "ebay_cert_id",
  auth_token: "ebay_auth_token",
  pay_pal_email: "pay_pal_email@yourcompany.com",
  site_id: 0,
  dispatch_time_max: 3,
  postal_code: 95125,
  return_description: "If you are not satisfied, return the book for refund.",
  level: 989,
  gateway: Ebayka.StubGateway
