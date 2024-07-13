with
    source as (
        select * from {{ source("stellar_health_application", "medical_group_list") }}
    ),

    renamed as (

        select
            medical_group_id as id,
            groupname as name,
            state,
            {{ standardize_date_format("date_group_created") }} as created_date,
            number_of_users,
            number_of_patients
        from source

    )

select *
from renamed
