Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2012 14:47:30 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:34379 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903385Ab2INMrW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2012 14:47:22 +0200
Received: by bkcji2 with SMTP id ji2so1202202bkc.36
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2012 05:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=AlNzf0c6jXpZEfFmsz6a5hMkpV4IAiry7rNXoT8d1wE=;
        b=h5lCeEOfGkcZ4/+ReFjqQVnYy2mwiTrlG7KveTHi4+I+G4qBOFROQ6XvGA9AOMwYyT
         3fHMCF+6vemM5lTe+NfoHOJRjAevw7N9iJWqthKHR8UeEKTe5E94VRVriukxygXeBFfr
         IGVkW2c3ELcD3/kcG6+nHqNAnntwrMgu9BnBphf80pQfddsSVDZm3P+c/yS6UPSKxtyK
         P3Fktpcu1Uwk4k7kaiAiHVkaHC0ClxrQ1q4bGwJ566aLvVGgOqlgbe/sCiSfjzOX9bvD
         t3+d3LxngxlijIyuPxlTpFWGRqQjfSCwBk8bdB8bdxGHmDfXjMe9YroD4dw7X4IQQeTc
         Yhkw==
Received: by 10.204.8.65 with SMTP id g1mr1088826bkg.50.1347626836703;
        Fri, 14 Sep 2012 05:47:16 -0700 (PDT)
Received: from flagship.roarinelk.net (188-22-1-39.adsl.highway.telekom.at. [188.22.1.39])
        by mx.google.com with ESMTPS id t23sm1040667bks.4.2012.09.14.05.47.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 05:47:15 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: merge PB1550 support into DB1550 code
Date:   Fri, 14 Sep 2012 14:47:10 +0200
Message-Id: <1347626830-15237-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.12
X-archive-position: 34499
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
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Status: A

The PB1550 is more or less a DB1550 without the PCI IDE controller,
a more complicated (read: configurable) Flash setup and some other
minor changes.  Like the DB1550 it can be automatically detected by
reading the CPLD ID register bits.

This patch adds PB1550 detection and setup to the DB1550 code.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Tested only on the DB1550 since I don't have and don't know anyone
with a PB1550.
Applies on top of the previos db1200/1300/1550 merge patch.

 arch/mips/alchemy/Kconfig            |  11 +-
 arch/mips/alchemy/devboards/Makefile |   1 -
 arch/mips/alchemy/devboards/db1235.c |  16 ++-
 arch/mips/alchemy/devboards/db1550.c | 181 +++++++++++++++++++++-----
 arch/mips/alchemy/devboards/pb1550.c | 244 -----------------------------------
 arch/mips/configs/pb1550_defconfig   | 145 ---------------------
 6 files changed, 161 insertions(+), 437 deletions(-)
 delete mode 100644 arch/mips/alchemy/devboards/pb1550.c
 delete mode 100644 arch/mips/configs/pb1550_defconfig

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index b4929b9..6eb66a9 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -37,7 +37,7 @@ config MIPS_DB1000
 	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_DB1235
-	bool "Alchemy DB1200/PB1200/DB1300/DB1550 boards"
+	bool "Alchemy DB1200/PB1200/DB1300/DB1550/PB1550 boards"
 	select ARCH_REQUIRE_GPIOLIB
 	select HW_HAS_PCI
 	select DMA_COHERENT
@@ -62,15 +62,6 @@ config MIPS_PB1500
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
-config MIPS_PB1550
-	bool "Alchemy PB1550 board"
-	select ALCHEMY_GPIOINT_AU1000
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select MIPS_DISABLE_OBSOLETE_IDE
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_HAS_EARLY_PRINTK
-
 config MIPS_XXS1500
 	bool "MyCable XXS1500 board"
 	select DMA_NONCOHERENT
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index f8a9624..fad8a99 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -6,6 +6,5 @@ obj-y += bcsr.o platform.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_MIPS_PB1100)	+= pb1100.o
 obj-$(CONFIG_MIPS_PB1500)	+= pb1500.o
