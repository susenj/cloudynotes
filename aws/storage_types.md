# Block v/s Object Storage


| EC2 - EBS(Block storage) | S3(Object storage) |
| --- | --- |
| Block stoage is mainly suited for transactional databases, random read/write loads and structured database storage | Good for random files, static data |
| Block storage divides the data to be stored in evenly sized blocks and indexes them | Object storage stores the files as a whole, doesn't divide them |
| Data blocks would not contain metadata | An object can be the file itself and/or its metadata |
| Block storage can only be accessed through an AWS EC2 instance | Object files has a unique global id using which it can be retrieved from anywhere. For example: s3|


# S3(Simple Storage Service)

1. S3 has multi-part upload option too. One need to select this option while uploading. But it doesn't mean, it is block storage types. The multi parts are uploaded in parallel
2. S3 is a storage for the internet. It has a simple webservices interface for simple storing and retrieving of any amount of data, anytime from anywhere on the internet.
3. S3 is object based storage.
4. S3 has a distributed data-store architecture - store architecture where objects are redundantly stored in multiple locations
5. S3 is region-specific service. Keeps backup in all the AZ for that region.
6. S3 can't be used to install Operating Systems.
7. Data is stored in **Buckets**
8. A bucket is a flat container of objects. Buckets under buckets(nested buckets) are **not** allowed.
9. You can create folders in your buckets.
10. Max capacity of a bucket is **5 TB**
11. Bucket ownership can't be transferred.
12. 100 buckets max soft limit per account.
13. Bucket's name can't be changed once created. If a bucket is deleted, its name can be used for another bucker.
14. Bucket names are part of the URL used to access a bucket.
15. Bucket names **can't contain Uppercase** letters. It can only contain lowercase, numbers and hyphen(can't start or end with it though).
16. Bucket name should not be an IP address.
17. By default buckets and its objects are private.
18. S3 **supports versioning** of objects. It is by default disabled, but **once enabled can't be disabled.** Bucket versioning states are - Enabled, Suspended, and unversinoed(default)
19. **Versioning is bucket specific** not object specific. It's applied on all objects in a bucket.
20. S3 costs are incremental for versions uploaded. If a file is 4 mb and it's next verison is 4.5 mb, charge will get calculated for additional 0.5mb only.
21. Access Control Lists - Bucket policies
22. Bucket nomenclature: https://s3-ap-south-1.amaozonaws.com/mybucket
23. Object storage in a s3-bucket in a region will never leave that region unless you specifically move them to another region or CRR
24. A bucket owner can grant cross-accoutn permission to another AWS account(or users in another account) to upload objects.
25. You can grant S3 bucket/object permission to- **Individual users** / **AWS account** / **Public** / **all authenticated users**


## Elastic Block Store - EBS

**Elastic Block Store V/s Instance Store backed EC2**

**EBS **
- Persistent
- Network Attached Vrtual Drive
- EBS volumes are block storage types. Suitable for database style data that requires frequent read and writes.
- An EBS volume can only be attached to single EC2 instance at a time.
- EC2 and EBS should be in the same AZ to get associated with each other.
- EBS replication will also be done in the same AZ.

**Instance Store Backed EC2**
- Virtual Hard drive similar to hard disk allocated to VMs on a hypervisor
- Limited to 10 GB per device
- Faster than EBS because it's directly attached
- Non-persistent over termination or stopping. Persistent over reboots only.

