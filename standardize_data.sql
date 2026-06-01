# 2. STANDARDIZING DATA

SELECT DISTINCT(company)
FROM layoffs_staging2
ORDER BY 1;

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company)
;

SELECT DISTINCT(industry)
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT(industry)
FROM layoffs_staging2
WHERE industry LIKE 'crypto%';

UPDATE layoffs_staging2
SET industry = 'crypto'
WHERE industry LIKE 'crypto%';

SELECT DISTINCT(country)
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT(country)
FROM layoffs_staging2
WHERE country LIKE 'united states%';

UPDATE layoffs_staging2
SET country = 'united states'
WHERE country LIKE 'united states%';

SELECT `date`
FROM layoffs_staging2;

SELECT `date`,
STR_TO_DATE(`date` , '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date` , '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date`  DATE;