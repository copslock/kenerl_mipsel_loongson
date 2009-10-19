Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Oct 2009 12:53:26 +0200 (CEST)
Received: from mail-fx0-f211.google.com ([209.85.220.211]:51543 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492539AbZJSKxB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Oct 2009 12:53:01 +0200
Received: by mail-fx0-f211.google.com with SMTP id 7so4630482fxm.34
        for <multiple recipients>; Mon, 19 Oct 2009 03:53:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ji3fBgHBer7Jn/MMX+3FeJftu+pAjT7HyA9M1p3zuF8=;
        b=qgcvudATZl33oNFl+kuliesNvsuV1gO+e/GJI+niAEAZ/qIveTP64Y+tVq6lk8fX9n
         TZXbj8684deprnMwS0op+hxlgzt1p8X2asKpj9u7m3XKpXCStPW5CZF0NF1/AUDXdpsn
         W00yr0AH2Edj0mTm6v5YgYAB7r6DNdIsRebJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OFtloO5/y8990T9lM6u89DeECuyk+TchJZiAYbCKpCin+xpEoONCopMk1a/kUQ4FhE
         UiFlwqFilpPRPgICwL4bF65n/2Rwa5D/CSLfQg7J0VwbEFai6jm7AB8HtZ4sNpaFTWQg
         +bOo4TB+2wafw2c1yQl93FpHb+8ee10uFjjHU=
Received: by 10.204.8.199 with SMTP id i7mr4635464bki.37.1255949581197;
        Mon, 19 Oct 2009 03:53:01 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil36.netpark.at [217.175.205.164])
        by mx.google.com with ESMTPS id 13sm583953bwz.2.2009.10.19.03.52.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Oct 2009 03:53:00 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: physmap-flash for all devboards
Date:	Mon, 19 Oct 2009 12:53:37 +0200
Message-Id: <1255949617-22943-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Replace the devboard NOR MTD mapping driver with physmap-flash support.
Also honor the "swapboot" switch settings wrt. to the layout of the
NOR partitions.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
on top of mips-queue, run-tested on db1200.

 arch/mips/alchemy/devboards/db1x00/platform.c    |   20 +++
 arch/mips/alchemy/devboards/pb1000/board_setup.c |    7 +
 arch/mips/alchemy/devboards/pb1100/platform.c    |    7 +
 arch/mips/alchemy/devboards/pb1200/platform.c    |    9 ++
 arch/mips/alchemy/devboards/pb1500/platform.c    |    7 +
 arch/mips/alchemy/devboards/pb1550/platform.c    |    6 +
 arch/mips/alchemy/devboards/platform.c           |  104 ++++++++++++++
 arch/mips/alchemy/devboards/platform.h           |    3 +
 drivers/mtd/maps/Kconfig                         |    6 -
 drivers/mtd/maps/Makefile                        |    1 -
 drivers/mtd/maps/alchemy-flash.c                 |  166 ----------------------
 11 files changed, 163 insertions(+), 173 deletions(-)
 delete mode 100644 drivers/mtd/maps/alchemy-flash.c

diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index 0ac5dd0..62e2a96 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-db1x00/bcsr.h>
 #include "../platform.h"
 
 /* DB1xxx PCMCIA interrupt sources:
@@ -32,6 +33,7 @@
  */
 
 #define DB1XXX_HAS_PCMCIA
+#define F_SWAPPED (bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1000_SWAPBOOT)
 
 #if defined(CONFIG_MIPS_DB1000)
 #define DB1XXX_PCMCIA_CD0	AU1000_GPIO0_INT
@@ -40,6 +42,8 @@
 #define DB1XXX_PCMCIA_CD1	AU1000_GPIO3_INT
 #define DB1XXX_PCMCIA_STSCHG1	AU1000_GPIO4_INT
 #define DB1XXX_PCMCIA_CARD1	AU1000_GPIO5_INT
+#define BOARD_FLASH_SIZE	0x02000000 /* 32MB */
+#define BOARD_FLASH_WIDTH	4 /* 32-bits */
 #elif defined(CONFIG_MIPS_DB1100)
 #define DB1XXX_PCMCIA_CD0	AU1100_GPIO0_INT
 #define DB1XXX_PCMCIA_STSCHG0	AU1100_GPIO1_INT
