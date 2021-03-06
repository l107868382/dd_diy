#!/bin/sh

function diycron(){

  # 修改docker_entrypoint.sh执行频率
  ln -sf /usr/local/bin/docker_entrypoint.sh /usr/local/bin/docker_entrypoint_mix.sh
  echo "18 */3 * * * docker_entrypoint_mix.sh >> /scripts/logs/default_task.log 2>&1" >> /scripts/docker/merged_list_file.sh
  echo "18 */3 * * * docker_entrypoint_mix.sh >> /scripts/logs/default_task.log 2>&1" >> /scripts/docker/merged_list_file.sh
  
  
  
   for jsname in /scripts/jddj_*.js ; do
        jsnamecron="$(cat $jsname | grep -oE "/?/?cron \".*\"" | cut -d\" -f2)"
        test -z "$jsnamecron" || echo "$jsnamecron node $jsname >> /scripts/logs/$(echo $jsname | cut -d/ -f3).log 2>&1" >> /scripts/docker/merged_list_file.sh
   done
  
  #收集助力码
  echo "30 * * * * sh +x /scripts/docker/auto_help.sh collect |ts >> /scripts/logs/auto_help_collect.log 2>&1" >> /scripts/docker/merged_list_file.sh
  # 京东月资产变动通知
  echo "10 7 1-31/7 * * node /scripts/jd_all_bean_change.js >> /scripts/logs/jd_all_bean_change.log 2>&1" >> /scripts/docker/merged_list_file.sh
  # 领现金兑换红包
  # echo "59 23 * * 4,5 sleep 59.7; node conc /scripts/jd_cash_exchange.js >> /scripts/logs/jd_cash_exchange.log 2>&1" >> /scripts/docker/merged_list_file.sh
    
}


