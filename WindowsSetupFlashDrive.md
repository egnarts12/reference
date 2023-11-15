# Problem
Recent Windows setup ISO files provided by Microsoft contain `install.wim` or `install.esd` that is larger than the maximum filesize of the FAT32 filesystem (4GiB). This makes the creation of bootable USB mass storage setup media (flash drives) more complex.

At first glance, the solution is to create a single exFAT or NTFS partition on the installation media, but because the UEFI specification only mandates that FAT12/16/32 filesystems are bootable, this is only suitable if the vendor chose to add support for these additional filesystems. This support is not typically publicly documented. Another solution may be to apply "maximum" compression to the file using `dism` to decrease filesize to below the 4GiB limit of FAT32, but this method requires a Windows host, additional skill and time, and the associated decompression will increase CPU overhead during installation, which may result in lengthier installation time.

# Simplest Solution
The official Media Creation Tool from Microsoft uses a similar, if not identical, method.

NOTE: MBR or GPT are both suitable
## Step 1
Create two partitions on the flash drive, as shown in the table below. NOTE: Check the combined size of the files listed in the "Contents" column before creating the partitions to verify the partition size is adequate. Then, copy the files in the "Contents" column to the respective partition.
| Partition | Filesystem | Size (Example) | Contents |
|----------:|-----------:|---------------:|----------|
| 1 | FAT32 | 2GiB | Contents of the Windows ISO, not including the `Sources` folder
| 2 | NTFS | 6GiB | Contains only the entire `Sources` folder from the ISO

## Step 2
Create a folder titled `Sources` on the FAT32 partition and copy `Sources\boot.wim` to this folder from the ISO.
