# Invoice App 🚀

A professional-grade **Invoice Management System** built with **Ruby on Rails 8.1**. Designed for service providers and freelancers, this application combines a sleek, responsive UI with robust backend architecture to handle client management, dynamic invoice generation, and pixel-perfect PDF exports.

<!-- [![CI](https://github.com/vitaoTM/invoice-app/actions/workflows/ci.yml/badge.svg)](https://github.com/vitaoTM/invoice-app/actions/workflows/ci.yml) -->

## ✨ Features

- **Dynamic Invoice Management:** Full CRUD for invoices with live-calculated line items, status tracking (`Draft`, `Sent`, `Paid`, `Cancelled`), and automatic invoice numbering.
- **Client CRM:** Comprehensive client management with searchable records and inline client creation directly from the invoice form.
- **Pixel-Perfect PDFs:** High-fidelity PDF generation using **Grover** (headless Chromium), ensuring invoices look professional and consistent.
- **Multi-Tenancy:** Secure, user-scoped data isolation ensuring every user has their own private workspace and business settings.
- **Modern Hotwire UX:** A snappy, SPA-like feel using **Turbo Frames**, **Turbo Streams**, and **Stimulus JS** for real-time interactions without full page reloads.
- **Mobile-First Design:** Fully responsive interface with a dedicated mobile navigation bar and optimized data views for small screens.
- **Authentication:** Secure session-based authentication with rate-limiting and password reset flows (Rails 8 native).

## 🛠 Tech Stack

- **Framework:** Ruby on Rails 8.1.3
- **Database:** SQLite3 (utilizing specialized databases for `Solid Cache`, `Solid Queue`, and `Solid Cable`)
- **Frontend:** Tailwind CSS, Hotwire (Turbo + Stimulus), Propshaft
- **PDF Engine:** Grover (Puppeteer / Headless Chrome)
- **Deployment:** Kamal / Docker / Fly.io
- **Testing & Quality:** Minitest, System Tests (Selenium), RuboCop, Brakeman, Bundler-Audit

## 🏗 Engineering Highlights

- **Solid Architecture:** Implements the latest Rails 8 "Solid" suite (Queue, Cache, Cable) for a simplified yet powerful production infrastructure.
- **Advanced Migrations:** Demonstrates safe multi-tenancy data backfilling patterns for zero-downtime schema updates.
- **Stimulus Power:** Custom Stimulus controllers for complex UI logic like dynamic table rows, live totals, and event-driven component communication.
- **CI/CD Pipeline:** Fully automated workflow including security audits, linting, and comprehensive test suites.
- **Professional PDF Workflow:** Bypasses traditional DSL-based PDF gems in favor of HTML-to-PDF rendering with Grover, allowing for modern CSS/Tailwind styling in exports.

## 🚀 Getting Started

### Prerequisites

- Ruby 3.2.2+
- Node.js 18+ (for PDF rendering support)
- SQLite3

### Setup

1. **Clone and install dependencies:**
   ```bash
   git clone https://github.com/vitaoTM/invoice-app.git
   cd invoice-app
   bundle install
   npm install
   ```

2. **Install Chrome for PDF rendering:**
   ```bash
   npx puppeteer browsers install chrome
   ```

3. **Prepare the database:**
   ```bash
   bin/rails db:prepare
   ```

4. **Run the development server:**
   ```bash
   bin/dev
   ```
   Visit `http://localhost:3000` to start.

## 📖 The Story Behind the App

This project isn't just a code exercise. It was built with a specific real-world use case in mind: an event service provider in Aruba needing a professional way to bill international clients. You can read the full "Development Documentary" of how this app evolved from a single-user tool to a multi-tenant platform in [STORY.md](./STORY.md).

## 👤 Author

**Vitor** - [@vitaoTM](https://github.com/vitaoTM)

---
*Built with passion and Rails 8.*
