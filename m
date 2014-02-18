Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Feb 2014 19:40:12 +0100 (CET)
Received: from mail-ea0-f180.google.com ([209.85.215.180]:56090 "EHLO
        mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825397AbaBRSjMdV1Ft (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Feb 2014 19:39:12 +0100
Received: by mail-ea0-f180.google.com with SMTP id o10so7978935eaj.25
        for <linux-mips@linux-mips.org>; Tue, 18 Feb 2014 10:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LpaoakQaPOV7lkM8NC93sFoaouSobOG4P0iwhQ+xB5A=;
        b=RH1vgRDHXa9o/ot9BV8S78/fYAk6CSmdriZzHcFzOwdIb3OIdgLP/0fKUG0zqSI9mO
         CrHWzepd5IWGIfeUOQTesRd/iEzNsf5VcU1Qhzp/1fQGBamftzRb7reWv8GJe+HAJodC
         xHTBGeabX2R0MHJVjvnp+anbqHD2pTPMLLQsp1BLXzOo8iJ/WR5CM1mDUa5KQLUieb96
         J2hkCU0dXc1M4xr6L/oBZFyibwQJMT1h8hgk3Ks8TwB66diO8IXGSaSozJsA1s8IZZ6e
         08uqcajTaaHgJ79Tm15KNb0ABJH5HjL86GKdUxqcAclKGiv4T5flr8hA/jaWOZY7rY4U
         7bVQ==
X-Received: by 10.15.49.65 with SMTP id i41mr350436eew.98.1392748745418;
        Tue, 18 Feb 2014 10:39:05 -0800 (PST)
Received: from localhost.localdomain (p54B21680.dip0.t-ipconnect.de. [84.178.22.128])
        by mx.google.com with ESMTPSA id j42sm73785779eep.21.2014.02.18.10.39.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2014 10:39:05 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH 3/3] MIPS: Alchemy: unify Devboard support.
Date:   Tue, 18 Feb 2014 19:38:55 +0100
Message-Id: <1392748735-16745-4-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.8.5.5
In-Reply-To: <1392748735-16745-1-git-send-email-manuel.lauss@gmail.com>
References: <1392748735-16745-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

This patch merges support for all DB1xxx and PB1xxx
boards into a single image.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
So far I've only tested it on a DB1500 and DB1300, as these are all I
have access to right now.  I've also removed Big-Endian support for now
I've received a report that BCSR handling isn't big-endian safe, but
fixing it for all devboards turned out to be quite a challenge...

 arch/mips/alchemy/Kconfig            |  17 ++---
 arch/mips/alchemy/Platform           |  16 ++---
 arch/mips/alchemy/devboards/Makefile |   4 +-
 arch/mips/alchemy/devboards/db1000.c |  47 ++++----------
 arch/mips/alchemy/devboards/db1200.c |   9 +++
 arch/mips/alchemy/devboards/db1235.c |  94 ---------------------------
 arch/mips/alchemy/devboards/db1300.c |   6 +-
 arch/mips/alchemy/devboards/db1550.c |  10 ++-
 arch/mips/alchemy/devboards/db1xxx.c | 121 +++++++++++++++++++++++++++++++++++
 drivers/spi/spi-au1550.c             |   9 +++
 10 files changed, 177 insertions(+), 156 deletions(-)
 delete mode 100644 arch/mips/alchemy/devboards/db1235.c
 create mode 100644 arch/mips/alchemy/devboards/db1xxx.c

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 4138672..ef53681 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -25,20 +25,17 @@ config MIPS_MTX1
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
-config MIPS_DB1000
-	bool "Alchemy DB1000/DB1500/DB1100 PB1500/1100 boards"
-	select ALCHEMY_GPIOINT_AU1000
-	select HW_HAS_PCI
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_HAS_EARLY_PRINTK
-
-config MIPS_DB1235
-	bool "Alchemy DB1200/PB1200/DB1300/DB1550/PB1550 boards"
+config MIPS_DB1XXX
+	bool "Alchemy DB1XXX / PB1XXX boards"
 	select ARCH_REQUIRE_GPIOLIB
 	select HW_HAS_PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
+	help
+	  Select this option if you have one of the following Alchemy
+	  development boards:  DB1000 DB1500 DB1100 DB1550 DB1200 DB1300
+			       PB1500 PB1100 PB1550 PB1200
+	  Board type is autodetected during boot.
 
 config MIPS_XXS1500
 	bool "MyCable XXS1500 board"
diff --git a/arch/mips/alchemy/Platform b/arch/mips/alchemy/Platform
index b3afcdd..33c9da3 100644
--- a/arch/mips/alchemy/Platform
+++ b/arch/mips/alchemy/Platform
@@ -5,18 +5,12 @@ platform-$(CONFIG_MIPS_ALCHEMY) += alchemy/common/
 
 
 #
-# AMD Alchemy Db1000/Db1500/Pb1500/Db1100/Pb1100 eval boards
+# AMD Alchemy Db1000/Db1500/Pb1500/Db1100/Pb1100
+#             Db1550/Pb1550/Db1200/Pb1200/Db1300
 #
-platform-$(CONFIG_MIPS_DB1000)	+= alchemy/devboards/
-cflags-$(CONFIG_MIPS_DB1000)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
-load-$(CONFIG_MIPS_DB1000)	+= 0xffffffff80100000
-
-#
-# AMD Alchemy Db1200/Pb1200/Db1550/Pb1550/Db1300 eval boards
-#
-platform-$(CONFIG_MIPS_DB1235)	+= alchemy/devboards/
-cflags-$(CONFIG_MIPS_DB1235)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
-load-$(CONFIG_MIPS_DB1235)	+= 0xffffffff80100000
+platform-$(CONFIG_MIPS_DB1XXX)	+= alchemy/devboards/
+cflags-$(CONFIG_MIPS_DB1XXX)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_DB1XXX)	+= 0xffffffff80100000
 
 #
 # 4G-Systems MTX-1 "MeshCube" wireless router
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index 15bf730..9da3659 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -2,7 +2,5 @@
 # Alchemy Develboards
 #
 
