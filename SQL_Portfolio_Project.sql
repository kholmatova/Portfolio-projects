SELECT * 
FROM PortfolioProject..CovidDeaths
ORDER BY 3,4;


select * 
from PortfolioProject..CovidVaccinations
order by 3,4;


--Looking at the total cases and total deaths
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as TotalDeathsPercentage
FROM PortfolioProject..CovidDeaths
Where location = 'Uzbekistan'
ORDER BY 1,2;


--Looking at the total cases vs population
SELECT location, date, total_cases, population, (total_cases/population) * 100 as TotalInfectionPercentage
FROM PortfolioProject..CovidDeaths
Where location = 'Uzbekistan'
ORDER BY 1,2;


SELECT location, population, date, Max(total_cases) as HighestInfectionCount, Max(total_cases/population) * 100 as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
Where Location not like '%income%'  and continent is not null --and location not in ('International', 'Africa', 'North America')
GROUP BY location, population, date
ORDER BY PercentPopulationInfected desc;

--Looking at the countries with the highest infection rate compared to population
SELECT location, population, Max(total_cases) as HighestInfectionCount,  Max((total_cases/population)) * 100 as TotalPopulationInfected
FROM PortfolioProject..CovidDeaths
Group by Location, Population
ORDER BY TotalPopulationInfected desc;


--Looking at the population death count by income level
SELECT location, Max(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
Where Location like '%income%'
Group by location
ORDER BY TotalDeathCount desc;


--Looking at the death count per country
SELECT location, Max(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
where continent is not null 
Group by location
ORDER BY TotalDeathCount desc;


--Looking at the death count in Uzbekistan
SELECT location, Max(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
where continent is not null and location = 'Uzbekistan'
Group by location
ORDER BY TotalDeathCount;

--Looking at the highest death count per population
SELECT location, Max(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
where continent is not null 
Group by location
ORDER BY TotalDeathCount desc;


--Looking at the highest death count per population
SELECT location, Max(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
where continent is null and location not in ('World', 'European Union', 'International', 'Upper middle income', 'High income', 'Lower middle income', 'Low income')
Group by location
ORDER BY TotalDeathCount desc;



--Looking at the continents with the highest death count per population
SELECT continent, Max(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null 
Group by continent
ORDER BY TotalDeathCount desc;

--Looking at global numbers
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
--WHERE location = 'Uzbekistan'
WHERE continent is not null 
--GROUP BY date
ORDER BY 1,2


Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3



