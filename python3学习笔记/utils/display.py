#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from IPython.display import publish_display_data
from IPython.core.interactiveshell import InteractiveShell


def custom_display(*objs, title='', symbol=''):
    """
    :param objs:    要显示的objects
    :param title:   例：title=';1;图1;'，以英文分号`;`分割
    :param px:      边框像素大小
    :param symbol:  间隔符号
    :return:        返回格式化html
    """

    format = InteractiveShell.instance().display_formatter.format
    format_dict = {}
    html = []
    plain = []
    title_list = title.split(';')
    symbol_list = symbol.split(';')

    length = len(objs)
    symbol_left_px = 15

    global plain_top_px
    for obj in objs:    # 是否全部为text/plain
        if hasattr(obj, 'columns'):
            plain_top_px = 40   # 全文本时上边距
            break
        else:
            plain_top_px = 5

    for index, obj in enumerate(objs):
        try:
            symbol = symbol_list[index].strip()
            symbol = symbol if symbol else '--'
        except:
            symbol = '--'

        if title:
            symbol_top_px = plain_top_px + 22   # 连接符号上高度
            title_bottom_px = 2  # 标题下划线厚度
            try:
                title = title_list[index].strip()
                title = title if title else index + 1
            except:
                title = index + 1
        else:
            symbol_top_px = plain_top_px + 2
            title_bottom_px = 0

        format_dict, md_dict = format(obj)
        text_plain = format_dict.get('text/plain')
        text_plain = text_plain.replace('Name', '\nName').replace(', dtype', ',\ndtype').replace(', Length', ',\nLength')

        text_html = format_dict.get('text/html',
                        '<div><pre style="text-align:left;margin-top:{0}px;">{1}</pre></div>'
                            .format(plain_top_px, text_plain))  # text_plain嵌入html显示

        html.append(text_html.replace('<div>',
            '<div style="display:inline-block;vertical-align:top;text-align:center;">\n'  # 更改div显示方式
            '<pre style="border-bottom:{}px solid">{}</pre>'.format(title_bottom_px, title)))  # 标题底部下划线

        if index + 1 < length:      # 表格连接符，默认为`-->`
            html.append(
                '<pre style="display:inline-block;position:relative;top:{0}px;'
                'margin-left:{1}px;margin-right:{1}px;">{2}</pre>'
                    .format(symbol_top_px, symbol_left_px, symbol))     # 表格连接符

        plain.append(text_plain)
        if index + 1 < length:
            plain.append('-'*10)

    format_dict.update({
        'text/html': '\n'.join(html),
        'text/plain': '\n'.join(plain),
    })
    publish_display_data(data=format_dict)


if __name__ == '__main__':
    import numpy as np
    import pandas as pd
    pd.set_option('display.max_rows', 6)  # 表格最大显示行数
    pd.set_option('display.show_dimensions', False)  # 是否显示结尾尺寸

    df1 = pd.DataFrame([{1: 2, 2: 4}]*10)
    df2 = [[56], [63], [63], [72], [80]]
    df3 = pd.Series({'a': 2, 'b': 1})
    narray = np.arange(0, 100).reshape(10, -1)

    # custom_display(df1, df2, [{1: 2, 2: 4}], df3)
    # custom_display(df1[1], show_dimensions=False)
    custom_display(narray, {1: 2, 2: 4})

