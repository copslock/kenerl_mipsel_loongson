Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Feb 2005 07:26:16 +0000 (GMT)
Received: from smtp001.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.125]:39356
	"HELO smtp001.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8224806AbVBVHZy>; Tue, 22 Feb 2005 07:25:54 +0000
Received: from unknown (HELO ?10.2.2.64?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp001.bizmail.yahoo.com with SMTP; 22 Feb 2005 07:25:50 -0000
Message-ID: <421ADE76.5020905@embeddedalley.com>
Date:	Mon, 21 Feb 2005 23:25:42 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Fixes to MTD flash driver on AMD Alchemy db1100 board
References: <1108962105.6611.24.camel@SillyPuddy.localdomain>	 <200502211144.58470.eckhardt@satorlaser.com>	 <1109030275.13988.21.camel@SillyPuddy.localdomain> <1109052412.20045.6.camel@SillyPuddy.localdomain>
In-Reply-To: <1109052412.20045.6.camel@SillyPuddy.localdomain>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040808010503020405080103"
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040808010503020405080103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Here is a 2.6 patch that gets rid of all the Au1x mapping files and 
replaces them with a single file. The driver doesn't check for 
different flash densities supported by the Db1x  boards, but it 
turns out AMD always shipped the boards with a single configuration 
only. This file should work on all boards. And I think it should 
work with 2.4 as well, as long as the entire tree is patched. 
Though, I need to first update the 2.4 style Config.in in the mtd tree.

Pete

Josh Green wrote:
> On Mon, 2005-02-21 at 15:57 -0800, Josh Green wrote:
> 
>>I've also got jffs2 working on the User FS partition, but I get a whole
>>bunch of errors when it boots (regardless it still seems to function).
>>I'll post these in another thread if I can't get it resolved.
>>
> 
> 
> Just to complete this thread, I did figure out what my trouble was.  I
> erroneously thought that I didn't need the mtd0-3 dev support, but I
> ended up needing it for the flash_erase (sometimes called just "erase")
> command, which was what I had to run before my jffs2 errors went away.
> Things seem to be working fine now :)  Make sure to erase the partition
> using the correct count, I had to do:
> 
> flash_erase /dev/mtd0 0 0xe0
> 
> The first parameter is the offset, the second is the number of "erase
> size" blocks to erase (likely different for your case).  This can be
> found from your total flash size divided by the erase size
> (cat /proc/mtd for this info).  Gee, funny how things work when you do
> it right :)  I must say documentation is lacking for the mtd tools
> though, I had to look at the code, sheesh, ha ha.  Cheers.
> 	Josh Green
> 


--------------040808010503020405080103
Content-Type: text/plain;
 name="alchemy_mtd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alchemy_mtd.patch"

diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/configs/db1000_defconfig linux-2.6-dev/arch/mips/configs/db1000_defconfig
--- linux-2.6-orig/arch/mips/configs/db1000_defconfig	2005-01-30 21:44:53.000000000 -0800
+++ linux-2.6-dev/arch/mips/configs/db1000_defconfig	2005-02-21 22:27:29.000000000 -0800
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.11-rc2
-# Sun Jan 30 19:02:48 2005
+# Mon Feb 21 22:20:54 2005
 #
 CONFIG_MIPS=y
 
@@ -182,6 +182,7 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
+# CONFIG_PM is not set
 
 #
 # Device Drivers
@@ -197,7 +198,67 @@
 #
 # Memory Technology Devices (MTD)
 #
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_CONCAT is not set
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+# CONFIG_MTD_CFI is not set
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_ALCHEMY=y
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
 
 #
 # Parallel port support
@@ -486,7 +547,8 @@
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
-CONFIG_RTC=y
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 
@@ -634,6 +696,8 @@
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_JFFS_FS is not set
+# CONFIG_JFFS2_FS is not set
 CONFIG_CRAMFS=m
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/configs/db1100_defconfig linux-2.6-dev/arch/mips/configs/db1100_defconfig
--- linux-2.6-orig/arch/mips/configs/db1100_defconfig	2005-01-30 21:44:53.000000000 -0800
+++ linux-2.6-dev/arch/mips/configs/db1100_defconfig	2005-02-21 22:34:42.000000000 -0800
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.11-rc2
-# Sun Jan 30 19:02:50 2005
+# Mon Feb 21 22:33:43 2005
 #
 CONFIG_MIPS=y
 
