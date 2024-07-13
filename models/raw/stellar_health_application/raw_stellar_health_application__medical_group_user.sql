with
    source as (
        select * from {{ source("stellar_health_application", "medical_group_user") }}
    ),

    renamed as (

        select
            user_id as id,
            medical_group_id,
            username,
            password,
            role,
            {{ standardize_date_format("date_user_created") }} as created_date,
            {{ standardize_date_format("last_login_date") }} as last_login_date
        from source

    )

select *
from renamed
