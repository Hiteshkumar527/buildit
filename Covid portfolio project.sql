use coviddeaths;
select * from coviddeaths;
LOAD DATA INFILE 'CovidVaccinations.csv' INTO TABLE covidvaccinations
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@viso_code, @vcontinent, @vlocation, @vdate, @vnew_tests, @vtotal_tests, @vtotal_tests_per_thousand, @vnew_tests_per_thousand, @vnew_tests_smoothed, 
@vnew_tests_smoothed_per_thousand, @vpositive_rate, @vtests_per_case, @vtests_units, @vtotal_vaccinations, @vpeople_vaccinated, @vpeople_fully_vaccinated, @vnew_vaccinations, 
@vnew_vaccinations_smoothed, @vtotal_vaccinations_per_hundred, @vpeople_vaccinated_per_hundred, @vpeople_fully_vaccinated_per_hundred, @vnew_vaccinations_smoothed_per_million,
@vstringency_index, @vpopulation_density, @vmedian_age, @vaged_65_older, @vaged_70_older, @vgdp_per_capita, @vextreme_poverty, @vcardiovasc_death_rate, @vdiabetes_prevalence, 
@vfemale_smokers, @vmale_smokers, @vhandwashing_facilities, @vhospital_beds_per_thousand, @vlife_expectancy, @vhuman_development_index)

SET 
iso_code= NULLIF(@viso_code,''),
continent=NULLIF(@vcontinent,''), 
location=NULLIF(@vlocation,''), 
date=NULLIF(@vdate,''), 
new_tests = NULLIF(@vnew_tests,'' or ' '),
total_tests = NULLIF(@vtotal_tests,''),
total_tests_per_thousand = NULLIF(@vtotal_tests_per_thousand,''),
new_tests_per_thousand = NULLIF(@vnew_tests_per_thousand,''),
new_tests_smoothed	= NULLIF(@vnew_tests_per_smoothed,''),
new_tests_smoothed_per_thousand = NULLIF(@vnew_tests_smoothed_per_thousand,''),
positive_rate = NULLIF(@vpositive_rate,''),
tests_per_case = NULLIF(@vtests_per_case,''),
tests_units	= NULLIF(@vtests_units,''),
total_vaccinations = NULLIF(@vtotal_vaccinations,''),
people_vaccinated = NULLIF(@vpeople_vaccinated,''),
people_fully_vaccinated = NULLIF(@vpeople_fully_vaccinated,''),
new_vaccinations = NULLIF(@vnew_vaccinations,''),
new_vaccinations_smoothed = NULLIF(@vnew_vaccinations_smoothed,''),
total_vaccinations_per_hundred = NULLIF(@vtotal_vaccinations_per_hundred,''),
people_vaccinated_per_hundred = NULLIF(@vpeople_vaccinated_per_hundred,''),
people_fully_vaccinated_per_hundred	= NULLIF(@vpeople_fully_vaccinated_per_hundred,''),
new_vaccinations_smoothed_per_million = NULLIF(@vnew_vaccinations_smoothed_per_million,''),
stringency_index = NULLIF(@vstringency_index,''),
population_density = NULLIF(@vpopulation_density,''),
median_age = NULLIF(@vmedian_age,''),
aged_65_older = NULLIF(@vaged_65_older,''),
aged_70_older = NULLIF(@vaged_70_older,''),
gdp_per_capita = NULLIF(@vgdp_per_capita,''),
extreme_poverty = NULLIF(@vextreme_poverty,''),
cardiovasc_death_rate = NULLIF(@vcardiovasc_death_rate,''),
diabetes_prevalence = NULLIF(@vdiabetes_prevalence,''),
female_smokers = NULLIF(@vfemale_smokers,''),
male_smokers = NULLIF(@vmale_smokers,''),
handwashing_facilities = NULLIF(@vhandwashing_facilities,''),
hospital_beds_per_thousand = NULLIF(@vhospital_beds_per_thousand,''),
life_expectancy = NULLIF(@vlife_expectancy,''),
human_development_index = NULLIF(@vhuman_development_index,'');


