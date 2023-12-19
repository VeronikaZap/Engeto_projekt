# Engeto_projekt
Cílem Engeto SQL projektu bylo vytvořit dvě tabulky a odpovědět na 5 otázek. V některých případech data chybí, třeba ceny potravin jsou zaznamenány jen v letech 2006-2018.
Nejdříve se musely vytvořit tabulky, ze kterých se pak dalo odpovědět na otázky. Do primary final se čerpalo z dat czechia_payroll, czechia_payroll_calculation, czechia_payroll_industry_branch, czechia_payroll_unit, czechia_payroll_value_type, czechia_price a czechia_price_category. Pro lepší odpovídání na otázky jsem si i rovnou vytvořila sloupec s průměrnou mzdou za všechna odvětví v daném roce.
U tabulky secondary final se čerpalo z economies a countries. Po vytvoření tabulek se šlo na zodpovězení otázek.

1.Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
Mzdy ve všech letech nerostou, u některých odvětví je mzda vyšší než následující rok. Například v oblasti peněžnictví a pojišťovnictví byla mzda v roce 2013 nižší než v roce 2012. Je tomu tak u více odvětví, například činnosti v oblasti nemovitostí, těžba a dobývání a další.

2.Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
První srovnatelné období je rok 2006 a poslední je rok 2018. V roce 2006 lze koupit 1 437,44 litrů mléka a v roce 2018 je to 1 641,64 litrů. Chleba lze koupit v roce 2006 1 287,18 kg a v roce 2018 je to 1 342,33 kg.

3.Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
Dle dat zdražují nejpomaleji rajská jablka červená kulatá.

4.Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
Podle dat žádný takový rok není.

5.Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
Dle dat nejde určit. Průměrná mzda má kromě roku 2013 rostoucí tendenci. Když v roce HDP výrazněji vzrostlo, tak v dalším roce byly ceny nižší. Ale když HDP vzrostlo v roce 2011, ceny byly následující rok zase vyšší. Z dat lze určit, že HDP ceny výrazněji neovlivňuje.
