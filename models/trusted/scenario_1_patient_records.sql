select count(distinct patient_id) as total_patients
from {{ ref("fact__patient_access") }}
where
    accessed_date > (current_date - interval '14 months')
    and users_accessed_patient_to_date >= 5
