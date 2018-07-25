view: liquid_madness {

derived_table: {
  sql:
  {% assign var =  _filters['liquid_madness.param'] %}
  {% assign vartwo = _filters['liquid_madness.paramtwo'] %}
      {% if var == "country" %}
    select country as field from users
        {% if vartwo == "y"  %}
            where 1=1
        {% else %}
            where 1=0
        {% endif %}
    {% elsif var == "state" %}
    select state as field from users
         {% if vartwo == "y"  %}
            where 1=1
        {% else %}
            where 1=0
        {% endif %}
    {% elsif var == "city" %}
    select city as field from users
         {% if vartwo == "y"  %}
            where 1=1
        {% else %}
            where 1=0
        {% endif %}
    {% else %}
    select id as field from users
         {% if vartwo == "y"  %}
            where 1=1
        {% else %}
            where 1=0
        {% endif %}
    {% endif %}
  ;;
}

dimension: field {}
parameter: param {
  type: string
  allowed_value: {
    label: "country"
    value: "country"
  }
  allowed_value: {
    label: "state"
    value: "state"
  }
  allowed_value: {
    label: "city"
    value: "city"
  }
}

parameter: paramtwo {
  type: string
  allowed_value: {
    label: "yes"
    value: "y"
  }
  allowed_value: {
    label: "no"
    value: "n"
  }

}

}
