-- Which medical groups are focused on treating patients who are retired?
with
    initial_calculations as (
        select
            g.id as group_id,
            g.name as group_name,
            count(distinct pa.patient_id) filter (
                where age >= 65
            ) as total_retired_patients,
            count(distinct pa.patient_id) filter (
                where age < 65
            ) as total_working_patients

        from {{ ref("fact__patient_access") }} as pa
        left join {{ ref("dim__patient") }} as p on pa.patient_id = p.id
        left join {{ ref("dim__group") }} as g on pa.group_id = g.id
        group by 1, 2
    )
select
    group_id,
    group_name,
    total_retired_patients,
    total_working_patients,
    round(
        (total_retired_patients / (total_retired_patients + total_working_patients))
        * 100
    ) as retired_pct
from initial_calculations
order by retired_pct desc
limit 25
