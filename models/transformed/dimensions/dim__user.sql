-- models/dimensions/dim__user.sql
with
    source as (
        select * from {{ ref("raw_stellar_health_application__medical_group_user") }}
    )

select
    id,
    medical_group_id as group_id,
    username,
    role,
    created_date,
    last_login_date,
    -- Added business logic for role descriptions
    case
        when role = 'admin'
        then 'Administrator'
        when role = 'doctor'
        then 'Doctor'
        when role = 'nurse'
        then 'Nurse'
        else 'Other'
    end as user_role_description
from source
