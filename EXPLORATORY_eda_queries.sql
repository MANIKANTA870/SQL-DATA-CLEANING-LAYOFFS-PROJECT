# EXPLORATORY DATA ANALYSIS

# TOTAL NUMBER OF ROWS 

SELECT COUNT(*) AS total_records
FROM layoffs_staging2;

# NUMBER OF UNIQUE COMPANIES

SELECT COUNT(DISTINCT(company))
FROM layoffs_staging2;

# TOP 5 COMPANIES BY LAYOFFS

SELECT company,sum(total_laid_off) AS TOTAL_LAYOFFS
FROM layoffs_staging2
GROUP BY company
ORDER BY TOTAL_LAYOFFS DESC
LIMIT 5;

# LAYOFFS BY INDUSTRY

SELECT industry,sum(total_laid_off) AS TOTAL_LAYOFFS
FROM layoffs_staging2
GROUP BY industry
ORDER BY TOTAL_LAYOFFS DESC
LIMIT 5;

# LAYOFFS BY COUNTRY

SELECT country,sum(total_laid_off) AS TOTAL_LAYOFFS
FROM layoffs_staging2
GROUP BY country
ORDER BY TOTAL_LAYOFFS DESC
LIMIT 5;

# LAYOFFS BY YEAR

SELECT YEAR(`date`) AS year,
		sum(total_laid_off) AS TOTAL_LAYOFFS
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY TOTAL_LAYOFFS DESC
LIMIT 5;

#COMPANIES WITH 100% LAYOFFS

SELECT company, percentage_laid_off
FROM layoffs_staging2
WHERE percentage_laid_off = 1
GROUP BY company;

# TOP 3 COMPANIES BY LAYOFFS
SELECT country,SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY country
ORDER BY total_layoffs DESC
LIMIT 3;

# RANK COMPANIES BY LAYOFFS
SELECT company, SUM(total_laid_off) AS total_layoffs,
	RANK() OVER(ORDER BY SUM(total_laid_off)DESC) AS rank_company
FROM layoffs_staging2
GROUP BY company
LIMIT 5;

#RUNNING TOTAL OF LAYOFFS
WITH monthly_totals AS(
	SELECT DATE_FORMAT(`date`, '%Y-%m') AS month,
    SUM(total_laid_off) AS total_layoffs
    FROM layoffs_staging2
    GROUP BY month
)
SELECT month,
	total_layoffs,
    SUM(total_layoffs) OVER(
    ORDER BY month) AS running_total
FROM monthly_totals
WHERE MONTH IS NOT NULL;

#NUMBER OF COMPANIES IN EACH INDUSTRY
SELECT industry,
	COUNT(DISTINCT (company)) AS company_count
FROM layoffs_staging2
GROUP BY industry
ORDER BY company_count DESC;

#AVERAGE LAYOFFS BY INDUSTRY
SELECT industry,
		ROUND(AVG(total_laid_off),2) AS avg_layoffs
FROM layoffs_staging2
WHERE INDUSTRY IS NOT NULL
GROUP BY industry
ORDER BY avg_layoffs DESC;

# LAYOFFS BY STAGE
SELECT STAGE,
		SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY STAGE
ORDER BY total_layoffs DESC;

# INDUSTRIES WITH MORE THAN 10,000 LAYOFFS
SELECT industry,SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY industry
HAVING total_layoffs >10000;

# COUNTRIES WITH MORE THEN 5 COMPANIES

SELECT country,
		COUNT(DISTINCT(company)) AS company_count
FROM layoffs_staging2
GROUP BY country
HAVING company_count > 5;