-obj-y += bcsr.o platform.o
+obj-y += bcsr.o platform.o db1000.o db1200.o db1300.o db1550.o db1xxx.o
 obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_MIPS_DB1000)	+= db1000.o
-obj-$(CONFIG_MIPS_DB1235)	+= db1235.o db1200.o db1300.o db1550.o
diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 5483906..92dd929 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -41,42 +41,27 @@
 
 #define F_SWAPPED (bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1000_SWAPBOOT)
 
-struct pci_dev;
+const char *get_system_type(void);
 
-static const char *board_type_str(void)
+int __init db1000_board_setup(void)
 {
+	/* initialize board register space */
+	bcsr_init(DB1000_BCSR_PHYS_ADDR,
+		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
+
 	switch (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI))) {
 	case BCSR_WHOAMI_DB1000:
-		return "DB1000";
 	case BCSR_WHOAMI_DB1500:
-		return "DB1500";
 	case BCSR_WHOAMI_DB1100:
-		return "DB1100";
 	case BCSR_WHOAMI_PB1500:
 	case BCSR_WHOAMI_PB1500R2:
-		return "PB1500";
 	case BCSR_WHOAMI_PB1100:
-		return "PB1100";
-	default:
-		return "(unknown)";
+		pr_info("AMD Alchemy %s Board\n", get_system_type());
+		return 0;
 	}
+	return -ENODEV;
 }
 
