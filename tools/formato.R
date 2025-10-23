# Cargar librerías
library(lintr)
library(styler)
library(here)

# ----------------------------------------
# Script 1: Lectura de archivos
lint(here("scripts", "index.qmd"))
style_file(here("scripts", "index.qmd"))


