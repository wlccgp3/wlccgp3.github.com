{%- extends 'basic.tpl' -%}
{% from 'mathjax.tpl' import mathjax %}


{%- block header -%}
<!DOCTYPE html>
<html>
<head>
{%- block html_head -%}
<meta charset="utf-8" />
<title>{{resources['metadata']['name']}}</title>

<script src="/lib/require/index.js"></script>
<script src="/lib/jquery/index.js"></script>

<!-- 改为引入外部样式 -->
<link rel="stylesheet" href="/css/custom.css">

{%- macro mathjax(url='/lib/mathjax/index.js') -%}
    <!-- Load mathjax -->
    <script src="{{url}}"></script>
    <!-- MathJax configuration -->
    <script type="text/x-mathjax-config">
    MathJax.Hub.Config({
        tex2jax: {
            inlineMath: [ ['$','$'], ["\\(","\\)"] ],
            displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
            processEscapes: true,
            processEnvironments: true
        },
        // Center justify equations in code and markdown cells. Elsewhere
        // we use CSS to left justify single line equations in code cells.
        displayAlign: 'center',
        "HTML-CSS": {
            styles: {'.MathJax_Display': {"margin": 0}},
            linebreaks: { automatic: true }
        }
    });
    </script>
    <!-- End of mathjax configuration -->
{%- endmacro %}

<!-- Loading mathjax macro -->
{{ mathjax() }}
{%- endblock html_head -%}
</head>
{%- endblock header -%}

{% block body %}
<body>
<div class="toc">
<ul>
{%- for cell in nb.cells -%}
    {%- if cell.cell_type in ['markdown'] -%}
        {%- if resources.global_content_filter.include_markdown and not cell.get("transient",{}).get("remove_source", false) -%}
            {%- for i in cell.source.split('\n') -%}
                {%- if i.startswith('#') -%}
                    {% if i.split(None, 1)[0].startswith('#') %}
                        {% set h_len = i.split(None, 1)[0] | length %}
                        {% set h_text = i.split(None, 1)[-1] %}
                        <li class="toc-li-{{ h_len }}">
                            <a href="#{{ i.split(None, 1)[-1].split() | join('-') }}">{{ h_text }}</a>
                        </li>
                    {% endif %}
                {% endif %}
            {% endfor %}
        {%- endif -%}
    {%- endif -%}
{%- endfor -%}
</ul>
</div>
  <div tabindex="-1" id="notebook" class="border-box-sizing">
    <div class="container" id="notebook-container">
{{ super() }}
    </div>
  </div>
</body>
{%- endblock body %}

{% block footer %}
{{ super() }}
</html>
{% endblock footer %}
