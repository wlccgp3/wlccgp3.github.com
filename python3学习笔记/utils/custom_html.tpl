{%- extends 'full.tpl' -%}

{% block input_group -%}
{%- if cell.metadata.hide_input or nb.metadata.hide_input -%}
{%- else -%}
{{ super() }}
{%- endif -%}
{% endblock input_group %}

{% block output_group -%}
{%- if cell.metadata.hide_output -%}
{%- else -%}
    {{ super() }}
{%- endif -%}
{% endblock output_group %}

{% block output_area_prompt %}
{%- if cell.metadata.hide_input or nb.metadata.hide_input -%}
    <div class="prompt"> </div>
{%- else -%}
    {{ super() }}
{%- endif -%}
{% endblock output_area_prompt %}

{%- block header -%}
{{ super() }}

 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.css">

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>

<link rel="stylesheet" type="text/css" href="https://rawgit.com/ipython-contrib/jupyter_contrib_nbextensions/master/src/jupyter_contrib_nbextensions/nbextensions/toc2/main.css">

<style type="text/css">

table>tbody>tr:hover {
    background-color: hsl(176, 64%, 96%);
}

.rendered_html td, .rendered_html th {
    border: none;
    padding-left: 15px;
    padding-right: 15px;
    text-align: center;
    max-width: 320px !important;
}

.rendered_html table, .rendered_html tr{
    border-left: 0px;
    border-right: 0px;
    margin-left: 30px;
    font-size: 14px;
}
/* 输出底部水平线 */
div.output_subarea {
    border-bottom: 1px solid hsl(0, 0%, 93%);
}
/* 输出颜色 */
div.output_area pre {
    color: #2410f5;
}

/* md高亮 */
.rendered_html pre, .rendered_html code {
    background-color: hsl(0, 0%, 91%);
}

/* 宽度自适应 */
#notebook-container {
    width: auto !important;
    margin-right: 15%;
    margin-left: 350px;
}

@font-face {
    font-family: 'FontAwesome';
    src: url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/fonts/fontawesome-webfont.eot');
    src: url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/fonts/fontawesome-webfont.eot?#iefix') format('embedded-opentype'),
         url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/fonts/fontawesome-webfont.woff') format('woff'),
         url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/fonts/fontawesome-webfont.ttf') format('truetype'),
         url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/fonts/fontawesome-webfont.svg#fontawesomeregular') format('svg');
    font-weight: normal;
    font-style: normal;
}
</style>

<script src="https://rawgit.com/ipython-contrib/jupyter_contrib_nbextensions/master/src/jupyter_contrib_nbextensions/nbextensions/toc2/toc2.js"></script>

<script>
$( document ).ready(function(){
    var cfg={'threshold':{{ nb.get('metadata', {}).get('toc', {}).get('threshold', '3') }},     // depth of toc (number of levels)
     'number_sections': {{ 'true' if nb.get('metadata', {}).get('toc', {}).get('number_sections', False) else 'false' }},  // sections numbering
     'toc_cell': false,          // useless here
     'toc_window_display': true, // display the toc window
     "toc_section_display": "block", // display toc contents in the window
     'markTocItemOnScroll': {{ 'true' if nb.get('metadata', {}).get('toc', {}).get('markTocItemOnScroll', False) else 'false' }},
     'sideBar':{{ 'true' if nb.get('metadata', {}).get('toc', {}).get('sideBar', False) else 'false' }},             // sidebar or floating window
     'navigate_menu':false       // navigation menu (only in liveNotebook -- do not change)
    }

    var st={};                  // some variables used in the script
    st.oldTocHeight = undefined

    // fire the main function with these parameters
    require(['nbextensions/toc2/toc2'], function (toc2) {
        toc2.table_of_contents(cfg, st);
    });
    });
</script>


{%- endblock header -%}