-obj-$(CONFIG_MIPS_PB1550)	+= pb1550.o
 obj-$(CONFIG_MIPS_DB1000)	+= db1000.o
 obj-$(CONFIG_MIPS_DB1235)	+= db1235.o db1200.o db1300.o db1550.o
diff --git a/arch/mips/alchemy/devboards/db1235.c b/arch/mips/alchemy/devboards/db1235.c
index 15003eb..c76a90f 100644
--- a/arch/mips/alchemy/devboards/db1235.c
+++ b/arch/mips/alchemy/devboards/db1235.c
@@ -13,7 +13,7 @@ int __init db1300_board_setup(void);
 int __init db1300_dev_setup(void);
 int __init db1550_board_setup(void);
 int __init db1550_dev_setup(void);
-int __init db1550_pci_setup(void);
+int __init db1550_pci_setup(int);
 
 static const char *board_type_str(void)
 {
@@ -27,6 +27,9 @@ static const char *board_type_str(void)
 		return "DB1300";
 	case BCSR_WHOAMI_DB1550:
 		return "DB1550";
+	case BCSR_WHOAMI_PB1550_SDR:
+	case BCSR_WHOAMI_PB1550_DDR:
+		return "PB1550";
 	default:
 		return "(unknown)";
 	}
@@ -61,8 +64,13 @@ void __init board_setup(void)
 
 int __init db1235_arch_init(void)
 {
-	if (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI)) == BCSR_WHOAMI_DB1550)
-		return db1550_pci_setup();
+	int id = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
+	if (id == BCSR_WHOAMI_DB1550)
+		return db1550_pci_setup(0);
+	else if ((id == BCSR_WHOAMI_PB1550_SDR) ||
+		 (id == BCSR_WHOAMI_PB1550_DDR))
+		return db1550_pci_setup(1);
+
 	return 0;
 }
 arch_initcall(db1235_arch_init);
@@ -77,6 +85,8 @@ int __init db1235_dev_init(void)
 	case BCSR_WHOAMI_DB1300:
 		return db1300_dev_setup();
 	case BCSR_WHOAMI_DB1550:
+	case BCSR_WHOAMI_PB1550_SDR:
+	case BCSR_WHOAMI_PB1550_DDR:
 		return db1550_dev_setup();
 	}
 	return 0;
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index 7664beed..5a9ae60 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -1,5 +1,5 @@
 /*
- * Alchemy Db1550 board support
+ * Alchemy Db1550/Pb1550 board support
  *
  * (c) 2011 Manuel Lauss <manuel.lauss@googlemail.com>
  */
@@ -17,11 +17,13 @@
 #include <linux/pm.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
+#include <asm/bootinfo.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_eth.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 #include <asm/mach-au1x00/au1550_spi.h>
+#include <asm/mach-au1x00/au1550nd.h>
 #include <asm/mach-db1x00/bcsr.h>
 #include <prom.h>
 #include "platform.h"
@@ -30,15 +32,14 @@ static void __init db1550_hw_setup(void)
 {
 	void __iomem *base;
 
-	alchemy_gpio_direction_output(203, 0);	/* red led on */
-
 	/* complete SPI setup: link psc0_intclk to a 48MHz source,
-	 * and assign GPIO16 to PSC0_SYNC1 (SPI cs# line)
+	 * and assign GPIO16 to PSC0_SYNC1 (SPI cs# line) as well as PSC1_SYNC
+	 * for AC97 on PB1550.
 	 */
 	base = (void __iomem *)SYS_CLKSRC;
 	__raw_writel(__raw_readl(base) | 0x000001e0, base);
 	base = (void __iomem *)SYS_PINFUNC;
-	__raw_writel(__raw_readl(base) | 1, base);
+	__raw_writel(__raw_readl(base) | 1 | SYS_PF_PSC1_S1, base);
 	wmb();
 
 	/* reset the AC97 codec now, the reset time in the psc-ac97 driver
@@ -51,8 +52,6 @@ static void __init db1550_hw_setup(void)
 	wmb();
 	__raw_writel(PSC_AC97RST_RST, base + PSC_AC97RST_OFFSET);
 	wmb();
-
-	alchemy_gpio_direction_output(202, 0);	/* green led on */
 }
 
 int __init db1550_board_setup(void)
