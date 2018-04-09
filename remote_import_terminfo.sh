#!/usr/bin/env bash
# *************************************************
#
#       Filename: remote_import_terminfo.sh
#         Author: Shingo
#          Email: gmboomker@gmail.com
#         Create: 2018-04-09 16:08:31
#       Description: -
#
# *************************************************

infocmp xterm-256color-italic > ~/xterm-256color-italic.terminfo
scp -P port ~/xterm-256color-italic.terminfo user@remote:~/
ssh -p 22 root@vulvps.com 'tic xterm-256color-italic.terminfo'
# $ ssh user@remote
# On the remote machine
# $ tic xterm-256-italic.terminfo
# alias tssh=TERM=xterm-256color ssh
