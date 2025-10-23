# Generar reporte HTML
index.html: scripts/index.qmd
	quarto render scripts/index.qmd --output-dir .

# Limpiar archivos generados
clean:
	rm -f index.html
	rm -rf index_files

# Ver todos los targets
help:
	@echo "Targets disponibles:"
	@echo "  make          - Genera index.html en root"
	@echo "  make clean    - Elimina archivos generados"
	@echo "  make help     - Muestra esta ayuda"

.PHONY: clean help