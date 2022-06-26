--Displaying Location, date, total_cases, new_cases, total_deaths, population from CovidDeaths.xlsx

SELECT * 
FROM Project_1..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
From Project_1..CovidDeaths
Where continent is not null 
order by 1,2

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in India in descending order

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From Project_1..CovidDeaths
Where location LIKE '%India%'
and continent is not null 
order by DeathPercentage DESC


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From Project_1..CovidDeaths
Where location LIKE '%India%'
and continent is not null 
order by PercentPopulationInfected DESC

---- Countries with Highest Infection Rate compared to Population


Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Project_1..CovidDeaths
Group by Location, Population
order by PercentPopulationInfected desc

-- Countries with Highest Death Count per Population

Select Location, MAX(cast (Total_deaths as int)) as TotalDeathCount
From Project_1..CovidDeaths 
Where continent is not null 
Group by Location
order by TotalDeathCount desc

-- Continents with Highest Death Count per Population
Select continent,MAX(CAST(total_deaths AS int)/ population) as Death_count
From Project_1..CovidDeaths
Where continent is not null 
GROUP BY continent
order by Death_count DESC


-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Project_1..CovidDeaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

--Joining CovidDeaths and CovidVaccinations excel sheets based on location and date

SELECT *
FROM Project_1..CovidDeaths Dea
JOIN Project_1..CovidVaccinations Vac
ON Dea.location=Vac.location
AND Dea.date=Vac.date
where Dea.continent is not null 
order by 2,3


--Total population VS Vaccination

SELECT DISTINCT Dea.continent,Dea.location,  Dea.date,Dea.population,Vac.new_vaccinations
FROM Project_1..CovidDeaths Dea
JOIN Project_1..CovidVaccinations Vac
ON Dea.location=Vac.location
AND Dea.date=Vac.date
where Dea.continent is not null 
order by 2,3


SELECT DISTINCT Dea.continent,Dea.location, Dea.date,Dea.population,Vac.new_vaccinations,
SUM(CAST(Vac.new_vaccinations AS int)) OVER (PARTITION BY Dea.location Order by Dea.location, Dea.Date)AS Vaccination_count
FROM Project_1..CovidDeaths Dea
JOIN Project_1..CovidVaccinations Vac
ON Dea.location=Vac.location
AND Dea.date=Vac.date
where Dea.continent IS NOT NULL
order by 2,3


Select Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations
, SUM(CONVERT(int,Vac.new_vaccinations)) OVER (Partition by Dea.Location Order by Dea.location, Dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Project_1..CovidDeaths Dea
Join Project_1..CovidVaccinations Vac
	On Dea.location = Vac.location
	and Dea.date = Vac.date
where Dea.continent is not null 
order by 2,3

-- Using CTE

With VacVSPop 
AS (
Select Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations
, SUM(CONVERT(int,Vac.new_vaccinations)) OVER (Partition by Dea.Location Order by Dea.location, Dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Project_1..CovidDeaths Dea
Join Project_1..CovidVaccinations Vac
	On Dea.location = Vac.location
	and Dea.date = Vac.date
where Dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From VacVSPop 