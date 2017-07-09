#!/bin/bash

host="acm.cs.nthu.edu.tw"
user="NTHU Online Judge<noreply@${host}>"
body="mail.html"

save_file() {
    echo "$1" > ${body}
}

send_mail() {
    content_type="Content-Type: text/html; charset=utf-8"
    subject=$1
    from="FROM: ${user}"
    to=$2
    time_for_waiting_sending_mail=3

    mail -a "${content_type}" -a "${from}" -s "${subject}" ${to} < ${body}
    sleep $time_for_waiting_sending_mail
}

service postfix start
save_file "$1"
send_mail "$2" "$3"
