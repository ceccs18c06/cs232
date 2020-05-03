
echo -e "System Configuration\n\n"

echo -e "OS version and release number:\n"
cat /etc/os-release
echo -e "\nkernal version:\n"
uname -r
echo -e "\navailable shells:\n"
cat /etc/shells
echo -e "\n CPU information:\n"
cat /proc/cpuinfo
echo -e "\n  Memory information:\n"
free -m
echo -e "\n  Hard disc information:\n"
df -h
echo -e "\nFile system (Mounted):\n"
mount | column -t
