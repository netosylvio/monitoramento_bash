#! /bin/bash
#                              #
#  Monitoramento do CRAY       #
#  Sylvio V. B. Neto           #
#                              #
#   			       #
#                              #
################################
################################
#

i=0
while true 
do 
rm -f ~/script/out_monitor.txt
ema=0
#variaveis
#cores
vermelho="\033[01;31;41m  \033[0m"
verde="\033[01;32;42m  \033[0m"
verde_f=$(echo -e "\033[0;48;5;118m  \033[0m")
conn="\033[01;37mcon\033[0m"
disk="\033[01;37mdisk\033[0m"
cpu="\033[01;37mcpu\033[0m"
mmm="\033[01;37mmem\033[0m"

nome_host_1_ok="\033[01;37mEslogin(s)\033[0m"
nome_host_2_ok="\033[01;37mAux01     \033[0m"
nome_host_3_ok="\033[01;37mAux17     \033[0m"



nome_host_1_err="\033[01;31mEslogin(s)\033[0m"
nome_host_2_err="\033[01;31mAux01     \033[0m"
nome_host_3_err="\033[01;31mAux17     \033[0m"

nome_host_1=$nome_host_1_ok
nome_host_2=$nome_host_2_ok
nome_host_3=$nome_host_3_ok

#hosts
host_1="www.uol.com.br"
host_2="www.google.com.br"
host_3="www.globo.com"
#
#


############################################################################################
#Teste de conexao
#ping, uptime, ifconfig
#fazer com ssh modoper no caso da aux01

upp="up"
con=1
recebidos=1
enviados=1

#Host1
#con=$(ping -c 5 $host_1 | grep 'received' | awk '{print $4}')
#recebidos=$(ifconfig | grep 'RX bytes' | head -n1 | awk '{print $3}' | cut -c 2-6);
#enviados=$(ifconfig | grep 'RX bytes' | head -n1 | awk '{print $7}' | cut -c 2-6);
#upp=$(uptime | awk '{print $2}');


if [[ "$con" == 0 || "$recebidos" == 0 || "$enviados" == 0 || "$upp" != "up" ]]; then 
con_h1=$vermelho
nome_host_1=$nome_host_1_err
h1_status_con=Erro
ema=1 
else
con_h1=$verde_f
h1_status_con=OK
fi

#host 2 
#con=$(ping -c 5 $host_2 | grep 'received' | awk '{print $4}')
#recebidos=$(ifconfig | grep 'RX bytes' | head -n1 | awk '{print $3}' | cut -c 2-6);
#enviados=$(ifconfig | grep 'RX bytes' | head -n1 | awk '{print $7}' | cut -c 2-6);
#upp=$(uptime | awk '{print $2}');

con=1

if [[ "$con" == 0 || "$recebidos" == 0 || "$enviados" == 0 || "$upp" != "up" ]]; then 
con_h2=$vermelho
nome_host_2=$nome_host_2_err
h2_status_con=Erro
ema=1
else
con_h2=$verde_f
h2_status_con=OK
fi

#host 3 
#con=$(ping -c 5 $host_3 | grep 'received' | awk '{print $4}')
#recebidos=$(ifconfig | grep 'RX bytes' | head -n1 | awk '{print $3}' | cut -c 2-6);
#enviados=$(ifconfig | grep 'RX bytes' | head -n1 | awk '{print $7}' | cut -c 2-6);
#upp=$(uptime | awk '{print $2}');


if [[ "$con" == 0 || "$recebidos" == 0 || "$enviados" == 0 || "$upp" != "up" ]]; then 
con_h3=$vermelho
nome_host_3=$nome_host_3_err
h3_status_con=Erro
ema=1
else
con_h3=$verde_f
h3_status_con=OK
fi


qtd=10
qtd_df=11
####################################################################################
#Teste de discos
#df   ssh modoper

#host 1 
#qtd=10
#qtd_df=$(df |wc -l);

