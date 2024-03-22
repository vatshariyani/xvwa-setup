#!/bin/bash
# XVWA Automatic Setup by Vats Hariyani
# Project Repo: https://github.com/s4n7h0/xvwa
# License: Apache-2.0 license
# License URL: http://www.apache.org/licenses/

# Function to display banner
display_banner() {
# Obtener prefijo de idioma / Get language prefix
lang_prefix="${LANG:0:2}"

# Function for verifying the language and displaying the corresponding message
get_language_message() {
    if [[ $lang_prefix -eq "es" ]]; then
        echo -e "$1"
    else
        echo -e "$2"
    fi
}

# Function for centering text on a line of specified length
center_text() {
    local text="$1"
    local line_length="$2"
    local text_length=${#text}
    local padding_before=$(( (line_length - text_length) / 2 ))
    local padding_after=$(( line_length - text_length - padding_before ))
    
    printf "%s%-${padding_before}s%s%-*s%s\n" "║" " " "$text" "$padding_after" " " "║"
}
# Desired line length
line_length=60
# ASCII Art
echo -e "\033[96m\033[1m

                ██╗    ██╗
                ╚██╗  ██╔╝██╗   ██╗██╗    ██╗ █████╗                    
                 ╚██╗██╔╝ ██║   ██║██║    ██║██╔══██╗                   
                  ╚███╔╝  ██║   ██║██║ █╗ ██║███████║                   
                  ██╔██╗  ╚██╗ ██╔╝██║███╗██║██╔══██║                   
                 ██╔╝ ╚██╗ ╚████╔╝ ╚███╔███╔╝██║  ██║                   
                 ╚═╝   ╚═╝  ╚═══╝   ╚══╝╚══╝ ╚═╝  ╚═╝                   
                                                                        
  ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗ 
  ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗
  ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝
  ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗
  ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║
  ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝     
\033[0m"
echo
echo -e "\033[92m╓────────────────────────────────────────────────────────────╖"
center_text "$(get_language_message "Welcome to the XVWA setup!" "¡Bienvenido al instalador de XVWA!")" "$line_length"
center_text "$(get_language_message "Script Name: xvwa_setup.sh " "Nombre del Script: xvwa_setup.sh ")" "$line_length"
center_text "$(get_language_message "Script Author: Vats Hariyani " " Script Autor: Vats Hariyani ")" "$line_length"
center_text "$(get_language_message "Setup Git Repo: https://github.com/vatshariyani/xvwa-setup" "Setup Git Repo: https://github.com/vatshariyani/xvwa-setup")" "$line_length"
center_text "$(get_language_message "XVWA Github Repo: https://github.com/s4n7h0/xvwa" "XVWA GitHub Repo: https://github.com/s4n7h0/xvwa")" "$line_length"
center_text "$(get_language_message "Installer Version: 1.0 " "Versión del Instalador: 1.0")" "$line_length"
echo -e "╙────────────────────────────────────────────────────────────╜\033[0m"
echo
# Check if the user is root
if [ "$EUID" -ne 0 ]; then
    error_message=$(get_language_message "\e[91mThis script must be run by the root user.\e[0m" "\e[91mEste script debe ejecutarse como usuario root.\e[0m")
    echo -e "$error_message"
    exit 1
fi

}

# Function to check if a package is installed
check_package_installed() {
    package_name=$1
    is_installed=$(apt-cache show "$package_name" 2>/dev/null)
    if [[ $is_installed == *"No packages found"* ]]; then
        return 1 # Package not installed
    else
        return 0 # Package installed
    fi
}

# Function to install a package
install_package() {
    package_name=$1
    echo "Installing $package_name. This might take a while."
    sudo apt-get install -y "$package_name"
}

# Function to start a service
start_service() {
    service_name=$1
    echo "Starting $service_name Service"
    sudo service "$service_name" start
}

# Function to check and start MySQL service
check_and_start_mysql() {
    if ! pgrep mysql >/dev/null; then
        echo "MySQL is down. Starting MySQL Service"
        start_service mysql
    fi
}

# Function to check and start Apache service
check_and_start_apache() {
    if ! pgrep apache2 >/dev/null; then
        echo "Apache is down. Starting Apache Service"
        start_service apache2
    fi
}

# Function to clone XVWA from GitHub and configure
clone_and_configure_xvwa() {
    echo "Cloning latest version of XVWA from GitHub"
    sudo git clone https://github.com/s4n7h0/xvwa.git "$webroot/xvwa"
    echo "Setting XVWA configuration"
    sudo chmod -R 777 "$webroot/xvwa"
    sed -i "2 c \$XVWA_WEBROOT = \"\";" "$webroot/xvwa/config.php"
    sed -i "5 c \$user = \"$uname\";" "$webroot/xvwa/config.php"
    sed -i "6 c \$pass = \"$pass\";" "$webroot/xvwa/config.php"

    # Creating database
    echo "Creating xvwa database"
    mysql -u "$uname" -p"$pass" -e "CREATE DATABASE IF NOT EXISTS xvwa"
    echo "Creating tables in the xvwa database"

    # Create users table
    mysql -u "$uname" -p"$pass" xvwa -e "CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(50) NOT NULL,
        email VARCHAR(100) NOT NULL,
        password VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )"

    # Create comments table
    mysql -u "$uname" -p"$pass" xvwa -e "CREATE TABLE IF NOT EXISTS comments (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT,
        comment_text TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users (id)
    )"

    # Create caffaine table
    mysql -u "$uname" -p"$pass" xvwa -e "CREATE TABLE IF NOT EXISTS caffaine (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        description TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )"

    # Grant privileges to access urdatabase
    mysql -u "$uname" -p"$pass" -e "GRANT ALL PRIVILEGES ON urdatabase.* TO '$uname'@'localhost' IDENTIFIED BY '$pass'"

    success_message="\e[92mXVWA has been installed successfully. Access \e[93mhttp://localhost/xvwa"
    echo -e "$success_message"

    #Mostrar al usuario las credenciales después de la configuración / Show user credentials after configuration
    credentials_after_setup_message="\e[92mCredentials:\e[0m"
    echo -e "$credentials_after_setup_message"
    echo -e "Username: \033[93madmin\033[0m"
    echo -e "Password: \033[93madmin\033[0m"

    # End of installer
    echo
    final_message="\033[95mWith ♡ by Vats Hariyani"
    echo -e "$final_message"
    echo "XVWA Setup Finished Successfully. Happy hacking and happy learning!"
}

