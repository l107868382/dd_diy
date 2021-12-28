#!/bin/sh

function jd_diy(){
    cp -f /jd_diy/scripts/sendNotify.js /ql/scripts
    cp -f /jd_diy/scripts/* /ql/scripts/shufflewzc_faker2
}

function replace(){
    sed -i "s/http:\/\/transfer.nz.lu\/farm/https:\/\/ghproxy.com\/https:\/\/github.com\/l107868382\/sharcode\/blob\/main\/v1\/JD_Fruit.json/g" /ql/scripts/shufflewzc_faker2/jd_fruit.js
    sed -i "s/https:\/\/raw.githubusercontent.com\/Aaron-lv\/updateTeam\/master\/shareCodes\/cfd.json/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jxcfd.json/g" /ql/scripts/shufflewzc_faker2/jd_cfd.js
    sed -i "s/https:\/\/purge.jsdelivr.net\/gh\/Aaron-lv\/updateTeam@master\/shareCodes\/cfd.json/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jxcfd.json/g" /ql/scripts/shufflewzc_faker2/jd_cfd.js
    sed -i "s/https:\/\/cdn.jsdelivr.net\/gh\/Aaron-lv\/updateTeam@master\/shareCodes\/cfd.json/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jxcfd.json/g" /ql/scripts/shufflewzc_faker2/jd_cfd.js
    sed -i "s/https:\/\/transfer.nz.lu\/cfd/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jxcfd.json/g" /ql/scripts/shufflewzc_faker2/jd_cfd.js
    sed -i "s/https:\/\/raw.githubusercontent.com\/shufflewzc\/updateTeam\/main\/shareCodes\/cfd.json/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jxcfd.json/g" /ql/scripts/shufflewzc_faker2/jd_cfd.js
    sed -i "s/https:\/\/raw.fastgit.org\/shufflewzc\/updateTeam\/main\/shareCodes\/cfd.json/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jxcfd.json/g" /ql/scripts/shufflewzc_faker2/jd_cfd.js
}

function main(){
    jd_diy
    replace
}

main
