#FINDING DUPLICATES USNIG ROW_NUMBER()

SELECT*
FROM layoffs_staging;

SELECT*,
ROW_NUMBER() OVER(PARTITION BY company,location, industry, total_laid_off, percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging;

# SHOW ONLY DUPLICATES ROWS

WITH duplicate_cte AS
(
SELECT*,
ROW_NUMBER() OVER(PARTITION BY company,location, industry, total_laid_off, percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT*
FROM duplicate_cte
WHERE row_num >1;

#CREATING A SECOND STAGING TABLE

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

# INSERTING DATA WITH ROW NUMBERS

INSERT INTO layoffs_staging2
SELECT*,
ROW_NUMBER() OVER(PARTITION BY company,location, industry, total_laid_off, percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging;

# VERIFING DUPLICATES

SELECT*
FROM layoffs_staging2
WHERE row_num >1;

# DELETING THE DUPLICATES

DELETE 
FROM layoffs_staging2
WHERE row_num>1;

# VERIFING THAT DUPLICATES ARE REMOVED

SELECT*
FROM layoffs_staging2
WHERE row_num >1;