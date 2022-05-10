# cd /var/lib/jenkins/workspace
aws iam list-users | grep UserName | cut -d:  -f2 | sed -e 's/"/ /g'| sed -e 's/,//g'> user_list.txt
while read u
do 
    echo "======|| creating $u ||======="
    u_check=$(cat user_list.txt| grep -w "$u")
    if [ -z $u_check ]; then echo "we don't have this username in our account - let's create this user " && aws iam create-user --user-name $u; else echo "this user named $u alredy exist ...." 
        continue
    fi

done < user_to_create.txt