DROP TABLE COVIDVACCINATIONS;
SET FOREIGN_KEY_CHECKS = 0;
CREATE TABLE covidvaccinations (
    iso_code VARCHAR(20) NULL,
    continent VARCHAR(40) NULL,
    location VARCHAR(50) NULL,
    date DATE NULL,
    new_tests INT NULL,
    total_tests	INT NULL DEFAULT 0,
    total_tests_per_thousand DECIMAL(10,3) NULL DEFAULT 0,	
    new_tests_per_thousand DECIMAL(10,3) NULL DEFAULT 0,
    new_tests_smoothed INT NULL DEFAULT 0,
    new_tests_smoothed_per_thousand	DECIMAL(10,3) NULL DEFAULT 0,
    positive_rate DECIMAL(10,3) NULL DEFAULT 0,
    tests_per_case DECIMAL(10,3) NULL DEFAULT 0,
    tests_units	VARCHAR(40) NULL DEFAULT 'NaN',
    total_vaccinations INT NULL DEFAULT 0,
    people_vaccinated INT NULL DEFAULT 0,
    people_fully_vaccinated	INT NULL DEFAULT 0,
    new_vaccinations INT NULL DEFAULT 0,
    new_vaccinations_smoothed INT NULL DEFAULT 0,
    total_vaccinations_per_hundred DECIMAL(10,3) NULL DEFAULT 0,
    people_vaccinated_per_hundred DECIMAL(10,3) NULL DEFAULT 0,
    people_fully_vaccinated_per_hundred	DECIMAL(10,3) NULL DEFAULT 0,
    new_vaccinations_smoothed_per_million DECIMAL(10,3) NULL DEFAULT 0,
    stringency_index DECIMAL(10,3) NULL DEFAULT 0,
    population_density DECIMAL(10,3) NULL DEFAULT 0,
    median_age DECIMAL(10,3) NULL DEFAULT 0,
    aged_65_older DECIMAL(10,3) NULL DEFAULT 0,
    aged_70_older DECIMAL(10,3) NULL DEFAULT 0,
    gdp_per_capita DECIMAL(10,3) NULL DEFAULT 0,
    extreme_poverty DECIMAL(10,3) NULL DEFAULT 0,
    cardiovasc_death_rate DECIMAL(10,3) NULL DEFAULT 0,
    diabetes_prevalence DECIMAL(10,3) NULL DEFAULT 0,
    female_smokers DECIMAL(10,3) NULL DEFAULT 0,
    male_smokers DECIMAL(10,3) NULL DEFAULT 0,
    handwashing_facilities DECIMAL(10,3) NULL DEFAULT 0,
    hospital_beds_per_thousand DECIMAL(10,3) NULL DEFAULT 0,
    life_expectancy	DECIMAL(10,3) NULL DEFAULT 0,
    human_development_index DECIMAL(10,3) DEFAULT 0
);

SHOW variables LIKE 'secure_file_priv';
SELECT * FROM covidvaccinations;
SELECT * FROM coviddeaths;

TRUNCATE TABLE coviddeaths;
LOAD DATA INFILE "CovidDeaths.csv" INTO TABLE coviddeaths
FIELDS TERMINATED BY ','
IGNORE 1 lines
(@viso_code, @vcontinent, @vlocation, @vdate, @vpopulation, @vtotal_cases, @vnew_cases, @vnew_cases_smoothed, @vtotal_deaths, @vnew_deaths, @vnew_deaths_smoothed, 
@vtotal_cases_per_million, @vnew_cases_per_million, @vnew_cases_smoothed_per_million, @vtotal_deaths_per_million, @vnew_deaths_per_million, @vnew_deaths_smoothed_per_million,	
@vreproduction_rate, @vicu_patients, @vicu_patients_per_million, @vhosp_patients, @vhosp_patients_per_million, @vweekly_icu_admissions, @vweekly_icu_admissions_per_million,
@vweekly_hosp_admissions, @vweekly_hosp_admissions_per_million)

SET
   iso_code	= NULLIF(@viso_code, ''),
   continent = NULLIF(@vcontinent, ''),	
   location = NULLIF(@vlocation, ''),
   date = NULLIF(@vdate, ''),
   population = NULLIF(@vpopulation, ''),	
   total_cases = NULLIF(@vtotal_cases, ''),
   new_cases = NULLIF(@vnew_cases, ''),
   new_cases_smoothed = NULLIF(@vnew_cases_smoothed, ''),	
   total_deaths = NULLIF(@vtotal_deaths, ''),
   new_deaths = NULLIF(@vnew_deaths, ''),
   new_deaths_smoothed = NULLIF(@vnew_deaths_smoothed, ''),
   total_cases_per_million = NULLIF(@vtotal_cases_per_million, ''),	
   new_cases_per_million = NULLIF(@vnew_cases_per_million, ''),
   new_cases_smoothed_per_million = NULLIF(@vnew_cases_smoothed_per_million, ''),	
   total_deaths_per_million = NULLIF(@vtotal_deaths_per_million, ''),
   new_deaths_per_million = NULLIF(@vnew_deaths_per_million, ''),
   new_deaths_smoothed_per_million = NULLIF(@vnew_deaths_smoothed_per_million, ''),
   reproduction_rate = NULLIF(@vreproduction_rate, ''),
   icu_patients = NULLIF(@vicu_patients, ''),
   icu_patients_per_million = NULLIF(@vicu_patients_per_million, ''),	
   hosp_patients = NULLIF(@vhosp_patients, ''),
   hosp_patients_per_million = NULLIF(@vhosp_patients_per_million, ''),	
   weekly_icu_admissions = NULLIF(@vweekly_icu_admissions, ''),
   weekly_icu_admissions_per_million = NULLIF(@vweekly_icu_admissions_per_million, ''),	
   weekly_hosp_admissions = NULLIF(@vweekly_hosp_admissions, ''),
   weekly_hosp_admissions_per_million = NULLIF(@weekly_hosp_admissions_per_million, '')
