# Posit Academy — Shiny IDE Tutorial Files

Starter files for Posit Academy Shiny for R IDE tutorials. These tutorials run in your browser but ask you to work with files in your IDE (Positron or RStudio) alongside the tutorial.

**By accessing these Posit Academy course materials, you agree to Posit's [End User License Agreement](https://posit.co/about/eula/) and [Learning Services Agreement](https://posit.co/learning-services-agreement/).**

## Setup

Clone this repository in a Terminal on Posit Workbench:

```bash
git clone https://github.com/rstudio/academy-shiny-ide-tutorials.git
```

## Folder contents

| Folder | Starter Files | Tutorial |
|--------|---------------|----------|
| `01-shiny-welcome_to_shiny/` | `ex01.R` | Welcome to Shiny: your first app, UI & layouts, input widgets |
| `02-shiny-basics_of_reactivity/` | `ex01.R`, `ex02.R`, `ex03.R` | Basics of reactivity: outputs, the server function, the reactive graph |

Each folder contains the starter `.R` app file(s) and the `data/` files needed for that tutorial.

## How to use

When a tutorial asks you to open a starter file, navigate to the corresponding folder and open the `.R` file in your IDE, then click **Run App** (RStudio) or run `shiny::runApp()` (Positron).
