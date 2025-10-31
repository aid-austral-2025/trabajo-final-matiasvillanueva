# Generar reporte HTML
index.html: index.qmd
	quarto render index.qmd

# Limpiar archivos generados
clean:
	rm -f index.html
	rm -rf index_files
	
# Formatear archivos
format:
	Rscript tools/format.R

# Ver todos los targets
help:
	@echo "Targets disponibles:"
	@echo "  make          - Genera index.html en root"
	@echo "  make clean    - Elimina archivos generados"
	@echo "  make format   - Formatea los archivos R"
	@echo "  make help     - Muestra esta ayuda"

.PHONY: clean help