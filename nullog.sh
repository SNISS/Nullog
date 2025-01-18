#!/bin/sh

banner() {
    printf '\033[0;31m
         ████               ████
        ███                   ███
       ███                     ███
      ███                       ███
     ███                         ███
    ████                         ████
    ████                         ████
    ██████       ███████       ██████
    █████████████████████████████████
    █████████████████████████████████
    ███████████████████████████████ 
      ████ ███████████████████ ████  
           ███▀███████████▀███       
          ████──▀███████▀──████      
          █████───█████───█████      
          ███████▄█████▄███████      
           ███████████████████       
            █████████████████        
             ███████████████         
              █████████████          
               ███████████           
              ███──▀▀▀──███          
              ███─█████─███          
               ███─███─███           
                █████████
    \033[0;31m  _   _       _\033[0;37m _             
    \033[0;31m | \ | |_   _| \033[0;37m| | ___   __ _ 
    \033[0;31m |  \| | | | | \033[0;37m| |/ _ \ / _` |
    \033[0;31m | |\  | |_| | \033[0;37m| | (_) | (_| |
    \033[0;31m |_| \_|\__,_|_\033[0;37m|_|\___/ \__, |
    \033[0;31m               \033[0;37m         |___/ 

            \033[0;31m[\033[0;37mVersion 2.0\033[0;31m]

'
}

remove_login() {
    for log in /var/log/wtmp /var/log/btmp /var/log/lastlog; do
        shred -zfxn 10 "$log" 2>/dev/null
    done
}

other_logs() {
    for log in /var/log/messages /var/log/maillog /var/log/secure /var/log/syslog /var/log/dmesg; do
        shred -zfxn 10 "$log" 2>/dev/null
    done

    find /var/log/ -name "mail.*" -exec shred -zfxn 10 {} + 2>/dev/null
}

bash_history() {
    find / -name ".bash_history" -exec chattr +i {} + 2>/dev/null
}

zsh_history() {
    find / -name ".zsh_history" -exec shred -zfxn 10 {} + 2>/dev/null
}

mac_root_logs() {
    find ~/Library -name "*.log" -exec shred -zfxn 10 {} + 2>/dev/null
}

mac_normal_logs() {
    find /Library -name "*.log" -exec shred -zfxn 10 {} + 2>/dev/null
}

logs_f() {
    find / -name "*.log.*" -exec shred -zfxn 10 {} + 2>/dev/null
}

main() {
    banner
    sleep 1
    printf '\n\033[0;34m[*] \033[0;37mClearing system login logs\n'
    remove_login
    printf '\033[0;32m[+] \033[0;37mLogin logs successfully deleted!\n'
    sleep 1
    printf '\n\033[0;34m[*] \033[0;37mClearing other logs\n'
    other_logs
    printf '\033[0;32m[+] \033[0;37mOther logs successfully deleted!\n'
    sleep 1
    printf '\n\033[0;34m[*] \033[0;37mClearing Bash histories\n'
    bash_history
    printf '\033[0;32m[+] \033[0;37mBash histories cleared successfully!\n'
    sleep 1
    printf '\n\033[0;34m[*] \033[0;37mClearing Zsh histories\n'
    zsh_history
    printf '\033[0;32m[+] \033[0;37mZsh histories cleared successfully!\n'
    sleep 1
    printf '\n\033[0;34m[*] \033[0;37mClearing Mac root logs\n'
    mac_root_logs
    printf '\033[0;32m[+] \033[0;37mMac root logs cleared successfully!\n'
    sleep 1
    printf '\n\033[0;34m[*] \033[0;37mClearing Mac normal logs\n'
    mac_normal_logs
    printf '\033[0;32m[+] \033[0;37mMac normal logs cleared successfully!\n'
    printf '\n\033[0;34m[*] \033[0;37mDeleting other log files\n'
    logs_f
    printf '\033[0;32m[+] \033[0;37mLog files cleared successfully!\n'
}

if [ "$(id -u)" -ne 0 ]; then
    printf "\033[0;34m[*] \033[0;37mYou are not running Nullog as root. Only logs with sufficient permissions will be deleted. Press ENTER to continue." 
    read -r
fi


if [ ! command -v shred &>/dev/null; ]  then
main


else

   echo "Instale o Shred antes de usar a ferramenta!";
   exit 0;

fi
