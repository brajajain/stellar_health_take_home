select
    pal.id as access_id,
    pal.user_id,
    du.group_id,
    pal.patient_id,
    pal.accessed_date,
    -- PRE CALCULATED METRICS
    -- - Total Access Counts
    count(*) over (partition by pal.user_id) as total_accesses_by_user,
    count(*) over (partition by du.group_id) as total_accesses_by_medical_group,
    count(*) over (
        partition by du.group_id, pal.accessed_date
    ) as accesses_by_medical_group_on_date,
    count(*) over (
        partition by du.group_id, pal.accessed_date
    ) as accesses_by_user_on_date,
    sum(1) over (
        partition by pal.user_id order by accessed_date
    ) as accesses_by_user_to_date,
    sum(1) over (
        partition by du.group_id order by accessed_date
    ) as accesses_by_medical_group_to_date,

    -- - Total Patient Level Access Counts
    count(*) over (partition by pal.patient_id) as total_patient_accesses,
    count(*) over (
        partition by pal.user_id, pal.patient_id
    ) as total_patient_accesses_by_user,
    count(*) over (
        partition by du.group_id, pal.patient_id
    ) as total_patient_accesses_by_medical_group,
    count(*) over (
        partition by du.group_id, pal.patient_id, pal.accessed_date
    ) as patient_accesses_by_medical_group_on_date,
    count(*) over (
        partition by du.group_id, pal.patient_id, pal.accessed_date
    ) as patient_accesses_by_user_on_date,
    sum(1) over (
        partition by pal.user_id, pal.patient_id order by accessed_date
    ) as patient_accesses_by_user_to_date,
    sum(1) over (
        partition by du.group_id, pal.patient_id order by accessed_date
    ) as patient_accesses_by_medical_group_to_date,

    -- - Total Users, Group per Patient
    count(distinct pal.user_id) over (
        partition by pal.patient_id
    ) as total_users_accessed_patient,
    count(distinct du.group_id) over (
        partition by pal.patient_id
    ) as total_medical_groups_accessed_patient,

    -- - Total Users, Groups per Patient to Date
    count(distinct pal.user_id) over (
        partition by pal.patient_id
        order by pal.accessed_date
        rows between unbounded preceding and current row
    ) as users_accessed_patient_to_date,
    count(distinct du.group_id) over (
        partition by pal.patient_id
        order by pal.accessed_date
        rows between unbounded preceding and current row
    ) as medical_groups_accessed_patient_to_date

from {{ ref("raw_stellar_health_application__patient_access_log") }} pal
left join {{ ref("dim__user") }} as du on du.id = pal.user_id
order by total_accesses_by_medical_group desc, accessed_date, group_id, user_id
