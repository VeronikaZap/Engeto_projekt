-- Vytvoření první tabulky
CREATE TABLE t_Veronika_Zapletalova_project_SQL_primary_final4 AS (
SELECT 
	cpf.average_price,
	cpf.price_value,
	cpf.price_unit,
	cpf.category_code,
	cpf.unit_name,
	cpayf.average_wages_all,
	cpayf.average_wages,
	cpayf.currency,
	cpayf.industry_branch_code,
	cpayf.industry_name,
	cpayf.payroll_year AS year
FROM (
	SELECT
		avg(cp.value) AS average_price,
		cpc.price_value,
		cpc.price_unit,
		cp.category_code,
		cpc.name AS unit_name,
		year(cp.date_from) AS year_name
	FROM czechia_price cp
	LEFT JOIN czechia_price_category cpc
	ON cp.category_code=cpc.code
	WHERE cp.region_code IS NULL
	GROUP BY cp.category_code, year(cp.date_from)
	) AS cpf
RIGHT JOIN (
	SELECT
		cpall.average_wages_all,
		avg(cpay.value) AS average_wages,
		cpu.name AS currency,
		cpay.industry_branch_code,
		cpib.name AS industry_name,
		cpay.payroll_year
	FROM czechia_payroll cpay
	LEFT JOIN czechia_payroll_industry_branch AS cpib
		ON cpay.industry_branch_code=cpib.code
	LEFT JOIN czechia_payroll_unit cpu
	ON cpay.unit_code=cpu.code
LEFT JOIN (
	SELECT
		avg(cpal.value) AS average_wages_all,
		cpal.payroll_year
	FROM czechia_payroll cpal
	WHERE cpal.value_type_code=5958 
		AND cpal.industry_branch_code IS NOT NULL
	GROUP BY cpal.payroll_year
	) AS cpall
	ON cpay.payroll_year=cpall.payroll_year
	WHERE cpay.value_type_code=5958 
		AND cpay.industry_branch_code IS NOT NULL
	GROUP BY cpay.payroll_year, cpay.industry_branch_code
	) AS cpayf
	ON cpf.year_name*=*cpayf.payroll_year);
	

-- Vytvoření druhé tabulky
 

CREATE TABLE t_Veronika_Zapletalova_project_SQL_secondary_final AS (
SELECT 
        ec.country,
        ec.GDP,
        ec.year,
        ec.gini,
        ec.population
FROM economies AS ec
LEFT JOIN countries AS ct
ON ec.country=ct.country
WHERE ct.continent="Europe" AND ec.year>=2000 AND ec.year<=2021);


-- První otázka 

SELECT DISTINCT 
	tvzpspf.industry_name,
	tvzpspf.average_wages,
	tvzpspf.`year`,
	tvzpspf2.`year` + 1 AS year_prev,
	round((tvzpspf.average_wages -tvzpspf2.average_wages)/tvzpspf2.average_wages*100,2) AS percent
FROM t_Veronika_Zapletalova_project_SQL_primary_final4 tvzpspf 
JOIN t_Veronika_Zapletalova_project_SQL_primary_final4 tvzpspf2
	ON tvzpspf.industry_name=tvzpspf2.industry_name  
	AND tvzpspf.`year` = tvzpspf2.`year` + 1
	AND tvzpspf.`year` < 2021;

-- Druhá otázka

-- mléko
SELECT DISTINCT 
	`year`,
	ROUND(average_wages_all/ average_price, 2) AS amount 
FROM t_Veronika_Zapletalova_project_SQL_primary_final4 tvzpspf
WHERE category_code = '114201'
	AND `year` = (2006)
UNION 
	SELECT DISTINCT 
		`year`,
		ROUND(average_wages_all/ average_price, 2) AS amount 
	FROM t_Veronika_Zapletalova_project_SQL_primary_final4 tvzpspf
	WHERE category_code = '114201'
		AND `year` = (2018);
-- chleba
SELECT DISTINCT 
	`year`,
	round(average_wages_all/ average_price, 2) AS amount 
FROM t_Veronika_Zapletalova_project_SQL_primary_final4 tvzpspf
WHERE category_code IN  ('111301')
	AND `year` = (2006)
UNION 
	SELECT DISTINCT 
		`year`,
		round(average_wages_all/ average_price, 2) AS amount 
	FROM t_Veronika_Zapletalova_project_SQL_primary_final4 tvzpspf
	WHERE category_code = '111301'
		AND `year` = (2018);


-- Třetí otázka

SELECT DISTINCT 
	tvzpspf.unit_name,
	tvzpspf.average_price,
	tvzpspf.`year`,
	tvzpspf2.`year` + 1 AS year_prev,
	round((tvzpspf.average_price-tvzpspf2.average_price)/tvzpspf2.average_price*100,2) AS percent
FROM t_Veronika_Zapletalova_project_SQL_primary_final4 tvzpspf 
JOIN t_Veronika_Zapletalova_project_SQL_primary_final4 tvzpspf2
	ON tvzpspf.unit_name=tvzpspf2.unit_name 
	AND tvzpspf.`year` = tvzpspf2.`year` + 1
	AND tvzpspf.`year` < 2021;
	

-- Čtvrtá otázka


SELECT DISTINCT 
	tvzpspf.unit_name,
	avg(tvzpspf.average_price),
	tvzpspf.`year`,
	tvzpspf2.`year` + 1 AS year_prev,
	round((avg(tvzpspf.average_price)-avg(tvzpspf2.average_price))/avg(tvzpspf2.average_price)*100,2) AS percent,
	round((tvzpspf.average_wages_all-tvzpspf2.average_wages_all)/tvzpspf2.average_wages_all*100,2) AS wages_growth
FROM t_Veronika_Zapletalova_project_SQL_primary_final4 tvzpspf
JOIN t_Veronika_Zapletalova_project_SQL_primary_final4 tvzpspf2
	ON tvzpspf.unit_name=tvzpspf2.unit_name 
	AND tvzpspf.`year` = tvzpspf2.`year` + 1
HAVING percent - wages_growth>10;


-- Pátá otázka

	
SELECT 
	tvzpspf.`year`, 
	avg(tvzpspf.average_price) AS average_price_all, 
	tvzpspf.average_wages_all,
	secondary.population,
	secondary.GDP as GDP,
	(secondary.GDP/secondary.population) AS GDP_per_capita
FROM t_Veronika_Zapletalova_project_SQL_primary_final4 tvzpspf 
JOIN (
        SELECT
                GDP,
                YEAR,
                population
        FROM t_Veronika_Zapletalova_project_SQL_secondary_final
        WHERE country="Czech Republic"
) AS secondary 
ON tvzpspf.year = secondary.year
GROUP BY tvzpspf.`year`;	
	
