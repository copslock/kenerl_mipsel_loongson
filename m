Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2009 21:28:28 +0100 (BST)
Received: from mail-fx0-f175.google.com ([209.85.220.175]:61323 "EHLO
	mail-fx0-f175.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022543AbZEVU0H (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2009 21:26:07 +0100
Received: by fxm23 with SMTP id 23so1991141fxm.0
        for <linux-mips@linux-mips.org>; Fri, 22 May 2009 13:26:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=74FYGapAWHQl4y3QoxGsjDc4KkHid1JgMJ2PSDtSVUo=;
        b=QjOBUdPmKQrZFWj3+oa2vIYekrFQ0K/Lj/+d+vWppFbxZVQGVjL3O3A7VdZXmfNTb3
         l/Vd4vtiGWwv6hvMcm15xwWDqHwnn+ChBwW2ySUScnrJC3tKwVMRvOjOmhKF/eS1UGPN
         CpMAYI0pQ3ATzjYTw2g444ykhtUCdmfUpKuvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=XD5QuxCG2Nh7+RQVpZz7Rq0+vj10LbmOm5H+bJHT9KPPiM11q/1SqmdZ6Bc9izJL+H
         RrarxvesuK2xxGO1l1ZxjWWIC4P3e+aU2mbt4ctAajw+lMUsgqPtrJck9wzOsq6q+qJQ
         TBk6h2wLm6rez5FEFP3ZVyRS3D3wFSRNpFvU0=
Received: by 10.86.61.18 with SMTP id j18mr3391261fga.68.1243023961149;
        Fri, 22 May 2009 13:26:01 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id e20sm1522973fga.0.2009.05.22.13.26.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 May 2009 13:26:00 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 4/4] Alchemy: convert to physmap flash
Date:	Fri, 22 May 2009 22:25:53 +0200
Message-Id: <1243023953-10401-4-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1243023953-10401-3-git-send-email-mano@roarinelk.homelinux.net>
References: <1243023953-10401-1-git-send-email-mano@roarinelk.homelinux.net>
 <1243023953-10401-2-git-send-email-mano@roarinelk.homelinux.net>
 <1243023953-10401-3-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Add physmap-flash support to all Alchemy devboards and get rid of the
alchemy-flash.c MTD map driver.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/devboards/db1200/platform.c |   47 +++++++++++++++
 arch/mips/alchemy/devboards/db1x00/platform.c |   75 +++++++++++++++++++++++++
 arch/mips/alchemy/devboards/pb1000/Makefile   |    3 +-
 arch/mips/alchemy/devboards/pb1100/platform.c |   49 ++++++++++++++++
 arch/mips/alchemy/devboards/pb1200/platform.c |   48 ++++++++++++++++
 arch/mips/alchemy/devboards/pb1500/platform.c |   49 ++++++++++++++++
 arch/mips/alchemy/devboards/pb1550/platform.c |   49 ++++++++++++++++
 drivers/mtd/maps/Kconfig                      |    6 --
 drivers/mtd/maps/Makefile                     |    1 -
 9 files changed, 319 insertions(+), 8 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
index de67f0c..0d6cb60 100644
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
@@ -169,6 +174,47 @@ static struct platform_device nand_dev = {
 	}
 };
 
+static struct mtd_partition db1200_nor_partitions[] = {
+	{
+		.name = "User FS",
+		.size = BOARD_FLASH_SIZE - 0x00400000,
+		.offset = 0x0000000
+	}, {
+		.name = "YAMON",
+		.size = 0x0100000,
+		.offset = MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE
+	}, {
+		.name = "raw kernel",
+		.size = (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset = MTDPART_OFS_APPEND,
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
@@ -526,6 +572,7 @@ static struct platform_device *db1200_devs[] __initdata = {
 	&ide_dev,
 	&smc91x_dev,
 	&rtc_dev,
+	&db1200_nor_dev,
 	&nand_dev,
 	&db1200_pcmcia0_dev,
 	&db1200_pcmcia1_dev,
diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index e95aaf1..4940eec 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -20,6 +20,9 @@
 
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
 
@@ -152,7 +155,79 @@ static struct platform_device db1xxx_pcmcia1_dev = {
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
+		.name = "User FS",
+		.size = BOARD_FLASH_SIZE - 0x00400000,
+		.offset = 0x0000000
+	}, {
+		.name = "YAMON",
+		.size = 0x0100000,
+		.offset = MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE
+	}, {
+		.name = "raw kernel",
+		.size = (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset = MTDPART_OFS_APPEND,
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
diff --git a/arch/mips/alchemy/devboards/pb1100/platform.c b/arch/mips/alchemy/devboards/pb1100/platform.c
index fb52b4b..93cad6d 100644
--- a/arch/mips/alchemy/devboards/pb1100/platform.c
+++ b/arch/mips/alchemy/devboards/pb1100/platform.c
@@ -20,6 +20,9 @@
 
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
 
@@ -72,7 +75,53 @@ static struct platform_device pb1100_pcmcia_dev = {
 	.resource	= pb1100_pcmcia_res,
 };
 
+
+#define PB1100_FLASH_SIZE	0x04000000	/* 64MB */
+#define PB1100_FLASH_WIDTH	4 		/* 32-bits */
+
+static struct mtd_partition pb1100_nor_partitions[] = {
+	{
+		.name = "User FS",
+		.size = PB1100_FLASH_SIZE - 0x00400000,
+		.offset = 0x0000000
+	}, {
+		.name = "YAMON",
+		.size = 0x0100000,
+		.offset = MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE
+	}, {
+		.name = "raw kernel",
+		.size = (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset = MTDPART_OFS_APPEND,
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
index 7d8294e..4429868 100644
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
@@ -263,9 +269,51 @@ static struct platform_device pb1200_pcmcia1_dev = {
 	.resource	= pb1200_pcmcia1_res,
 };
 
+static struct mtd_partition pb1200_nor_partitions[] = {
+	{
+		.name = "User FS",
+		.size = BOARD_FLASH_SIZE - 0x00400000,
+		.offset = 0x0000000
+	}, {
+		.name = "YAMON",
+		.size = 0x0100000,
+		.offset = MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE
+	}, {
+		.name = "raw kernel",
+		.size = (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset = MTDPART_OFS_APPEND,
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
index 36a4034..31b1f4c 100644
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
@@ -72,7 +79,49 @@ static struct platform_device pb1500_pcmcia_dev = {
 	.resource	= pb1500_pcmcia_res,
 };
 
+static struct mtd_partition pb1500_nor_partitions[] = {
+	{
+		.name = "User FS",
+		.size = PB1500_FLASH_SIZE - 0x00400000,
+		.offset = 0x0000000
+	}, {
+		.name = "YAMON",
+		.size = 0x0100000,
+		.offset = MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE
+	}, {
+		.name = "raw kernel",
+		.size = (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset = MTDPART_OFS_APPEND,
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
index 11c91b5..67a35f5 100644
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
@@ -113,7 +120,49 @@ static struct platform_device pb1550_pcmcia1_dev = {
 	.resource	= pb1550_pcmcia1_res,
 };
 
+static struct mtd_partition pb1550_nor_partitions[] = {
+	{
+		.name = "User FS",
+		.size = PB1550_FLASH_SIZE - 0x00400000,
+		.offset = 0x0000000
+	}, {
+		.name = "YAMON",
+		.size = 0x0100000,
+		.offset = MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE
+	}, {
+		.name = "raw kernel",
+		.size = (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset = MTDPART_OFS_APPEND,
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
 static struct platform_device *board_platform_devices[] __initdata = {
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
-- 
1.6.3.1
