# azure-file-workload

This script demos using the Microsoft Azure File Service from a Docker Container.

To see how this works, try the demo:

1. create an azure storage account and file share according to: http://blogs.msdn.com/b/windowsazurestorage/archive/2014/05/12/introducing-microsoft-azure-file-service.aspx

2. next type "docker run --privileged anhowe/azure-file-workload STORAGEACCOUNTNAME STORAGEACCOUNTKEY SHARENAME"