@@ -62,9 +61,14 @@ int __init db1550_board_setup(void)
 	bcsr_init(DB1550_BCSR_PHYS_ADDR,
 		  DB1550_BCSR_PHYS_ADDR + DB1550_BCSR_HEXLED_OFS);
 
-	whoami = bcsr_read(BCSR_WHOAMI);
-	printk(KERN_INFO "Alchemy/AMD DB1550 Board, CPLD Rev %d"
-		"  Board-ID %d  Daughtercard ID %d\n",
+	whoami = bcsr_read(BCSR_WHOAMI); /* PB1550 hexled offset differs */
+	if ((BCSR_WHOAMI_BOARD(whoami) == BCSR_WHOAMI_PB1550_SDR) ||
+	    (BCSR_WHOAMI_BOARD(whoami) == BCSR_WHOAMI_PB1550_DDR))
+		bcsr_init(PB1550_BCSR_PHYS_ADDR,
+			  PB1550_BCSR_PHYS_ADDR + PB1550_BCSR_HEXLED_OFS);
+
+	pr_info("Alchemy/AMD %s Board, CPLD Rev %d Board-ID %d  "	\
+		"Daughtercard ID %d\n", get_system_type(),
 		(whoami >> 4) & 0xf, (whoami >> 8) & 0xf, whoami & 0xf);
 
 	db1550_hw_setup();
@@ -189,6 +193,39 @@ static struct platform_device db1550_nand_dev = {
 	}
 };
 
+static struct au1550nd_platdata pb1550_nand_pd = {
+	.parts		= db1550_nand_parts,
+	.num_parts	= ARRAY_SIZE(db1550_nand_parts),
+	.devwidth	= 0,	/* x8 NAND default, needs fixing up */
+};
+
+static struct platform_device pb1550_nand_dev = {
+	.name		= "au1550-nand",
+	.id		= -1,
+	.resource	= db1550_nand_res,
+	.num_resources	= ARRAY_SIZE(db1550_nand_res),
+	.dev		= {
+		.platform_data	= &pb1550_nand_pd,
+	},
+};
+
+static void __init pb1550_nand_setup(void)
+{
+	int boot_swapboot = (au_readl(MEM_STSTAT) & (0x7 << 1)) |
+			    ((bcsr_read(BCSR_STATUS) >> 6) & 0x1);
+
+	gpio_direction_input(206);	/* de-assert NAND CS# */
+	switch (boot_swapboot) {
+	case 0: case 2: case 8: case 0xC: case 0xD:
+		/* x16 NAND Flash */
+		pb1550_nand_pd.devwidth = 1;
+		/* fallthrough */
+	case 1: case 3: case 9: case 0xE: case 0xF:
+		/* x8 NAND, already set up */
+		platform_device_register(&pb1550_nand_dev);
+	}
+}
+
 /**********************************************************************/
 
 static struct resource au1550_psc0_res[] = {
@@ -389,6 +426,29 @@ static int db1550_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
 	return -1;
 }
 
