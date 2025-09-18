defmodule TechScanner.TechDetector do
  @moduledoc """
  Module for detecting web technologies from HTML content and HTTP headers
  """

  def detect_technologies(html_body, headers) do
    header_map = headers_to_map(headers)

    []
    |> detect_from_headers(header_map)
    |> detect_from_html(html_body)
    |> detect_from_meta_tags(html_body)
    |> detect_from_scripts(html_body)
    |> detect_from_stylesheets(html_body)
    |> Enum.uniq_by(& &1.name)
  end

  defp headers_to_map(headers) do
    headers
    |> Enum.into(%{}, fn {key, value} -> {String.downcase(key), value} end)
  end

  defp detect_from_headers(technologies, headers) do
    technologies
    |> check_server_header(headers)
    |> check_powered_by_header(headers)
    |> check_content_type(headers)
  end

  defp check_server_header(technologies, headers) do
    case Map.get(headers, "server") do
      nil -> technologies
      server ->
        cond do
          String.contains?(String.downcase(server), "nginx") ->
            [%{name: "Nginx", confidence: "high", category: "Web server"} | technologies]
          String.contains?(String.downcase(server), "apache") ->
            [%{name: "Apache", confidence: "high", category: "Web server"} | technologies]
          String.contains?(String.downcase(server), "cloudflare") ->
            [%{name: "Cloudflare", confidence: "high", category: "CDN"} | technologies]
          String.contains?(String.downcase(server), "go") ->
            [%{name: "Go", confidence: "high", category: "Programming language"} | technologies]
          String.contains?(String.downcase(server), "caddy") ->
            [%{name: "Caddy", confidence: "high", category: "Web server"}, %{name: "Go", confidence: "medium", category: "Programming language"} | technologies]
          true ->
            technologies
        end
    end
  end

  defp check_powered_by_header(technologies, headers) do
    case Map.get(headers, "x-powered-by") do
      nil -> technologies
      powered_by ->
        cond do
          String.contains?(String.downcase(powered_by), "php") ->
            [%{name: "PHP", confidence: "high", category: "Programming language"} | technologies]
          String.contains?(String.downcase(powered_by), "asp.net") ->
            [%{name: "ASP.NET", confidence: "high", category: "Web framework"} | technologies]
          String.contains?(String.downcase(powered_by), "express") ->
            [%{name: "Express.js", confidence: "high", category: "Web framework"} | technologies]
          true ->
            technologies
        end
    end
  end

  defp check_content_type(technologies, headers) do
    case Map.get(headers, "content-type") do
      nil -> technologies
      content_type ->
        if String.contains?(String.downcase(content_type), "text/html") do
          technologies
        else
          technologies
        end
    end
  end

  defp detect_from_html(technologies, html_body) do
    html_lower = String.downcase(html_body)

    technologies
    |> check_wordpress(html_lower)
    |> check_react(html_lower)
    |> check_nextjs(html_lower)
    |> check_rails(html_lower)
    |> check_laravel(html_lower)
    |> check_jquery(html_lower)
    |> check_bootstrap(html_lower)
    |> check_java_frameworks(html_lower)
  end

  defp check_wordpress(technologies, html) do
    cond do
      String.contains?(html, "wp-content") or String.contains?(html, "wordpress") ->
        [%{name: "WordPress", confidence: "high", category: "CMS"} | technologies]
      String.contains?(html, "/wp-includes/") ->
        [%{name: "WordPress", confidence: "medium", category: "CMS"} | technologies]
      true ->
        technologies
    end
  end

  defp check_react(technologies, html) do
    cond do
      String.contains?(html, "react") and String.contains?(html, "__react") ->
        [%{name: "React", confidence: "high", category: "JavaScript framework"} | technologies]
      String.contains?(html, "reactdom") ->
        [%{name: "React", confidence: "medium", category: "JavaScript framework"} | technologies]
      true ->
        technologies
    end
  end

  defp check_jquery(technologies, html) do
    cond do
      String.contains?(html, "jquery") ->
        [%{name: "jQuery", confidence: "high", category: "JavaScript library"} | technologies]
      String.contains?(html, "$(") or String.contains?(html, "jquery") ->
        [%{name: "jQuery", confidence: "medium", category: "JavaScript library"} | technologies]
      true ->
        technologies
    end
  end

  defp check_bootstrap(technologies, html) do
    cond do
      String.contains?(html, "bootstrap") ->
        [%{name: "Bootstrap", confidence: "high", category: "CSS framework"} | technologies]
      String.contains?(html, "btn-") or String.contains?(html, "col-") ->
        [%{name: "Bootstrap", confidence: "medium", category: "CSS framework"} | technologies]
      true ->
        technologies
    end
  end

  defp check_nextjs(technologies, html) do
    cond do
      String.contains?(html, "__next") or String.contains?(html, "next.js") ->
        [%{name: "Next.js", confidence: "high", category: "React framework"} | technologies]
      String.contains?(html, "_next/static") ->
        [%{name: "Next.js", confidence: "high", category: "React framework"} | technologies]
      String.contains?(html, "next/router") ->
        [%{name: "Next.js", confidence: "medium", category: "React framework"} | technologies]
      true ->
        technologies
    end
  end

  defp check_rails(technologies, html) do
    cond do
      String.contains?(html, "csrf-param") and String.contains?(html, "csrf-token") ->
        [%{name: "Ruby on Rails", confidence: "high", category: "Web framework"} | technologies]
      String.contains?(html, "rails") and String.contains?(html, "authenticity_token") ->
        [%{name: "Ruby on Rails", confidence: "high", category: "Web framework"} | technologies]
      String.contains?(html, "/assets/") and String.contains?(html, "data-turbolinks") ->
        [%{name: "Ruby on Rails", confidence: "medium", category: "Web framework"} | technologies]
      true ->
        technologies
    end
  end

  defp check_laravel(technologies, html) do
    cond do
      String.contains?(html, "laravel_session") ->
        [%{name: "Laravel", confidence: "high", category: "PHP framework"} | technologies]
      String.contains?(html, "_token") and String.contains?(html, "csrf-token") ->
        [%{name: "Laravel", confidence: "medium", category: "PHP framework"} | technologies]
      String.contains?(html, "laravel") ->
        [%{name: "Laravel", confidence: "medium", category: "PHP framework"} | technologies]
      true ->
        technologies
    end
  end

  defp check_java_frameworks(technologies, html) do
    cond do
      String.contains?(html, "jsessionid") ->
        [%{name: "Java", confidence: "high", category: "Programming language"} | technologies]
      String.contains?(html, "spring") and String.contains?(html, "mvc") ->
        [%{name: "Spring Framework", confidence: "high", category: "Java framework"} | technologies]
      String.contains?(html, "struts") ->
        [%{name: "Apache Struts", confidence: "high", category: "Java framework"} | technologies]
      String.contains?(html, "/WEB-INF/") ->
        [%{name: "Java", confidence: "medium", category: "Programming language"} | technologies]
      true ->
        technologies
    end
  end

  defp detect_from_meta_tags(technologies, html_body) do
    case Floki.parse_document(html_body) do
      {:ok, document} ->
        meta_tags = Floki.find(document, "meta")
        technologies
        |> check_generator_meta(meta_tags)
        |> check_application_name_meta(meta_tags)

      {:error, _} ->
        technologies
    end
  end

  defp check_generator_meta(technologies, meta_tags) do
    generator =
      meta_tags
      |> Enum.find_value(fn tag ->
        case Floki.attribute(tag, "name") do
          ["generator"] -> Floki.attribute(tag, "content") |> List.first()
          _ -> nil
        end
      end)

    case generator do
      nil -> technologies
      gen ->
        gen_lower = String.downcase(gen)
        cond do
          String.contains?(gen_lower, "wordpress") ->
            [%{name: "WordPress", confidence: "high", category: "CMS"} | technologies]
          String.contains?(gen_lower, "drupal") ->
            [%{name: "Drupal", confidence: "high", category: "CMS"} | technologies]
          String.contains?(gen_lower, "joomla") ->
            [%{name: "Joomla", confidence: "high", category: "CMS"} | technologies]
          String.contains?(gen_lower, "rails") ->
            [%{name: "Ruby on Rails", confidence: "high", category: "Web framework"} | technologies]
          String.contains?(gen_lower, "laravel") ->
            [%{name: "Laravel", confidence: "high", category: "PHP framework"} | technologies]
          String.contains?(gen_lower, "next.js") ->
            [%{name: "Next.js", confidence: "high", category: "React framework"} | technologies]
          true ->
            technologies
        end
    end
  end

  defp check_application_name_meta(technologies, meta_tags) do
    app_name =
      meta_tags
      |> Enum.find_value(fn tag ->
        case Floki.attribute(tag, "name") do
          ["application-name"] -> Floki.attribute(tag, "content") |> List.first()
          _ -> nil
        end
      end)

    case app_name do
      nil -> technologies
      _ -> technologies
    end
  end

  defp detect_from_scripts(technologies, html_body) do
    case Floki.parse_document(html_body) do
      {:ok, document} ->
        scripts = Floki.find(document, "script")
        technologies
        |> check_script_sources(scripts)

      {:error, _} ->
        technologies
    end
  end

  defp check_script_sources(technologies, scripts) do
    script_sources =
      scripts
      |> Enum.flat_map(fn script ->
        Floki.attribute(script, "src")
      end)
      |> Enum.join(" ")
      |> String.downcase()

    technologies
    |> check_cdn_libraries(script_sources)
  end

  defp check_cdn_libraries(technologies, sources) do
    technologies
    |> add_if_present(sources, "googleapis.com", %{name: "Google APIs", confidence: "high", category: "CDN"})
    |> add_if_present(sources, "cdnjs.cloudflare.com", %{name: "Cloudflare CDN", confidence: "high", category: "CDN"})
    |> add_if_present(sources, "unpkg.com", %{name: "unpkg CDN", confidence: "high", category: "CDN"})
    |> add_if_present(sources, "jsdelivr.net", %{name: "jsDelivr CDN", confidence: "high", category: "CDN"})
  end

  defp detect_from_stylesheets(technologies, html_body) do
    case Floki.parse_document(html_body) do
      {:ok, document} ->
        links = Floki.find(document, "link[rel=\"stylesheet\"]")
        technologies
        |> check_stylesheet_sources(links)

      {:error, _} ->
        technologies
    end
  end

  defp check_stylesheet_sources(technologies, links) do
    stylesheet_sources =
      links
      |> Enum.flat_map(fn link ->
        Floki.attribute(link, "href")
      end)
      |> Enum.join(" ")
      |> String.downcase()

    technologies
    |> add_if_present(stylesheet_sources, "bootstrap", %{name: "Bootstrap", confidence: "high", category: "CSS framework"})
    |> add_if_present(stylesheet_sources, "fontawesome", %{name: "Font Awesome", confidence: "high", category: "Font library"})
  end

  defp add_if_present(technologies, source, pattern, tech) do
    if String.contains?(source, pattern) do
      [tech | technologies]
    else
      technologies
    end
  end
end