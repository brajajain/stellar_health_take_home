with
    source as (
        select * from {{ source("stellar_health_application", "patient_access_log") }}
    ),

    renamed as (

        select
            access_id as id,
            patient_id,
            user_id,
            {{ standardize_date_format("date_accessed") }} as accessed_date
        from source

    )

select *
from renamed
