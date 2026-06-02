{% macro transform_otra_enfermedad(table) %}
    {% set diseases %}
        ["Hematologica","Cardíaca","Enfermedad coronaria","Diabetes Mellitus","Endocrina","Gastrointestinal",
            "Hepatopatía crónica", "Hipertensión arterial","Neurológica","Pulmonar","Renal","Trombofilia",
            "Urológica","Vascular","VIH"]
    {% endset %}

    {% for i in diseases %}
        select sum(i)
        from {{ source("etl_adt", "bronze_data") }}
    {% endfor %}
{% endmacro %}