;

ALTER TABLE coviddeaths
MODIFY column population bigint;

SELECT 
    *
FROM
    coviddeaths
ORDER BY 3,4;

-- looking at total_cases vs total_deaths
SELECT 
    location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentage
FROM
    coviddeaths
where location like "%India%"
order by 1,2;

-- looking at total_cases vs population
-- percentage of population who got affected by covid
SELECT 
    location, date, total_cases, population, (total_cases/population)*100 as casepercentage
FROM
    coviddeaths
where location like "%India%"
order by 1,2;

-- countries with highest infection rate compared to it population
SELECT 
    location, population, max(total_cases) as HighestInfcount, (max(total_cases)/population)*100 as infpercentage
FROM
    coviddeaths
group by location, population
order by infpercentage desc;

-- countries with highest death count per population
select location, max(cast(total_deaths as unsigned)) as totaldeathcount, population, (max(cast(total_deaths as unsigned))/population)*100 as deathcountperpopulation
from coviddeaths
where continent is not null
group by location, population
order by deathcountperpopulation desc;

-- lets break things by continent
select continent, max(cast(total_deaths as unsigned)) as totaldeathcount
from coviddeaths
where continent is not null
group by continent
order by totaldeathcount desc;

-- global data for each date
select  sum(new_cases), sum(cast(new_deaths as signed)), (sum(cast(new_deaths as signed))/sum(new_cases))*100 as deathpercent
from coviddeaths
where continent is not null
-- group by date
order by date;

select * from covidvaccinations;

-- looking at total population vs vaccinations
SELECT 
    d.continent, d.location, d.date, d.population, v.new_vaccinations, 
    sum(v.new_vaccinations) OVER (Partition by d.location order by d.location, d.date) as Rollingpeoplevaccinated
FROM
    coviddeaths d
        JOIN
    covidvaccinations v ON d.location = v.location
        AND d.date = v.date
where d.continent is not null
order by 2,3;


-- use CTE
with popvsvac ( continent, location, date, population,new_vaccinations, Rollingpeoplevaccinated)
as 
(SELECT 
    d.continent, d.location, d.date, d.population, v.new_vaccinations, 
    sum(v.new_vaccinations) OVER (Partition by d.location order by d.location, d.date) as Rollingpeoplevaccinated
FROM
    coviddeaths d
        JOIN
    covidvaccinations v ON d.location = v.location
        AND d.date = v.date
where d.continent is not null
order by 2,3)
select *, (Rollingpeoplevaccinated/ population)*100 from popvsvac;

-- temp table
Drop table if exists Percentpopulationvaccinated;
CREATE TABLE Percentpopulationvaccinated
(
  Continent nvarchar(255),
  location nvarchar(255),
  date datetime,
  population numeric,
  new_vaccinations numeric,
  RollingPeoplevaccinated numeric
  );
Insert into Percentpopulationvaccinated
SELECT 
    d.continent, d.location, d.date, d.population, v.new_vaccinations, 
    sum(v.new_vaccinations) OVER (Partition by d.location order by d.location, d.date) as Rollingpeoplevaccinated
FROM
    coviddeaths d
        JOIN
    covidvaccinations v ON d.location = v.location
        AND d.date = v.date
where d.continent is not null;
-- order by 2,3

-- create view
create view vPercentpopulationvaccinated as 
SELECT 
    d.continent, d.location, d.date, d.population, v.new_vaccinations, 
    sum(v.new_vaccinations) OVER (Partition by d.location order by d.location, d.date) as Rollingpeoplevaccinated
FROM
    coviddeaths d
        JOIN
    covidvaccinations v ON d.location = v.location
        AND d.date = v.date
where d.continent is not null
