# Kaliko - Web technology detection API

Kaliko is a web technology detection API built with Phoenix/Elixir that analyzes websites to identify the technologies they use.

## Features

- Synchronous website scanning
- Technology detection (frameworks, libraries, servers, etc.)
- RESTful API endpoint
- JSON response format

## Supported Technologies

**Web Frameworks:**
- Ruby on Rails
- Laravel (PHP)
- ASP.NET
- Express.js
- Next.js
- Spring Framework (Java)

**CMS:**
- WordPress
- Drupal
- Joomla

**JavaScript Libraries:**
- React
- jQuery

**CSS Frameworks:**
- Bootstrap

**Web Servers:**
- Nginx
- Apache
- Caddy

**Programming Languages:**
- PHP
- Java
- Go

**CDN/Services:**
- Cloudflare
- Google APIs
- jsDelivr
- unpkg

## API Usage

**Scan a website:**
```bash
POST /api/scan
Content-Type: application/json

{
  "domain": "https://example.com"
}
```

**Response:**
```json
{
  "domain": "https://example.com",
  "technologies": [
    {"name": "WordPress", "category": "CMS", "confidence": "high"},
    {"name": "Bootstrap", "category": "CSS framework", "confidence": "medium"},
    {"name": "Cloudflare", "category": "CDN", "confidence": "high"}
  ],
  "scan_time": "2025-09-18T10:30:00Z"
}
```

## Example Tests

**WordPress.com:**
```bash
curl -X POST http://localhost:4000/api/scan \
  -H "Content-Type: application/json" \
  -d '{"domain": "wordpress.com"}'
```
Result: WordPress + Nginx detected

**Laravel.com:**
```bash
curl -X POST http://localhost:4000/api/scan \
  -H "Content-Type: application/json" \
  -d '{"domain": "laravel.com"}'
```
Result: Laravel + Bootstrap + Cloudflare detected

**Next.js.org:**
```bash
curl -X POST http://localhost:4000/api/scan \
  -H "Content-Type: application/json" \
  -d '{"domain": "nextjs.org"}'
```
Result: Next.js detected

**GitHub.com:**
```bash
curl -X POST http://localhost:4000/api/scan \
  -H "Content-Type: application/json" \
  -d '{"domain": "github.com"}'
```
Result: Bootstrap detected

## Development

**Setup:**
```bash
mix deps.get
mix phx.server
```

Visit [`localhost:4000`](http://localhost:4000) from your browser.

## Tech Stack

- **Phoenix** - Web framework
- **HTTPoison** - HTTP client for website requests
- **Floki** - HTML parsing and analysis
- **Jason** - JSON encoding/decoding
