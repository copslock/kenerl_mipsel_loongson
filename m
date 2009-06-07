Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Jun 2009 19:41:23 +0100 (WEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:42819 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023087AbZFGSjV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 7 Jun 2009 19:39:21 +0100
Received: by mail-fx0-f223.google.com with SMTP id 23so2654437fxm.0
        for <multiple recipients>; Sun, 07 Jun 2009 11:39:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=06Wmd4s4plZh0o6xi9B/Imp8kjmgkgs5ddmVRKYcI9w=;
        b=sDFSYtAYLqSmx7Kvvva9HocsUuo9n2eYXM3T8V3vpBARIvXoYQ2pb2ogh2kNy392Dt
         eHX5hDZjjjcPLJBekC5MJ0SPId2m/3JQZLzCYQWwOT3UgvztdeClSjLxJbxDs57QYY9f
         NNtrhOn2sCVbNqyp6cwoJGlFrGkmo++/KBtuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RMMBLciBSNcvNFBQoHNmSvVWKUybkvUfGVX1kYfpuuH8XG5+KTApxTVWnTFKQ5vQVB
         KVLouWXELCQqjTp2QP9Y5CHlAnCo01zaJnKMvNO95ImYEeDDjb0Q+VTtFA9TIVUnWZFI
         kQ6zC1U+ZgegsHjd6n2pd8aR5d4fm7bm8iVEI=
Received: by 10.86.93.19 with SMTP id q19mr6247023fgb.55.1244399960703;
        Sun, 07 Jun 2009 11:39:20 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 12sm421510fgg.0.2009.06.07.11.39.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Jun 2009 11:39:20 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 6/7] Alchemy: convert to physmap flash
Date:	Sun,  7 Jun 2009 20:39:03 +0200
Message-Id: <1244399944-29043-7-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1244399944-29043-6-git-send-email-manuel.lauss@gmail.com>
References: <1244399944-29043-1-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-3-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-6-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Add physmap-flash support to all Alchemy devboards and get rid of the
alchemy-flash.c MTD map driver.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1200/platform.c |   49 +++++++
 arch/mips/alchemy/devboards/db1x00/platform.c |   77 ++++++++++++
 arch/mips/alchemy/devboards/pb1000/Makefile   |    3 +-
 arch/mips/alchemy/devboards/pb1000/platform.c |   84 +++++++++++++
 arch/mips/alchemy/devboards/pb1100/platform.c |   51 ++++++++
 arch/mips/alchemy/devboards/pb1200/platform.c |   50 ++++++++
 arch/mips/alchemy/devboards/pb1500/platform.c |   51 ++++++++
 arch/mips/alchemy/devboards/pb1550/platform.c |   51 ++++++++
 drivers/mtd/maps/Kconfig                      |    6 -
 drivers/mtd/maps/Makefile                     |    1 -
 drivers/mtd/maps/alchemy-flash.c              |  166 -------------------------
 11 files changed, 415 insertions(+), 174 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/pb1000/platform.c
 delete mode 100644 drivers/mtd/maps/alchemy-flash.c

diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
index fb63026..1da114e 100644
--- a/arch/mips/alchemy/devboards/db1200/platform.c
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -27,6 +27,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 #include <linux/spi/spi.h>
@@ -39,6 +40,10 @@
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-au1x00/au1550_spi.h>
 
