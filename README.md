![Kaliko Web Technology Scanner](https://icbotbz40ngrmv6r.public.blob.vercel-storage.com/kaliko.png)

# Kaliko - Web Technology Scanner

Kaliko is a beautiful web technology detection platform built with Phoenix/Elixir that analyzes websites to identify the technologies they use. Features a stunning glassmorphism interface with emerald design, real-time scanning, and comprehensive technology detection.

## ✨ Features

### 🎨 Beautiful Modern Interface
- **Glassmorphism Design**: Stunning backdrop-blur effects with emerald gradient backgrounds
- **Animated Background**: Floating particles with tech-inspired animations
- **Clean Professional Styling**: Minimal, distraction-free scanning interface
- **Responsive Layout**: Perfect experience across all devices and screen sizes
- **Optimized Viewport**: Compact design that fits without scrolling

### 🔍 Advanced Technology Detection
- **Comprehensive Scanning**: Detects frameworks, libraries, servers, and development tools
- **Real-time Results**: Instant technology identification with confidence levels
- **Visual Feedback**: Color-coded confidence indicators and organized results grid
- **Export Functionality**: Download scan results as JSON for further analysis
- **Example Domains**: Quick-start with popular websites for testing

### 🚀 User Experience
- **One-Click Scanning**: Simple URL input with instant results
- **Interactive Examples**: Pre-loaded popular domains for quick testing
- **Clean Visual Feedback**: Technology cards with confidence levels and categories
- **Compact Results**: Scrollable results area that maintains viewport size
- **RESTful API**: Full API access for programmatic integration

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

## 🎯 Usage

### Web Interface
1. **Visit the Scanner**: Navigate to `http://localhost:4000` in your browser
2. **Enter Website URL**: Type or paste the domain you want to scan
3. **Click Scan Technologies**: Watch the real-time scanning process
4. **View Results**: See detected technologies with confidence levels
5. **Export Data**: Download results as JSON for further analysis
6. **Try Examples**: Use pre-loaded domains like GitHub, WordPress, Laravel, Next.js

### API Usage

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

## 📋 API Example Tests

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

## 🚀 Getting Started

### Prerequisites
- Elixir 1.14+ and Erlang/OTP 25+
- Phoenix Framework 1.7+

### Installation
```bash
# Clone the repository
git clone https://github.com/harmoniousmoss/kaliko.git
cd kaliko

# Install dependencies
mix deps.get

# Start the server
mix phx.server
```

Visit `http://localhost:4000` to experience the beautiful technology scanner interface!

## 🛠️ Built With

* **Backend**: [Phoenix Framework](https://phoenixframework.org/) & [Elixir](https://elixir-lang.org/)
* **Frontend**: [Tailwind CSS](https://tailwindcss.com/) with custom glassmorphism effects
* **Styling**: Advanced CSS animations, backdrop-blur, and emerald gradient themes
* **HTTP Client**: [HTTPoison](https://github.com/edgurgel/httpoison) for website requests
* **HTML Parsing**: [Floki](https://github.com/philss/floki) for content analysis
* **JSON Processing**: [Jason](https://github.com/michalmuskala/jason) for encoding/decoding

## 🏗️ Technical Highlights

- **Beautiful UI**: Modern glassmorphism design with emerald theme
- **Responsive Design**: Mobile-first approach with perfect scaling
- **Real-time Scanning**: Instant feedback with animated loading states
- **Compact Layout**: Optimized viewport usage without scrolling
- **API-Driven**: Clean separation between frontend and backend
- **Technology Detection**: Comprehensive scanning for frameworks, libraries, and tools
