# azure-file-workload

This script demos using the Microsoft Azure File Service from a Docker Container.

To see how this works, try the demo:

1. create an azure storage account and file share according to: http://blogs.msdn.com/b/windowsazurestorage/archive/2014/05/12/introducing-microsoft-azure-file-service.aspx

2. next type "docker run --privileged anhowe/azure-file-workload STORAGEACCOUNTNAME STORAGEACCOUNTKEY SHARENAME"

# Running in Marathon on a Mesos Cluster

If you have created a mesos cluster from the [Mesos Azure Quickstart template](https://github.com/Azure/azure-quickstart-templates/tree/master/mesos-swarm-marathon), then following the instructions below.

1. In Azure Portal, create a storage account in the same region as the mesos cluster (alternatively you can one of the existing storage accounts created with the mesos cluster).

2. Using the Portal, get the primary access key for later in the instructions.

3. Create a share with the cluster, using the following commands from powershell

 ```powershell
 $ctx=New-AzureStorageContext STORAGEACCOUNT STORAGEACCOUNTKEY
 $s = New-AzureStorageShare SHARE -Context $ctx
 ```

4. Go to Marathon, start the App, and run the command docker run --privileged anhowe/azure-file-workload STORAGEACCOUNTNAME STORAGEACCOUNTKEY SHARE (replacing the ALLCAPS names with the correct values)

 ![Image of marathon with a single instance](https://raw.githubusercontent.com/anhowe/azure-file-workload/master/images/marathon-app.png)

5. The docker image anhowe/azure-file-workload will mount the share to /mnt/sharename in the docker container, and then start writing 1MB random files to that share.

6. Use Marathon to scale up to 5

 ![Image of marathon with a single instance](https://raw.githubusercontent.com/anhowe/azure-file-workload/master/images/marathon-app2.png)

7. Then scale up to 20 and then to 30 containers

8. Looking at the storage account performance you can see the load increase as you increase the containers

 ![storage load](https://raw.githubusercontent.com/anhowe/azure-file-workload/master/images/storageaccountload.png)
