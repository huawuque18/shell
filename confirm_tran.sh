#!/bin/bash
MSIG_ADDR="" #交易钱包的地址
KEY_FILE=/root/testwallet/deploy1.keys.json     #确认key文件
SMult_ABI=/root/testwallet/SafeMultisigWallet.abi.json
CF_logs=/root/testwallet/log.txt
TIME=$(date "+%Y-%m-%d %H:%M:%S")
#tonos-cli --version |grep "tonos_cli"
cd /root/testwallet
source /etc/profile
TRID(){
        if [ -n "$MSIG_ADDR" ] || [ -n "$SMult_ABi" ]; then
                tonos-cli run "$MSIG_ADDR" getTransactions {} --abi "$SMult_ABI" \
                | grep "id" \
                | sed "s/\"//g"|sed "s/\,//g"|awk '{print $2}'
        else
                echo "请检查文件"
        fi
        }
#将订单ID赋值给变量
transid=`TRID`
#定义JSON格式变量
jsonid="{\"transactionId\":\"${transid}\"}"

        if [ -n "$transid" ]; then
                #echo "id:"$transid
                echo "$TIME"":本次获取交易单号:" $transid >> $CF_logs
                tonos-cli call $MSIG_ADDR confirmTransaction ${jsonid} --abi "$SMult_ABI" --sign "$KEY_FILE"
        else
                echo "$TIME"":无确认交易" >> $CF_logs
        fi
