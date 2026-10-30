<p align="center">
  <a href="https://www.autom.dev"><img src="images/banner.png" alt="Google Search API by Autom" width="100%"></a>
</p>

# Google Search API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Autom-Get%20an%20API%20key-111827)](https://app.autom.dev/register) [![API docs](https://img.shields.io/badge/Docs-API%20reference-0EA5E9)](https://docs.autom.dev) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Autom Google Search API** returns Google results — organic results, knowledge graph, related questions and pagination — as structured JSON.

- **Google Search API** — Scrape Google Search results via API and retrieve structured SERP data with pagination.
- **Google Search Light API** — Scrape lightweight Google Search results via API: fast, cost-efficient, organic results only.

Use it for rank tracking, SEO audits, market research or grounding LLMs with fresh search results.

| Endpoint | Request | Credits |
|---|---|---|
| [Google Search API](#google-search-api) | `GET /v1/google/search` | 1 |
| [Google Search Light API](#google-search-light-api) | `GET /v1/google/search/light` | 1 |

## Table of contents

- [How it works](#how-it-works)
- [Google Search API](#google-search-api)
- [Google Search Light API](#google-search-light-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Use cases](#use-cases)
- [Why Autom?](#why-autom)
- [FAQ](#faq)
- [Related repositories](#related-repositories)
- [Support](#support)

## How it works

1. **Create a Autom account** and copy your API key from the [dashboard](https://app.autom.dev/register).
2. **Call `https://api.autom.dev`** with the header `x-api-key: YOUR_API_KEY`.
3. **Use the result** in your app — no infrastructure to run.

```bash
export AUTOM_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

## Google Search API

Scrape Google Search results via API and retrieve structured SERP data with pagination.

`GET https://api.autom.dev/v1/google/search` · **1 credit per request** · [API reference](https://app.autom.dev/openapi)

### Request parameters

| Parameter | In | Type | Required | Description |
|---|---|---|---|---|
| `query` | query | string | ✅ | The search query you want to run on Google (supports advanced operators like `site:`, `inurl:`, `intitle:`). |
| `tbs` | query | string | — | Advanced search filters string (e.g. time ranges: `qdr:h` last hour, `qdr:d` last day, `qdr:w` last week, `qdr:m` last month, `qdr:y` last year). |
| `safe` | query | string | — | Adult content filter. `active` enables Google SafeSearch; `off` disables it. Omit to use Google default. |
| `location` | query | string | — | Human-readable location to originate the search from (e.g. `New York, NY`, `Paris, France`). If several locations match, the most popular one is used. Note: `location` and `uule` cannot be used together. |
| `uule` | query | string | — | Google encoded location parameter. Use for precise geo targeting. Note: `uule` and `location` cannot be used together. |
| `gl` | query | string | — | Country to use for the Google search (two-letter country code, e.g. `us`, `fr`). |
| `hl` | query | string | — | Language to use for the Google search (two-letter language code, e.g. `en`, `fr`). |
| `page` | query | number | — | Page number / offset used for pagination. |
| `num` | query | number | — | Maximum number of results to return per page (deprecated). |

### Python example

```python
import os

import requests

API_KEY = os.environ["AUTOM_API_KEY"]
HEADERS = {"x-api-key": API_KEY}

response = requests.get(
    "https://api.autom.dev/v1/google/search",
    headers=HEADERS,
    params={
        "query": "YOUR_VALUE",
    },
    timeout=120,
)
response.raise_for_status()

data = response.json()
print(data)
```

### TypeScript example

```typescript
type GoogleSearchApi = {
  pagination?: {
    next?: number;
    current?: number;
    other_pages?: number[];
    has_next_page?: boolean;
  };
  knowledge_graph?: {
    type?: string;
    title?: string;
    website?: string;
  };
  organic_results?: {
    link?: string;
    title?: string;
    domain?: string;
    source?: string;
    snippet?: string;
    position?: number;
  }[];
  search_parameters?: {
    q?: string;
    gl?: string;
    hl?: string;
    page?: number;
    engine?: string;
  };
};

const headers = { "x-api-key": process.env.AUTOM_API_KEY!, "Content-Type": "application/json" };

const params = new URLSearchParams({
  "query": "YOUR_VALUE",
});

const response = await fetch(`https://api.autom.dev/v1/google/search?${params}`, { headers });
if (!response.ok) throw new Error(`HTTP ${response.status}: ${await response.text()}`);

const data = (await response.json()) as GoogleSearchApi;
console.log(data);
```

### Output example

Example response from the API reference, abridged.

```json
{
  "pagination": {
    "next": 2,
    "current": 1,
    "other_pages": [
      2,
      3
    ],
    "has_next_page": true
  },
  "knowledge_graph": {
    "type": "Aircraft manufacturing commercial company",
    "title": "Airbus SE",
    "website": "https://www.airbus.com/en"
  },
  "organic_results": [
    {
      "link": "https://www.airbus.com/en",
      "title": "Airbus: Pioneering sustainable aerospace",
      "domain": "www.airbus.com",
      "source": "Airbus",
      "snippet": "Airbus designs, manufactures and delivers industry-leading commercial aircraft, helicopters, military transports, satellites, launchers a…",
      "position": 1
    }
  ],
  "search_parameters": {
    "q": "Airbus Company",
    "gl": "us",
    "hl": "en",
    "page": 1,
    "engine": "google"
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `pagination` | object |  |
| `pagination.next` | integer |  |
| `pagination.current` | integer |  |
| `pagination.other_pages` | integer[] |  |
| `pagination.has_next_page` | boolean |  |
| `knowledge_graph` | object |  |
| `knowledge_graph.type` | string |  |
| `knowledge_graph.title` | string |  |
| `knowledge_graph.website` | string |  |
| `organic_results[]` | object[] |  |
| `organic_results[].link` | string |  |
| `organic_results[].title` | string |  |
| `organic_results[].domain` | string |  |
| `organic_results[].source` | string |  |
| `organic_results[].snippet` | string |  |
| `organic_results[].position` | integer |  |
| `search_parameters` | object |  |
| `search_parameters.q` | string |  |
| `search_parameters.gl` | string |  |
| `search_parameters.hl` | string |  |
| `search_parameters.page` | integer |  |
| `search_parameters.engine` | string |  |

## Google Search Light API

Scrape lightweight Google Search results via API: fast, cost-efficient, organic results only.

`GET https://api.autom.dev/v1/google/search/light` · **1 credit per request** · [API reference](https://app.autom.dev/openapi)

### Request parameters

| Parameter | In | Type | Required | Description |
|---|---|---|---|---|
| `query` | query | string | ✅ | The search query you want to run on Google (supports advanced operators like `site:`, `inurl:`, `intitle:`). |
| `gl` | query | string | — | Country to use for the Google search (two-letter country code, e.g. `us`, `fr`). |
| `hl` | query | string | — | Language to use for the Google search (two-letter language code, e.g. `en`, `fr`). |

### Python example

```python
import os

import requests

API_KEY = os.environ["AUTOM_API_KEY"]
HEADERS = {"x-api-key": API_KEY}

response = requests.get(
    "https://api.autom.dev/v1/google/search/light",
    headers=HEADERS,
    params={
        "query": "YOUR_VALUE",
    },
    timeout=120,
)
response.raise_for_status()

data = response.json()
print(data)
```

### TypeScript example

```typescript
type GoogleSearchLightApi = {
  organic_results?: {
    link?: string;
    title?: string;
    source?: string;
    snippet?: string;
    position?: number;
  }[];
  search_parameters?: {
    q?: string;
    gl?: string;
    hl?: string;
    engine?: string;
  };
};

const headers = { "x-api-key": process.env.AUTOM_API_KEY!, "Content-Type": "application/json" };

const params = new URLSearchParams({
  "query": "YOUR_VALUE",
});

const response = await fetch(`https://api.autom.dev/v1/google/search/light?${params}`, { headers });
if (!response.ok) throw new Error(`HTTP ${response.status}: ${await response.text()}`);

const data = (await response.json()) as GoogleSearchLightApi;
console.log(data);
```

### Output example

Example response from the API reference, abridged.

```json
{
  "organic_results": [
    {
      "link": "https://www.facebook.com/newyorktimessquare1/photos/times-square-new-york-/1207893114725830/",
      "title": "Times Square, New York | Facebook",
      "source": "Facebook",
      "snippet": "Facebook · Happy Valentines day from Times Square #newyork #newyorkcity #nyc · Still magnificent amidst the fog. @vuralelibol · The magni…",
      "position": 1
    },
    {
      "link": "https://www.reddit.com/r/nyc/comments/1r4vwp3/1970s_new_yorkers_are_asked_what_they_dislike_the/",
      "title": "1970s New Yorkers are asked what they dislike the most about living in New York City : r/nyc - Reddit",
      "source": "Reddit",
      "snippet": "468 votes, 55 comments. People saying some things never change weren't around NYC in the 1970s. I was. And I live here now.",
      "position": 2
    }
  ],
  "search_parameters": {
    "q": "new york",
    "gl": "us",
    "hl": "en",
    "engine": "google"
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `organic_results[]` | object[] |  |
| `organic_results[].link` | string |  |
| `organic_results[].title` | string |  |
| `organic_results[].source` | string |  |
| `organic_results[].snippet` | string |  |
| `organic_results[].position` | integer |  |
| `search_parameters` | object |  |
| `search_parameters.q` | string |  |
| `search_parameters.gl` | string |  |
| `search_parameters.hl` | string |  |
| `search_parameters.engine` | string |  |

## Code examples in other languages

Ready-to-run examples live in [`examples/`](examples); each reads your key from `AUTOM_API_KEY`.

| Language | `google-search` | `google-search-light` |
|---|---|---|
| cURL (Bash) | [google_search.sh](examples/curl/google_search.sh) | [google_search_light.sh](examples/curl/google_search_light.sh) |
| PHP | [google_search.php](examples/php/google_search.php) | [google_search_light.php](examples/php/google_search_light.php) |
| C# | [GoogleSearch.cs](examples/csharp/GoogleSearch.cs) | [GoogleSearchLight.cs](examples/csharp/GoogleSearchLight.cs) |
| Go | [google_search.go](examples/go/google_search.go) | [google_search_light.go](examples/go/google_search_light.go) |
| Java | [GoogleSearchExample.java](examples/java/GoogleSearchExample.java) | [GoogleSearchLightExample.java](examples/java/GoogleSearchLightExample.java) |
| Ruby | [google_search.rb](examples/ruby/google_search.rb) | [google_search_light.rb](examples/ruby/google_search_light.rb) |
| Node.js | [google_search.mjs](examples/nodejs/google_search.mjs) | [google_search_light.mjs](examples/nodejs/google_search_light.mjs) |

## Use cases

- **Rank tracking** — Track positions of your pages and competitors.
- **SEO research** — Analyse SERP features and competitors per keyword.
- **LLM grounding** — Feed agents and RAG pipelines with fresh results.

## Why Autom?

- **Every SERP in one API** — Google Search, AI Mode, Maps, News, Shopping, Images, Videos, Jobs, Autocomplete, plus Bing and Brave.
- **Structured JSON** — documented fields instead of brittle HTML parsing.
- **Geo & language targeting** — search like a user from the country and language you need.
- **One API key, one header** — `x-api-key` on every request.
- **Copy-paste examples** — Python and TypeScript in each README, 7 more languages in `examples/`.

## FAQ

### How do I authenticate?

Create an account on [Autom](https://app.autom.dev/register), copy your API key and send it in the `x-api-key` header of every request to `https://api.autom.dev`.

### How much does a request cost?

Credits per call: `/v1/google/search` **1**, `/v1/google/search/light` **1**. See [Autom pricing](https://www.autom.dev/pricing).

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related repositories

- [Google AI Mode API](https://github.com/automdev/google-ai-mode-api)
- [Google Maps API](https://github.com/automdev/google-maps-api)
- [Google News API](https://github.com/automdev/google-news-api)
- [Google Shopping API](https://github.com/automdev/google-shopping-api)
- [Google Images API](https://github.com/automdev/google-images-api)
- [Google Videos API](https://github.com/automdev/google-videos-api)
- [Google Jobs API](https://github.com/automdev/google-jobs-api)
- [Google Autocomplete API](https://github.com/automdev/google-autocomplete-api)
- [All Autom repositories](https://github.com/automdev)

## Support

- 💬 Join the [Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Read the [API reference](https://docs.autom.dev).
- 🔑 [Get your API key](https://app.autom.dev/register).

---

<p align="center">
  <a href="https://www.autom.dev">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Autom" height="28">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.autom.dev">Autom</a>. Examples are released under the MIT license.</sub>
</p>
