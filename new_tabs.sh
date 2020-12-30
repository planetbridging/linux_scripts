#nmap -p 22 --open -sV 192.168.1.0/24 -oG -
#nmap -p 22 --open -sV 192.168.1.0/24 -oG - | grep 22/open

DEFAULT_TABS_TITLE1="tab 1"
DEFAULT_TABS_TITLE2="retytr 2"
DEFAULT_TABS_TITLE3="tab 3"

DEFAULT_TABS_CMD1="echo hello"
DEFAULT_TABS_CMD2="echo yay"
DEFAULT_TABS_CMD3="echo omg" # Use quotes like this if there are spaces in the path

open_default_tabs() {
    gnome-terminal --tab -- bash -ic "export TITLE_DEFAULT='$DEFAULT_TABS_TITLE1'; $DEFAULT_TABS_CMD1; exec bash;"
    gnome-terminal --tab -- bash -ic "export TITLE_DEFAULT='$DEFAULT_TABS_TITLE2'; $DEFAULT_TABS_CMD2; exec bash;"
    gnome-terminal --tab -- bash -ic "export TITLE_DEFAULT='$DEFAULT_TABS_TITLE3'; $DEFAULT_TABS_CMD3; exec bash;"
}

# If length of this is NONzero
if [[ -n "$OPEN_DEFAULT_TABS" ]]; then
    OPEN_DEFAULT_TABS= # reset to an empty string so this only happens ONCE
    open_default_tabs
    exit 0 # close the calling process so only the "default tabs" are left open
fi

open_default_tabs