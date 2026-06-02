{%- macro discretize_values(column, intervals, lower_bound = 0, lower_value = -1, upper_value = 999) -%}
    case
        {% for lower, upper, value in intervals %}
            when ({{ column }} >= {{ lower }}) and ({{ column }} < {{ upper }}) then {{ value }}
        {% endfor %}
        when {{ column }} < {{ lower_bound }} then {{ lower_value }}
        else {{ upper_value }}
    end
{%- endmacro -%}