@@ -47,6 +51,8 @@
 #define DB1XXX_PCMCIA_CD1	AU1100_GPIO3_INT
 #define DB1XXX_PCMCIA_STSCHG1	AU1100_GPIO4_INT
 #define DB1XXX_PCMCIA_CARD1	AU1100_GPIO5_INT
+#define BOARD_FLASH_SIZE	0x02000000 /* 32MB */
+#define BOARD_FLASH_WIDTH	4 /* 32-bits */
 #elif defined(CONFIG_MIPS_DB1500)
 #define DB1XXX_PCMCIA_CD0	AU1500_GPIO0_INT
 #define DB1XXX_PCMCIA_STSCHG0	AU1500_GPIO1_INT
@@ -54,6 +60,8 @@
 #define DB1XXX_PCMCIA_CD1	AU1500_GPIO3_INT
 #define DB1XXX_PCMCIA_STSCHG1	AU1500_GPIO4_INT
 #define DB1XXX_PCMCIA_CARD1	AU1500_GPIO5_INT
+#define BOARD_FLASH_SIZE	0x02000000 /* 32MB */
+#define BOARD_FLASH_WIDTH	4 /* 32-bits */
 #elif defined(CONFIG_MIPS_DB1550)
 #define DB1XXX_PCMCIA_CD0	AU1550_GPIO0_INT
 #define DB1XXX_PCMCIA_STSCHG0	AU1550_GPIO21_INT
@@ -61,9 +69,20 @@
 #define DB1XXX_PCMCIA_CD1	AU1550_GPIO1_INT
 #define DB1XXX_PCMCIA_STSCHG1	AU1550_GPIO22_INT
 #define DB1XXX_PCMCIA_CARD1	AU1550_GPIO5_INT
+#define BOARD_FLASH_SIZE	0x08000000 /* 128MB */
+#define BOARD_FLASH_WIDTH	4 /* 32-bits */
 #else
 /* other board: no PCMCIA */
 #undef DB1XXX_HAS_PCMCIA
+#undef F_SWAPPED
+#define F_SWAPPED 0
+#if defined(CONFIG_MIPS_BOSPORUS)
+#define BOARD_FLASH_SIZE	0x01000000 /* 16MB */
+#define BOARD_FLASH_WIDTH	2 /* 16-bits */
+#elif defined(CONFIG_MIPS_MIRAGE)
+#define BOARD_FLASH_SIZE	0x04000000 /* 64MB */
+#define BOARD_FLASH_WIDTH	4 /* 32-bits */
+#endif
 #endif
 
 static int __init db1xxx_dev_init(void)
@@ -93,6 +112,7 @@ static int __init db1xxx_dev_init(void)
 				    0,
 				    1);
 #endif
