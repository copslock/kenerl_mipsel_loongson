Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Aug 2003 12:54:24 +0100 (BST)
Received: from [IPv6:::ffff:203.197.124.190] ([IPv6:::ffff:203.197.124.190]:17677
	"EHLO alumnux.com") by linux-mips.org with ESMTP
	id <S8225343AbTHBLyV>; Sat, 2 Aug 2003 12:54:21 +0100
Received: from mamata (mamata.alumnus.co.in [192.168.10.121])
	by alumnux.com (8.9.3/8.9.3) with SMTP id WAA11295
	for <linux-mips@linux-mips.org>; Sat, 2 Aug 2003 22:58:43 +0530
From: "debashis" <debashis@alumnux.com>
To: <linux-mips@linux-mips.org>
Subject: Mlata: Problem with Flash Write
Date: Sat, 2 Aug 2003 17:24:11 +0530
Message-ID: <HPEELEDLLMNGNMNENADLKEDHCAAA.debashis@alumnux.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Return-Path: <debashis@alumnux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: debashis@alumnux.com
Precedence: bulk
X-list: linux-mips

Hi,
I have a problem with writing into the FLASH of Malta board. I am trying to
describe the problem bellow. Please help me. I am using Malta 4KC box and
running Linux Kernel 2.4.18.

I have writen a File System (ext2) into Flash address 0x9E100000 using
Yamon's 'load' command.

I have also loaded my Vmlinux into RAM using Yamon's 'load' command. Now I
am trying to access the File System written into Flash (Loaded at address
0x9E100000) from vmlinux code. I am actually enabled the MTD support and
using Test RAM driver(linux/drivers/mtd/devices/mtdram.c) to get a MTD
device. The portion of the configuration is given bellow -

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=y
CONFIG_MTD_DEBUG=y
CONFIG_MTD_DEBUG_VERBOSE=3
# CONFIG_MTD_PARTITIONS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CHAR is not set
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
......

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=1024
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTDRAM_ABS_POS=1E100000

Also I did the small change in the mtdram.c file -

	mtd_info->type = MTD_NORFLASH;
	mtd_info->flags = MTD_CAP_NORFLASH;


Now, with the above cofiguration I am able to mount the File System from
Flash. I am able to read the files. Also I can add/delete files. However,
once I unmount the File System, none of the changes are reflected into
Flash. So next time when I mount, I am not able to view my changes. It is
all old stuff. I saw that the ram_write() function gets called during
unmount.

Do I need to use some other driver? Any test code/sample code is available
for this? Any other suggestion are welcome.

Regards,
debashis