+static int pb1550_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	if ((slot < 12) || (slot > 13) || pin == 0)
+		return -1;
+	if (slot == 12) {
+		switch (pin) {
+		case 1: return AU1500_PCI_INTB;
+		case 2: return AU1500_PCI_INTC;
+		case 3: return AU1500_PCI_INTD;
+		case 4: return AU1500_PCI_INTA;
+		}
+	}
+	if (slot == 13) {
+		switch (pin) {
+		case 1: return AU1500_PCI_INTA;
+		case 2: return AU1500_PCI_INTB;
+		case 3: return AU1500_PCI_INTC;
+		case 4: return AU1500_PCI_INTD;
+		}
+	}
+	return -1;
+}
+
 static struct resource alchemy_pci_host_res[] = {
 	[0] = {
 		.start	= AU1500_PCI_PHYS_ADDR,
@@ -412,7 +472,6 @@ static struct platform_device db1550_pci_host_dev = {
 /**********************************************************************/
 
 static struct platform_device *db1550_devs[] __initdata = {
-	&db1550_nand_dev,
 	&db1550_i2c_dev,
 	&db1550_ac97_dev,
 	&db1550_spi_dev,
@@ -425,14 +484,16 @@ static struct platform_device *db1550_devs[] __initdata = {
 };
 
 /* must be arch_initcall; MIPS PCI scans busses in a subsys_initcall */
-int __init db1550_pci_setup(void)
+int __init db1550_pci_setup(int id)
 {
+	if (id)
+		db1550_pci_pd.board_map_irq = pb1550_map_pci_irq;
 	return platform_device_register(&db1550_pci_host_dev);
 }
 
-int __init db1550_dev_setup(void)
+static void __init db1550_devices(void)
 {
-	int swapped;
+	alchemy_gpio_direction_output(203, 0);	/* red led on */
 
 	irq_set_irq_type(AU1550_GPIO0_INT, IRQ_TYPE_EDGE_BOTH);  /* CD0# */
 	irq_set_irq_type(AU1550_GPIO1_INT, IRQ_TYPE_EDGE_BOTH);  /* CD1# */
@@ -441,6 +502,75 @@ int __init db1550_dev_setup(void)
 	irq_set_irq_type(AU1550_GPIO21_INT, IRQ_TYPE_LEVEL_LOW); /* STSCHG0# */
 	irq_set_irq_type(AU1550_GPIO22_INT, IRQ_TYPE_LEVEL_LOW); /* STSCHG1# */
 
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		AU1550_GPIO3_INT, AU1550_GPIO0_INT,
+		/*AU1550_GPIO21_INT*/0, 0, 0);
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004000000,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
+		AU1550_GPIO5_INT, AU1550_GPIO1_INT,
+		/*AU1550_GPIO22_INT*/0, 0, 1);
+
+	platform_device_register(&db1550_nand_dev);
+
+	alchemy_gpio_direction_output(202, 0);	/* green led on */
+}
+
+static void __init pb1550_devices(void)
+{
+	irq_set_irq_type(AU1550_GPIO0_INT, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(AU1550_GPIO1_INT, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(AU1550_GPIO201_205_INT, IRQ_TYPE_LEVEL_HIGH);
+
+	/* enable both PCMCIA card irqs in the shared line */
+	alchemy_gpio2_enable_int(201);	/* socket 0 card irq */
+	alchemy_gpio2_enable_int(202);	/* socket 1 card irq */
+
+	/* Pb1550, like all others, also has statuschange irqs; however they're
+	* wired up on one of the Au1550's shared GPIO201_205 line, which also
+	* services the PCMCIA card interrupts.  So we ignore statuschange and
+	* use the GPIO201_205 exclusively for card interrupts, since a) pcmcia
+	* drivers are used to shared irqs and b) statuschange isn't really use-
+	* ful anyway.
+	*/
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		AU1550_GPIO201_205_INT, AU1550_GPIO0_INT, 0, 0, 0);
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008000000,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008000000,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008000000,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008010000 - 1,
+		AU1550_GPIO201_205_INT, AU1550_GPIO1_INT, 0, 0, 1);
+
+	pb1550_nand_setup();
+}
+
+int __init db1550_dev_setup(void)
+{
+	int swapped, id;
+
+	id = (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI)) != BCSR_WHOAMI_DB1550);
+
 	i2c_register_board_info(0, db1550_i2c_devs,
 				ARRAY_SIZE(db1550_i2c_devs));
 	spi_register_board_info(db1550_spi_devs,
@@ -461,27 +591,10 @@ int __init db1550_dev_setup(void)
 	    (void __iomem *)KSEG1ADDR(AU1550_PSC2_PHYS_ADDR) + PSC_SEL_OFFSET);
 	wmb();
 
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-		AU1550_GPIO3_INT, AU1550_GPIO0_INT,
-		/*AU1550_GPIO21_INT*/0, 0, 0);
-
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004000000,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
-		AU1550_GPIO5_INT, AU1550_GPIO1_INT,
-		/*AU1550_GPIO22_INT*/0, 0, 1);
+	id ? pb1550_devices() : db1550_devices();
 
