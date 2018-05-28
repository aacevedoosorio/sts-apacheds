# ApacheDS

This Docker image provides an [ApacheDS](https://directory.apache.org/apacheds/) LDAP server.


## Build

    git clone https://github.com/openmicroscopy/apacheds-docker.git
    docker build -t openmicroscopy/apacheds apacheds-docker


## Installation

All the installation plus the runtime data can be found at */opt/apacheds-2.0.0-M23/*

The container can be started issuing the following command:

    docker run -d  -p 10389:10389 --name sts-ldap stackstate/apacheds


## Usage

You can manage the ldap server with the admin user *uid=admin,ou=system* and the default password *secret*. The *default* instance comes with a pre-configured partition *dc=stackstate,dc=com*.

Then you can import extra entries into that partition via your own *ldif* file:

```
    ldapadd -v -h <your-docker-ip>:10389 -c -x -D uid=admin,ou=system -w <your-admin-password> -f sample.ldif
	ldapsearch -x -H ldap://localhost:10389 -b "ou=employees,dc=stackstate,dc=com" "cn=demouser1"  -w password
	ldapsearch -x -H ldap://localhost:10389 -b "ou=system" "uid=admin" -w secret
```