@@ -146,7 +146,7 @@
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-# CONFIG_64BIT_PHYS_ADDR is not set
+CONFIG_64BIT_PHYS_ADDR=y
 # CONFIG_CPU_ADVANCED is not set
 CONFIG_CPU_HAS_LLSC=y
 CONFIG_CPU_HAS_SYNC=y
@@ -180,6 +180,7 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
+# CONFIG_PM is not set
 
 #
 # Device Drivers
@@ -195,7 +196,67 @@
 #
 # Memory Technology Devices (MTD)
 #
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_CONCAT is not set
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+# CONFIG_MTD_CFI is not set
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_ALCHEMY=y
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
 
 #
 # Parallel port support
@@ -481,7 +542,8 @@
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
-CONFIG_RTC=y
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 
@@ -629,6 +691,8 @@
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_JFFS_FS is not set
+# CONFIG_JFFS2_FS is not set
 CONFIG_CRAMFS=m
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/configs/db1500_defconfig linux-2.6-dev/arch/mips/configs/db1500_defconfig
--- linux-2.6-orig/arch/mips/configs/db1500_defconfig	2005-01-30 21:44:53.000000000 -0800
+++ linux-2.6-dev/arch/mips/configs/db1500_defconfig	2005-02-21 21:48:46.000000000 -0800
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.11-rc2
-# Sun Jan 30 19:02:54 2005
+# Mon Feb 21 21:33:53 2005
 #
 CONFIG_MIPS=y
 
@@ -104,7 +104,7 @@
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_HAVE_DEC_LOCK=y
-CONFIG_DMA_COHERENT=y
+CONFIG_DMA_NONCOHERENT=y
 CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
@@ -190,6 +190,7 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
+# CONFIG_PM is not set
 
 #
 # Device Drivers
@@ -253,9 +254,7 @@
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
 # CONFIG_MTD_PHYSMAP is not set
-CONFIG_MTD_DB1X00=y
-CONFIG_MTD_DB1X00_BOOT=y
-CONFIG_MTD_DB1X00_USER=y
+CONFIG_MTD_ALCHEMY=y
 
 #
 # Self-contained MTD device drivers
@@ -617,7 +616,8 @@
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
-CONFIG_RTC=y
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/configs/db1550_defconfig linux-2.6-dev/arch/mips/configs/db1550_defconfig
--- linux-2.6-orig/arch/mips/configs/db1550_defconfig	2005-01-30 21:44:53.000000000 -0800
+++ linux-2.6-dev/arch/mips/configs/db1550_defconfig	2005-02-21 22:46:50.000000000 -0800
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.11-rc2
-# Sun Jan 30 19:02:57 2005
+# Mon Feb 21 22:40:28 2005
 #
 CONFIG_MIPS=y
 
@@ -104,7 +104,7 @@
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_HAVE_DEC_LOCK=y
-CONFIG_DMA_COHERENT=y
+CONFIG_DMA_NONCOHERENT=y
 CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
@@ -190,6 +190,7 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
+# CONFIG_PM is not set
 
 #
 # Device Drivers
@@ -252,9 +253,7 @@
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
 # CONFIG_MTD_PHYSMAP is not set
-CONFIG_MTD_DB1550=y
-CONFIG_MTD_DB1550_BOOT=y
-CONFIG_MTD_DB1550_USER=y
+CONFIG_MTD_ALCHEMY=y
 
 #
 # Self-contained MTD device drivers
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/configs/pb1100_defconfig linux-2.6-dev/arch/mips/configs/pb1100_defconfig
--- linux-2.6-orig/arch/mips/configs/pb1100_defconfig	2005-01-30 21:44:55.000000000 -0800
+++ linux-2.6-dev/arch/mips/configs/pb1100_defconfig	2005-02-21 22:00:40.000000000 -0800
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.11-rc2
-# Sun Jan 30 19:03:55 2005
+# Mon Feb 21 22:00:32 2005
 #
 CONFIG_MIPS=y
 
@@ -148,7 +148,7 @@
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
-# CONFIG_64BIT_PHYS_ADDR is not set
+CONFIG_64BIT_PHYS_ADDR=y
 # CONFIG_CPU_ADVANCED is not set
 CONFIG_CPU_HAS_LLSC=y
 CONFIG_CPU_HAS_SYNC=y
