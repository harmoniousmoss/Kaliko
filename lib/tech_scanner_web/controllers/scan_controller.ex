defmodule TechScannerWeb.ScanController do
  use TechScannerWeb, :controller

  def scan(conn, %{"domain" => domain}) do
    case scan_domain(domain) do
      {:ok, result} ->
        json(conn, result)

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: reason})
    end
  end

  def scan(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "Missing required parameter: domain"})
  end

  defp scan_domain(domain) do
    domain = normalize_domain(domain)

    case HTTPoison.get(domain, [], timeout: 15_000, recv_timeout: 15_000) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body, headers: headers}} ->
        technologies = detect_technologies(body, headers)

        result = %{
          domain: domain,
          technologies: technologies,
          scan_time: DateTime.utc_now() |> DateTime.to_iso8601()
        }

        {:ok, result}

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "HTTP #{status_code}: Unable to fetch website"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Request failed: #{inspect(reason)}"}
    end
  end

  defp normalize_domain(domain) do
    domain = String.trim(domain)

    cond do
      String.starts_with?(domain, "http://") or String.starts_with?(domain, "https://") ->
        domain

      true ->
        "https://#{domain}"
    end
  end

  defp detect_technologies(body, headers) do
    TechScanner.TechDetector.detect_technologies(body, headers)
  end
end