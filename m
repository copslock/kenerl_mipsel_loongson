Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2006 13:18:00 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:16552 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037767AbWLHNR4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2006 13:17:56 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 8DF553EC9; Fri,  8 Dec 2006 05:17:52 -0800 (PST)
Message-ID: <45796661.7070600@ru.mvista.com>
Date:	Fri, 08 Dec 2006 16:19:29 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Vitaly Wool <vitalywool@gmail.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH][respin] add STB810 support (Philips PNX8550-based)
References: <20061208114035.000049c4.vitalywool@gmail.com>
In-Reply-To: <20061208114035.000049c4.vitalywool@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Vitaly Wool wrote:

>  please find the updated  patch that adds support for STB810 below.

[...]


> Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

> Index: linux-mips.git/arch/mips/configs/pnx8550-stb810_defconfig
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-mips.git/arch/mips/configs/pnx8550-stb810_defconfig	2006-12-08 11:31:44.000000000 +0300

> +CONFIG_BLK_DEV_HPT366=y

    Oh? Definitely not a good driver support choice for embedded targets...
Does STB810 have is on board?

> +# CONFIG_BLK_DEV_HD is not set
> +
> +#
> +# SCSI device support
> +#
> +# CONFIG_RAID_ATTRS is not set
> +CONFIG_SCSI=y
> +# CONFIG_SCSI_NETLINK is not set
> +CONFIG_SCSI_PROC_FS=y
> +
> +#
> +# SCSI support type (disk, tape, CD-ROM)
> +#
> +CONFIG_BLK_DEV_SD=y

    Do we really need SCSI *disk* support?

> +#
> +# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> +#
> +# CONFIG_SCSI_MULTI_LUN is not set
> +CONFIG_SCSI_CONSTANTS=y
> +# CONFIG_SCSI_LOGGING is not set
> +
> +#
> +# SCSI Transports
> +#
> +# CONFIG_SCSI_SPI_ATTRS is not set
> +# CONFIG_SCSI_FC_ATTRS is not set
> +CONFIG_SCSI_ISCSI_ATTRS=m
> +# CONFIG_SCSI_SAS_ATTRS is not set
> +# CONFIG_SCSI_SAS_LIBSAS is not set
> +
> +#
> +# SCSI low-level drivers
> +#
> +CONFIG_ISCSI_TCP=m

    I doubt this kernel needs iSCSI crap even as modules...

> +#
> +# Watchdog Cards
> +#
> +# CONFIG_WATCHDOG is not set
> +CONFIG_HW_RANDOM=y

    Oh?

> +#
> +# Hardware Monitoring support
> +#
> +CONFIG_HWMON=y

    Oh really?

> +# may also be needed; see USB_STORAGE Help for more information
> +#
> +CONFIG_USB_STORAGE=y
> +# CONFIG_USB_STORAGE_DEBUG is not set
> +CONFIG_USB_STORAGE_DATAFAB=y
> +CONFIG_USB_STORAGE_FREECOM=y
> +CONFIG_USB_STORAGE_ISD200=y
> +CONFIG_USB_STORAGE_DPCM=y
> +CONFIG_USB_STORAGE_USBAT=y
> +CONFIG_USB_STORAGE_SDDR09=y
> +CONFIG_USB_STORAGE_SDDR55=y
> +CONFIG_USB_STORAGE_JUMPSHOT=y

    Hm, do we really need to support all these?

> +CONFIG_EXT2_FS=y
> +# CONFIG_EXT2_FS_XATTR is not set
> +# CONFIG_EXT2_FS_XIP is not set
> +# CONFIG_EXT3_FS is not set
> +# CONFIG_EXT4DEV_FS is not set
> +# CONFIG_REISERFS_FS is not set
> +# CONFIG_JFS_FS is not set
> +# CONFIG_FS_POSIX_ACL is not set
> +# CONFIG_XFS_FS is not set
> +# CONFIG_GFS2_FS is not set
> +# CONFIG_OCFS2_FS is not set
> +# CONFIG_MINIX_FS is not set
> +# CONFIG_ROMFS_FS is not set
> +CONFIG_INOTIFY=y
> +CONFIG_INOTIFY_USER=y
> +# CONFIG_QUOTA is not set
> +# CONFIG_DNOTIFY is not set
> +# CONFIG_AUTOFS_FS is not set
> +# CONFIG_AUTOFS4_FS is not set
> +# CONFIG_FUSE_FS is not set
> +
> +#
> +# CD-ROM/DVD Filesystems
> +#
> +# CONFIG_ISO9660_FS is not set
> +# CONFIG_UDF_FS is not set
> +
> +#
> +# DOS/FAT/NT Filesystems
> +#
> +CONFIG_FAT_FS=y
> +CONFIG_MSDOS_FS=y
> +CONFIG_VFAT_FS=y
> +CONFIG_FAT_DEFAULT_CODEPAGE=437
> +CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> +# CONFIG_NTFS_FS is not set
> +
> +#
> +# Pseudo filesystems
> +#
> +CONFIG_PROC_FS=y
> +# CONFIG_PROC_KCORE is not set
> +CONFIG_PROC_SYSCTL=y
> +CONFIG_SYSFS=y
> +CONFIG_TMPFS=y
> +# CONFIG_TMPFS_POSIX_ACL is not set
> +# CONFIG_HUGETLB_PAGE is not set
> +CONFIG_RAMFS=y
> +# CONFIG_CONFIGFS_FS is not set
> +
> +#
> +# Miscellaneous filesystems
> +#
> +# CONFIG_ADFS_FS is not set
> +# CONFIG_AFFS_FS is not set
> +# CONFIG_HFS_FS is not set
> +# CONFIG_HFSPLUS_FS is not set
> +# CONFIG_BEFS_FS is not set
> +# CONFIG_BFS_FS is not set
> +# CONFIG_EFS_FS is not set
> +# CONFIG_CRAMFS is not set
> +# CONFIG_VXFS_FS is not set
> +# CONFIG_HPFS_FS is not set
> +# CONFIG_QNX4FS_FS is not set
> +# CONFIG_SYSV_FS is not set
> +# CONFIG_UFS_FS is not set
> +
> +#
> +# Network File Systems
> +#
> +CONFIG_NFS_FS=y
> +CONFIG_NFS_V3=y
> +# CONFIG_NFS_V3_ACL is not set
> +# CONFIG_NFS_V4 is not set
> +# CONFIG_NFS_DIRECTIO is not set
> +CONFIG_NFSD=m
> +# CONFIG_NFSD_V3 is not set
> +# CONFIG_NFSD_TCP is not set
> +CONFIG_ROOT_NFS=y
> +CONFIG_LOCKD=y
> +CONFIG_LOCKD_V4=y
> +CONFIG_EXPORTFS=m
> +CONFIG_NFS_COMMON=y
> +CONFIG_SUNRPC=y
> +# CONFIG_RPCSEC_GSS_KRB5 is not set
> +# CONFIG_RPCSEC_GSS_SPKM3 is not set
> +# CONFIG_SMB_FS is not set
> +# CONFIG_CIFS is not set
> +# CONFIG_NCP_FS is not set
> +# CONFIG_CODA_FS is not set
> +# CONFIG_AFS_FS is not set
> +# CONFIG_9P_FS is not set
> +
> +#
> +# Partition Types
> +#
> +# CONFIG_PARTITION_ADVANCED is not set
> +CONFIG_MSDOS_PARTITION=y

    I doubt this kernel needs iSCSI crap even as modules but well...

WBR, Sergei
