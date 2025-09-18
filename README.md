# Kaliko

Kaliko is a web technology detection API built with Phoenix/Elixir that analyzes websites to identify the technologies they use.

## Features

- Synchronous website scanning
- Technology detection (frameworks, libraries, servers, etc.)
- RESTful API endpoint
- JSON response format

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
    {"name": "WordPress", "version": "6.3", "confidence": "high"},
    {"name": "PHP", "confidence": "medium"},
    {"name": "Apache", "confidence": "high"}
  ],
  "scan_time": "2025-09-18T10:30:00Z"
}
```

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
