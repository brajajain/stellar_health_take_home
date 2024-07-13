with
    source as (
        select * from {{ ref("raw_stellar_health_application__patient_demographics") }}
    )

select id, age, weight, last_visit_date
from source
