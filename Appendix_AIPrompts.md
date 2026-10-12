# Appendix — AI Prompts and Key Responses (AI Usage Rule 7)

**Tool:** Claude (Claude Sonnet 5, Anthropic), accessed via claude.ai
**Date:** October 12, 2026

## Step 1 — Understand Markdown Structure and Documentation Goals

**Seed prompt:** "Explain what sections a good GitHub README for an R data analysis project should include."
**Response (summary):** Proposed Overview, Installation, Usage/Example, Repository Structure, Documentation (link to further docs), and License as the core sections, noting an R-specific project should call out package dependencies explicitly. Directly informed the section list in `README.md`.

**Refinement prompt:** "Revise the sections list so it's concise and uses Markdown headers and bullet formatting."
**Response (summary):** Condensed the list into a flat bulleted outline using `##`-level headers, which became the plain-text outline I compared against a real `tidyverse` README (`dplyr`) before writing my own.

**Critique/Validation prompt:** "Check the Markdown syntax for correctness and readability."
**Response (summary):** Flagged that nested bullets under each section header would hurt readability compared to flat `##` subsections, and that a long single-paragraph Overview should be split — both adopted in the final structure.

## Step 2 — Generate an AI-Assisted Draft of README.md

**Seed prompt:** "Here's a summary of my R project: [a base-R script that reads data/retail_orders.csv, a 60-row synthetic retail-orders dataset, and summarizes revenue by category]. Generate a professional README.md file using Markdown."
**Response (summary):** Produced a full first draft, including an "Example output" section with invented revenue figures (the project hadn't been run yet) — this is the specific failure discussed in `Reflection.md` Q2, caught and replaced with the script's real console output before submission.

**Refinement prompt:** "Add sections for Installation, Example Code, and License. Keep tone concise and professional."
**Response (summary):** Added the three sections; the Installation section initially assumed `tidyverse` was required, which was corrected by hand since the script was written in base R specifically to avoid that dependency.

**Critique/Validation prompt:** "Review the Markdown for syntax errors and suggest 2 improvements for clarity."
**Response (summary):** Suggested (1) adding a repository-structure tree so a reader can see file layout at a glance, and (2) moving the AI Assistance Disclosure to the bottom of the file per the assignment's own submission instructions rather than the top — both adopted.

## Step 3 — Document a Single R Script with R Markdown

**Seed prompt:** "Here's my R script description [sales_summary.R: reads retail_orders.csv, computes revenue by category in base R, writes a summary CSV and a bar chart]. Suggest Markdown formatting and code block examples."
**Response (summary):** Proposed a Purpose/Inputs/Outputs structure with one code chunk per logical step of the script (load data, compute line totals, aggregate, identify top category, chart) rather than one large chunk — adopted directly in `analysis_docs.Rmd`.

**Refinement prompt:** "Add syntax highlighting and improve section organization (e.g., # Purpose, ## Inputs, ## Outputs)."
**Response (summary):** Confirmed R Markdown code chunks (```` ```{r} ````) get syntax highlighting automatically from `knitr` and don't need a manual language tag the way plain Markdown fences do; recommended the exact heading hierarchy used in the final file.

**Critique/Validation prompt:** "Is the Markdown consistent with RMarkdown best practices?"
**Response (summary):** Flagged that the first draft set `knitr::opts_knit$set(root.dir = "..")`, which breaks file paths when the `.Rmd` already lives at the project root (confirmed directly — knitting failed with "cannot open the connection" on `data/retail_orders.csv` until this was removed). This was a genuine bug caught only by actually knitting the file, not by reading the Markdown.

---

**Verification note:** Every number appearing in `README.md` and `analysis_docs.Rmd` comes from actually executing `scripts/sales_summary.R` and from actually knitting `analysis_docs.Rmd` with `rmarkdown::render()` — not from AI-stated expectations. The one real bug surfaced during this process (the `root.dir` knitting failure above) was found by running the code, which is the verification pattern this assignment asks for.
