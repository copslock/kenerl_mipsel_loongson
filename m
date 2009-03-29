Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2009 10:27:44 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:44941 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20032702AbZC2J1D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 29 Mar 2009 10:27:03 +0100
Received: (qmail 22293 invoked from network); 29 Mar 2009 11:26:14 +0200
Received: from flagship.roarinelk.net (HELO localhost.localdomain) (192.168.0.197)
  by 192.168.0.1 with SMTP; 29 Mar 2009 11:26:14 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Linux-MTD <linux-mtd@lists.infradead.org>
Subject: [PATCH 3/3] Alchemy: convert to physmap flash
Date:	Sun, 29 Mar 2009 11:27:02 +0200
Message-Id: <1238318822-4772-4-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1238318822-4772-3-git-send-email-mano@roarinelk.homelinux.net>
References: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net>
 <1238318822-4772-2-git-send-email-mano@roarinelk.homelinux.net>
 <1238318822-4772-3-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Add physmap-flash support to all Alchemy devboards and get rid of the
alchemy-flash.c MTD map driver.

Cc: Linux-MTD <linux-mtd@lists.infradead.org>
Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/devboards/db1x00/platform.c |   76 +++++++++++
 arch/mips/alchemy/devboards/pb1000/platform.c |   48 +++++++
 arch/mips/alchemy/devboards/pb1100/platform.c |   49 +++++++
 arch/mips/alchemy/devboards/pb1200/platform.c |   53 ++++++++
 arch/mips/alchemy/devboards/pb1500/platform.c |   48 +++++++
 arch/mips/alchemy/devboards/pb1550/platform.c |   48 +++++++
 drivers/mtd/maps/Kconfig                      |    6 -
 drivers/mtd/maps/Makefile                     |    1 -
 drivers/mtd/maps/alchemy-flash.c              |  166 -------------------------
 9 files changed, 322 insertions(+), 173 deletions(-)
 delete mode 100644 drivers/mtd/maps/alchemy-flash.c

diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index a6fb6bd..edb910f 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -15,9 +15,84 @@
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 #include <linux/init.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
 
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
+
+static struct mtd_partition db1x_nor_partitions[] = {
+	{
+		.name = "User FS",
+		.size = BOARD_FLASH_SIZE - 0x00400000,
+		.offset = 0x0000000
+	},{
+		.name = "YAMON",
+		.size = 0x0100000,
+		.offset = MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE
+	},{
+		.name = "raw kernel",
+		.size = (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset = MTDPART_OFS_APPEND,
+        }
+};
+
+static struct physmap_flash_data db1x_nor_data = {
+	.width		= BOARD_FLASH_WIDTH,
+	.nr_parts	= ARRAY_SIZE(db1x_nor_partitions),
+	.parts		= &db1x_nor_partitions[0],
+};
+
+static struct resource db1x_nor_res[] = {
+	[0] = {
+		.start	= 0x20000000 - BOARD_FLASH_SIZE,
+		.end	= 0x1fffffff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device db1x_nor_device = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &db1x_nor_data,
+	},
+	.resource	= db1x_nor_res,
+	.num_resources	= ARRAY_SIZE(db1x_nor_res),
+};
+
 #define PORT(_base, _irq)					\
 	{							\
 		.iobase		= _base,			\
@@ -153,6 +228,7 @@ static struct platform_device *au1xxx_platform_devices[] __initdata = {
 	&pbdb_smbus_device,
 #endif
 	&au1xxx_rtc_device,
+	&db1x_nor_device,
 };
 
 static int __init au1xxx_platform_init(void)
diff --git a/arch/mips/alchemy/devboards/pb1000/platform.c b/arch/mips/alchemy/devboards/pb1000/platform.c
index 9f42f4c..fc51e05 100644
--- a/arch/mips/alchemy/devboards/pb1000/platform.c
+++ b/arch/mips/alchemy/devboards/pb1000/platform.c
@@ -6,9 +6,56 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/mach-au1x00/au1000.h>
 
+#define PB1000_FLASH_SIZE	0x00800000	/* 8MB */
+#define PB1000_FLASH_WIDTH	4		/* 32-bits */
+
+static struct mtd_partition pb1000_nor_partitions[] = {
+	{
+		.name = "User FS",
+		.size = PB1000_FLASH_SIZE - 0x00400000,
+		.offset = 0x0000000
+	},{
+		.name = "YAMON",
+		.size = 0x0100000,
+		.offset = MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE
+	},{
+		.name = "raw kernel",
+		.size = (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset = MTDPART_OFS_APPEND,
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
+static struct platform_device pb1000_nor_device = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &pb1000_nor_data,
+	},
+	.resource	= pb1000_nor_res,
+	.num_resources	= ARRAY_SIZE(pb1000_nor_res),
+};
+
 #define PORT(_base, _irq)					\
 	{							\
 		.iobase		= _base,			\
@@ -78,6 +125,7 @@ static struct platform_device *pb1000_devices[] = {
 	&au1xxx_usb_ohci_device,
 	&pb1000_pcmcia_device,
 	&au1xxx_rtc_device,
+	&pb1000_nor_device,
 };
 
 static int __init pb1000_platform_init(void)
diff --git a/arch/mips/alchemy/devboards/pb1100/platform.c b/arch/mips/alchemy/devboards/pb1100/platform.c
index 42759f9..9616f58 100644
--- a/arch/mips/alchemy/devboards/pb1100/platform.c
+++ b/arch/mips/alchemy/devboards/pb1100/platform.c
@@ -6,9 +6,57 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/mach-au1x00/au1000.h>
 
+#define PB1100_FLASH_SIZE	0x04000000	/* 64MB */
+#define PB1100_FLASH_WIDTH	4 		/* 32-bits */
+
+static struct mtd_partition pb1100_nor_partitions[] = {
+	{
+		.name = "User FS",
+		.size = PB1100_FLASH_SIZE - 0x00400000,
+		.offset = 0x0000000
+	},{
+		.name = "YAMON",
+		.size = 0x0100000,
+		.offset = MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE
+	},{
+		.name = "raw kernel",
+		.size = (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset = MTDPART_OFS_APPEND,
+        }
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
+static struct platform_device pb1100_nor_device = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &pb1100_nor_data,
+	},
+	.resource	= pb1100_nor_res,
+	.num_resources	= ARRAY_SIZE(pb1100_nor_res),
+};
+
+
 #define PORT(_base, _irq)					\
 	{							\
 		.iobase		= _base,			\
@@ -104,6 +152,7 @@ static struct platform_device *pb1100_devices[] = {
 	&pb1100_pcmcia_device,
 	&au1100_lcd_device,
 	&au1xxx_rtc_device,
+	&pb1100_nor_device,
 };
 
 static int __init pb1100_platform_init(void)
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index f32391e..204ae4b 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -23,13 +23,65 @@
 #include <linux/leds.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
 
+#if defined(CONFIG_MIPS_PB1200)
+#define BOARD_FLASH_SIZE	0x08000000	/* 128MB */
+#elif defined(CONFIG_MIPS_DB1200)
+#define BOARD_FLASH_SIZE	0x04000000	/* 64MB */
+#endif
+
+#define BOARD_FLASH_WIDTH	2		/* 16-bits */
+
 static int mmc_activity;
 
+static struct mtd_partition pb1200_nor_partitions[] = {
+	{
+		.name = "User FS",
+		.size = BOARD_FLASH_SIZE - 0x00400000,
+		.offset = 0x0000000
+	},{
+		.name = "YAMON",
+		.size = 0x0100000,
+		.offset = MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE
+	},{
+		.name = "raw kernel",
+		.size = (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset = MTDPART_OFS_APPEND,
+        }
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
+static struct platform_device pb1200_nor_device = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &pb1200_nor_data,
+	},
+	.resource	= pb1200_nor_res,
+	.num_resources	= ARRAY_SIZE(pb1200_nor_res),
+};
+
 #define PORT(_base, _irq)					\
 	{							\
 		.iobase		= _base,			\
@@ -342,6 +394,7 @@ static struct platform_device *board_platform_devices[] __initdata = {
 	&au1200_lcd_device,
 	&pb1200_smbus_device,
 	&au1xxx_rtc_device,
+	&pb1200_nor_device,
 };
 
 static int __init board_register_devices(void)
diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c b/arch/mips/alchemy/devboards/pb1500/platform.c
index affb3e1..723a2ff 100644
--- a/arch/mips/alchemy/devboards/pb1500/platform.c
+++ b/arch/mips/alchemy/devboards/pb1500/platform.c
@@ -6,9 +6,56 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/mach-au1x00/au1000.h>
 
+#define PB1500_FLASH_SIZE	0x04000000	/* 64MB */
+#define PB1500_FLASH_WIDTH	4		/* 32-bits */
+
+static struct mtd_partition pb1500_nor_partitions[] = {
+	{
+		.name = "User FS",
+		.size = PB1500_FLASH_SIZE - 0x00400000,
+		.offset = 0x0000000
+	},{
+		.name = "YAMON",
+		.size = 0x0100000,
+		.offset = MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE
+	},{
+		.name = "raw kernel",
+		.size = (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset = MTDPART_OFS_APPEND,
+        }
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
+static struct platform_device pb1500_nor_device = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &pb1500_nor_data,
+	},
+	.resource	= pb1500_nor_res,
+	.num_resources	= ARRAY_SIZE(pb1500_nor_res),
+};
+
 #define PORT(_base, _irq)					\
 	{							\
 		.iobase		= _base,			\
@@ -76,6 +123,7 @@ static struct platform_device *pb1500_devices[] = {
 	&au1xxx_usb_ohci_device,
 	&pb1500_pcmcia_device,
 	&au1xxx_rtc_device,
+	&pb1500_nor_device,
 };
 
 static int __init pb1500_platform_init(void)
diff --git a/arch/mips/alchemy/devboards/pb1550/platform.c b/arch/mips/alchemy/devboards/pb1550/platform.c
index 717ff02..3548207 100644
--- a/arch/mips/alchemy/devboards/pb1550/platform.c
+++ b/arch/mips/alchemy/devboards/pb1550/platform.c
@@ -6,10 +6,57 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1550.h>
 
+#define PB1550_FLASH_SIZE	0x08000000	/* 128MB */
+#define PB1550_FLASH_WIDTH	4		/* 32-bits */
+
+static struct mtd_partition pb1550_nor_partitions[] = {
+	{
+		.name = "User FS",
+		.size = PB1550_FLASH_SIZE - 0x00400000,
+		.offset = 0x0000000
+	},{
+		.name = "YAMON",
+		.size = 0x0100000,
+		.offset = MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE
+	},{
+		.name = "raw kernel",
+		.size = (0x300000 - 0x40000), /* last 256KB is yamon env */
+		.offset = MTDPART_OFS_APPEND,
+        }
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
+static struct platform_device pb1550_nor_device = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &pb1550_nor_data,
+	},
+	.resource	= pb1550_nor_res,
+	.num_resources	= ARRAY_SIZE(pb1550_nor_res),
+};
+
 #define PORT(_base, _irq)					\
 	{							\
 		.iobase		= _base,			\
@@ -94,6 +141,7 @@ static struct platform_device *pb1550_devices[] = {
 	&pb1550_pcmcia_device,
 	&pb1550_smbus_device,
 	&au1xxx_rtc_device,
+	&pb1550_nor_device,
 };
 
 static int __init pb1550_platform_init(void)
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 729f899..36616fd 100644
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
index 26b28a7..9f3d342 100644
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
1.6.2
