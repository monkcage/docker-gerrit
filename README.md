# docker-gerrit
## LDAP config
gerrit.config
```
[ldap]
    server = ldap://your-host-ip
    username = cn=admin,dc=example,dc=com
    accountBase = dc=example,dc=com
    groupBase = dc=example,dc=com
```
secure.config
```
[ldap]
    password = secret
```