function jd_diy(){
    cp -f /jd_diy/scripts/* /scripts
    cat /dev/null > /scripts/docker/auto_help.sh
    cat /jd_diy/shell/auto_help.sh >> /scripts/docker/auto_help.sh
    
    # 设置环境变量
    # cp -f /jd_diy/env/jd_env.sh /etc/profile.d
    # source /etc/profile.d/jd_env.sh
}



function jddj_diy(){
    ## 克隆jddj_diy仓库
    if [ ! -d "/jddj_diy/" ]; then
        echo "未检查到克隆jddj_diy仓库，初始化下载相关脚本..."
        git clone -b main https://ghproxy.com/https://github.com/passerby-b/JDDJ.git /jddj_diy
    else
        echo "更新jddj_diy脚本相关文件..."
        git -C /jddj_diy reset --hard
        git -C /jddj_diy pull origin main --rebase
    fi  
    cp -f /jddj_diy/jddj_*.js /scripts
}




# wuzhi_diy
function wuzhi_diy(){
    # package.json生成md5文件
    md5sum /wuzhi/package.json > /packagejson.md5

    if [ ! -d "/wuzhi/" ]; then
        echo "未检查到wuzhi仓库脚本，初始化下载相关脚本..."
        git clone -b main https://ghproxy.com/https://github.com/wuzhi05/MyActions.git /wuzhi
    else
        echo "更新wuzhi脚本相关文件..."
        git -C /wuzhi reset --hard
        git -C /wuzhi pull origin main --rebase
    fi
  
    cp -f /wuzhi/*.js /wuzhi/package.json /scripts
    cp -f /wuzhi/utils/*.js /scripts/utils
    if [ ! -d /scripts/function  ];then
      mkdir /scripts/function
    else
      echo dir exist
    fi
    cp -f /wuzhi/function/*.js /scripts/function
    cat /dev/null > /scripts/docker/merged_list_file.sh
    cat /wuzhi/docker/crontab_list.sh >> /scripts/docker/merged_list_file.sh
}


# faker3_diy
function faker3_diy(){
    if [ ! -d "/faker3/" ]; then
        echo "未检查到faker3仓库脚本，初始化下载相关脚本..."
        git clone -b main https://ghproxy.com/https://github.com/shufflewzc/faker3.git /faker3
    else
        echo "更新wuzhi脚本相关文件..."
        git -C /faker3 reset --hard
        git -C /faker3 pull origin main --rebase
    fi
    cp -f /faker3/jd_bean_change.js /faker3/jd_jxlhb.js /faker3/jd_cfd.js /faker3/sendNotify.py /fakcer3/jd_redrain.js /fakcer3/jd_redrain_half.js /scripts
}


# 替换
function otherreplace(){
    echo " otherreplace "    
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/RandomShareCode\/git\/raw\/main\/JD_Fruit.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/JD_Fruit.json/g" /scripts/jd_fruit.js
    sed -i "s/let helpAuthor = true/let helpAuthor = false/g" /scripts/jd_fruit.js
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/RandomShareCode\/git\/raw\/main\/JD_Cash.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/JD_Cash.json/g" /scripts/jd_cash.js
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/shareCodes\/git\/raw\/main\/jd_updateCash.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jd_updateCash.json/g" /scripts/jd_cash.js
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/shareCodes\/git\/raw\/main\/jd_red.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jd_red.json/g" /scripts/jd_redPacket.js
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/shareCodes\/git\/raw\/main\/fcwb.json/https:\/\/ghproxy.com\/https:\/\/github.com\/l107868382\/sharcode\/blob\/main\/v1\/fcwb.json/g" /scripts/jd_fcwb.js
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/shareCodes\/git\/raw\/main\/jd_cfd.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jd_cfd.json/g" /scripts/jd_cfd.js

    #city
     sed -i "s/https:\/\/purge.jsdelivr.net\/gh\/Aaron-lv\/updateTeam@master\/shareCodes\/city.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jd_city2.json/g" /scripts/jd_city.js
     sed -i "s/https:\/\/cdn.jsdelivr.net\/gh\/Aaron-lv\/updateTeam@master\/shareCodes\/city.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jd_city2.json/g" /scripts/jd_city.js
   # 惊喜工厂
    sed -i "s/http:\/\/share.turinglabs.net\/api\/v3\/jxfactory\/query\/0/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jd_dream.json/g" /scripts/jd_dreamFactory.js
    #惊喜88红包
    sed -i "s/https:\/\/wuzhi03.coding.net\/p\/dj\/d\/shareCodes\/git\/raw\/main\/jd_redhb.json/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com\/l107868382\/sharcode\/main\/v1\/jd_redhb.json/g" /scripts/jd_jxlhb.js
    
    # 注释jd_bean_change_clean.js 不执行
    sed -ie '/jd_bean_change_clean.js/d' /scripts/docker/merged_list_file.sh
    
    # 注释jd_redPacket.js 不执行
    sed -ie '/jd_redPacket.js/d' /scripts/docker/merged_list_file.sh
    echo "12 0-23/4 * * * node /scripts/jd_redPacket.js >> /scripts/logs/jd_redPacket.log 2>&1" >> /scripts/docker/merged_list_file.sh
    
    # 注释京东试用 不执行
    # sed -ie '/jd_try_new.js/d' /scripts/docker/merged_list_file.sh
    
    # 注释京喜财富岛提现
    sed -ie '/jd_cfdtx.js/d' /scripts/docker/merged_list_file.sh
    #echo "59 11,12,23 * * * node /scripts/jd_cfdtx.js >> /scripts/logs/jd_cfdtx.log 2>&1" >> /scripts/docker/merged_list_file.sh
    
    #京豆变化
    sed -ie '/jd_bean_change.js/d' /scripts/docker/merged_list_file.sh
    echo "15 8,20 * * * node /scripts/jd_bean_change.js >> /scripts/logs/jd_bean_change.log 2>&1" >> /scripts/docker/merged_list_file.sh
    
    #东东工厂
    sed -ie '/jd_jdfactory.js/d' /scripts/docker/merged_list_file.sh
    echo "26 * * * * node /scripts/jd_jdfactory.js >> /scripts/logs/jd_jdfactory.log 2>&1" >> /scripts/docker/merged_list_file.sh
  
    # 删除开卡任务
    sed -ie '/jd_opencard/d' /scripts/docker/merged_list_file.sh
    
    # 删除 财富岛热气球接待
    sed -ie '/jd_cfd_loop/d' /scripts/docker/merged_list_file.sh
   
    # 修改饭粒运行时间
    #sed -ie '/jd_fanli/d' /scripts/docker/merged_list_file.sh
    #echo "0 0,18 * * * node /scripts/jd_fanli.js >> /scripts/logs/jd_fanli.log 2>&1" >> /scripts/docker/merged_list_file.sh
    
     # 发财挖宝
     sed -ie '/jd_fcwb/d' /scripts/docker/merged_list_file.sh
     # echo "5 7 * * * node /scripts/jd_fcwb.js >> /scripts/logs/jd_fcwb.log 2>&1" >> /scripts/docker/merged_list_file.sh
     
     # 暖暖红包
     # sed -ie '/jd_redEnvelope/d' /scripts/docker/merged_list_file.sh
     # echo "0 0,12 * * * node /scripts/jd_redEnvelope.js >> /scripts/logs/jd_redEnvelope.log 2>&1" >> /scripts/docker/merged_list_file.sh
     
     #京豆雨
     sed -ie '/jd_redrain_half/d' /scripts/docker/merged_list_file.sh
     echo "31 20-23/1 * * * node /scripts/jd_redrain_half.js >> /scripts/logs/jd_redrain_half.log 2>&1" >> /scripts/docker/merged_list_file.sh
     sed -ie '/jd_redrain/d' /scripts/docker/merged_list_file.sh
     echo "0 * * * * node /scripts/jd_redrain.js >> /scripts/logs/jd_redrain.log 2>&1" >> /scripts/docker/merged_list_file.sh
     
     
     
    #------------------------------黑号删除脚本-----------------------------------------
    # 京东极速版红包
    sed -ie '/jd_speed_redpocke/d' /scripts/docker/merged_list_file.sh
    # 省钱大赢家翻翻乐
    sed -ie '/jd_big_winner/d' /scripts/docker/merged_list_file.sh
    # 推一推
    sed -ie '/jd_tyt/d' /scripts/docker/merged_list_file.sh
    
   # -----------------------------自己服务器环境判断（特殊设置）---------------------------------
   if [ -f /scripts/logs/myFlag.txt ]; then
    echo "this is my vps " 
    # 极速版签到
    sed -ie '/jd_speed_sign/d' /scripts/docker/merged_list_file.sh
    echo "11 6 */7 * * node /scripts/jd_speed_sign.js >> /scripts/logs/jd_speed_sign.log 2>&1" >> /scripts/docker/merged_list_file.sh
   
   fi
   
   
}


 # 安装依赖插件
function npmInstall(){
      echo "npm install 安装最新依赖检测"
      md5sum -c -s /packagejson.md5
      if [ $? == 0 ]; then
        echo "packagejson无更新，跳过npm install"
      else
        echo "packagejson更新，执行npm install"
        npm install --prefix /scripts
        npm install --save js-base64
      fi

}

function main(){
    # wuzhi_diy
    # faker3_diy
    npmInstall
    # jddj_diy
    jd_diy
   # smiek2221
    # diycron
    # otherreplace
}

main
