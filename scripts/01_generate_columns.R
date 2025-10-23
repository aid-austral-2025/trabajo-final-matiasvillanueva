library(here)
library(dplyr)

# Leer y procesar los datos
video_game_sales <- read.csv(here("input", "vgsales.csv"))

# Función para asignar continente a cada consola
library(here)
library(dplyr)

# Leer y procesar los datos
video_game_sales <- read.csv(here("input", "vgsales.csv"))

# Función para asignar continente a cada consola
assign_origin_to_console <- function(platform) {
  case_when(
    platform %in% c("NES", "SNES", "N64", "GC", "Wii", "WiiU", "GB", "GBA", "DS", "3DS",
                    "PS", "PS2", "PS3", "PS4", "PSP", "PSV",
                    "GEN", "SAT", "DC", "GG", "SCD",
                    "NG", "TG16", "WS", "PCFX") ~ "Asia",
    platform %in% c("XB", "X360", "XOne", "2600", "3DO") ~ "North America",
    TRUE ~ "Unknown"
  )
}

# Agregar columna con el continente de origen de la consola
video_game_sales <- video_game_sales %>%
  mutate(ConsoleOrigin = assign_origin_to_console(Platform)) %>%
  filter(Year >= 1986 & Year <= 2016, Platform != "PC")  # Filtrar del 1986 al 2016 y quitar PC

cat("Columna 'ConsoleOrigin' agregada correctamente, datos filtrados del 1986 al 2016 y PC removido\n")

unique(video_game_sales$ConsoleOrigin)
###############################################################################
library(dplyr)

# Tabla 1: Ventas de consolas americanas en América
ventas_americanas_america <- video_game_sales %>%
  filter(ConsoleOrigin == "North America", Year != "N/A") %>%
  group_by(Year) %>%
  summarise(
    Total_Ventas_NA = sum(NA_Sales, na.rm = TRUE),
    .groups = 'drop'
  ) %>%
  arrange(Year)

# Tabla 2: Ventas de consolas japonesas en Japón
ventas_japonesas_japon <- video_game_sales %>%
  filter(ConsoleOrigin == "Asia", Year != "N/A") %>%
  group_by(Year) %>%
  summarise(
    Total_Ventas_JP = sum(JP_Sales, na.rm = TRUE),
    .groups = 'drop'
  ) %>%
  arrange(Year)

# Mostrar las tablas
cat("=== VENTAS DE CONSOLAS AMERICANAS EN AMÉRICA POR AÑO ===\n")
print(ventas_americanas_america, n = 50)

cat("\n=== VENTAS DE CONSOLAS JAPONESAS EN JAPÓN POR AÑO ===\n")
print(ventas_japonesas_japon, n = 50)

########################################################################################
library(dplyr)

# Tabla 1: Ventas totales de consolas americanas en Japón por año
ventas_americanas_japon <- video_game_sales %>%
  filter(ConsoleOrigin == "North America", Year != "N/A") %>%
  group_by(Year) %>%
  summarise(
    Total_Ventas_JP = sum(JP_Sales, na.rm = TRUE),
    .groups = 'drop'
  ) %>%
  arrange(Year)

# Tabla 2: Ventas totales de consolas japonesas en América por año
ventas_japonesas_america <- video_game_sales %>%
  filter(ConsoleOrigin == "Asia", Year != "N/A") %>%
  group_by(Year) %>%
  summarise(
    Total_Ventas_NA = sum(NA_Sales, na.rm = TRUE),
    .groups = 'drop'
  ) %>%
  arrange(Year)

# Mostrar las tablas
cat("=== VENTAS TOTALES DE CONSOLAS AMERICANAS EN JAPÓN POR AÑO ===\n")
print(ventas_americanas_japon, n = 100)

cat("\n=== VENTAS TOTALES DE CONSOLAS JAPONESAS EN AMÉRICA POR AÑO ===\n")
print(ventas_japonesas_america, n = 100)


#######################################################################################
library(ggplot2)
library(dplyr)

# Preparar datos para el gráfico CORREGIDO
sales_evolution <- video_game_sales %>%
  filter(Year != "N/A") %>%
  mutate(Year = as.numeric(Year)) %>%
  group_by(Year) %>%
  summarise(
    # Ventas de consolas americanas en Japón
    American_in_Japan = sum(JP_Sales[ConsoleOrigin == "North America"], na.rm = TRUE),
    # Ventas de consolas japonesas en América
    Japanese_in_America = sum(NA_Sales[ConsoleOrigin == "Asia"], na.rm = TRUE)
  ) %>%
  filter(Year >= 1980) # Filtrar años razonables

# Crear gráfico de líneas con puntos
ggplot(sales_evolution, aes(x = Year)) +
  geom_line(aes(y = American_in_Japan, color = "American Consoles in Japan")) +
  geom_point(aes(y = American_in_Japan, color = "American Consoles in Japan")) +
  geom_line(aes(y = Japanese_in_America, color = "Japanese Consoles in America")) +
  geom_point(aes(y = Japanese_in_America, color = "Japanese Consoles in America")) +
  labs(
    title = "Evolution of Cross-Region Video Game Sales",
    x = "Year",
    y = "Sales (in millions)",
    color = "Sales Type"
  ) +
  theme_minimal() +
  scale_y_continuous(labels = scales::comma)