-const char *get_system_type(void)
-{
-	return board_type_str();
-}
-
-void __init board_setup(void)
-{
-	/* initialize board register space */
-	bcsr_init(DB1000_BCSR_PHYS_ADDR,
-		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
-
-	printk(KERN_INFO "AMD Alchemy %s Board\n", board_type_str());
-}
-
-
 static int db1500_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
 {
 	if ((slot < 12) || (slot > 13) || pin == 0)
@@ -114,17 +99,10 @@ static struct platform_device db1500_pci_host_dev = {
 	.resource	= alchemy_pci_host_res,
 };
 
-static int __init db1500_pci_init(void)
+int __init db1500_pci_setup(void)
 {
-	int id = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
-	if ((id == BCSR_WHOAMI_DB1500) || (id == BCSR_WHOAMI_PB1500) ||
-	    (id == BCSR_WHOAMI_PB1500R2))
-		return platform_device_register(&db1500_pci_host_dev);
-	return 0;
+	return platform_device_register(&db1500_pci_host_dev);
 }
-/* must be arch_initcall; MIPS PCI scans busses in a subsys_initcall */
-arch_initcall(db1500_pci_init);
-
 
 static struct resource au1100_lcd_resources[] = {
 	[0] = {
@@ -513,7 +491,7 @@ static struct platform_device *db1100_devs[] = {
 	&db1000_irda_dev,
 };
 
-static int __init db1000_dev_init(void)
+int __init db1000_dev_setup(void)
 {
 	int board = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
 	int c0, c1, d0, d1, s0, s1, flashsize = 32,  twosocks = 1;
@@ -623,4 +601,3 @@ static int __init db1000_dev_init(void)
 	db1x_register_norflash(flashsize << 20, 4 /* 32bit */, F_SWAPPED);
 	return 0;
 }
-device_initcall(db1000_dev_init);
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index a84d98b..a60d0a3 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -89,6 +89,15 @@ int __init db1200_board_setup(void)
 		return -ENODEV;
 
 	whoami = bcsr_read(BCSR_WHOAMI);
+	switch (BCSR_WHOAMI_BOARD(whoami)) {
+	case BCSR_WHOAMI_PB1200_DDR1:
+	case BCSR_WHOAMI_PB1200_DDR2:
+	case BCSR_WHOAMI_DB1200:
+		break;
+	default:
+		return -ENODEV;
+	}
+
 	printk(KERN_INFO "Alchemy/AMD/RMI %s Board, CPLD Rev %d"
 		"  Board-ID %d	Daughtercard ID %d\n", get_system_type(),
 		(whoami >> 4) & 0xf, (whoami >> 8) & 0xf, whoami & 0xf);
diff --git a/arch/mips/alchemy/devboards/db1235.c b/arch/mips/alchemy/devboards/db1235.c
deleted file mode 100644
index bac19dc..0000000
--- a/arch/mips/alchemy/devboards/db1235.c
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
- * DB1200/PB1200 / DB1550 / DB1300 board support.
- *
- * These 4 boards can reliably be supported in a single kernel image.
- */
-
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-db1x00/bcsr.h>
-
-int __init db1200_board_setup(void);
-int __init db1200_dev_setup(void);
-int __init db1300_board_setup(void);
-int __init db1300_dev_setup(void);
-int __init db1550_board_setup(void);
-int __init db1550_dev_setup(void);
-int __init db1550_pci_setup(int);
-
-static const char *board_type_str(void)
-{
-	switch (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI))) {
-	case BCSR_WHOAMI_PB1200_DDR1:
-	case BCSR_WHOAMI_PB1200_DDR2:
-		return "PB1200";
-	case BCSR_WHOAMI_DB1200:
-		return "DB1200";
-	case BCSR_WHOAMI_DB1300:
-		return "DB1300";
-	case BCSR_WHOAMI_DB1550:
-		return "DB1550";
-	case BCSR_WHOAMI_PB1550_SDR:
-	case BCSR_WHOAMI_PB1550_DDR:
-		return "PB1550";
-	default:
-		return "(unknown)";
-	}
-}
-
-const char *get_system_type(void)
-{
-	return board_type_str();
-}
-
-void __init board_setup(void)
-{
-	int ret;
-
-	switch (alchemy_get_cputype()) {
-	case ALCHEMY_CPU_AU1550:
-		ret = db1550_board_setup();
-		break;
-	case ALCHEMY_CPU_AU1200:
-		ret = db1200_board_setup();
-		break;
-	case ALCHEMY_CPU_AU1300:
-		ret = db1300_board_setup();
-		break;
-	default:
-		pr_err("unsupported CPU on board\n");
-		ret = -ENODEV;
-	}
-	if (ret)
-		panic("cannot initialize board support");
-}
-
-int __init db1235_arch_init(void)
-{
-	int id = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
-	if (id == BCSR_WHOAMI_DB1550)
-		return db1550_pci_setup(0);
-	else if ((id == BCSR_WHOAMI_PB1550_SDR) ||
-		 (id == BCSR_WHOAMI_PB1550_DDR))
-		return db1550_pci_setup(1);
-
-	return 0;
-}
-arch_initcall(db1235_arch_init);
-
-int __init db1235_dev_init(void)
-{
-	switch (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI))) {
-	case BCSR_WHOAMI_PB1200_DDR1:
-	case BCSR_WHOAMI_PB1200_DDR2:
-	case BCSR_WHOAMI_DB1200:
-		return db1200_dev_setup();
-	case BCSR_WHOAMI_DB1300:
-		return db1300_dev_setup();
-	case BCSR_WHOAMI_DB1550:
-	case BCSR_WHOAMI_PB1550_SDR:
-	case BCSR_WHOAMI_PB1550_DDR:
-		return db1550_dev_setup();
-	}
-	return 0;
-}
-device_initcall(db1235_dev_init);
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index 6167e73..509602c 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -759,11 +759,15 @@ int __init db1300_board_setup(void)
 {
 	unsigned short whoami;
 
-	db1300_gpio_config();
 	bcsr_init(DB1300_BCSR_PHYS_ADDR,
 		  DB1300_BCSR_PHYS_ADDR + DB1300_BCSR_HEXLED_OFS);
 
 	whoami = bcsr_read(BCSR_WHOAMI);
+	if (BCSR_WHOAMI_BOARD(whoami) != BCSR_WHOAMI_DB1300)
+		return -ENODEV;
+
+	db1300_gpio_config();
+
 	printk(KERN_INFO "NetLogic DBAu1300 Development Platform.\n\t"
 		"BoardID %d   CPLD Rev %d   DaughtercardID %d\n",
 		BCSR_WHOAMI_BOARD(whoami), BCSR_WHOAMI_CPLD(whoami),
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index 016cdda..bbd8d98 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -62,10 +62,16 @@ int __init db1550_board_setup(void)
 		  DB1550_BCSR_PHYS_ADDR + DB1550_BCSR_HEXLED_OFS);
 
 	whoami = bcsr_read(BCSR_WHOAMI); /* PB1550 hexled offset differs */
-	if ((BCSR_WHOAMI_BOARD(whoami) == BCSR_WHOAMI_PB1550_SDR) ||
-	    (BCSR_WHOAMI_BOARD(whoami) == BCSR_WHOAMI_PB1550_DDR))
+	switch (BCSR_WHOAMI_BOARD(whoami)) {
+	case BCSR_WHOAMI_PB1550_SDR:
+	case BCSR_WHOAMI_PB1550_DDR:
 		bcsr_init(PB1550_BCSR_PHYS_ADDR,
 			  PB1550_BCSR_PHYS_ADDR + PB1550_BCSR_HEXLED_OFS);
+	case BCSR_WHOAMI_DB1550:
+		break;
+	default:
+		return -ENODEV;
+	}
 
 	pr_info("Alchemy/AMD %s Board, CPLD Rev %d Board-ID %d	"	\
 		"Daughtercard ID %d\n", get_system_type(),
diff --git a/arch/mips/alchemy/devboards/db1xxx.c b/arch/mips/alchemy/devboards/db1xxx.c
new file mode 100644
index 0000000..e070c13
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1xxx.c
@@ -0,0 +1,121 @@
+/*
+ * Alchemy DB/PB1xxx board support.
+ */
+
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-db1x00/bcsr.h>
+
+int __init db1000_board_setup(void);
+int __init db1000_dev_setup(void);
+int __init db1500_pci_setup(void);
+int __init db1200_board_setup(void);
+int __init db1200_dev_setup(void);
+int __init db1300_board_setup(void);
+int __init db1300_dev_setup(void);
+int __init db1550_board_setup(void);
+int __init db1550_dev_setup(void);
+int __init db1550_pci_setup(int);
+
+static const char *board_type_str(void)
+{
+	switch (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI))) {
+	case BCSR_WHOAMI_DB1000:
+		return "DB1000";
+	case BCSR_WHOAMI_DB1500:
+		return "DB1500";
+	case BCSR_WHOAMI_DB1100:
+		return "DB1100";
+	case BCSR_WHOAMI_PB1500:
+	case BCSR_WHOAMI_PB1500R2:
+		return "PB1500";
+	case BCSR_WHOAMI_PB1100:
+		return "PB1100";
+	case BCSR_WHOAMI_PB1200_DDR1:
+	case BCSR_WHOAMI_PB1200_DDR2:
+		return "PB1200";
+	case BCSR_WHOAMI_DB1200:
+		return "DB1200";
+	case BCSR_WHOAMI_DB1300:
+		return "DB1300";
+	case BCSR_WHOAMI_DB1550:
+		return "DB1550";
+	case BCSR_WHOAMI_PB1550_SDR:
+	case BCSR_WHOAMI_PB1550_DDR:
+		return "PB1550";
+	default:
+		return "(unknown)";
+	}
+}
+
+const char *get_system_type(void)
+{
+	return board_type_str();
+}
+
+void __init board_setup(void)
+{
+	int ret;
+
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000:
+	case ALCHEMY_CPU_AU1500:
+	case ALCHEMY_CPU_AU1100:
+		ret = db1000_board_setup();
+		break;
+	case ALCHEMY_CPU_AU1550:
+		ret = db1550_board_setup();
+		break;
+	case ALCHEMY_CPU_AU1200:
+		ret = db1200_board_setup();
+		break;
+	case ALCHEMY_CPU_AU1300:
+		ret = db1300_board_setup();
+		break;
+	default:
+		pr_err("unsupported CPU on board\n");
+		ret = -ENODEV;
+	}
+	if (ret)
+		panic("cannot initialize board support");
+}
+
+int __init db1235_arch_init(void)
+{
+	int id = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
+	if (id == BCSR_WHOAMI_DB1550)
+		return db1550_pci_setup(0);
+	else if ((id == BCSR_WHOAMI_PB1550_SDR) ||
+		 (id == BCSR_WHOAMI_PB1550_DDR))
+		return db1550_pci_setup(1);
+	else if ((id == BCSR_WHOAMI_DB1500) || (id == BCSR_WHOAMI_PB1500) ||
+		 (id == BCSR_WHOAMI_PB1500R2))
+		return db1500_pci_setup();
+
+	return 0;
+}
+arch_initcall(db1235_arch_init);
+
+int __init db1235_dev_init(void)
+{
+	switch (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI))) {
+	case BCSR_WHOAMI_DB1000:
+	case BCSR_WHOAMI_DB1500:
+	case BCSR_WHOAMI_DB1100:
+	case BCSR_WHOAMI_PB1500:
+	case BCSR_WHOAMI_PB1500R2:
+	case BCSR_WHOAMI_PB1100:
+		return db1000_dev_setup();
+	case BCSR_WHOAMI_PB1200_DDR1:
+	case BCSR_WHOAMI_PB1200_DDR2:
+	case BCSR_WHOAMI_DB1200:
+		return db1200_dev_setup();
+	case BCSR_WHOAMI_DB1300:
+		return db1300_dev_setup();
+	case BCSR_WHOAMI_DB1550:
+	case BCSR_WHOAMI_PB1550_SDR:
+	case BCSR_WHOAMI_PB1550_DDR:
+		return db1550_dev_setup();
+	}
+	return 0;
+}
+device_initcall(db1235_dev_init);
diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index c4141c9..2ca4ee2 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -999,6 +999,15 @@ static int __init au1550_spi_init(void)
 	 * create memory device with 8 bits dev_devwidth
 	 * needed for proper byte ordering to spi fifo
 	 */
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1550:
+	case ALCHEMY_CPU_AU1200:
+	case ALCHEMY_CPU_AU1300:
+		break;
+	default:
+		return -ENODEV;
+	}
+
 	if (usedma) {
 		ddma_memid = au1xxx_ddma_add_device(&au1550_spi_mem_dbdev);
 		if (!ddma_memid)
-- 
1.8.5.5
