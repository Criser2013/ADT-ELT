{%- macro transform_bool(column) -%}
    case
        when lower(cast({{ column }} as text)) in ('0', 'ni', 'no', 'n') then 0
        when cast({{ column }} as text) is not null then 1
        when ({{ column }} is null) then null
        when cast({{ column }} as numeric) = 1 then 1
        when cast({{ column }} as numeric) = 0 then 0
        else 1
    end
{%- endmacro -%}