+/* NOR flash */
+#define BOARD_FLASH_SIZE	0x04000000	/* 64MB */
+#define BOARD_FLASH_WIDTH	2		/* 16-bits */
+
 static struct mtd_partition db1200_spiflash_parts[] = {
 	{
 		.name	= "DB1200 SPI flash",
@@ -169,6 +174,49 @@ static struct platform_device nand_dev = {
 	}
 };
 
+static struct mtd_partition db1200_nor_partitions[] = {
+	{
+		.name	= "User FS",
+		.size	= BOARD_FLASH_SIZE - 0x00400000,
+		.offset	= 0x0000000,
+	},
+	{
+		.name	= "YAMON",
+		.size	= 0x0100000,
+		.offset	= MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	{
+		.name	= "raw kernel",
+		.size	= (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset	= MTDPART_OFS_APPEND,
+	}
+};
+
+static struct physmap_flash_data db1200_nor_data = {
+	.width		= BOARD_FLASH_WIDTH,
+	.nr_parts	= ARRAY_SIZE(db1200_nor_partitions),
+	.parts		= &db1200_nor_partitions[0],
+};
+
+static struct resource db1200_nor_res[] = {
+	[0] = {
+		.start	= 0x20000000 - BOARD_FLASH_SIZE,
+		.end	= 0x1fffffff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device db1200_nor_dev = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &db1200_nor_data,
+	},
+	.resource	= db1200_nor_res,
+	.num_resources	= ARRAY_SIZE(db1200_nor_res),
+};
+
 /**********************************************************************/
 
 static struct smc91x_platdata smc_data = {
@@ -526,6 +574,7 @@ static struct platform_device *db1200_devs[] __initdata = {
 	&ide_dev,
 	&smc91x_dev,
 	&rtc_dev,
+	&db1200_nor_dev,
 	&nand_dev,
 	&db1200_pcmcia0_dev,
 	&db1200_pcmcia1_dev,
diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index 1b50b1a..e7e4243 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -20,6 +20,9 @@
 
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
 
@@ -152,7 +155,81 @@ static struct platform_device db1xxx_pcmcia1_dev = {
 };
 #endif
 
+#ifdef CONFIG_MIPS_BOSPORUS
+#define BOARD_FLASH_SIZE	0x01000000	/* 16MB */
+#define BOARD_FLASH_WIDTH	2		/* 16-bits */
+#endif
+
+#ifdef CONFIG_MIPS_MIRAGE
+#define BOARD_FLASH_SIZE	0x04000000	/* 64MB */
+#define BOARD_FLASH_WIDTH	4		/* 32-bits */
+#endif
+
+#ifdef CONFIG_MIPS_DB1000
+#define BOARD_FLASH_SIZE	0x02000000	/* 32MB */
+#define BOARD_FLASH_WIDTH	4		/* 32-bits */
+#endif
+
+#ifdef CONFIG_MIPS_DB1500
+#define BOARD_FLASH_SIZE	0x02000000	/* 32MB */
+#define BOARD_FLASH_WIDTH	4		/* 32-bits */
+#endif
+
+#ifdef CONFIG_MIPS_DB1100
+#define BOARD_FLASH_SIZE	0x02000000	/* 32MB */
+#define BOARD_FLASH_WIDTH	4		/* 32-bits */
+#endif
+
+#ifdef CONFIG_MIPS_DB1550
+#define BOARD_FLASH_SIZE	0x08000000	/* 128MB */
+#define BOARD_FLASH_WIDTH	4		/* 32-bits */
+#endif
+
+static struct mtd_partition db1xxx_nor_partitions[] = {
+	{
+		.name	= "User FS",
+		.size	= BOARD_FLASH_SIZE - 0x00400000,
+		.offset	= 0x0000000,
+	},
+	{
+		.name	= "YAMON",
+		.size	= 0x0100000,
+		.offset	= MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	{
+		.name	= "raw kernel",
+		.size	= (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset	= MTDPART_OFS_APPEND,
+	}
+};
+
+static struct physmap_flash_data db1xxx_nor_data = {
+	.width		= BOARD_FLASH_WIDTH,
+	.nr_parts	= ARRAY_SIZE(db1xxx_nor_partitions),
+	.parts		= &db1xxx_nor_partitions[0],
+};
+
+static struct resource db1xxx_nor_res[] = {
+	[0] = {
+		.start	= 0x20000000 - BOARD_FLASH_SIZE,
+		.end	= 0x1fffffff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device db1xxx_nor_dev = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &db1xxx_nor_data,
+	},
+	.resource	= db1xxx_nor_res,
+	.num_resources	= ARRAY_SIZE(db1xxx_nor_res),
+};
+
 static struct platform_device *db1xxx_devs[] __initdata = {
+	&db1xxx_nor_dev,
 #ifdef DB1XXX_HAS_PCMCIA
 	&db1xxx_pcmcia0_dev,
 	&db1xxx_pcmcia1_dev,
diff --git a/arch/mips/alchemy/devboards/pb1000/Makefile b/arch/mips/alchemy/devboards/pb1000/Makefile
index 97c6615..ff838be 100644
--- a/arch/mips/alchemy/devboards/pb1000/Makefile
+++ b/arch/mips/alchemy/devboards/pb1000/Makefile
@@ -5,4 +5,5 @@
 # Makefile for the Alchemy Semiconductor Pb1000 board.
 #
 
-obj-y := board_setup.o
+obj-y := board_setup.o platform.o
+
diff --git a/arch/mips/alchemy/devboards/pb1000/platform.c b/arch/mips/alchemy/devboards/pb1000/platform.c
new file mode 100644
index 0000000..949982d
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pb1000/platform.c
@@ -0,0 +1,84 @@
+/*
+ * Pb1000 board platform device registration
+ *
+ * Copyright (C) 2009 Manuel Lauss
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-pb1x00/pb1000.h>
+
+#define PB1000_FLASH_SIZE	0x00800000	/* 8MB */
+#define PB1000_FLASH_WIDTH	4		/* 32-bits */
+
+static struct mtd_partition pb1000_nor_partitions[] = {
+	{
+		.name	= "User FS",
+		.size	= PB1000_FLASH_SIZE - 0x00400000,
+		.offset	= 0x0000000,
+	},
+	{
+		.name	= "YAMON",
+		.size	= 0x0100000,
+		.offset	= MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	{
+		.name	= "raw kernel",
+		.size	= (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset	= MTDPART_OFS_APPEND,
+        }
+};
+
+static struct physmap_flash_data pb1000_nor_data = {
+	.width		= PB1000_FLASH_WIDTH,
+	.nr_parts	= ARRAY_SIZE(pb1000_nor_partitions),
+	.parts		= &pb1000_nor_partitions[0],
+};
+
+static struct resource pb1000_nor_res[] = {
+	[0] = {
+		.start	= 0x20000000 - PB1000_FLASH_SIZE,
+		.end	= 0x1fffffff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device pb1000_nor_dev = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &pb1000_nor_data,
+	},
+	.resource	= pb1000_nor_res,
+	.num_resources	= ARRAY_SIZE(pb1000_nor_res),
+};
+
+static struct platform_device *pb1000_devs[] __initdata = {
+	&pb1000_nor_dev,
+};
+
+static int __init pb1000_dev_init(void)
+{
+	return platform_add_devices(pb1000_devs, ARRAY_SIZE(pb1000_devs));
+}
+device_initcall(pb1000_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1100/platform.c b/arch/mips/alchemy/devboards/pb1100/platform.c
index fb52b4b..c5787fa 100644
--- a/arch/mips/alchemy/devboards/pb1100/platform.c
+++ b/arch/mips/alchemy/devboards/pb1100/platform.c
@@ -20,6 +20,9 @@
 
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
 
@@ -72,7 +75,55 @@ static struct platform_device pb1100_pcmcia_dev = {
 	.resource	= pb1100_pcmcia_res,
 };
 
+
+#define PB1100_FLASH_SIZE	0x04000000	/* 64MB */
+#define PB1100_FLASH_WIDTH	4 		/* 32-bits */
+
+static struct mtd_partition pb1100_nor_partitions[] = {
+	{
+		.name	= "User FS",
+		.size	= PB1100_FLASH_SIZE - 0x00400000,
+		.offset	= 0x0000000,
+	},
+	{
+		.name	= "YAMON",
+		.size	= 0x0100000,
+		.offset	= MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	{
+		.name	= "raw kernel",
+		.size	= (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset	= MTDPART_OFS_APPEND,
+	}
+};
+
+static struct physmap_flash_data pb1100_nor_data = {
+	.width		= PB1100_FLASH_WIDTH,
+	.nr_parts	= ARRAY_SIZE(pb1100_nor_partitions),
+	.parts		= &pb1100_nor_partitions[0],
+};
+
+static struct resource pb1100_nor_res[] = {
+	[0] = {
+		.start	= 0x20000000 - PB1100_FLASH_SIZE,
+		.end	= 0x1fffffff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device pb1100_nor_dev = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &pb1100_nor_data,
+	},
+	.resource	= pb1100_nor_res,
+	.num_resources	= ARRAY_SIZE(pb1100_nor_res),
+};
+
 static struct platform_device *pb1100_devs[] __initdata = {
+	&pb1100_nor_dev,
 	&pb1100_pcmcia_dev,
 };
 
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index c49fb10..c33b2fc 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -21,12 +21,18 @@
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/leds.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 #include <linux/platform_device.h>
 #include <linux/smc91x.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
 
+#define BOARD_FLASH_SIZE	0x08000000	/* 128MB */
+#define BOARD_FLASH_WIDTH	2		/* 16-bits */
+
 static int mmc_activity;
 
 static void pb1200mmc0_set_power(void *mmc_host, int state)
@@ -267,9 +273,53 @@ static struct platform_device pb1200_pcmcia1_dev = {
 	.resource	= pb1200_pcmcia1_res,
 };
 
+static struct mtd_partition pb1200_nor_partitions[] = {
+	{
+		.name	= "User FS",
+		.size	= BOARD_FLASH_SIZE - 0x00400000,
+		.offset	= 0x0000000,
+	},
+	{
+		.name	= "YAMON",
+		.size	= 0x0100000,
+		.offset	= MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	{
+		.name	= "raw kernel",
+		.size	= (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset	= MTDPART_OFS_APPEND,
+	}
+};
+
+static struct physmap_flash_data pb1200_nor_data = {
+	.width		= BOARD_FLASH_WIDTH,
+	.nr_parts	= ARRAY_SIZE(pb1200_nor_partitions),
+	.parts		= &pb1200_nor_partitions[0],
+};
+
+static struct resource pb1200_nor_res[] = {
+	[0] = {
+		.start	= 0x20000000 - BOARD_FLASH_SIZE,
+		.end	= 0x1fffffff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device pb1200_nor_dev = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &pb1200_nor_data,
+	},
+	.resource	= pb1200_nor_res,
+	.num_resources	= ARRAY_SIZE(pb1200_nor_res),
+};
+
 static struct platform_device *board_platform_devices[] __initdata = {
 	&ide_device,
 	&smc91c111_device,
+	&pb1200_nor_dev,
 	&pb1200_pcmcia0_dev,
 	&pb1200_pcmcia1_dev
 };
diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c b/arch/mips/alchemy/devboards/pb1500/platform.c
index 36a4034..90c26b7 100644
--- a/arch/mips/alchemy/devboards/pb1500/platform.c
+++ b/arch/mips/alchemy/devboards/pb1500/platform.c
@@ -19,10 +19,17 @@
  */
 
 #include <linux/init.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 #include <linux/platform_device.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
 
+#define PB1500_FLASH_SIZE	0x04000000	/* 64MB */
+#define PB1500_FLASH_WIDTH	4		/* 32-bits */
+
+
 /* PCMCIA: single socket, identical to PB1100 */
 static struct resource pb1500_pcmcia_res[] = {
 	{
@@ -72,7 +79,51 @@ static struct platform_device pb1500_pcmcia_dev = {
 	.resource	= pb1500_pcmcia_res,
 };
 
+static struct mtd_partition pb1500_nor_partitions[] = {
+	{
+		.name	= "User FS",
+		.size	= PB1500_FLASH_SIZE - 0x00400000,
+		.offset	= 0x0000000,
+	},
+	{
+		.name	= "YAMON",
+		.size	= 0x0100000,
+		.offset	= MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	{
+		.name	= "raw kernel",
+		.size	= (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset	= MTDPART_OFS_APPEND,
+	}
+};
+
+static struct physmap_flash_data pb1500_nor_data = {
+	.width		= PB1500_FLASH_WIDTH,
+	.nr_parts	= ARRAY_SIZE(pb1500_nor_partitions),
+	.parts		= &pb1500_nor_partitions[0],
+};
+
+static struct resource pb1500_nor_res[] = {
+	[0] = {
+		.start	= 0x20000000 - PB1500_FLASH_SIZE,
+		.end	= 0x1fffffff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device pb1500_nor_dev = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &pb1500_nor_data,
+	},
+	.resource	= pb1500_nor_res,
+	.num_resources	= ARRAY_SIZE(pb1500_nor_res),
+};
+
 static struct platform_device *pb1500_devs[] __initdata = {
+	&pb1500_nor_dev,
 	&pb1500_pcmcia_dev,
 };
 
diff --git a/arch/mips/alchemy/devboards/pb1550/platform.c b/arch/mips/alchemy/devboards/pb1550/platform.c
index 24657cb..cbefa00 100644
--- a/arch/mips/alchemy/devboards/pb1550/platform.c
+++ b/arch/mips/alchemy/devboards/pb1550/platform.c
@@ -20,11 +20,18 @@
 
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 #include <linux/platform_device.h>
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1550.h>
 
+#define PB1550_FLASH_SIZE	0x08000000	/* 128MB */
+#define PB1550_FLASH_WIDTH	4		/* 32-bits */
+
+
 /* Pb1550, like all others, also has statuschange irqs; however they're
  * wired up on one of the Au1550's shared GPIO201_205 line, which also
  * services the PCMCIA card interrupts.  So we ignore statuschange and
@@ -113,7 +120,51 @@ static struct platform_device pb1550_pcmcia1_dev = {
 	.resource	= pb1550_pcmcia1_res,
 };
 
+static struct mtd_partition pb1550_nor_partitions[] = {
+	{
+		.name	= "User FS",
+		.size	= PB1550_FLASH_SIZE - 0x00400000,
+		.offset	= 0x0000000,
+	},
+	{
+		.name	= "YAMON",
+		.size	= 0x0100000,
+		.offset	= MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	{
+		.name	= "raw kernel",
+		.size	= (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset	= MTDPART_OFS_APPEND,
+	}
+};
+
+static struct physmap_flash_data pb1550_nor_data = {
+	.width		= PB1550_FLASH_WIDTH,
+	.nr_parts	= ARRAY_SIZE(pb1550_nor_partitions),
+	.parts		= &pb1550_nor_partitions[0],
+};
+
+static struct resource pb1550_nor_res[] = {
+	[0] = {
+		.start	= 0x20000000 - PB1550_FLASH_SIZE,
+		.end	= 0x1fffffff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device pb1550_nor_dev = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &pb1550_nor_data,
+	},
+	.resource	= pb1550_nor_res,
+	.num_resources	= ARRAY_SIZE(pb1550_nor_res),
+};
+
 static struct platform_device *pb1550_devs[] __initdata = {
+	&pb1550_nor_dev,
 	&pb1550_pcmcia0_dev,
 	&pb1550_pcmcia1_dev
 };
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 82923bd..118cab4 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -262,12 +262,6 @@ config MTD_NETtel
 	help
 	  Support for flash chips on NETtel/SecureEdge/SnapGear boards.
 
-config MTD_ALCHEMY
-	tristate "AMD Alchemy Pb1xxx/Db1xxx/RDK MTD support"
-	depends on SOC_AU1X00 && MTD_PARTITIONS && MTD_CFI
-	help
-	  Flash memory access on AMD Alchemy Pb/Db/RDK Reference Boards
-
 config MTD_DILNETPC
 	tristate "CFI Flash device mapped on DIL/Net PC"
 	depends on X86 && MTD_CONCAT && MTD_PARTITIONS && MTD_CFI_INTELEXT
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 2dbc1be..2c846c9 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -41,7 +41,6 @@ obj-$(CONFIG_MTD_SCx200_DOCFLASH)+= scx200_docflash.o
 obj-$(CONFIG_MTD_DBOX2)		+= dbox2-flash.o
 obj-$(CONFIG_MTD_SOLUTIONENGINE)+= solutionengine.o
 obj-$(CONFIG_MTD_PCI)		+= pci.o
-obj-$(CONFIG_MTD_ALCHEMY)       += alchemy-flash.o
 obj-$(CONFIG_MTD_AUTCPU12)	+= autcpu12-nvram.o
 obj-$(CONFIG_MTD_EDB7312)	+= edb7312.o
 obj-$(CONFIG_MTD_IMPA7)		+= impa7.o
diff --git a/drivers/mtd/maps/alchemy-flash.c b/drivers/mtd/maps/alchemy-flash.c
deleted file mode 100644
index 845ad4f..0000000
--- a/drivers/mtd/maps/alchemy-flash.c
+++ /dev/null
@@ -1,166 +0,0 @@
-/*
- * Flash memory access on AMD Alchemy evaluation boards
- *
- * (C) 2003, 2004 Pete Popov <ppopov@embeddedalley.com>
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-
-#include <asm/io.h>
-
-#ifdef CONFIG_MIPS_PB1000
-#define BOARD_MAP_NAME "Pb1000 Flash"
-#define BOARD_FLASH_SIZE 0x00800000 /* 8MB */
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */
-#endif
-
-#ifdef CONFIG_MIPS_PB1500
-#define BOARD_MAP_NAME "Pb1500 Flash"
-#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */
-#endif
-
-#ifdef CONFIG_MIPS_PB1100
-#define BOARD_MAP_NAME "Pb1100 Flash"
-#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */
-#endif
-
-#ifdef CONFIG_MIPS_PB1550
-#define BOARD_MAP_NAME "Pb1550 Flash"
-#define BOARD_FLASH_SIZE 0x08000000 /* 128MB */
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */
-#endif
-
-#ifdef CONFIG_MIPS_PB1200
-#define BOARD_MAP_NAME "Pb1200 Flash"
-#define BOARD_FLASH_SIZE 0x08000000 /* 128MB */
-#define BOARD_FLASH_WIDTH 2 /* 16-bits */
-#endif
-
-#ifdef CONFIG_MIPS_DB1000
-#define BOARD_MAP_NAME "Db1000 Flash"
-#define BOARD_FLASH_SIZE 0x02000000 /* 32MB */
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */
-#endif
-
-#ifdef CONFIG_MIPS_DB1500
-#define BOARD_MAP_NAME "Db1500 Flash"
-#define BOARD_FLASH_SIZE 0x02000000 /* 32MB */
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */
-#endif
-
-#ifdef CONFIG_MIPS_DB1100
-#define BOARD_MAP_NAME "Db1100 Flash"
-#define BOARD_FLASH_SIZE 0x02000000 /* 32MB */
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */
-#endif
-
-#ifdef CONFIG_MIPS_DB1550
-#define BOARD_MAP_NAME "Db1550 Flash"
-#define BOARD_FLASH_SIZE 0x08000000 /* 128MB */
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */
-#endif
-
-#ifdef CONFIG_MIPS_DB1200
-#define BOARD_MAP_NAME "Db1200 Flash"
-#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */
-#define BOARD_FLASH_WIDTH 2 /* 16-bits */
-#endif
-
-#ifdef CONFIG_MIPS_BOSPORUS
-#define BOARD_MAP_NAME "Bosporus Flash"
-#define BOARD_FLASH_SIZE 0x01000000 /* 16MB */
-#define BOARD_FLASH_WIDTH 2 /* 16-bits */
-#endif
-
-#ifdef CONFIG_MIPS_MIRAGE
-#define BOARD_MAP_NAME "Mirage Flash"
-#define BOARD_FLASH_SIZE 0x04000000 /* 64MB */
-#define BOARD_FLASH_WIDTH 4 /* 32-bits */
-#define USE_LOCAL_ACCESSORS /* why? */
-#endif
-
-static struct map_info alchemy_map = {
-	.name =	BOARD_MAP_NAME,
-};
-
-static struct mtd_partition alchemy_partitions[] = {
-        {
-                .name = "User FS",
-                .size = BOARD_FLASH_SIZE - 0x00400000,
-                .offset = 0x0000000
-        },{
-                .name = "YAMON",
-                .size = 0x0100000,
-		.offset = MTDPART_OFS_APPEND,
-                .mask_flags = MTD_WRITEABLE
-        },{
-                .name = "raw kernel",
-		.size = (0x300000 - 0x40000), /* last 256KB is yamon env */
-		.offset = MTDPART_OFS_APPEND,
-        }
-};
-
-static struct mtd_info *mymtd;
-
-static int __init alchemy_mtd_init(void)
-{
-	struct mtd_partition *parts;
-	int nb_parts = 0;
-	unsigned long window_addr;
-	unsigned long window_size;
-
-	/* Default flash buswidth */
-	alchemy_map.bankwidth = BOARD_FLASH_WIDTH;
-
-	window_addr = 0x20000000 - BOARD_FLASH_SIZE;
-	window_size = BOARD_FLASH_SIZE;
-
-	/*
-	 * Static partition definition selection
-	 */
-	parts = alchemy_partitions;
-	nb_parts = ARRAY_SIZE(alchemy_partitions);
-	alchemy_map.size = window_size;
-
-	/*
-	 * Now let's probe for the actual flash.  Do it here since
-	 * specific machine settings might have been set above.
-	 */
-	printk(KERN_NOTICE BOARD_MAP_NAME ": probing %d-bit flash bus\n",
-			alchemy_map.bankwidth*8);
-	alchemy_map.virt = ioremap(window_addr, window_size);
-	mymtd = do_map_probe("cfi_probe", &alchemy_map);
-	if (!mymtd) {
-		iounmap(alchemy_map.virt);
-		return -ENXIO;
-	}
-	mymtd->owner = THIS_MODULE;
-
-	add_mtd_partitions(mymtd, parts, nb_parts);
-	return 0;
-}
-
-static void __exit alchemy_mtd_cleanup(void)
-{
-	if (mymtd) {
-		del_mtd_partitions(mymtd);
-		map_destroy(mymtd);
-		iounmap(alchemy_map.virt);
-	}
-}
-
-module_init(alchemy_mtd_init);
-module_exit(alchemy_mtd_cleanup);
-
-MODULE_AUTHOR("Embedded Alley Solutions, Inc");
-MODULE_DESCRIPTION(BOARD_MAP_NAME " MTD driver");
-MODULE_LICENSE("GPL");
-- 
1.6.3.1
