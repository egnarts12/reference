# Problem
Recent Windows setup ISO files provided by Microsoft contain `install.wim` or `install.esd` that is larger than the maximum filesize of the FAT32 filesystem (4GiB). This makes the creation of bootable USB mass storage setup media (flash drives) more complex. On UEFI systems, it was as simple as creating a single FAT32 partition and extracting the contents of the setup ISO to the drive. This method no longer works.

At first glance, the solution is to create a single exFAT or NTFS partition on the installation media, but because the UEFI specification only mandates that FAT12/16/32 filesystems are bootable, this is only suitable if the vendor chose to add support for these additional filesystems. This support is not typically publicly documented. Another solution may be to apply "maximum" compression to the file using `dism` to decrease filesize to below the 4GiB limit of FAT32, but this method requires a Windows host, additional skill and time, and the associated decompression will increase CPU overhead during installation, which may result in lengthier installation time.

# Simplest Solution
The official Media Creation Tool from Microsoft uses a similar, if not identical, method. These generic instructions can be used on any OS.

NOTE: MBR and GPT are both suitable

Create two partitions on the flash drive, as shown in the table below. NOTE: Check the combined size of the files listed in the "Contents" column before creating the partitions to verify the partition size is adequate. Then, copy the files in the "Contents" column to the respective partition.
| Partition | Filesystem | Size (Example) | Contents |
|----------:|-----------:|---------------:|----------|
| 1 | FAT32 | 2GiB | Contents of the Windows ISO, not including the `Sources` folder. From the  `Sources` folder of the ISO, only copy `Sources\boot.wim` to `Sources\boot.wim` of the new installation media.
| 2 | NTFS | 6GiB | Contains only the entire `Sources` folder from the ISO