@@ -184,6 +184,7 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
+# CONFIG_PM is not set
 
 #
 # Device Drivers
@@ -246,9 +247,7 @@
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
 # CONFIG_MTD_PHYSMAP is not set
-CONFIG_MTD_PB1100=y
-CONFIG_MTD_PB1500_BOOT=y
-CONFIG_MTD_PB1500_USER=y
+CONFIG_MTD_ALCHEMY=y
 
 #
 # Self-contained MTD device drivers
@@ -547,7 +546,8 @@
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
-CONFIG_RTC=y
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/configs/pb1500_defconfig linux-2.6-dev/arch/mips/configs/pb1500_defconfig
--- linux-2.6-orig/arch/mips/configs/pb1500_defconfig	2005-01-30 21:44:55.000000000 -0800
+++ linux-2.6-dev/arch/mips/configs/pb1500_defconfig	2005-02-21 22:11:42.000000000 -0800
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.11-rc2
-# Sun Jan 30 19:03:58 2005
+# Mon Feb 21 22:05:25 2005
 #
 CONFIG_MIPS=y
 
@@ -104,7 +104,7 @@
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_HAVE_DEC_LOCK=y
-CONFIG_DMA_COHERENT=y
+CONFIG_DMA_NONCOHERENT=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
@@ -191,6 +191,7 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
+# CONFIG_PM is not set
 
 #
 # Device Drivers
@@ -206,7 +207,68 @@
 #
 # Memory Technology Devices (MTD)
 #
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_CONCAT is not set
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+# CONFIG_MTD_CFI is not set
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_ALCHEMY=y
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
 
 #
 # Parallel port support
@@ -726,6 +788,8 @@
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_JFFS_FS is not set
+# CONFIG_JFFS2_FS is not set
 CONFIG_CRAMFS=m
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/configs/pb1550_defconfig linux-2.6-dev/arch/mips/configs/pb1550_defconfig
--- linux-2.6-orig/arch/mips/configs/pb1550_defconfig	2005-01-30 21:44:55.000000000 -0800
+++ linux-2.6-dev/arch/mips/configs/pb1550_defconfig	2005-02-21 22:19:48.000000000 -0800
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.11-rc2
-# Sun Jan 30 19:04:01 2005
+# Mon Feb 21 22:19:39 2005
 #
 CONFIG_MIPS=y
 
@@ -104,7 +104,7 @@
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_HAVE_DEC_LOCK=y
-CONFIG_DMA_COHERENT=y
+CONFIG_DMA_NONCOHERENT=y
 CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
@@ -191,6 +191,7 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
+# CONFIG_PM is not set
 
 #
 # Device Drivers
@@ -206,7 +207,68 @@
 #
 # Memory Technology Devices (MTD)
 #
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_CONCAT is not set
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+# CONFIG_MTD_CFI is not set
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_ALCHEMY=y
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
 
 #
 # Parallel port support
