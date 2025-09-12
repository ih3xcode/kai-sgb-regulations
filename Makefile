# Makefile for compiling LaTeX documents

# Variables
# Використовуємо latexmk з двигуном lualatex та опцією -cd
LATEXMK = latexmk -lualatex -interaction=nonstopmode
PYTHON = python3
# Цільова директорія для PDF файлів
DIST_DIR = dist

# Директорії з джерельними файлами
OSS_DIR = Положення_про_ОСС
SUD_DIR = Положення_про_СУД
SR_KAI_DIR = Положення_про_СР_КАІ
KSU_DIR = Регламент_КСУ
CVKS_DIR = Положення_про_ЦВКс
TVR_DIR = Тимчасовий_виборчий_регламент

# Головні .tex файли
OSS_SRC = $(OSS_DIR)/Положення_про_ОСС.tex
SUD_SRC = $(SUD_DIR)/Положення_про_СУД.tex
SR_KAI_SRC = $(SR_KAI_DIR)/Положення_про_СР_КАІ.tex
KSU_SRC = $(KSU_DIR)/Регламент_КСУ.tex
CVKS_SRC = $(CVKS_DIR)/Положення_про_ЦВКс.tex
TVR_SRC = $(TVR_DIR)/Тимчасовий_виборчий_регламент.tex

# Скрипт для компіляції розділів
COMPILE_SCRIPT = scripts/compile_sections.py
# Директорія для скомпільованих розділів
COMPILED_DIR = compiled
# Скомпільовані файли розділів
COMPILED_OSS = $(COMPILED_DIR)/oss.tex
COMPILED_SUD = $(COMPILED_DIR)/sud.tex
COMPILED_SR_KAI = $(COMPILED_DIR)/sr_kai.tex
COMPILED_KSU = $(COMPILED_DIR)/ksu.tex
COMPILED_CVKS = $(COMPILED_DIR)/cvks.tex
COMPILED_TVR = $(COMPILED_DIR)/tvr.tex

# Цільові PDF файли у директорії dist (використовуємо латиницю та дефіси)
OSS_PDF = $(DIST_DIR)/Polozhennia-pro-OSS.pdf
SUD_PDF = $(DIST_DIR)/Polozhennia-pro-SUD.pdf
SR_KAI_PDF = $(DIST_DIR)/Polozhennia-pro-SR-KAI.pdf
KSU_PDF = $(DIST_DIR)/Reglament-KSU.pdf
CVKS_PDF = $(DIST_DIR)/Polozhennia-pro-CVKS.pdf
TVR_PDF = $(DIST_DIR)/Tymchasovyi-vyborchyi-reglament.pdf

# Ціль за замовчуванням: зібрати всі документи
all: $(OSS_PDF) $(SUD_PDF) $(SR_KAI_PDF) $(KSU_PDF) $(CVKS_PDF) $(TVR_PDF)

