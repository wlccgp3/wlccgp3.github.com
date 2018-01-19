def func():
    spam = "func_scope"
    print(locals())
    
    def do_local():
        spam = "local spam"
        print('do_local_scope:', locals())
    def do_nonlocal():
        nonlocal spam  # 浅拷贝func中的locals['spam']，并创建spam标识符
        print('do_nonlocal_scope:', locals())
        spam = "nonlocal spam"
    def do_global():
        global spam
        print('do_global_scope:', locals())
        spam = "global spam"
        
    do_local()
    do_nonlocal()
    do_global()

func()