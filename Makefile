# Makefile for compiling LaTeX documents

# Variables
# Використовуємо latexmk з двигуном lualatex та опцією -cd
LATEXMK = latexmk -lualatex -interaction=nonstopmode
# Цільова директорія для PDF файлів
DIST_DIR = dist

# Директорії з джерельними файлами
OSS_DIR = Положення_про_ОСС
SUD_DIR = Положення_про_СУД

# Головні .tex файли
OSS_SRC = $(OSS_DIR)/Положення_про_ОСС.tex
SUD_SRC = $(SUD_DIR)/Положення_про_СУД.tex

# Цільові PDF файли у директорії dist
OSS_PDF = $(DIST_DIR)/$(notdir $(OSS_SRC:.tex=.pdf))
SUD_PDF = $(DIST_DIR)/$(notdir $(SUD_SRC:.tex=.pdf))

# Ціль за замовчуванням: зібрати всі документи
all: $(OSS_PDF) $(SUD_PDF)

# Правило для компіляції Положення про ОСС
# Залежить від головного файлу та всіх .tex файлів у його директорії
$(OSS_PDF): $(OSS_SRC) $(wildcard $(OSS_DIR)/*.tex)
	@echo "Compiling $(OSS_SRC) -> $(OSS_PDF)"
	@mkdir -p $(DIST_DIR)
	$(LATEXMK) -cd -output-directory=../$(DIST_DIR) -jobname=$(notdir $(OSS_SRC:.tex=)) $<

# Правило для компіляції Положення про СУД
# Залежить від головного файлу та всіх .tex файлів у його директорії
$(SUD_PDF): $(SUD_SRC) $(wildcard $(SUD_DIR)/*.tex)
	@echo "Compiling $(SUD_SRC) -> $(SUD_PDF)"
	@mkdir -p $(DIST_DIR)
	$(LATEXMK) -cd -output-directory=../$(DIST_DIR) -jobname=$(notdir $(SUD_SRC:.tex=)) $<

# Ціль для очищення допоміжних файлів
clean:
	@echo "Cleaning up auxiliary files..."
	# Використовуємо latexmk для очищення, ігноруємо можливі помилки
	# Переходимо в директорії перед очищенням
	(cd $(OSS_DIR) && $(LATEXMK) -C -output-directory=../$(DIST_DIR) $(notdir $(OSS_SRC))) || true
	(cd $(SUD_DIR) && $(LATEXMK) -C -output-directory=../$(DIST_DIR) $(notdir $(SUD_SRC))) || true
	# Якщо потрібно також видалити PDF та директорію: rm -rf $(DIST_DIR)

# Оголошення цілей, що не є файлами
.PHONY: all clean 