defmodule TechScannerWeb.Router do
  use TechScannerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TechScannerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TechScannerWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # API routes
  scope "/api", TechScannerWeb do
    pipe_through :api

    post "/scan", ScanController, :scan
  end
end
