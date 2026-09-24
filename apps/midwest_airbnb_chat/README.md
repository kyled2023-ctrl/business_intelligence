# ISA 401 Job Scout Chat

**Ask a question in plain English, get the SQL and a table back**

A twelve-line [querychat](https://github.com/posit-dev/querychat) app built in ISA 401 (Miami University) on the job postings that [ChatISA](https://chatisa.fsb.miamioh.edu) Job Scout collected. It is the starting point for Assignment 05, where you rebuild it on the Airbnb data, deploy it to [Render](https://render.com) from your GitHub repository, and then improve it.

**Live app:** https://midwest-airbnb-chat-cn6m.onrender.com/

---

## What is this app?

The app connects to a SQLite database (`data/scout.db`), hands the `scout_postings` table to querychat, and lets an LLM translate your question into SQL. Every answer shows the query it ran, so you can check the logic and reuse the SQL yourself.

**Example queries:**
- "Which Columbus neighborhoods have the highest average prices?"
![Columbus prices](screenshots/01_columbus_prices.png)
![Columbus prices](screenshots/04_columbus_prices.png)


- “Compare superhost and other host prices by city.”
![Superhost comparison](screenshots/02_superhost_comparison.png)
![Superhost comparison](screenshots/05_superhost_comparison.png)


- “How many listings accommodate 10+ guests?”
![Guest capacity](screenshots/03_guest_capacity.png)

---

## About

Built by **YOUR NAME** for ISA 401: Business Intelligence and Data Visualization at Miami University.
Midwest Stay Explorer uses R, Shiny, bslib, querychat, and SQLite to explore 14,887 Airbnb listings. The app has a navy and teal theme, an About section, an interactive listings table, and a visible SQL panel. Charts and summary results appear in the chat.
The SQL panel describes the current listings table. Aggregate and chart queries are included with their answers in the chat, because those queries do not necessarily update the listings table.
## Data source

The course database comes from [Inside Airbnb](https://insideairbnb.com/get-the-data/).

| Market | Snapshot date | Listings |
| --- | --- | ---: |
| Chicago | 2026-07-20 | 7,439 |
| Columbus | 2026-07-23 | 2,587 |
| Twin Cities | 2026-07-21 | 4,861 |
| Total | | 14,887 |

Each row is one listing. The `listings` table has 29 columns, documented in `data/data_desc.md`. Nightly prices are in USD. The data are historical snapshots, availability is not occupancy, and revenue values are estimates. `host_since` and `instant_bookable` contain no observed values in this database.


---

## Required Secret

The app calls OpenAI (`gpt-5.6-luna (reasoning off)`) through [ellmer](https://ellmer.tidyverse.org/), so it needs one environment variable:

```bash
export OPENAI_API_KEY="your-api-key-here"
```

On Hugging Face Spaces, add it under **Settings > Variables and secrets** as a secret named `OPENAI_API_KEY`. Never commit the key; `.Renviron` is listed in `.gitignore` for that reason.

---

## Run locally

Open the `business_intelligence` RStudio project and use the packages installed in class. Keep `OPENAI_API_KEY` in the project's ignored `.Renviron`. Restart R after editing that file. Do not publish the key.

```r
shiny::runApp("apps/midwest_airbnb_chat")
```

If your working directory is already `apps/midwest_airbnb_chat`, use `shiny::runApp(".")`.

---

---

## Deployment

Render web service: Docker; branch `main`; root directory `apps/midwest_airbnb_chat`; instance type Free. Set `OPENAI_API_KEY` in Render's environment settings. The included instructor Dockerfile reads Render's `PORT` and uses the class package snapshot.

---

---

## Credits

- [ISA 401 Job Scout reference app](https://github.com/fmegahed/job_scout_chat)
- [Inside Airbnb data assumptions and dictionary](https://insideairbnb.com/data-assumptions/)
- [querychat documentation](https://posit-dev.github.io/querychat/)
- [bslib theming](https://rstudio.github.io/bslib/articles/theming/index.html)

---

## Technology Stack

- **[Shiny](https://shiny.posit.co/)** - Web application framework for R
- **[querychat](https://github.com/posit-dev/querychat)** - Natural language data querying
- **[ellmer](https://ellmer.tidyverse.org/)** - LLM client for R
- **[RSQLite](https://rsqlite.r-dbi.org/)** - SQLite driver for R

---

## Course Information

This application was developed for **ISA 401** at **Miami University**. The polished version of the same idea, built on BLS wage data, is the [OEWS Jobs Explorer](https://huggingface.co/spaces/fmegahed/querychat_demo).
