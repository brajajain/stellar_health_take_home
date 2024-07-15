# Stellar Health Take Home

This project is a take-home assignment for the Senior Analytics Engineer role. It demonstrates the use of dbt (data build tool) to model, transform, and aggregate data from the Stellar Health application. The project involves generating mock data, organizing it in a data warehouse, and building dbt models for analysis.

## Project Resources 
 
- **Google Slide Deck**: [Project Presentation](https://docs.google.com/presentation/d/13R2xIiYSl9aL_KT0hyILIKo2d0PcVF3yF7tcvK4U9gE/)
 
- **dbdocs Website**: [Project Documentation](https://dbdocs.io/brajajain/stellar-health)

These resources provide a comprehensive overview of the project, including answers to the assignment questions and detailed documentation of the data models.

## Project Structure 

Here's an overview of the project directory structure:

```
.
├── Pipfile
├── Pipfile.lock
├── README.md
├── dbt_packages
│   └── dbt_date
├── dbt_project.yml
├── generate_mock_data.ipynb
├── macros
│   ├── standardize_date_format.sql
│   └── tests
├── models
│   ├── raw
│   │   └── stellar_health_application
│   │       ├── _stellar_health_application__schema.yml
│   │       ├── _stellar_health_application__sources.yml
│   │       ├── raw_stellar_health_application__medical_group_list.sql
│   │       ├── raw_stellar_health_application__medical_group_user.sql
│   │       ├── raw_stellar_health_application__patient_access_log.sql
│   │       └── raw_stellar_health_application__patient_demographics.sql
│   ├── transformed
│   │   ├── dimensions
│   │   │   ├── _dimensions__schema.yml
│   │   │   ├── dim__group.sql
│   │   │   ├── dim__patient.sql
│   │   │   └── dim__user.sql
│   │   └── facts
│   │       ├── _facts__schema.yml
│   │       └── fact__patient_access.sql
│   └── trusted
│       ├── _trusted__schema.yml
│       ├── scenario_1_medical_group_retired_patients.sql
│       └── scenario_1_patient_records.sql
├── package-lock.yml
├── packages.yml
├── profiles.yml
├── seeds
└── stellar_health.db
```

## Installation 
To set up the project, you need to have Python and `pipenv` installed. Follow these steps to install the project dependencies and set up the environment. 
1. **Clone the Repository**:

```bash
git clone https://github.com/brajajain/stellar_health_take_home.git
cd stellar_health_take_home
```
 
2. **Install Dependencies**:
Use `pipenv` to install the required packages.

```bash
pipenv install
```
 
3. **Activate the Virtual Environment**:

```bash
pipenv shell
```

## Generating Mock Data 

Before running dbt models, generate the mock data by executing the Jupyter notebook provided:
 
1. **Run the Jupyter Notebook**:
Open the `generate_mock_data.ipynb` notebook and run all cells to generate mock data and save it to `stellar_health.db`.

## Building and Testing Models with dbt 

To build and test the dbt models, use the following commands:
 
1. **Build the dbt Models**:

```bash
dbt build
```
 
2. **Run Tests**:

```bash
dbt test
```

## Additional Information 

### Macros 
 
- `macros/standardize_date_format.sql`: Contains SQL for standardizing date formats across tables.
 
- `macros/tests`: Directory for custom dbt tests.

### Models 
 
- **Raw Models**: Contain the initial data loaded from the source.
 
- **Transformed Models**: Include dimensions and fact tables.
 
- **Trusted Models**: Include business logic for specific scenarios and aggregated views.