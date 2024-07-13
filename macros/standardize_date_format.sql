-- macros/standardize_date_format.sql
{% macro standardize_date_format(date_column) %}
    CASE
        WHEN {{ date_column }} IS NULL THEN NULL
        ELSE STRPTIME({{ date_column }}::VARCHAR, '%Y-%m-%d %H:%M:%S.%f')
    END
{% endmacro %}
