#!/bin/bash
# Desafio DIO - Infraestrutura como código:
# Script de criação de estrutura de usuários, diretórios e permissões 
# Author: Marley Adriano <marleyas@gmail.com>

array_dir=(/publico /adm /ven /sec)
array_grp=(GRP_ADM GRP_VEN GRP_SEC)
array_adm=(carlos maria joao)
array_ven=(debora sebastiana roberto)
array_sec=(josefina amanda rogerio)

echo "Criando diretórios..."
for i in "${array_dir[@]}"
do
	mkdir "$i"
done

echo "Criando  grupos de usuários..."
for i in "${array_grp[@]}"
do
	groupadd "$i"
done

echo "Criando usuários..."
for i in "${array_adm[@]}"
do
	useradd "$i" -m -s /bin/bash -p $(openssl passwd 123456) -G "${array_grp[0]}"
done
for i in "${array_ven[@]}"
do
	useradd "$i" -m -s /bin/bash -p $(openssl passwd 123456) -G "${array_grp[1]}"
done
for i in "${array_sec[@]}"
do
	useradd "$i" -m -s /bin/bash -p $(openssl passwd 123456) -G "${array_grp[2]}"
done

echo "Especificando permissões dos diretórios..."
chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

for i in "${array_dir[@]}"
do
	chmod 770 "$i"
    if [ $i == "/publico" ]
    then
        chmod 777 "$i"
    fi
done

echo "Fim..."