# Main script starts here
clear
display_banner
# Update repositories
update_message="\e[96mUpdating repositories...\e[0m"
echo -e "$update_message"
apt update


# Check if MySQL package is installed
if ! check_package_installed mysql-server; then
    echo -n "MySQL Package Not Found. Do you want to install (Y/N)? "
    read -r mysql_flag
    if [[ $mysql_flag == "Y" || $mysql_flag == "y" ]]; then
        install_package mysql-server
    else
        echo "XVWA Setup Terminated. MySQL is a must requirement for XVWA to run"
        exit 0
    fi
else
    echo "MySQL found with $(apt-cache show mysql-server | grep 'Version')"
fi

# Check if Apache package is installed
if ! check_package_installed apache2; then
    echo -n "Apache Package Not Found. Do you want to install (Y/N)? "
    read -r apache_flag
    if [[ $apache_flag == "Y" || $apache_flag == "y" ]]; then
        install_package apache2
    else
        echo "XVWA Setup Terminated. Apache is a must requirement for XVWA to run"
        exit 0
    fi
else
    echo "Apache found with $(apt-cache show apache2 | grep 'Version')"
fi

# Start MySQL and Apache services
check_and_start_mysql
check_and_start_apache

# Configure MySQL and Apache for XVWA
echo -n "Enter mysql username: "
read -r uname
echo -n "Enter mysql password: "
read -rs pass
echo
echo -n "Enter the full web root path: "
read -r webroot

# Clone XVWA from GitHub and configure

if [[ -d "$webroot/xvwa" ]]; then
    echo -n "Folder $webroot/xvwa already exists. Do you want to clean and build a fresh latest copy? (Y/N) "
    read -r clean_flag
    if [[ $clean_flag == "Y" || $clean_flag == "y" ]]; then
        echo "Cleaning up old copy"
        sudo rm -rf "$webroot/xvwa"
        clone_and_configure_xvwa
    else
        echo "XVWA Setup Terminated."
    fi
else
    clone_and_configure_xvwa
fi
