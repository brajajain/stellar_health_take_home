with
    source as (
        select * from {{ ref("raw_stellar_health_application__medical_group_list") }}
    )

select id, name, state, created_date, number_of_users, number_of_patients
from source
