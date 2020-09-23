# Configuring CRC instance

Running service mesh on a CRC instance is possible. But it consumes some resources. 

By default, an unmodified CRC installation reserves 8 GB of memory (RAM) for the virtual machine running OpenShift. It is not enough to run Service Mesh. Depending of the confguration of the used environment, CRC could reserve more memory.

To extend the memory of your crc instance, do the following command:
```
crc config set memory 16384
``` 

This command should be issued before to create the crc instance. Otherwise, you have to delete the instance, execute the config command and recreate the instance. 

For example, here is the config I'm using:
![crc config](./images/crc_status.png)