if [[ "$qtd_df" < "$qtd" ]]; then
dis_h1=$vermelho
nome_host_1=$nome_host_1_err
h1_status_disco=Erro
ema=1
else 
dis_h1=$verde_f
h1_status_disco=OK
fi

#host 2 
#qtd=10
#qtd_df=$(df |wc -l);

if [[ "$qtd_df" < "$qtd" ]]; then  
dis_h2=$vermelho
nome_host_2=$nome_host_2_err
h2_status_disco=Erro
ema=1
else
dis_h2=$verde_f
h2_status_disco=OK
fi


#host 3 
#qtd=10
#qtd_df=$(df |wc -l);

if [[ "$qtd_df" < "$qtd" ]]; then
dis_h3=$vermelho
nome_host_3=$nome_host_3_err 
h3_status_disco=Erro
ema=1
else
dis_h3=$verde_f 
h3_status_disco=OK
fi

########################################################################################
# Teste de CPU 
# top 
#tt=$(top | head -3 | tail -1 | awk '{print $3}')

# Host 1
tt=$(top -b -n 3 | grep %sy, | awk '{print $3}')
t1=$(echo $tt | awk '{print $1}')
t2=$(echo $tt | awk '{print $2}')
t3=$(echo $tt | awk '{print $3}')

if [[ "$t1" == "" || "$t2" == "" || "$t3" == "" ]]; then
cpu_h1=$vermelho
nome_host_1=$nome_host_1_err 
h1_status_cpu=Erro
ema=1
else
cpu_h1=$verde_f 
h1_status_cpu=OK
fi

# Host 2
#tt=$(top -b -n 3 | grep %sy, | awk '{print $3}')
#t1=$(echo $tt | awk '{print $1}')
#t2=$(echo $tt | awk '{print $2}')
#t3=$(echo $tt | awk '{print $3}')

if [[ "$t1" == "" || "$t2" == "" || "$t3" == "" ]]; then
cpu_h2=$vermelho
nome_host_2=$nome_host_2_err 
h2_status_cpu=Erro
ema=1
else
cpu_h2=$verde_f 
h2_status_cpu=OK
fi

# Host 3
#tt=$(top -b -n 3 | grep %sy, | awk '{print $3}')
#t1=$(echo $tt | awk '{print $1}')
#t2=$(echo $tt | awk '{print $2}')
#t3=$(echo $tt | awk '{print $3}')

if [[ "$t1" == "" || "$t2" == "" || "$t3" == "" ]]; then
cpu_h3=$vermelho
nome_host_3=$nome_host_3_err 
h3_status_cpu=Erro
ema=1
else
cpu_h3=$verde_f 
h3_status_cpu=OK
fi

#########################################################################################
# Teste de memoria
# free  init process e vmstat

#host 1
tt=$(free -m | grep Mem: | awk '{print $2}')
us=$(free -m | grep Mem: | awk '{print $3}')
lv=$(free -m | grep Mem: | awk '{print $4}')
in=$(ps -ef | grep init | wc -l)
mf=$(vmstat | tail -1 | awk '{print $4}')
cx=$(vmstat | tail -1 | awk '{print $6}')


if [[ "$tt" == 0 || "$us" == 0 || "$lv" == 0 || "$in" == 0 || "$mf" == 0|| "$cx" == 0 ]]; then
mem_h1=$vermelho
nome_host_1=$nome_host_1_err 
h1_status_mem=Erro
ema=1
else
mem_h1=$verde_f 
h1_status_mem=OK
fi

#host 2
#tt=$(free -m | grep Mem: | awk '{print $2}')
#us=$(free -m | grep Mem: | awk '{print $3}')
#lv=$(free -m | grep Mem: | awk '{print $4}')
#in=$(ps -ef | grep init | wc -l)
#mf=$(vmstat | tail -1 | awk '{print $4}')
#cx=$(vmstat | tail -1 | awk '{print $6}')


