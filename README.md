<h1 align="center">「🧹」 Ferramenta baseada no Nullog do MrEmpy </h1>

<a><p align="center">Nullog is a tool created in Shell Script with the aim of automating the cleaning of logs after an invasion of a Linux system.</p></a>

<p align="center"><img src="image.png"></p>


<a><p align="center">Nessa modificação usa o shred para excluir arquivos sem poder recupera-lós com facilidade! Eo uso do chattr nos historys para impedir modificações</p></a>


```
$ apt install coreutils

```



# What does it clean?

* wtmp

* btmp

* lastlog

* maillog

* syslog

* dmesg

* messages

* .bash_history

* .zsh_history

* Mac Logs - Normal (/Library)

* Mac Logs - Root (~/Library)

* all .log files




## Mais opções ( stealh ) 

* Pausar  os  historys da maquina 

* remover todas as linhas que contenham o seu IP


