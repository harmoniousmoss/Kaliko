defmodule TechScannerWeb.ScanJSON do
  def scan(%{result: result}) do
    result
  end

  def error(%{error: error}) do
    %{error: error}
  end
end