if [[ "$tt" == 0 || "$us" == 0 || "$lv" == 0 || "$in" == 0 || "$mf" == 0|| "$cx" == 0 ]]; then
mem_h2=$vermelho
nome_host_2=$nome_host_2_err 
h2_status_mem=Erro
ema=1
else
mem_h2=$verde_f 
h2_status_mem=OK
fi


#host 3
#tt=$(free -m | grep Mem: | awk '{print $2}')
#us=$(free -m | grep Mem: | awk '{print $3}')
#lv=$(free -m | grep Mem: | awk '{print $4}')
#in=$(ps -ef | grep init | wc -l)
#mf=$(vmstat | tail -1 | awk '{print $4}')
#cx=$(vmstat | tail -1 | awk '{print $6}')


if [[ "$tt" == 0 || "$us" == 0 || "$lv" == 0 || "$in" == 0 || "$mf" == 0|| "$cx" == 0 ]]; then
mem_h3=$vermelho
nome_host_3=$nome_host_3_err 
h3_status_mem=Erro
ema=1
else
mem_h3=$verde_f 
h3_status_mem=OK
fi

###############################################
# escrevendo out
echo -e "-------------------------------------------" >> ~/script/out_monitor.txt
echo -e "Eslogin(s)" >> ~/script/out_monitor.txt
echo -e "Conexao.......$h1_status_con"  >> ~/script/out_monitor.txt
echo -e "Disco.........$h1_status_disco" >> ~/script/out_monitor.txt
echo -e "Cpu...........$h1_status_cpu" >> ~/script/out_monitor.txt
echo -e "Mem...........$h1_status_mem" >> ~/script/out_monitor.txt
echo -e "-------------------------------------------" >> ~/script/out_monitor.txt
echo -e "Aux01" >> ~/script/out_monitor.txt
echo -e "Conexao.......$h2_status_con" >> ~/script/out_monitor.txt
echo -e "Disco.........$h2_status_disco" >> ~/script/out_monitor.txt
echo -e "Cpu...........$h2_status_cpu" >> ~/script/out_monitor.txt
echo -e "Mem...........$h2_status_mem" >> ~/script/out_monitor.txt
echo -e "-------------------------------------------" >> ~/script/out_monitor.txt
echo -e "Aux17" >> ~/script/out_monitor.txt
echo -e "Conexao.......$h3_status_con" >> ~/script/out_monitor.txt
echo -e "Disco.........$h3_status_disco" >> ~/script/out_monitor.txt
echo -e "Cpu...........$h3_status_cpu" >> ~/script/out_monitor.txt
echo -e "Mem...........$h3_status_mem" >> ~/script/out_monitor.txt


#####################################################################################
#mandando emails

#18 vezes a 10 minutos = 3 horas
#12 vezes a 15 minutos = 3 horas
#if [[ "$i" == 12 ]]; then 

if [[ "$i" == 18 ]]; then 
#mail - s "CRAY Hardware OK" neto.sylvio@gmail.com < out_monitor.txt
i=0
echo "mandei email"
break
fi

if [[ "$ema" == 1 ]]; then 
#mail - s "CRAY Hardware ERRO" neto.sylvio@gmail.com < out_monitor.txt
echo "mandei email de erro"
fi

clear
echo -e ""
echo -e "+--------------------------------------------+"
echo -e "|                $conn    $disk    $cpu    $mmm   |"
echo -e "|                                            |"
echo -e "| $nome_host_1     $con_h1      $dis_h1     $cpu_h1     $mem_h1    |" 
echo -e "|                                            |"
echo -e "| $nome_host_2     $con_h2      $dis_h2     $cpu_h2     $mem_h2    |" 
echo -e "|                                            |"
echo -e "| $nome_host_3     $con_h3      $dis_h3     $cpu_h3     $mem_h3    |" 
echo -e "|                                            |"
echo -e "+--------------------------------------------+"
date
echo -e ""

i=$((i+1))
#sleep 600 #10 minutos
#sleep 900 #15 minutos
sleep 20
done
exit

#while true; do ./monitor.bash ; sleep 5; clear;  done