# Правило для компіляції Положення про ОСС
# Залежить від головного файлу та всіх .tex файлів у його директорії
$(OSS_PDF): $(OSS_SRC) $(wildcard $(OSS_DIR)/*.tex)
	@echo "Compiling $(OSS_SRC) -> $(OSS_PDF)"
	@mkdir -p $(DIST_DIR)
	# Використовуємо jobname без пробілів для назви логів/aux, але фінальний PDF буде перейменовано
	$(LATEXMK) -cd -output-directory=../$(DIST_DIR) -jobname=$(notdir $(OSS_SRC:.tex=)) $<
	# Перейменовуємо PDF якщо ім'я відрізняється (команда виконується з кореневої директорії)
	[ -f "$(DIST_DIR)/$(notdir $(OSS_SRC:.tex=.pdf))" ] && [ "$(notdir $(OSS_SRC:.tex=.pdf))" != "$(notdir $(OSS_PDF))" ] && mv "$(DIST_DIR)/$(notdir $(OSS_SRC:.tex=.pdf))" "$(DIST_DIR)/$(notdir $(OSS_PDF))" || true

# Правило для компіляції Положення про СУД
# Залежить від головного файлу та всіх .tex файлів у його директорії
$(SUD_PDF): $(SUD_SRC) $(wildcard $(SUD_DIR)/*.tex)
	@echo "Compiling $(SUD_SRC) -> $(SUD_PDF)"
	@mkdir -p $(DIST_DIR)
	# Використовуємо jobname без пробілів для назви логів/aux, але фінальний PDF буде перейменовано
	$(LATEXMK) -cd -output-directory=../$(DIST_DIR) -jobname=$(notdir $(SUD_SRC:.tex=)) $<
	# Перейменовуємо PDF якщо ім'я відрізняється (команда виконується з кореневої директорії)
	[ -f "$(DIST_DIR)/$(notdir $(SUD_SRC:.tex=.pdf))" ] && [ "$(notdir $(SUD_SRC:.tex=.pdf))" != "$(notdir $(SUD_PDF))" ] && mv "$(DIST_DIR)/$(notdir $(SUD_SRC:.tex=.pdf))" "$(DIST_DIR)/$(notdir $(SUD_PDF))" || true

# Правило для компіляції Положення про СР КАІ
# Залежить від головного файлу та всіх .tex файлів у його директорії
$(SR_KAI_PDF): $(SR_KAI_SRC) $(wildcard $(SR_KAI_DIR)/*.tex)
	@echo "Compiling $(SR_KAI_SRC) -> $(SR_KAI_PDF)"
	@mkdir -p $(DIST_DIR)
	$(LATEXMK) -cd -output-directory=../$(DIST_DIR) -jobname=$(notdir $(SR_KAI_SRC:.tex=)) $<
	# Перейменовуємо PDF якщо ім'я відрізняється
	[ -f "$(DIST_DIR)/$(notdir $(SR_KAI_SRC:.tex=.pdf))" ] && [ "$(notdir $(SR_KAI_SRC:.tex=.pdf))" != "$(notdir $(SR_KAI_PDF))" ] && mv "$(DIST_DIR)/$(notdir $(SR_KAI_SRC:.tex=.pdf))" "$(DIST_DIR)/$(notdir $(SR_KAI_PDF))" || true

# Правило для компіляції Регламенту КСУ
# Залежить від головного файлу та всіх .tex файлів у його директорії
$(KSU_PDF): $(KSU_SRC) $(wildcard $(KSU_DIR)/*.tex)
	@echo "Compiling $(KSU_SRC) -> $(KSU_PDF)"
	@mkdir -p $(DIST_DIR)
	$(LATEXMK) -cd -output-directory=../$(DIST_DIR) -jobname=$(notdir $(KSU_SRC:.tex=)) $<
	# Перейменовуємо PDF якщо ім'я відрізняється
	[ -f "$(DIST_DIR)/$(notdir $(KSU_SRC:.tex=.pdf))" ] && [ "$(notdir $(KSU_SRC:.tex=.pdf))" != "$(notdir $(KSU_PDF))" ] && mv "$(DIST_DIR)/$(notdir $(KSU_SRC:.tex=.pdf))" "$(DIST_DIR)/$(notdir $(KSU_PDF))" || true

# Правило для компіляції Положення про ЦВКс
# Залежить від головного файлу та всіх .tex файлів у його директорії
$(CVKS_PDF): $(CVKS_SRC) $(wildcard $(CVKS_DIR)/*.tex)
	@echo "Compiling $(CVKS_SRC) -> $(CVKS_PDF)"
	@mkdir -p $(DIST_DIR)
	$(LATEXMK) -cd -output-directory=../$(DIST_DIR) -jobname=$(notdir $(CVKS_SRC:.tex=)) $<
	# Перейменовуємо PDF якщо ім'я відрізняється
	[ -f "$(DIST_DIR)/$(notdir $(CVKS_SRC:.tex=.pdf))" ] && [ "$(notdir $(CVKS_SRC:.tex=.pdf))" != "$(notdir $(CVKS_PDF))" ] && mv "$(DIST_DIR)/$(notdir $(CVKS_SRC:.tex=.pdf))" "$(DIST_DIR)/$(notdir $(CVKS_PDF))" || true

# Правило для компіляції Тимчасового виборчого регламенту
# Залежить від головного файлу та всіх .tex файлів у його директорії
$(TVR_PDF): $(TVR_SRC) $(wildcard $(TVR_DIR)/*.tex)
	@echo "Compiling $(TVR_SRC) -> $(TVR_PDF)"
	@mkdir -p $(DIST_DIR)
	$(LATEXMK) -cd -output-directory=../$(DIST_DIR) -jobname=$(notdir $(TVR_SRC:.tex=)) $<
	# Перейменовуємо PDF якщо ім'я відрізняється
	[ -f "$(DIST_DIR)/$(notdir $(TVR_SRC:.tex=.pdf))" ] && [ "$(notdir $(TVR_SRC:.tex=.pdf))" != "$(notdir $(TVR_PDF))" ] && mv "$(DIST_DIR)/$(notdir $(TVR_SRC:.tex=.pdf))" "$(DIST_DIR)/$(notdir $(TVR_PDF))" || true

# Нове правило для компіляції розділів у окремі файли
# Залежить від відповідних цілей для кожного документа
compile_sections: $(COMPILED_OSS) $(COMPILED_SUD) $(COMPILED_SR_KAI) $(COMPILED_KSU) $(COMPILED_CVKS) $(COMPILED_TVR)

# Правило для компіляції розділів ОСС
# Залежить від скрипта та всіх .tex файлів у директорії ОСС
$(COMPILED_OSS): $(COMPILE_SCRIPT) $(wildcard $(OSS_DIR)/*.tex)
	@echo "Compiling OSS sections using $(COMPILE_SCRIPT)..."
	$(PYTHON) $(COMPILE_SCRIPT) -s $(OSS_DIR) -o $@

# Правило для компіляції розділів СУД
# Залежить від скрипта та всіх .tex файлів у директорії СУД
$(COMPILED_SUD): $(COMPILE_SCRIPT) $(wildcard $(SUD_DIR)/*.tex)
	@echo "Compiling SUD sections using $(COMPILE_SCRIPT)..."
	$(PYTHON) $(COMPILE_SCRIPT) -s $(SUD_DIR) -o $@

# Правило для компіляції розділів СР КАІ
# Залежить від скрипта та всіх .tex файлів у директорії СР КАІ
$(COMPILED_SR_KAI): $(COMPILE_SCRIPT) $(wildcard $(SR_KAI_DIR)/*.tex)
	@echo "Compiling SR KAI sections using $(COMPILE_SCRIPT)..."
	$(PYTHON) $(COMPILE_SCRIPT) -s $(SR_KAI_DIR) -o $@

# Правило для компіляції розділів Регламенту КСУ
# Залежить від скрипта та всіх .tex файлів у директорії КСУ
$(COMPILED_KSU): $(COMPILE_SCRIPT) $(wildcard $(KSU_DIR)/*.tex)
	@echo "Compiling KSU sections using $(COMPILE_SCRIPT)..."
	$(PYTHON) $(COMPILE_SCRIPT) -s $(KSU_DIR) -o $@

# Правило для компіляції розділів Положення про ЦВКс
# Залежить від скрипта та всіх .tex файлів у директорії ЦВКс
$(COMPILED_CVKS): $(COMPILE_SCRIPT) $(wildcard $(CVKS_DIR)/*.tex)
	@echo "Compiling CVKS sections using $(COMPILE_SCRIPT)..."
	$(PYTHON) $(COMPILE_SCRIPT) -s $(CVKS_DIR) -o $@

# Правило для компіляції розділів Тимчасового виборчого регламенту
# Залежить від скрипта та всіх .tex файлів у директорії TVR
$(COMPILED_TVR): $(COMPILE_SCRIPT) $(wildcard $(TVR_DIR)/*.tex)
	@echo "Compiling TVR sections using $(COMPILE_SCRIPT)..."
	$(PYTHON) $(COMPILE_SCRIPT) -s $(TVR_DIR) -o $@

# Ціль для очищення допоміжних файлів
clean:
	@echo "Cleaning up auxiliary files..."
	# Використовуємо latexmk для очищення, ігноруємо можливі помилки
	# Переходимо в директорії перед очищенням
	(cd $(OSS_DIR) && $(LATEXMK) -C -output-directory=../$(DIST_DIR) $(notdir $(OSS_SRC))) || true
	(cd $(SUD_DIR) && $(LATEXMK) -C -output-directory=../$(DIST_DIR) $(notdir $(SUD_SRC))) || true
	(cd $(SR_KAI_DIR) && $(LATEXMK) -C -output-directory=../$(DIST_DIR) $(notdir $(SR_KAI_SRC))) || true
	(cd $(KSU_DIR) && $(LATEXMK) -C -output-directory=../$(DIST_DIR) $(notdir $(KSU_SRC))) || true
	(cd $(CVKS_DIR) && $(LATEXMK) -C -output-directory=../$(DIST_DIR) $(notdir $(CVKS_SRC))) || true
	(cd $(TVR_DIR) && $(LATEXMK) -C -output-directory=../$(DIST_DIR) $(notdir $(TVR_SRC))) || true
	# Видаляємо директорію зі скомпільованими розділами
	@echo "Removing compiled sections directory $(COMPILED_DIR)..."
	rm -rf $(COMPILED_DIR)
	# Якщо потрібно також видалити PDF та директорію dist: rm -rf $(DIST_DIR)

# Оголошення цілей, що не є файлами
.PHONY: all clean compile_sections