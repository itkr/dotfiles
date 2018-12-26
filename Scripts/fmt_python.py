# -*- coding:utf-8 -*-
from __future__ import absolute_import, print_function, unicode_literals

import os
import shlex
import subprocess

_env = None


def get_env():
    global _env
    if _env is None:
        _env = os.environ.copy()
        path = os.sep.join(_env['_'].split(os.sep)[0: -1])
        _env['PATH'] = ':'.join([path, _env['PATH']])
    return _env


def execute(cmd):
    env = get_env()

    popen = subprocess.Popen(
        shlex.split(cmd) if not isinstance(cmd, list) else cmd,
        stdout=subprocess.PIPE,
        env=env)

    output = popen.communicate()[0]
    return output


def ls():
    return execute(
        ['find', os.environ['PWD'], '-type', 'f', '-print']).split('\n')


def get_python_files():
    return [path for path in ls() if os.path.splitext(path)[1] == '.py']


def main():
    for path in get_python_files():
        # execute('docformatter %s -i' % path)
        # execute('pyformat -i %s' % path)

        execute('autoflake %s -i' % path)
        execute('autopep8 %s -i --max-line-length 120' % path)
        execute('isort %s -m 3' % path)
        execute('unify %s -i' % path)
        print(path)


if __name__ == '__main__':
    main()
