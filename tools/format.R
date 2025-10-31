# Cargar librerías
library(lintr)
library(styler)
library(here)

# ----------------------------------------
# Script 1: Lectura de archivos
lint(here("", "index.qmd"))
style_file(here("", "index.qmd"))