+	db1x_register_norflash(BOARD_FLASH_SIZE, BOARD_FLASH_WIDTH, F_SWAPPED);
 	return 0;
 }
 device_initcall(db1xxx_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c b/arch/mips/alchemy/devboards/pb1000/board_setup.c
index 287d661..c8d3789 100644
--- a/arch/mips/alchemy/devboards/pb1000/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1000/board_setup.c
@@ -31,6 +31,7 @@
 #include <asm/mach-pb1x00/pb1000.h>
 #include <prom.h>
 
+#include "../platform.h"
 
 const char *get_system_type(void)
 {
@@ -190,3 +191,9 @@ static int __init pb1000_init_irq(void)
 	return 0;
 }
 arch_initcall(pb1000_init_irq);
+
+static int __init pb1000_device_init(void)
+{
+	return db1x_register_norflash(8 * 1024 * 1024, 4, 0);
+}
+device_initcall(pb1000_device_init);
diff --git a/arch/mips/alchemy/devboards/pb1100/platform.c b/arch/mips/alchemy/devboards/pb1100/platform.c
index ec932e7..bfc5ab6 100644
--- a/arch/mips/alchemy/devboards/pb1100/platform.c
+++ b/arch/mips/alchemy/devboards/pb1100/platform.c
@@ -21,11 +21,14 @@
 #include <linux/init.h>
 
 #include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-db1x00/bcsr.h>
 
 #include "../platform.h"
 
 static int __init pb1100_dev_init(void)
 {
+	int swapped;
+
 	/* PCMCIA. single socket, identical to Pb1500 */
 	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
 				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
@@ -38,6 +41,10 @@ static int __init pb1100_dev_init(void)
 				    /*AU1100_GPIO10_INT*/0, /* stschg */
 				    0,			 /* eject */
 				    0);			 /* id */
+
+	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1000_SWAPBOOT;
+	db1x_register_norflash(64 * 1024 * 1024, 4, swapped);
+
 	return 0;
 }
 device_initcall(pb1100_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index c8b7ae3..736d647 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -172,6 +172,8 @@ static struct platform_device *board_platform_devices[] __initdata = {
 
 static int __init board_register_devices(void)
 {
+	int swapped;
+
 #ifdef CONFIG_MIPS_PB1200
 	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
 				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
@@ -222,6 +224,13 @@ static int __init board_register_devices(void)
 				    1);
 #endif
 
+	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1200_SWAPBOOT;
+#ifdef CONFIG_MIPS_PB1200
+	db1x_register_norflash(128 * 1024 * 1024, 2, swapped);
+#else
+	db1x_register_norflash(64 * 1024 * 1024, 2, swapped);
+#endif
+
 	return platform_add_devices(board_platform_devices,
 				    ARRAY_SIZE(board_platform_devices));
 }
diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c b/arch/mips/alchemy/devboards/pb1500/platform.c
index cdce775..529acb7 100644
--- a/arch/mips/alchemy/devboards/pb1500/platform.c
+++ b/arch/mips/alchemy/devboards/pb1500/platform.c
@@ -20,11 +20,14 @@
 
 #include <linux/init.h>
 #include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-db1x00/bcsr.h>
 
 #include "../platform.h"
 
 static int __init pb1500_dev_init(void)
 {
+	int swapped;
+
 	/* PCMCIA. single socket, identical to Pb1500 */
 	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
 				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
@@ -37,6 +40,10 @@ static int __init pb1500_dev_init(void)
 				    /*AU1500_GPIO10_INT*/0, /* stschg */
 				    0,			 /* eject */
 				    0);			 /* id */
+
+	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1000_SWAPBOOT;
+	db1x_register_norflash(64 * 1024 * 1024, 4, swapped);
+
 	return 0;
 }
 device_initcall(pb1500_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1550/platform.c b/arch/mips/alchemy/devboards/pb1550/platform.c
index b496fb6..4613391 100644
--- a/arch/mips/alchemy/devboards/pb1550/platform.c
+++ b/arch/mips/alchemy/devboards/pb1550/platform.c
@@ -22,11 +22,14 @@
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1550.h>
+#include <asm/mach-db1x00/bcsr.h>
 
 #include "../platform.h"
 
 static int __init pb1550_dev_init(void)
 {
+	int swapped;
+
 	/* Pb1550, like all others, also has statuschange irqs; however they're
 	* wired up on one of the Au1550's shared GPIO201_205 line, which also
 	* services the PCMCIA card interrupts.  So we ignore statuschange and
@@ -58,6 +61,9 @@ static int __init pb1550_dev_init(void)
 				    0,
 				    1);
 
+	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_PB1550_SWAPBOOT;
+	db1x_register_norflash(128 * 1024 * 1024, 4, swapped);
+
 	return 0;
 }
 device_initcall(pb1550_dev_init);
diff --git a/arch/mips/alchemy/devboards/platform.c b/arch/mips/alchemy/devboards/platform.c
index 48c537c..7f2bcee 100644
--- a/arch/mips/alchemy/devboards/platform.c
+++ b/arch/mips/alchemy/devboards/platform.c
@@ -3,6 +3,9 @@
  */
 
 #include <linux/init.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/physmap.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 
@@ -87,3 +90,104 @@ out:
 	kfree(sr);
 	return ret;
 }
+
+#define YAMON_SIZE	0x00100000
+#define YAMON_ENV_SIZE	0x00040000
+
+int __init db1x_register_norflash(unsigned long size, int width,
+				  int swapped)
+{
+	struct physmap_flash_data *pfd;
+	struct platform_device *pd;
+	struct mtd_partition *parts;
+	struct resource *res;
+	int ret, i;
+
+	if (size < (8 * 1024 * 1024))
+		return -EINVAL;
+
+	ret = -ENOMEM;
+	parts = kzalloc(sizeof(struct mtd_partition) * 5, GFP_KERNEL);
+	if (!parts)
+		goto out;
+
+	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+	if (!res)
+		goto out1;
+
+	pfd = kzalloc(sizeof(struct physmap_flash_data), GFP_KERNEL);
+	if (!pfd)
+		goto out2;
+
+	pd = platform_device_alloc("physmap-flash", 0);
+	if (!pd)
+		goto out3;
+
+	/* NOR flash ends at 0x20000000, regardless of size */
+	res->start = 0x20000000 - size;
+	res->end = 0x20000000 - 1;
+	res->flags = IORESOURCE_MEM;
+
+	/* partition setup.  Most Develboards have a switch which allows
+	 * to swap the physical locations of the 2 NOR flash banks.
+	 */
+	i = 0;
+	if (!swapped) {
+		/* first NOR chip */
+		parts[i].offset = 0;
+		parts[i].name = "User FS";
+		parts[i].size = size / 2;
+		i++;
+	}
+
+	parts[i].offset = MTDPART_OFS_APPEND;
+	parts[i].name = "User FS 2";
+	parts[i].size = (size / 2) - (0x20000000 - 0x1fc00000);
+	i++;
+
+	parts[i].offset = MTDPART_OFS_APPEND;
+	parts[i].name = "YAMON";
+	parts[i].size = YAMON_SIZE;
+	parts[i].mask_flags = MTD_WRITEABLE;
+	i++;
+
+	parts[i].offset = MTDPART_OFS_APPEND;
+	parts[i].name = "raw kernel";
+	parts[i].size = 0x00400000 - YAMON_SIZE - YAMON_ENV_SIZE;
+	i++;
+
+	parts[i].offset = MTDPART_OFS_APPEND;
+	parts[i].name = "YAMON Env";
+	parts[i].size = YAMON_ENV_SIZE;
+	parts[i].mask_flags = MTD_WRITEABLE;
+	i++;
+
+	if (swapped) {
+		parts[i].offset = MTDPART_OFS_APPEND;
+		parts[i].name = "User FS";
+		parts[i].size = size / 2;
+		i++;
+	}
+
+	pfd->width = width;
+	pfd->parts = parts;
+	pfd->nr_parts = 5;
+
+	pd->dev.platform_data = pfd;
+	pd->resource = res;
+	pd->num_resources = 1;
+
+	ret = platform_device_add(pd);
+	if (!ret)
+		return ret;
+
+	platform_device_put(pd);
+out3:
+	kfree(pfd);
+out2:
+	kfree(res);
+out1:
+	kfree(parts);
+out:
+	return ret;
+}
diff --git a/arch/mips/alchemy/devboards/platform.h b/arch/mips/alchemy/devboards/platform.h
index 55ecf7e..828c54e 100644
--- a/arch/mips/alchemy/devboards/platform.h
+++ b/arch/mips/alchemy/devboards/platform.h
@@ -15,4 +15,7 @@ int __init db1x_register_pcmcia_socket(unsigned long pseudo_attr_start,
 				       int eject_irq,
 				       int id);
 
+int __init db1x_register_norflash(unsigned long size, int width,
+				  int swapped);
+
 #endif
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 841e085..af0e6ef 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -253,12 +253,6 @@ config MTD_NETtel
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
 	depends on X86 && MTD_CONCAT && MTD_PARTITIONS && MTD_CFI_INTELEXT && BROKEN
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 1d5cf86..0256933 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -40,7 +40,6 @@ obj-$(CONFIG_MTD_SCx200_DOCFLASH)+= scx200_docflash.o
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
1.6.5
