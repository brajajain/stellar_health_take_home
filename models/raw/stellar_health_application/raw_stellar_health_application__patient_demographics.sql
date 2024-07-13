with
    source as (
        select * from {{ source("stellar_health_application", "patient_demographics") }}
    ),

    renamed as (

        select
            patient_id as id,
            age,
            weight,
            {{ standardize_date_format("last_visit_date") }} as last_visit_date
        from source

    )

select *
from renamed
