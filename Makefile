# Generar reporte HTML
index.html: scripts/index.qmd
	cd scripts && Rscript -e "quarto::quarto_render('index.qmd')" && mv index.html index_files ../

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