@@ -718,6 +780,8 @@
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_JFFS_FS is not set
+# CONFIG_JFFS2_FS is not set
 CONFIG_CRAMFS=m
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
diff -Naur --exclude=CVS linux-2.6-orig/drivers/mtd/maps/alchemy-flash.c linux-2.6-dev/drivers/mtd/maps/alchemy-flash.c
--- linux-2.6-orig/drivers/mtd/maps/alchemy-flash.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/drivers/mtd/maps/alchemy-flash.c	2005-02-21 21:35:35.000000000 -0800
@@ -0,0 +1,189 @@
+/*
+ * Flash memory access on AMD Alchemy evaluation boards
+ * 
+ * $Id: alchey-flash.c,v 1.0 2004/11/04 13:24:14 gleixner Exp $
+ *
+ * (C) 2003, 2004 Pete Popov <ppopov@embeddedalley.com>
+ * 
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/io.h>
+
+#ifdef 	DEBUG_RW
+#define	DBG(x...)	printk(x)
+#else
+#define	DBG(x...)	
+#endif
+
+#ifdef CONFIG_MIPS_PB1000
+#define BOARD_MAP_NAME "Pb1000 Flash"
+#define BOARD_FLASH_SIZE 0x00800000 /* 8MB */
+#define BOARD_FLASH_WIDTH 4 /* 32-bits */
+#endif
+
+#ifdef CONFIG_MIPS_PB1500
+#define BOARD_MAP_NAME "Pb1500 Flash"
+#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */
+#define BOARD_FLASH_WIDTH 4 /* 32-bits */
+#endif
+
+#ifdef CONFIG_MIPS_PB1100
+#define BOARD_MAP_NAME "Pb1100 Flash"
+#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */
+#define BOARD_FLASH_WIDTH 4 /* 32-bits */
+#endif
+
+#ifdef CONFIG_MIPS_PB1550
+#define BOARD_MAP_NAME "Pb1550 Flash"
+#define BOARD_FLASH_SIZE 0x08000000 /* 128MB */
+#define BOARD_FLASH_WIDTH 4 /* 32-bits */
+#endif
+
+#ifdef CONFIG_MIPS_PB1200
+#define BOARD_MAP_NAME "Pb1200 Flash"
+#define BOARD_FLASH_SIZE 0x08000000 /* 128MB */
+#define BOARD_FLASH_WIDTH 2 /* 16-bits */
+#endif
+
+#ifdef CONFIG_MIPS_DB1000
+#define BOARD_MAP_NAME "Db1000 Flash"
+#define BOARD_FLASH_SIZE 0x02000000 /* 32MB */
+#define BOARD_FLASH_WIDTH 4 /* 32-bits */
+#endif
+
+#ifdef CONFIG_MIPS_DB1500
+#define BOARD_MAP_NAME "Db1500 Flash"
+#define BOARD_FLASH_SIZE 0x02000000 /* 32MB */
+#define BOARD_FLASH_WIDTH 4 /* 32-bits */
+#endif
+
+#ifdef CONFIG_MIPS_DB1100
+#define BOARD_MAP_NAME "Db1100 Flash"
+#define BOARD_FLASH_SIZE 0x02000000 /* 32MB */
+#define BOARD_FLASH_WIDTH 4 /* 32-bits */
+#endif
+
+#ifdef CONFIG_MIPS_DB1550
+#define BOARD_MAP_NAME "Db1550 Flash"
+#define BOARD_FLASH_SIZE 0x08000000 /* 128MB */
+#define BOARD_FLASH_WIDTH 4 /* 32-bits */
+#endif
+
+#ifdef CONFIG_MIPS_DB1200
+#define BOARD_MAP_NAME "Db1200 Flash"
+#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */
+#define BOARD_FLASH_WIDTH 2 /* 16-bits */
+#endif
+
+#ifdef CONFIG_MIPS_HYDROGEN3
+#define BOARD_MAP_NAME "Hydrogen3 Flash"
+#define BOARD_FLASH_SIZE 0x02000000 /* 32MB */
+#define BOARD_FLASH_WIDTH 4 /* 32-bits */
+#define USE_LOCAL_ACCESSORS /* why? */
+#endif
+
+#ifdef CONFIG_MIPS_BOSPORUS
+#define BOARD_MAP_NAME "Bosporus Flash"
+#define BOARD_FLASH_SIZE 0x01000000 /* 16MB */
+#define BOARD_FLASH_WIDTH 2 /* 16-bits */
+#endif
+
+#ifdef CONFIG_MIPS_MIRAGE
+#define BOARD_MAP_NAME "Mirage Flash"
+#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */
+#define BOARD_FLASH_WIDTH 4 /* 32-bits */
+#define USE_LOCAL_ACCESSORS /* why? */
+#endif
+
+static struct map_info alchemy_map = {
+	.name =	BOARD_MAP_NAME,
+};
+
+static struct mtd_partition alchemy_partitions[] = {
+        {
+                .name = "User FS",
+                .size = BOARD_FLASH_SIZE - 0x00400000,
+                .offset = 0x0000000
+        },{
+                .name = "YAMON",
+                .size = 0x0100000,
+		.offset = MTDPART_OFS_APPEND,
+                .mask_flags = MTD_WRITEABLE
+        },{
+                .name = "raw kernel",
+		.size = (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset = MTDPART_OFS_APPEND,
+        }
+};
+
+#define NB_OF(x)  (sizeof(x)/sizeof(x[0]))
+
+static struct mtd_info *mymtd;
+
+int __init alchemy_mtd_init(void)
+{
+	struct mtd_partition *parts;
+	int nb_parts = 0;
+	unsigned long window_addr;
+	unsigned long window_size;
+	
+	/* Default flash buswidth */
+	alchemy_map.bankwidth = BOARD_FLASH_WIDTH;
+
+	window_addr = 0x20000000 - BOARD_FLASH_SIZE;
+	window_size = BOARD_FLASH_SIZE;
+#ifdef CONFIG_MIPS_MIRAGE_WHY
+	/* Boot ROM flash bank only; no user bank */
+	window_addr = 0x1C000000;
+	window_size = 0x04000000;
+	/* USERFS from 0x1C00 0000 to 0x1FC00000 */
+	alchemy_partitions[0].size = 0x03C00000;
+#endif
+
+	/*
+	 * Static partition definition selection
+	 */
+	parts = alchemy_partitions;
+	nb_parts = NB_OF(alchemy_partitions);
+	alchemy_map.size = window_size;
+
+	/*
+	 * Now let's probe for the actual flash.  Do it here since
+	 * specific machine settings might have been set above.
+	 */
+	printk(KERN_NOTICE BOARD_MAP_NAME ": probing %d-bit flash bus\n", 
+			alchemy_map.bankwidth*8);
+	alchemy_map.virt = ioremap(window_addr, window_size);
+	mymtd = do_map_probe("cfi_probe", &alchemy_map);
+	if (!mymtd) return -ENXIO;
+	mymtd->owner = THIS_MODULE;
+
+	add_mtd_partitions(mymtd, parts, nb_parts);
+	return 0;
+}
+
+static void __exit alchemy_mtd_cleanup(void)
+{
+	if (mymtd) {
+		del_mtd_partitions(mymtd);
+		map_destroy(mymtd);
+		iounmap((void *) alchemy_map.virt);
+	}
+}
+
+module_init(alchemy_mtd_init);
+module_exit(alchemy_mtd_cleanup);
+
+MODULE_AUTHOR("Embedded Alley Solutions, Inc");
+MODULE_DESCRIPTION(BOARD_MAP_NAME " MTD driver");
+MODULE_LICENSE("GPL");
diff -Naur --exclude=CVS linux-2.6-orig/drivers/mtd/maps/Kconfig linux-2.6-dev/drivers/mtd/maps/Kconfig
--- linux-2.6-orig/drivers/mtd/maps/Kconfig	2005-01-30 21:45:19.000000000 -0800
+++ linux-2.6-dev/drivers/mtd/maps/Kconfig	2005-02-21 22:13:00.000000000 -0800
@@ -207,52 +207,6 @@
 	help
 	  Support for flash chips on NETtel/SecureEdge/SnapGear boards.
 
-config MTD_PB1550
-	tristate "Flash devices on Alchemy PB1550 board"
-	depends on MIPS && MIPS_PB1550
-	help
-	  Flash memory access on Alchemy Pb1550 board
-
-config MTD_PB1550_BOOT
-	bool "PB1550 boot flash device"
-	depends on MTD_PB1550
-	help
-	  Use the first of the two 64MiB flash banks on Pb1550 board.
-	  You can say 'Y' to both this and 'MTD_PB1550_USER' below, to use
-	  both banks.
-
-config MTD_PB1550_USER
-	bool "PB1550 user flash device"
-	depends on MTD_PB1550
-	default y if MTD_PB1550_BOOT = n
-	help
-	  Use the second of the two 64MiB flash banks on Pb1550 board.
-	  You can say 'Y' to both this and 'MTD_PB1550_BOOT' above, to use
-	  both banks.
-
-config MTD_DB1550
-	tristate "Flash devices on Alchemy DB1550 board"
-	depends on MIPS && MIPS_DB1550
-	help
-	  Flash memory access on Alchemy Db1550 board
-
-config MTD_DB1550_BOOT
-	bool "DB1550 boot flash device"
-	depends on MTD_DB1550
-	help
-	  Use the first of the two 64MiB flash banks on Db1550 board.
-	  You can say 'Y' to both this and 'MTD_DB1550_USER' below, to use
-	  both banks.
-
-config MTD_DB1550_USER
-	bool "DB1550 user flash device"
-	depends on MTD_DB1550
-	default y if MTD_DB1550_BOOT = n
-	help
-	  Use the second of the two 64MiB flash banks on Db1550 board.
-	  You can say 'Y' to both this and 'MTD_DB1550_BOOT' above, to use
-	  both banks.
-
 config MTD_DILNETPC
 	tristate "CFI Flash device mapped on DIL/Net PC"
 	depends on X86 && MTD_CONCAT && MTD_PARTITIONS && MTD_CFI_INTELEXT
@@ -328,67 +282,11 @@
 	  Mapping for the Flaga digital module. If you don't have one, ignore
 	  this setting.
 
-config MTD_PB1000
-	tristate "Pb1000 Boot Flash device"
-	depends on MIPS && MIPS_PB1000
-	help
-	  Flash memory access on Alchemy Pb1000
-
-config MTD_PB1100
-	tristate "Pb1100 Flash device"
-	depends on MIPS && MIPS_PB1100
-	help
-	  Flash memory access on Alchemy Pb1100
-
-config MTD_PB1500
-	tristate "Pb1500 Flash device"
-	depends on MIPS && MIPS_PB1500
-	help
-	  Flash memory access on Alchemy Pb1500
-
-config MTD_PB1500_BOOT
-	bool "Pb1100/Pb1500 Boot Flash device"
-	depends on MIPS && (MTD_PB1500 || MTD_PB1100)
-	help
-	  Use the first of the two 32MB flash banks on Pb1100/Pb1500 board.
-	  You can say 'Y' to both this and the USER flash option, to use
-	  both banks.
-
-config MTD_PB1500_USER
-	bool "Pb1100/Pb1500 User Flash device (2nd 32MB bank)"
-	depends on MIPS && (MTD_PB1500 || MTD_PB1100)
-	help
-	  Use the second of the two 32MB flash banks on Pb1100/Pb1500 board.
-	  You can say 'Y' to both this and the BOOT flash option, to use
-	  both banks.
-
-config MTD_DB1X00
-	tristate "Db1X00 Flash device"
-	depends on MIPS && (MIPS_DB1000 || MIPS_DB1100 || MIPS_DB1500)
-	help
-	  Flash memory access on Alchemy Db1X00 Boards
-
-config MTD_DB1X00_BOOT
-	bool "Db1X00 Boot Flash device"
-	depends on MIPS && MTD_DB1X00
-	help
-	  Use the first of the two 32MB flash banks on Db1X00 board.
-	  You can say 'Y' to both this and the USER flash option, to use
-	  both banks.
-
-config MTD_DB1X00_USER
-	bool "Db1X00 User Flash device (2nd 32MB bank)"
-	depends on MIPS && MTD_DB1X00
-	help
-	  Use the second of the two 32MB flash banks on Db1X00 boards.
-	  You can say 'Y' to both this and the BOOT flash option, to use
-	  both banks.
-
-config MTD_BOSPORUS
-	tristate "Bosporus Flash device"
-	depends on MIPS && MIPS_BOSPORUS
+config MTD_ALCHEMY
+	tristate '  AMD Alchemy Pb1xxx/Db1xxx/RDK MTD support' 
+	depends on MIPS && SOC_AU1X00
 	help
-	  Flash memory access on Alchemy Bosporus Board
+	  Flash memory access on AMD Alchemy Pb/Db/RDK Reference Boards
 
 config MTD_XXS1500
 	tristate "MyCable XXS1500 Flash device"
diff -Naur --exclude=CVS linux-2.6-orig/drivers/mtd/maps/Makefile linux-2.6-dev/drivers/mtd/maps/Makefile
--- linux-2.6-orig/drivers/mtd/maps/Makefile	2005-01-17 21:23:31.000000000 -0800
+++ linux-2.6-dev/drivers/mtd/maps/Makefile	2005-02-21 21:17:59.000000000 -0800
@@ -69,7 +69,4 @@
 obj-$(CONFIG_MTD_IXP2000)	+= ixp2000.o
 obj-$(CONFIG_MTD_WRSBC8260)	+= wr_sbc82xx_flash.o
 obj-$(CONFIG_MTD_DMV182)	+= dmv182.o
-obj-$(CONFIG_MTD_PB1000)        += pb1xxx-flash.o
-obj-$(CONFIG_MTD_PB1100)        += pb1xxx-flash.o
-obj-$(CONFIG_MTD_PB1500)        += pb1xxx-flash.o
-obj-$(CONFIG_MTD_DB1X00)        += db1x00-flash.o
+obj-$(CONFIG_MTD_ALCHEMY)       += alchemy-flash.o

--------------040808010503020405080103--