-	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1000_SWAPBOOT;
+	swapped = bcsr_read(BCSR_STATUS) &
+	       (id ? BCSR_STATUS_PB1550_SWAPBOOT : BCSR_STATUS_DB1000_SWAPBOOT);
 	db1x_register_norflash(128 << 20, 4, swapped);
 
 	return platform_add_devices(db1550_devs, ARRAY_SIZE(db1550_devs));
diff --git a/arch/mips/alchemy/devboards/pb1550.c b/arch/mips/alchemy/devboards/pb1550.c
deleted file mode 100644
index b37e7de..0000000
--- a/arch/mips/alchemy/devboards/pb1550.c
+++ /dev/null
@@ -1,244 +0,0 @@
-/*
- * Pb1550 board support.
- *
- * Copyright (C) 2009-2011 Manuel Lauss
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/dma-mapping.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-au1x00/au1xxx_dbdma.h>
-#include <asm/mach-au1x00/au1550nd.h>
-#include <asm/mach-au1x00/gpio.h>
-#include <asm/mach-db1x00/bcsr.h>
-#include "platform.h"
-
-const char *get_system_type(void)
-{
-	return "PB1550";
-}
-
-void __init board_setup(void)
-{
-	u32 pin_func;
-
-	bcsr_init(PB1550_BCSR_PHYS_ADDR,
-		  PB1550_BCSR_PHYS_ADDR + PB1550_BCSR_HEXLED_OFS);
-
-	alchemy_gpio2_enable();
-
-	/*
-	 * Enable PSC1 SYNC for AC'97.  Normaly done in audio driver,
-	 * but it is board specific code, so put it here.
-	 */
-	pin_func = au_readl(SYS_PINFUNC);
-	au_sync();
-	pin_func |= SYS_PF_MUST_BE_SET | SYS_PF_PSC1_S1;
-	au_writel(pin_func, SYS_PINFUNC);
-
-	bcsr_write(BCSR_PCMCIA, 0);	/* turn off PCMCIA power */
-
-	printk(KERN_INFO "AMD Alchemy Pb1550 Board\n");
-}
-
-/******************************************************************************/
-
-static int pb1550_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
-{
-	if ((slot < 12) || (slot > 13) || pin == 0)
-		return -1;
-	if (slot == 12) {
-		switch (pin) {
-		case 1: return AU1500_PCI_INTB;
-		case 2: return AU1500_PCI_INTC;
-		case 3: return AU1500_PCI_INTD;
-		case 4: return AU1500_PCI_INTA;
-		}
-	}
-	if (slot == 13) {
-		switch (pin) {
-		case 1: return AU1500_PCI_INTA;
-		case 2: return AU1500_PCI_INTB;
-		case 3: return AU1500_PCI_INTC;
-		case 4: return AU1500_PCI_INTD;
-		}
-	}
-	return -1;
-}
-
-static struct resource alchemy_pci_host_res[] = {
-	[0] = {
-		.start	= AU1500_PCI_PHYS_ADDR,
-		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct alchemy_pci_platdata pb1550_pci_pd = {
-	.board_map_irq	= pb1550_map_pci_irq,
-};
-
-static struct platform_device pb1550_pci_host = {
-	.dev.platform_data = &pb1550_pci_pd,
-	.name		= "alchemy-pci",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
-	.resource	= alchemy_pci_host_res,
-};
-
-static struct resource au1550_psc2_res[] = {
-	[0] = {
-		.start	= AU1550_PSC2_PHYS_ADDR,
-		.end	= AU1550_PSC2_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1550_PSC2_INT,
-		.end	= AU1550_PSC2_INT,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AU1550_DSCR_CMD0_PSC2_TX,
-		.end	= AU1550_DSCR_CMD0_PSC2_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= AU1550_DSCR_CMD0_PSC2_RX,
-		.end	= AU1550_DSCR_CMD0_PSC2_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static struct platform_device pb1550_i2c_dev = {
-	.name		= "au1xpsc_smbus",
-	.id		= 0,	/* bus number */
-	.num_resources	= ARRAY_SIZE(au1550_psc2_res),
-	.resource	= au1550_psc2_res,
-};
-
-static struct mtd_partition pb1550_nand_parts[] = {
-	[0] = {
-		.name	= "NAND FS 0",
-		.offset	= 0,
-		.size	= 8 * 1024 * 1024,
-	},
-	[1] = {
-		.name	= "NAND FS 1",
-		.offset	= MTDPART_OFS_APPEND,
-		.size	= MTDPART_SIZ_FULL,
-	},
-};
-
-static struct au1550nd_platdata pb1550_nand_pd = {
-	.parts		= pb1550_nand_parts,
-	.num_parts	= ARRAY_SIZE(pb1550_nand_parts),
-	.devwidth	= 0,	/* x8 NAND default, needs fixing up */
-};
-
-static struct resource pb1550_nand_res[] = {
-	[0] = {
-		.start	= 0x20000000,
-		.end	= 0x20000fff,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device pb1550_nand_dev = {
-	.name		= "au1550-nand",
-	.id		= -1,
-	.resource	= pb1550_nand_res,
-	.num_resources	= ARRAY_SIZE(pb1550_nand_res),
-	.dev		= {
-		.platform_data	= &pb1550_nand_pd,
-	},
-};
-
-static void __init pb1550_nand_setup(void)
-{
-	int boot_swapboot = (au_readl(MEM_STSTAT) & (0x7 << 1)) |
-			    ((bcsr_read(BCSR_STATUS) >> 6) & 0x1);
-
-	switch (boot_swapboot) {
-	case 0:
-	case 2:
-	case 8:
-	case 0xC:
-	case 0xD:
-		/* x16 NAND Flash */
-		pb1550_nand_pd.devwidth = 1;
-		/* fallthrough */
-	case 1:
-	case 9:
-	case 3:
-	case 0xE:
-	case 0xF:
-		/* x8 NAND, already set up */
-		platform_device_register(&pb1550_nand_dev);
-	}
-}
-
-static int __init pb1550_dev_init(void)
-{
-	int swapped;
-
-	irq_set_irq_type(AU1550_GPIO0_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1550_GPIO1_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1550_GPIO201_205_INT, IRQF_TRIGGER_HIGH);
-
-	/* enable both PCMCIA card irqs in the shared line */
-	alchemy_gpio2_enable_int(201);
-	alchemy_gpio2_enable_int(202);
-
-	/* Pb1550, like all others, also has statuschange irqs; however they're
-	* wired up on one of the Au1550's shared GPIO201_205 line, which also
-	* services the PCMCIA card interrupts.  So we ignore statuschange and
-	* use the GPIO201_205 exclusively for card interrupts, since a) pcmcia
-	* drivers are used to shared irqs and b) statuschange isn't really use-
-	* ful anyway.
-	*/
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-		AU1550_GPIO201_205_INT, AU1550_GPIO0_INT, 0, 0, 0);
-
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008000000,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008000000,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008000000,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008010000 - 1,
-		AU1550_GPIO201_205_INT, AU1550_GPIO1_INT, 0, 0, 1);
-
-	/* NAND setup */
-	gpio_direction_input(206);	/* GPIO206 high */
-	pb1550_nand_setup();
-
-	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_PB1550_SWAPBOOT;
-	db1x_register_norflash(128 * 1024 * 1024, 4, swapped);
-	platform_device_register(&pb1550_pci_host);
-	platform_device_register(&pb1550_i2c_dev);
-
-	return 0;
-}
-arch_initcall(pb1550_dev_init);
diff --git a/arch/mips/configs/pb1550_defconfig b/arch/mips/configs/pb1550_defconfig
deleted file mode 100644
index e83d649..0000000
--- a/arch/mips/configs/pb1550_defconfig
+++ /dev/null
@@ -1,145 +0,0 @@
-CONFIG_MIPS_ALCHEMY=y
-CONFIG_MIPS_PB1550=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
-CONFIG_LOCALVERSION="-pb1550"
-CONFIG_KERNEL_LZMA=y
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_TINY_RCU=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EXPERT=y
-# CONFIG_SYSCTL_SYSCALL is not set
-# CONFIG_KALLSYMS is not set
-# CONFIG_PCSPKR_PLATFORM is not set
-# CONFIG_VM_EVENT_COUNTERS is not set
-# CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_PCI=y
-CONFIG_PCCARD=y
-# CONFIG_CARDBUS is not set
-CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
-CONFIG_PM=y
-CONFIG_PM_RUNTIME=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_AU1550=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_UB=y
-# CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECS=y
-CONFIG_BLK_DEV_IDECD=y
-# CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS is not set
-# CONFIG_IDEPCI_PCIBUS_ORDER is not set
-CONFIG_BLK_DEV_HPT366=y
-CONFIG_NETDEVICES=y
-CONFIG_MARVELL_PHY=y
-CONFIG_DAVICOM_PHY=y
-CONFIG_QSEMI_PHY=y
-CONFIG_LXT_PHY=y
-CONFIG_CICADA_PHY=y
-CONFIG_VITESSE_PHY=y
-CONFIG_SMSC_PHY=y
-CONFIG_BROADCOM_PHY=y
-CONFIG_ICPLUS_PHY=y
-CONFIG_REALTEK_PHY=y
-CONFIG_NATIONAL_PHY=y
-CONFIG_STE10XP=y
-CONFIG_LSI_ET1011C_PHY=y
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-CONFIG_MIPS_AU1X00_ENET=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
-# CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV is not set
-CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-# CONFIG_SERIAL_8250_PCI is not set
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
-# CONFIG_I2C_COMPAT is not set
-CONFIG_I2C_CHARDEV=y
-# CONFIG_I2C_HELPER_AUTO is not set
-CONFIG_I2C_AU1550=y
-# CONFIG_HWMON is not set
-# CONFIG_VGA_ARB is not set
-CONFIG_HIDRAW=y
-CONFIG_USB_HIDDEV=y
-CONFIG_USB=y
-CONFIG_USB_DEVICEFS=y
-CONFIG_USB_DYNAMIC_MINORS=y
-CONFIG_USB_SUSPEND=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_ROOT_HUB_TT=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_AU1XXX=y
-CONFIG_EXT2_FS=y
-CONFIG_ISO9660_FS=y
-CONFIG_JOLIET=y
-CONFIG_ZISOFS=y
-CONFIG_UDF_FS=y
-CONFIG_VFAT_FS=y
-# CONFIG_PROC_PAGE_MONITOR is not set
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_SUMMARY=y
-CONFIG_JFFS2_COMPRESSION_OPTIONS=y
-CONFIG_JFFS2_LZO=y
-CONFIG_JFFS2_RUBIN=y
-CONFIG_SQUASHFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_ROOT_NFS=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_CODEPAGE_850=y
-CONFIG_NLS_CODEPAGE_852=y
-CONFIG_NLS_CODEPAGE_1250=y
-CONFIG_NLS_ASCII=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_NLS_ISO8859_15=y
-CONFIG_NLS_UTF8=y
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_FTRACE is not set
-CONFIG_DEBUG_ZBOOT=y
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
-CONFIG_SECURITYFS=y
-- 
1.7.12
