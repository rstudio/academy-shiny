# Posit Academy — Shiny for R

Course files for the Posit Academy *Getting Started with Shiny for R* course. This single repository contains everything you need for the course, organized into two top-level folders:

- **`tutorials/`** — starter files for the Shiny IDE tutorials. These tutorials run in your browser but ask you to work with files in your IDE (Positron or RStudio) alongside the tutorial.
- **`milestones/`** — the starter files for your weekly project milestones. Each week you work through a milestone in your IDE, applying the skills from that week's tutorials. The milestone **instructions** live in the course site (open the "Milestone N" tutorial in your browser); the files you edit and run live here.

**By accessing these Posit Academy course materials, you agree to Posit's [End User License Agreement](https://posit.co/about/eula/) and [Learning Services Agreement](https://posit.co/learning-services-agreement/).**

## Setup

Clone this repository in a Terminal on Posit Workbench:

```bash
git clone https://github.com/rstudio/academy-shiny.git
```

You only need to do this once for the course. See the **Set Up Your Project & Tutorials** tutorial in the course site for a step-by-step walkthrough.

## `tutorials/`

Starter files for the IDE tutorials. Each folder contains the starter `.R` app file(s) and the `data/` files needed for that tutorial.

| Folder | Starter Files | Tutorial |
|--------|---------------|----------|
| `tutorials/01-shiny-welcome_to_shiny/` | `ex01.R` | Welcome to Shiny: your first app, UI & layouts, input widgets |
| `tutorials/02-shiny-basics_of_reactivity/` | `ex01.R`, `ex02.R`, `ex03.R` | Basics of reactivity: outputs, the server function, the reactive graph |
| `tutorials/03-shiny-more_reactivity/` | `ex01.R`, `ex02.R`, `ex03.R` | More reactivity: `reactive()`, `observe()`, `req()`, and `bindEvent()` |
| `tutorials/04-shiny-dynamic_modern_ui/` | `ex01.R`, `ex02.R`, `ex03.R` | Dynamic and modern UIs: bslib cards, value boxes, and `renderUI()` |
| `tutorials/05-shiny-customization_and_theming/` | `bslib.R`, `shiny.R`, `colors.R`, `darkmode.R` | Customization and theming: Bootstrap versions, `bs_theme()`, dark mode, thematic |
| `tutorials/06-shiny-workflow_and_deployment/` | `app.R` | Workflow and deployment: organizing an app and publishing to Posit Connect Cloud |
| `tutorials/07-shiny-more_interactive_visualizations/` | `leaflet.R`, `plotly.R`, `dt.R` | More interactive visualizations: leaflet maps, plotly plots, DT tables (optional) |
| `tutorials/08-shiny-production_ready_apps/` | `testing.R`, `app.R` | Production-ready apps: testing with shinytest2 (optional) |
| `tutorials/09-shiny-user_input_validation/` | `validation.R`, `feedback.R` | User input & validation: `req()`, `validate()`, and user feedback (optional) |

### How to use the tutorial files

When a tutorial asks you to open a starter file, navigate to the corresponding folder inside `tutorials/` and open the `.R` file in your IDE. To run an app:

- **RStudio**: click the **Run App** button in the editor toolbar.
- **Positron**: run the app from the Console with a lesson-folder-qualified path, e.g.

  ```r
  shiny::runApp("tutorials/01-shiny-welcome_to_shiny/ex01.R")
  ```

This works from the repo root: `runApp()` temporarily switches to the app's folder while the app runs, so the app can find its `data/` files. (Avoid an argument-less `shiny::runApp()` — from the repo root it cannot find the app or its data.)

## `milestones/`

The starter files for your weekly project milestones. Each folder contains the starter scripts and a `data/` folder with the data those scripts read. The **step-by-step instructions** for each milestone are a tutorial in the course site — open the "Milestone N" tutorial there and follow along, editing and running these files in your IDE.

| Folder | Files | Milestone |
|--------|-------|-----------|
| `milestones/shiny_01/` | `exercise1.R`, `exercise2.R`, `exercise3.R`, `data/` | Week 1 — Welcome to Shiny: arranging layouts with `layout_columns()`, tabbed UIs with `navset_card_tab()`, and `page_navbar()` |
| `milestones/shiny_02/` | `exercise1.R`, `exercise2.R`, `exercise3.R`, `data/` | Week 2 — Reactivity and modern UIs: downloads, `dateRangeInput()`, and file uploads with `fileInput()` |
| `milestones/shiny_03/` | `app.R`, `data/` | Week 3 — Theming and publishing: `bs_theme()` / `bs_themer()` / `thematic_shiny()`, then publishing to Posit Connect |

The Week 4 capstone project is set up separately when you reach it — see the course site for details.

### How to use the milestone files

Open the "Milestone N" instructions tutorial in the course site to read what to do, then work through the exercises in the accompanying `.R` scripts here. Run an app the same way as the tutorial files, using a path qualified to the milestone folder, e.g.

```r
shiny::runApp("milestones/shiny_01/exercise1.R")
```

Each app reads its data from a relative `data/` path, so it will find `data/weather.csv` as long as you launch it with a milestone-folder-qualified `runApp()` (or with the **Run App** button in RStudio).

### One milestone at a time

You have access to all of the milestone files, but we encourage you to **only focus on the milestone for the current week of your course**. Milestone folders are numbered sequentially by week (`shiny_01`, `shiny_02`, `shiny_03`).
