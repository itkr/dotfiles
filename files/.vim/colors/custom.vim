if has("gui_running")

    " normal
    highlight Normal guifg=#333333

    " function name, class name
    highlight pythonFunction guifg=#990000 gui=BOLD

    " if
    highlight pythonConditional guifg=#3333cc gui=BOLD

    " string
    highlight pythonString guifg=#009900 gui=ITALIC

    " None, True, False (,objects)
    highlight pythonBuiltin gui=BOLD,ITALIC

    " is, and, or
    highlight link pythonOperator pythonConditional

    " try, except
    highlight link pythonException pythonConditional

    " while
    highlight link pythonRepeat pythonConditional

    " exception name
    highlight pythonExceptions gui=ITALIC,UNDERLINE
    highlight link pythonExClass pythonExceptions

    " decorator
    highlight pythonDecorator guifg=#999900 gui=ITALIC
    highlight link pythonDottedName pythonDecorator
    highlight link pythonDecoratorName pythonDecorator

    " def, class, brake, continue, exec, return, pass
    highlight link pythonStatement pythonConditional

endif
