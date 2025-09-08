# 🛡️ XVWA Setup - Automated Installation Tool

[![Shell Script](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![License: Apache-2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Security](https://img.shields.io/badge/Security-Pentesting-red.svg)](https://owasp.org/)
[![Web Security](https://img.shields.io/badge/Web%20Security-Vulnerability%20Testing-orange.svg)](https://www.owasp.org/index.php/OWASP_Testing_Guide)
[![XVWA](https://img.shields.io/badge/XVWA-Extreme%20Vulnerable%20Web%20App-purple.svg)](https://github.com/s4n7h0/xvwa)

**XVWA Setup** is an automated installation and configuration tool for the Xtreme Vulnerable Web Application (XVWA). This tool simplifies the complex setup process of XVWA, making it accessible for security professionals, penetration testers, and cybersecurity students who want to practice web application security testing in a controlled environment.

## 🎯 What is XVWA?

The **Xtreme Vulnerable Web Application (XVWA)** is a deliberately vulnerable web application designed for security testing and learning purposes. It contains various web vulnerabilities that are commonly found in real-world applications, making it an excellent platform for:

- **Penetration Testing Practice**
- **Web Application Security Training**
- **Vulnerability Assessment Learning**
- **Security Tool Testing**
- **Educational Purposes**

## 🚀 Features

### ⚡ **One-Click Installation**
- Automated setup process with minimal user intervention
- Handles all dependencies and configuration automatically
- Compatible with Ubuntu, Debian, and other Linux distributions

### 🔧 **Complete Environment Setup**
- **Apache Web Server** configuration
- **MySQL Database** setup and initialization
- **PHP** environment configuration
- **XVWA Application** download and installation
- **Database Schema** creation and population

### 🛡️ **Security-Focused**
- Isolated testing environment
- No impact on production systems
- Safe for educational and testing purposes
- Follows security best practices for lab environments

### 📚 **Educational Value**
- Perfect for cybersecurity courses
- Hands-on vulnerability testing
- Real-world attack simulation
- Security tool validation

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    XVWA Setup Tool                         │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   System    │  │   Apache    │  │   MySQL     │        │
│  │  Updates    │  │   Server    │  │  Database   │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │     PHP     │  │    XVWA     │  │  Database   │        │
│  │  Extension  │  │ Application │  │   Schema    │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
├─────────────────────────────────────────────────────────────┤
│              Vulnerable Web Application                    │
│              Ready for Security Testing                    │
└─────────────────────────────────────────────────────────────┘
```

## 🚀 Quick Start

### Prerequisites

- **Linux Distribution**: Ubuntu 18.04+, Debian 9+, or CentOS 7+
- **Root Access**: sudo privileges required
- **Internet Connection**: For downloading dependencies
- **Minimum 2GB RAM**: Recommended for smooth operation
- **5GB Free Space**: For installation and database

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/vatshariyani/xvwa-setup.git
   cd xvwa-setup
   ```

2. **Make the script executable**
   ```bash
   sudo chmod +x xvwa_setup.sh
   ```

3. **Run the installation script**
   ```bash
   sudo ./xvwa_setup.sh
   ```

4. **Access XVWA**
   ```
   Open your browser and navigate to:
   http://localhost/xvwa
   ```

## 📋 What the Script Does

### 🔄 **System Preparation**
- Updates package repositories
- Installs essential development tools
- Configures system for web development

### 🌐 **Web Server Setup**
- Installs and configures Apache HTTP Server
- Sets up virtual hosts for XVWA
- Configures proper permissions and ownership

### 🗄️ **Database Configuration**
- Installs MySQL/MariaDB server
- Creates dedicated database for XVWA
- Sets up database user with appropriate privileges
- Imports initial database schema

### 🐘 **PHP Environment**
- Installs PHP with required extensions
- Configures PHP settings for XVWA
- Enables necessary PHP modules

### 📦 **Application Installation**
- Downloads XVWA from official repository
- Places files in web root directory
- Sets proper file permissions
- Configures application settings

## 🎮 Usage

### Accessing XVWA

After successful installation, you can access XVWA through:

```
URL: http://localhost/xvwa
Default Credentials: admin / admin
```

### Common Vulnerabilities Included

XVWA includes various web vulnerabilities for testing:

- **SQL Injection** (Blind, Union-based, Error-based)
- **Cross-Site Scripting (XSS)** (Reflected, Stored, DOM-based)
- **Cross-Site Request Forgery (CSRF)**
- **File Upload Vulnerabilities**
- **Authentication Bypass**
- **Session Management Issues**
- **Insecure Direct Object References**
- **Security Misconfiguration**
- **Insecure Cryptographic Storage**
- **Insufficient Transport Layer Protection**

### Testing Workflow

1. **Reconnaissance**: Explore the application structure
2. **Vulnerability Identification**: Use automated and manual testing
3. **Exploitation**: Practice various attack techniques
4. **Documentation**: Record findings and remediation steps

## 🔧 Configuration

### Custom Installation Path

If you want to install XVWA in a custom directory:

```bash
# Edit the script and modify the webroot variable
WEBROOT="/custom/path/to/webroot"
```

### Database Configuration

The script automatically creates:
- **Database Name**: `xvwa`
- **Username**: `xvwa_user`
- **Password**: `xvwa_pass`

To modify these settings, edit the script before running:

```bash
# Database configuration variables
DB_NAME="xvwa"
DB_USER="xvwa_user"
DB_PASS="xvwa_pass"
```

### Apache Configuration

The script configures Apache with:
- **Document Root**: `/var/www/html`
- **Virtual Host**: Enabled for localhost
- **Mod Rewrite**: Enabled for clean URLs
- **Error Logging**: Configured for debugging

## 🛠️ Troubleshooting

### Common Issues

**Permission Denied Error**
```bash
# Solution: Ensure script has execute permissions
sudo chmod +x xvwa_setup.sh
```

**Port 80 Already in Use**
```bash
# Solution: Stop conflicting services
sudo systemctl stop nginx
sudo systemctl stop apache2
```

**Database Connection Failed**
```bash
# Solution: Check MySQL service status
sudo systemctl status mysql
sudo systemctl start mysql
```

**PHP Extensions Missing**
```bash
# Solution: Install required PHP extensions
sudo apt-get install php-mysql php-curl php-gd php-mbstring
```

### Log Files

Check these log files for troubleshooting:

```bash
# Apache error logs
sudo tail -f /var/log/apache2/error.log

# MySQL error logs
sudo tail -f /var/log/mysql/error.log

# System logs
sudo journalctl -u apache2
sudo journalctl -u mysql
```

## 🔒 Security Considerations

### ⚠️ **Important Security Notes**

- **Never use XVWA on production systems**
- **Isolate the testing environment**
- **Use strong passwords for database access**
- **Regularly update the system and dependencies**
- **Monitor network traffic and logs**

### 🛡️ **Best Practices**

- Run XVWA in a virtual machine or isolated environment
- Use a dedicated testing network
- Implement proper firewall rules
- Regular security updates
- Backup important data before testing

## 📚 Educational Resources

### Learning Path

1. **OWASP Top 10**: Understand common web vulnerabilities
2. **Manual Testing**: Practice without automated tools
3. **Tool Integration**: Use Burp Suite, OWASP ZAP, etc.
4. **Code Review**: Analyze vulnerable code patterns
5. **Remediation**: Learn proper security fixes

### Recommended Tools

- **Burp Suite**: Web application security testing
- **OWASP ZAP**: Free security testing tool
- **SQLMap**: Automated SQL injection testing
- **Nikto**: Web server scanner
- **Nmap**: Network discovery and security auditing

## 🧪 Testing Scenarios

### Beginner Level
- Basic SQL injection
- Simple XSS attacks
- Authentication bypass
- File upload testing

### Intermediate Level
- Blind SQL injection
- Stored XSS
- CSRF token bypass
- Session hijacking

### Advanced Level
- Time-based SQL injection
- DOM-based XSS
- Advanced CSRF techniques
- Privilege escalation

## 🤝 Contributing

We welcome contributions to improve the XVWA setup process!

### Areas for Contribution
- **Additional OS Support**: Windows, macOS compatibility
- **Docker Integration**: Containerized setup
- **Configuration Options**: More customization options
- **Error Handling**: Better error messages and recovery
- **Documentation**: Improved guides and tutorials

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on different systems
5. Submit a pull request

## 📄 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **XVWA Original Authors**: For creating the vulnerable web application
- **OWASP Community**: For security testing guidelines and resources
- **Security Community**: For continuous feedback and improvements
- **Open Source Contributors**: For making security education accessible

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/vatshariyani/xvwa-setup/issues)
- **Discussions**: [GitHub Discussions](https://github.com/vatshariyani/xvwa-setup/discussions)
- **Documentation**: Check the troubleshooting section above

## 🗺️ Roadmap

- [ ] **v2.0**: Docker containerization support
- [ ] **v2.1**: Windows PowerShell script
- [ ] **v2.2**: Automated vulnerability scanning
- [ ] **v2.3**: Multiple XVWA versions support
- [ ] **v2.4**: Web-based management interface

## 🎯 Use Cases

### Educational Institutions
- Cybersecurity courses and labs
- Hands-on security training
- Student assessment and evaluation
- Research and development

### Security Professionals
- Penetration testing practice
- Tool validation and testing
- Security awareness training
- Vulnerability research

### Organizations
- Security team training
- Red team exercises
- Security tool evaluation
- Compliance testing

## ⚡ Performance

### System Requirements
- **Minimum RAM**: 2GB
- **Recommended RAM**: 4GB+
- **Storage**: 5GB free space
- **CPU**: 2 cores minimum
- **Network**: Internet connection for initial setup

### Installation Time
- **Fast Setup**: 5-10 minutes on modern systems
- **Dependencies**: Automatic download and installation
- **Configuration**: Automated with minimal user input

---

**Made with 🛡️ by [Vats Hariyani](https://github.com/vatshariyani)**

*Simplifying web application security testing through automated setup and configuration.*

## 🌟 Star History

[![Star History Chart](https://api.star-history.com/svg?repos=vatshariyani/xvwa-setup&type=Date)](https://star-history.com/#vatshariyani/xvwa-setup&Date)
