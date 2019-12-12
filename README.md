# os-migration
Collection of scripts to help in OS migration/reinstallation

# Installation/migration checklist
 - [ ] Transfer users, home directories, crontabs (user-accounts-source.sh, user-accounts-destination.sh)
 - [ ] Transfer /etc/sudoers customizations (manually)
 - [ ] Transfer iptables rules (/etc/sysconfig/iptables)
 - [ ] Extract and install manually installed packages (yum-packages-source.sh)
 - [ ] Reinstall manually installed perl packages (cpan-modules-source.sh)
 - [ ] Reinstall manually installed python (2/3) packages (manual)
```
src# pip3 list
src# pip2 list
```
 - [ ] Transfer ssh configuration, host keys (optional, manual)
 ```
 dst# cp -ar /etc/ssh /etc/ssh.orig
 src# scp /etc/ssh/* root@dst:/etc/ssh/
 ```
