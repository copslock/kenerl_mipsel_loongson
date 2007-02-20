Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2007 05:13:25 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:13369 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20027668AbXBTFNU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2007 05:13:20 +0000
Received: by mo.po.2iij.net (mo31) id l1K5C1mj030143; Tue, 20 Feb 2007 14:12:01 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id l1K5BvxC096265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 20 Feb 2007 14:11:57 +0900 (JST)
Date:	Tue, 20 Feb 2007 14:11:57 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp,
	linux-mips <linux-mips@linux-mips.org>,
	linux-mtd <linux-mtd@lists.infradead.org>
Subject: [PATCH][MIPS] add MTD device support for Cobalt
Message-Id: <20070220141157.06bf44bd.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added MTD device support for Cobalt.
Moreover, removes old type FlashROM support.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/Makefile mips/arch/mips/cobalt/Makefile
--- mips-orig/arch/mips/cobalt/Makefile	2007-02-19 17:44:20.696243250 +0900
+++ mips/arch/mips/cobalt/Makefile	2007-02-19 17:45:12.951509000 +0900
@@ -5,5 +5,6 @@
 obj-y	 := irq.o reset.o setup.o
 
 obj-$(CONFIG_EARLY_PRINTK)	+= console.o
+obj-$(CONFIG_MTD_PHYSMAP)	+= mtd.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/mtd.c mips/arch/mips/cobalt/mtd.c
--- mips-orig/arch/mips/cobalt/mtd.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/cobalt/mtd.c	2007-02-19 17:45:12.951509000 +0900
@@ -0,0 +1,61 @@
+/*
+ *  Registration of Cobalt MTD device.
+ *
+ *  Copyright (C) 2006  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+
+static struct mtd_partition cobalt_mtd_partitions[] = {
+	{
+		.name	= "Colo",
+		.offset	= 0x0,
+		.size	= 0x80000,
+	},
+};
+
+static struct physmap_flash_data cobalt_flash_data = {
+	.width		= 1,
+	.nr_parts	= 1,
+	.parts		= cobalt_mtd_partitions,
+};
+
+static struct resource cobalt_mtd_resource = {
+	.start	= 0x1fc00000,
+	.end	= 0x1fc7ffff,
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct platform_device cobalt_mtd = {
+	.name		= "physmap-flash",
+	.dev		= {
+		.platform_data	= &cobalt_flash_data,
+	},
+	.num_resources	= 1,
+	.resource	= &cobalt_mtd_resource,
+};
+
+static int __init cobalt_mtd_init(void)
+{
+	platform_device_register(&cobalt_mtd);
+
+	return 0;
+}
+
+module_init(cobalt_mtd_init);
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/cobalt_defconfig mips/arch/mips/configs/cobalt_defconfig
--- mips-orig/arch/mips/configs/cobalt_defconfig	2007-02-19 17:44:20.696243250 +0900
+++ mips/arch/mips/configs/cobalt_defconfig	2007-02-19 17:46:05.766809750 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.20
-# Sun Feb 18 21:27:37 2007
+# Mon Feb 19 14:51:58 2007
 #
 CONFIG_MIPS=y
 
@@ -373,7 +373,88 @@ CONFIG_PROC_EVENTS=y
 #
 # Memory Technology Devices (MTD)
 #
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+# CONFIG_MTD_BLOCK is not set
+# CONFIG_MTD_BLOCK_RO is not set
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+# CONFIG_MTD_CFI is not set
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
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
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+# CONFIG_MTD_OBSOLETE_CHIPS is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=0x0
+CONFIG_MTD_PHYSMAP_LEN=0
+CONFIG_MTD_PHYSMAP_BANKWIDTH=0
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
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
+# CONFIG_MTD_NAND_CAFE is not set
+
+#
+# OneNAND Flash Device Drivers
+#
+# CONFIG_MTD_ONENAND is not set
 
 #
 # Parallel port support
@@ -901,6 +982,7 @@ CONFIG_CONFIGFS_FS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_JFFS2_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/char/lcd.c mips/drivers/char/lcd.c
--- mips-orig/drivers/char/lcd.c	2007-02-19 17:44:31.888942750 +0900
+++ mips/drivers/char/lcd.c	2007-02-19 17:45:12.955509250 +0900
@@ -409,138 +409,6 @@ static int lcd_ioctl(struct inode *inode
 			break;
 		}
 
-//  Erase the flash
-
-	case FLASH_Erase:{
-
-			int ctr = 0;
-
-			if ( !capable(CAP_SYS_ADMIN) ) return -EPERM;
-
-			pr_info(LCD "Erasing Flash\n");
-
-			// Chip Erase Sequence
-			WRITE_FLASH(kFlash_Addr1, kFlash_Data1);
-			WRITE_FLASH(kFlash_Addr2, kFlash_Data2);
-			WRITE_FLASH(kFlash_Addr1, kFlash_Erase3);
-			WRITE_FLASH(kFlash_Addr1, kFlash_Data1);
-			WRITE_FLASH(kFlash_Addr2, kFlash_Data2);
-			WRITE_FLASH(kFlash_Addr1, kFlash_Erase6);
-
-			while ((!dqpoll(0x00000000, 0xFF))
-			       && (!timeout(0x00000000))) {
-				ctr++;
-			}
-
-			if (READ_FLASH(0x07FFF0) == 0xFF) {
-				pr_info(LCD "Erase Successful\n");
-			} else if (timeout) {
-				pr_info(LCD "Erase Timed Out\n");
-			}
-
-			break;
-		}
-
-// burn the flash
-
-	case FLASH_Burn:{
-
-			volatile unsigned long burn_addr;
-			unsigned long flags;
-			unsigned int i, index;
-			unsigned char *rom;
-
-
-			struct lcd_display display;
-
-			if ( !capable(CAP_SYS_ADMIN) ) return -EPERM;
-
-			if (copy_from_user
-			    (&display, (struct lcd_display *) arg,
-			     sizeof(struct lcd_display)))
-				return -EFAULT;
-			rom = kmalloc((128), GFP_ATOMIC);
-			if (rom == NULL) {
-				printk(KERN_ERR LCD "kmalloc() failed in %s\n",
-						__FUNCTION__);
-				return -ENOMEM;
-			}
-
-			pr_info(LCD "Starting Flash burn\n");
-			for (i = 0; i < FLASH_SIZE; i = i + 128) {
-
-				if (copy_from_user
-				    (rom, display.RomImage + i, 128)) {
-					kfree(rom);
-					return -EFAULT;
-				}
-				burn_addr = kFlashBase + i;
-				spin_lock_irqsave(&lcd_lock, flags);
-				for (index = 0; index < (128); index++) {
-
-					WRITE_FLASH(kFlash_Addr1,
-						    kFlash_Data1);
-					WRITE_FLASH(kFlash_Addr2,
-						    kFlash_Data2);
-					WRITE_FLASH(kFlash_Addr1,
-						    kFlash_Prog);
-					*((volatile unsigned char *)burn_addr) =
-					  (volatile unsigned char) rom[index];
-
-					while ((!dqpoll (burn_addr,
-						(volatile unsigned char)
-						rom[index])) &&
-						(!timeout(burn_addr))) { }
-					burn_addr++;
-				}
-				spin_unlock_irqrestore(&lcd_lock, flags);
-				if (* ((volatile unsigned char *)
-					(burn_addr - 1)) ==
-					(volatile unsigned char)
-					rom[index - 1]) {
-				} else if (timeout) {
-					pr_info(LCD "Flash burn timed out\n");
-				}
-
-
-			}
-			kfree(rom);
-
-			pr_info(LCD "Flash successfully burned\n");
-
-			break;
-		}
-
-//  read the flash all at once
-
-	case FLASH_Read:{
-
-			unsigned char *user_bytes;
-			volatile unsigned long read_addr;
-			unsigned int i;
-
-			user_bytes =
-			    &(((struct lcd_display *) arg)->RomImage[0]);
-
-			if (!access_ok
-			    (VERIFY_WRITE, user_bytes, FLASH_SIZE))
-				return -EFAULT;
-
-			pr_info(LCD "Reading Flash");
-			for (i = 0; i < FLASH_SIZE; i++) {
-				unsigned char tmp_byte;
-				read_addr = kFlashBase + i;
-				tmp_byte =
-				    *((volatile unsigned char *)
-				      read_addr);
-				if (__put_user(tmp_byte, &user_bytes[i]))
-					return -EFAULT;
-			}
-
-
-			break;
-		}
-
 	default:
 		return -EINVAL;
 
@@ -644,42 +512,6 @@ static void __exit lcd_exit(void)
 	misc_deregister(&lcd_dev);
 }
 
-//
-// Function: dqpoll
-//
-// Description:  Polls the data lines to see if the flash is busy
-//
-// In: address, byte data
-//
-// Out: 0 = busy, 1 = write or erase complete
-//
-//
-
-static int dqpoll(volatile unsigned long address, volatile unsigned char data)
-{
-	volatile unsigned char dq7;
-
-	dq7 = data & 0x80;
-
-	return ((READ_FLASH(address) & 0x80) == dq7);
-}
-
-//
-// Function: timeout
-//
-// Description: Checks to see if erase or write has timed out
-//              By polling dq5
-//
-// In: address
-//
-//
-// Out: 0 = not timed out, 1 = timed out
-
-static int timeout(volatile unsigned long address)
-{
-	return (READ_FLASH(address) & 0x20) == 0x20;
-}
-
 module_init(lcd_init);
 module_exit(lcd_exit);
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/char/lcd.h mips/drivers/char/lcd.h
--- mips-orig/drivers/char/lcd.h	2007-02-19 17:44:31.888942750 +0900
+++ mips/drivers/char/lcd.h	2007-02-19 17:45:12.955509250 +0900
@@ -14,11 +14,7 @@
 
 // function headers
 
-static int dqpoll(volatile unsigned long, volatile unsigned char );
-static int timeout(volatile unsigned long);
-
 #define LCD_CHARS_PER_LINE 40
-#define FLASH_SIZE 524288
 #define MAX_IDLE_TIME 120
 
 struct lcd_display {
@@ -54,26 +50,6 @@ struct lcd_display {
 #define LCDTimeoutValue	0xfff
 
 
-// Flash definitions AMD 29F040
-#define kFlashBase	0x0FC00000
-
-#define kFlash_Addr1    0x5555
-#define kFlash_Addr2    0x2AAA
-#define kFlash_Data1    0xAA
-#define kFlash_Data2    0x55
-#define kFlash_Prog     0xA0
-#define kFlash_Erase3   0x80
-#define kFlash_Erase6   0x10
-#define kFlash_Read     0xF0
-
-#define kFlash_ID       0x90
-#define kFlash_VenAddr  0x00
-#define kFlash_DevAddr  0x01
-#define kFlash_VenID    0x01
-#define kFlash_DevID    0xA4    // 29F040
-//#define kFlash_DevID  0xAD    // 29F016
-
-
 // Macros
 
 #define LCDWriteData(x)	outl((x << 24), kLCD_DR)
@@ -89,9 +65,6 @@ struct lcd_display {
 #define WRITE_GAL(x,y)	outl(y, 0x04000000 | (x))
 #define BusyCheck()	while ((LCDReadInst & 0x80) == 0x80)
 
-#define WRITE_FLASH(x,y) outb((char)y, kFlashBase | (x))
-#define READ_FLASH(x)	(inb(kFlashBase | (x)))
-
 
 
 /*
@@ -124,11 +97,6 @@ struct lcd_display {
 //  Button defs
 #define BUTTON_Read             50
 
-//  Flash command codes
-#define FLASH_Erase		60
-#define FLASH_Burn		61
-#define FLASH_Read		62
-
 
 // Ethernet LINK check hackaroo
 #define LINK_Check              90
