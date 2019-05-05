Irmin handles the data using stores. Irmin-ipfs uses two stores: AppendOnly and AtomicRead. AppendOnly store is used to put the data and AtomicWrites stores the key pointing to the latest version of the data.

##How IPFS handles key and values
When a data is added into IPFS, it returns back a hash which can identify the data into the network. Every time a new version of the data is pushed, a new hash is generated. These hashes are unique, since they are based on the data itself. Since these hash values keep changing everytime any modification is made in the data, it becomes difficult to use them.
To provide a single handle to the latest version of the data, IPFS uses a feature called `publish`. IPFS publish puts the data into the network and generates a key (hash) which is based on the IPFS id of the node. This key always points towards the latest version of the data pushed.
The problem with this is that, even if there are multiple data pushed over the network, only the latest one can be fetched using the key, all other are lost. IPFS uses `key` flag to handle this situation.
Using the `key` flag, user can generate different keys and while publishing the data, these keys can be used. The latest version of data pushed with such a key can be identified using that key. 



`ipfs_application.ml` is like a user interface where commands can be passed to use push key and data to ipfs and to fetch them back using the key.

`memipfs_ao.ml` processes the commands and sometimes interact with IPFS too. It is like a middle layer between irmin-ipfs backend and user application. This can be merged with backend in future.
Please find the comments in the code to understand how it is working.
