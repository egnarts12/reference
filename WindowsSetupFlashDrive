Problem
  "install.wim" or "install.esd" is larger than 4GB and will not fit on a FAT32 filesystem.
    The most apparent and simple solution is to use either exFAT or NTFS but this only works in some cases.
    The UEFI specification only mandates that FAT12/16/32 filesystems are bootable and only a few implementations support other filesystems.
    Compressing the file with dism may work but takes more work and makes installation slower.

Simple Solution
  The official Media Creation Tool from Microsoft uses a similar, if not identical, method.
  
  Create two partitions on the flash drive
    Partition 1: FAT32 and contains the contents of the Windows ISO, not including the "Sources" folder
    Partition 2: NTFS and contains only the sources folder
