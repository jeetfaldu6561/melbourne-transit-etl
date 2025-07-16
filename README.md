# 🚆 Public Transport Coverage ETL Project – Melbourne

This data engineering project analyzes the coverage and accessibility of public transport across Greater Melbourne using **GTFS (General Transit Feed Specification)** and **Australian Bureau of Statistics (ABS)** spatial datasets. It involves ingesting multi-format data (CSV, TXT, SHP), spatial processing using **PostGIS**, and delivering insights through SQL-based geospatial analysis.

---

## 📁 Project Structure

gtfs-melbourne-public-transport-etl/

├── sql/
│   ├── 01_schema_and_load.sql        # Create schema and load GTFS data  
│   ├── 02_preprocessing.sql          # Filter & transform mesh block boundaries  
│   ├── 03_analysis_queries.sql       # Gap & coverage analysis, vehicle density  
│   └── 04_helpers.sql                # Calendar flags, enriched joins  
├── appendix/
│   └── Report.pdf                    # Original project report with visuals & context  
├── README.md                         # Project overview and usage  
├── LICENSE                           # MIT License  
└── .gitignore                        # Common ignore rules  

---

## 🔍 Key Features

- 📦 **ETL Pipeline**: Loads and processes over 350K mesh blocks and GTFS transit data  
- 🌐 **Spatial Analysis**: Uses PostGIS to map transit stops, detect gaps, and join with LGAs and SALs  
- 🚊 **Vehicle Type Insights**: Identifies top LGAs/SALs by stop density for buses, trains, and trams  
- 🧠 **Reusable Queries**: Structured SQL scripts for easy reuse and deployment  

---

## 📚 Datasets Used

- **GTFS Victoria – 17 March 2023**  
  Source: https://www.ptv.vic.gov.au/footer/data-and-reporting/datasets/

- **Australian Statistical Geography Standard (ASGS)**  
  Source: https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026

---

## 🛠️ Tech Stack

| Tool         | Purpose                            |
|--------------|------------------------------------|
| PostgreSQL   | Relational database                |
| PostGIS      | Spatial extensions for SQL         |
| ogr2ogr      | Geospatial file format conversion  |
| Docker       | Isolated environment (optional)    |
| QGIS         | Map visualization                  |
| DBeaver      | SQL IDE for database interaction   |

---

## 🚀 Getting Started

1. Clone this repo:


2. Run the SQL files in the following order inside your PostgreSQL + PostGIS-enabled DB:
- `01_schema_and_load.sql`
- `02_preprocessing.sql`
- `04_helpers.sql`
- `03_analysis_queries.sql`

3. Open `Report.pdf` in the `/appendix` folder for visual references and methodology.

---

## 📈 Sample Outputs (Optional)

> Add screenshots inside the `/images` folder and embed them like below when using GitHub markdown:


---

## 📄 License

MIT License — see the `LICENSE` file for full details.

---

## 🙋 Author

**Jeet Faldu**  
Data Engineer | Data Analyst | AI Practitioner  
[LinkedIn](https://www.linkedin.com/in/jeetfaldu)