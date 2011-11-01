Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 20:09:04 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:32904 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903698Ab1KATEp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2011 20:04:45 +0100
Received: by mail-fx0-f49.google.com with SMTP id q17so947590faa.36
        for <multiple recipients>; Tue, 01 Nov 2011 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GVcpTODkBEbEz1erVU7MFpIaWH3/1av876avuWSKJ0g=;
        b=lic8XEzCvGSOLoOabRHWI5Io27Hib/5Rs0Y7PpuqbDuejiqagt2Lxy0xvi4tkU7yqr
         hQw4MNKwtGSuo1JXWb4MGCZ1bG4ef9vrKR7n8z+V3Nd8ZHEBxD6dmPGYLaZKbyrwRRCj
         1w+lNqTZWdk9+H0cdemOx04Jkq7hH/dLuRxMk=
Received: by 10.223.76.27 with SMTP id a27mr2548289fak.12.1320174284792;
        Tue, 01 Nov 2011 12:04:44 -0700 (PDT)
Received: from localhost.localdomain (188-22-150-81.adsl.highway.telekom.at. [188.22.150.81])
        by mx.google.com with ESMTPS id a8sm327916faa.11.2011.11.01.12.04.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 12:04:43 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 11/18] MIPS: Alchemy: one kernel for DB1000/DB1500/DB1100
Date:   Tue,  1 Nov 2011 20:03:37 +0100
Message-Id: <1320174224-27305-12-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 660

These 3 boards are very similar; with this patch a single kernel image
which runs on all three can be built.

Tested on DB1500 and DB1100.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/Kconfig            |   21 +--
 arch/mips/alchemy/Platform           |   16 +--
 arch/mips/alchemy/devboards/Makefile |    4 +-
 arch/mips/alchemy/devboards/db1000.c |  267 ++++++++++++++++++++++++
 arch/mips/alchemy/devboards/db1x00.c |  256 -----------------------
 arch/mips/alchemy/devboards/prom.c   |    4 +-
 arch/mips/configs/db1000_defconfig   |  369 ++++++++++++++++++++++++++++------
 arch/mips/configs/db1100_defconfig   |  122 -----------
 arch/mips/configs/db1500_defconfig   |  128 ------------
 drivers/net/irda/au1k_ir.c           |   10 +-
 drivers/video/au1100fb.c             |   12 -
 11 files changed, 584 insertions(+), 625 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/db1000.c
 delete mode 100644 arch/mips/alchemy/devboards/db1x00.c
 delete mode 100644 arch/mips/configs/db1100_defconfig
 delete mode 100644 arch/mips/configs/db1500_defconfig

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index e1b3be7..0faaab2 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -27,17 +27,12 @@ config MIPS_MTX1
 	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_DB1000
-	bool "Alchemy DB1000 board"
+	bool "Alchemy DB1000/DB1500/DB1100 boards"
 	select ALCHEMY_GPIOINT_AU1000
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_HAS_EARLY_PRINTK
-
-config MIPS_DB1100
-	bool "Alchemy DB1100 board"
-	select ALCHEMY_GPIOINT_AU1000
-	select DMA_NONCOHERENT
+	select MIPS_DISABLE_OBSOLETE_IDE
+	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
@@ -57,16 +52,6 @@ config MIPS_DB1300
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
-config MIPS_DB1500
-	bool "Alchemy DB1500 board"
-	select ALCHEMY_GPIOINT_AU1000
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select MIPS_DISABLE_OBSOLETE_IDE
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_HAS_EARLY_PRINTK
-
 config MIPS_DB1550
 	bool "Alchemy DB1550 board"
 	select ALCHEMY_GPIOINT_AU1000
diff --git a/arch/mips/alchemy/Platform b/arch/mips/alchemy/Platform
index bbdcc15..33f80e8 100644
--- a/arch/mips/alchemy/Platform
+++ b/arch/mips/alchemy/Platform
@@ -26,27 +26,13 @@ cflags-$(CONFIG_MIPS_PB1550)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
 load-$(CONFIG_MIPS_PB1550)	+= 0xffffffff80100000
 
 #
-# AMD Alchemy Db1000 eval board
+# AMD Alchemy Db1000/Db1500/Db1100 eval boards
 #
 platform-$(CONFIG_MIPS_DB1000)	+= alchemy/devboards/
 cflags-$(CONFIG_MIPS_DB1000)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
 load-$(CONFIG_MIPS_DB1000)	+= 0xffffffff80100000
 
 #
-# AMD Alchemy Db1100 eval board
-#
-platform-$(CONFIG_MIPS_DB1100)	+= alchemy/devboards/
-cflags-$(CONFIG_MIPS_DB1100)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
-load-$(CONFIG_MIPS_DB1100)	+= 0xffffffff80100000
-
-#
-# AMD Alchemy Db1500 eval board
-#
-platform-$(CONFIG_MIPS_DB1500)	+= alchemy/devboards/
-cflags-$(CONFIG_MIPS_DB1500)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
-load-$(CONFIG_MIPS_DB1500)	+= 0xffffffff80100000
-
-#
 # AMD Alchemy Db1550 eval board
 #
 platform-$(CONFIG_MIPS_DB1550)	+= alchemy/devboards/
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index 2fbf179..3c37fb3 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -7,9 +7,7 @@ obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_MIPS_PB1100)	+= pb1100.o
 obj-$(CONFIG_MIPS_PB1500)	+= pb1500.o
 obj-$(CONFIG_MIPS_PB1550)	+= pb1550.o
-obj-$(CONFIG_MIPS_DB1000)	+= db1x00.o
-obj-$(CONFIG_MIPS_DB1100)	+= db1x00.o
+obj-$(CONFIG_MIPS_DB1000)	+= db1000.o
 obj-$(CONFIG_MIPS_DB1200)	+= db1200.o
 obj-$(CONFIG_MIPS_DB1300)	+= db1300.o
-obj-$(CONFIG_MIPS_DB1500)	+= db1x00.o
 obj-$(CONFIG_MIPS_DB1550)	+= db1550.o
diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
new file mode 100644
index 0000000..57ed5f1
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -0,0 +1,267 @@
+/*
+ * DBAu1000/1500/1100 board support
+ *
+ * Copyright 2000, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
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
+#include <linux/dma-mapping.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1000_dma.h>
+#include <asm/mach-db1x00/bcsr.h>
+#include <asm/reboot.h>
+#include <prom.h>
+#include "platform.h"
+
+#define F_SWAPPED (bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1000_SWAPBOOT)
+
+struct pci_dev;
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
+	/* initialize board register space */
+	bcsr_init(DB1000_BCSR_PHYS_ADDR,
+		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
+
+	printk(KERN_INFO "AMD Alchemy %s Board\n", board_type_str());
+
+#if defined(CONFIG_IRDA) && defined(CONFIG_AU1000_FIR)
+	{
+		u32 pin_func;
+
+		/* Set IRFIRSEL instead of GPIO15 */
+		pin_func = au_readl(SYS_PINFUNC) | SYS_PF_IRF;
+		au_writel(pin_func, SYS_PINFUNC);
+		/* Power off until the driver is in use */
+		bcsr_mod(BCSR_RESETS, BCSR_RESETS_IRDA_MODE_MASK,
+			 BCSR_RESETS_IRDA_MODE_OFF);
+	}
+#endif
+	bcsr_write(BCSR_PCMCIA, 0);	/* turn off PCMCIA power */
+
+	/* Enable GPIO[31:0] inputs */
+	alchemy_gpio1_input_enable();
+}
+
+
+static int db1500_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	if ((slot < 12) || (slot > 13) || pin == 0)
+		return -1;
+	if (slot == 12)
+		return (pin == 1) ? AU1500_PCI_INTA : 0xff;
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
+static struct resource alchemy_pci_host_res[] = {
+	[0] = {
+		.start	= AU1500_PCI_PHYS_ADDR,
+		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct alchemy_pci_platdata db1500_pci_pd = {
+	.board_map_irq	= db1500_map_pci_irq,
+};
+
+static struct platform_device db1500_pci_host_dev = {
+	.dev.platform_data = &db1500_pci_pd,
+	.name		= "alchemy-pci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
+	.resource	= alchemy_pci_host_res,
+};
+
+static int __init db1500_pci_init(void)
+{
+	if (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI)) == BCSR_WHOAMI_DB1500)
+		return platform_device_register(&db1500_pci_host_dev);
+	return 0;
+}
+/* must be arch_initcall; MIPS PCI scans busses in a subsys_initcall */
+arch_initcall(db1500_pci_init);
+
+
+static struct resource au1100_lcd_resources[] = {
+	[0] = {
+		.start	= AU1100_LCD_PHYS_ADDR,
+		.end	= AU1100_LCD_PHYS_ADDR + 0x800 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1100_LCD_INT,
+		.end	= AU1100_LCD_INT,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static u64 au1100_lcd_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device au1100_lcd_device = {
+	.name		= "au1100-lcd",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1100_lcd_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(au1100_lcd_resources),
+	.resource	= au1100_lcd_resources,
+};
+
+static struct resource alchemy_ac97c_res[] = {
+	[0] = {
+		.start	= AU1000_AC97_PHYS_ADDR,
+		.end	= AU1000_AC97_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= DMA_ID_AC97C_TX,
+		.end	= DMA_ID_AC97C_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[2] = {
+		.start	= DMA_ID_AC97C_RX,
+		.end	= DMA_ID_AC97C_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device alchemy_ac97c_dev = {
+	.name		= "alchemy-ac97c",
+	.id		= -1,
+	.resource	= alchemy_ac97c_res,
+	.num_resources	= ARRAY_SIZE(alchemy_ac97c_res),
+};
+
+static struct platform_device alchemy_ac97c_dma_dev = {
+	.name		= "alchemy-pcm-dma",
+	.id		= 0,
+};
+
+static struct platform_device db1x00_codec_dev = {
+	.name		= "ac97-codec",
+	.id		= -1,
+};
+
+static struct platform_device db1x00_audio_dev = {
+	.name		= "db1000-audio",
+};
+
+static struct platform_device *db1x00_devs[] = {
+	&db1x00_codec_dev,
+	&alchemy_ac97c_dma_dev,
+	&alchemy_ac97c_dev,
+	&db1x00_audio_dev,
+};
+
+static struct platform_device *db1100_devs[] = {
+	&au1100_lcd_device,
+};
+
+static int __init db1000_dev_init(void)
+{
+	int board = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
+	int c0, c1, d0, d1, s0, s1;
+
+	if (board == BCSR_WHOAMI_DB1500) {
+		c0 = AU1500_GPIO2_INT;
+		c1 = AU1500_GPIO5_INT;
+		d0 = AU1500_GPIO0_INT;
+		d1 = AU1500_GPIO3_INT;
+		s0 = AU1500_GPIO1_INT;
+		s1 = AU1500_GPIO4_INT;
+	} else if (board == BCSR_WHOAMI_DB1100) {
+		c0 = AU1100_GPIO2_INT;
+		c1 = AU1100_GPIO5_INT;
+		d0 = AU1100_GPIO0_INT;
+		d1 = AU1100_GPIO3_INT;
+		s0 = AU1100_GPIO1_INT;
+		s1 = AU1100_GPIO4_INT;
+		platform_add_devices(db1100_devs, ARRAY_SIZE(db1100_devs));
+	} else if (board == BCSR_WHOAMI_DB1000) {
+		c0 = AU1000_GPIO2_INT;
+		c1 = AU1000_GPIO5_INT;
+		d0 = AU1000_GPIO0_INT;
+		d1 = AU1000_GPIO3_INT;
+		s0 = AU1000_GPIO1_INT;
+		s1 = AU1000_GPIO4_INT;
+	} else
+		return 0; /* unknown board, no further dev setup to do */
+
+	irq_set_irq_type(d0, IRQ_TYPE_EDGE_BOTH);
+	irq_set_irq_type(d1, IRQ_TYPE_EDGE_BOTH);
+	irq_set_irq_type(c0, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(c1, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(s0, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(s1, IRQ_TYPE_LEVEL_LOW);
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		c0, d0,	/*s0*/0, 0, 0);
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004000000,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
+		c1, d1,	/*s1*/0, 0, 1);
+
+	platform_add_devices(db1x00_devs, ARRAY_SIZE(db1x00_devs));
+	db1x_register_norflash(32 << 20, 4 /* 32bit */, F_SWAPPED);
+	return 0;
+}
+device_initcall(db1000_dev_init);
diff --git a/arch/mips/alchemy/devboards/db1x00.c b/arch/mips/alchemy/devboards/db1x00.c
deleted file mode 100644
index 589ae24..0000000
--- a/arch/mips/alchemy/devboards/db1x00.c
+++ /dev/null
@@ -1,256 +0,0 @@
-/*
- * DBAu1000/1500/1100 board support
- *
- * Copyright 2000, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
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
-#include <linux/gpio.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/pm.h>
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-au1x00/au1000_dma.h>
-#include <asm/mach-db1x00/bcsr.h>
-#include <asm/reboot.h>
-#include <prom.h>
-#include "platform.h"
-
-struct pci_dev;
-
-const char *get_system_type(void)
-{
-	return "Alchemy Db1x00";
-}
-
-void __init board_setup(void)
-{
-#ifdef CONFIG_MIPS_DB1000
-	printk(KERN_INFO "AMD Alchemy Au1000/Db1000 Board\n");
-#endif
-#ifdef CONFIG_MIPS_DB1500
-	printk(KERN_INFO "AMD Alchemy Au1500/Db1500 Board\n");
-#endif
-#ifdef CONFIG_MIPS_DB1100
-	printk(KERN_INFO "AMD Alchemy Au1100/Db1100 Board\n");
-#endif
-	/* initialize board register space */
-	bcsr_init(DB1000_BCSR_PHYS_ADDR,
-		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
-
-#if defined(CONFIG_IRDA) && defined(CONFIG_AU1000_FIR)
-	{
-		u32 pin_func;
-
-		/* Set IRFIRSEL instead of GPIO15 */
-		pin_func = au_readl(SYS_PINFUNC) | SYS_PF_IRF;
-		au_writel(pin_func, SYS_PINFUNC);
-		/* Power off until the driver is in use */
-		bcsr_mod(BCSR_RESETS, BCSR_RESETS_IRDA_MODE_MASK,
-			 BCSR_RESETS_IRDA_MODE_OFF);
-	}
-#endif
-	bcsr_write(BCSR_PCMCIA, 0);	/* turn off PCMCIA power */
-
-	/* Enable GPIO[31:0] inputs */
-	alchemy_gpio1_input_enable();
-}
-
-/* DB1xxx PCMCIA interrupt sources:
- * CD0/1	GPIO0/3
- * STSCHG0/1	GPIO1/4
- * CARD0/1	GPIO2/5
- */
-
-#define F_SWAPPED (bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1000_SWAPBOOT)
-
-#if defined(CONFIG_MIPS_DB1000)
-#define DB1XXX_PCMCIA_CD0	AU1000_GPIO0_INT
-#define DB1XXX_PCMCIA_STSCHG0	AU1000_GPIO1_INT
-#define DB1XXX_PCMCIA_CARD0	AU1000_GPIO2_INT
-#define DB1XXX_PCMCIA_CD1	AU1000_GPIO3_INT
-#define DB1XXX_PCMCIA_STSCHG1	AU1000_GPIO4_INT
-#define DB1XXX_PCMCIA_CARD1	AU1000_GPIO5_INT
-#elif defined(CONFIG_MIPS_DB1100)
-#define DB1XXX_PCMCIA_CD0	AU1100_GPIO0_INT
-#define DB1XXX_PCMCIA_STSCHG0	AU1100_GPIO1_INT
-#define DB1XXX_PCMCIA_CARD0	AU1100_GPIO2_INT
-#define DB1XXX_PCMCIA_CD1	AU1100_GPIO3_INT
-#define DB1XXX_PCMCIA_STSCHG1	AU1100_GPIO4_INT
-#define DB1XXX_PCMCIA_CARD1	AU1100_GPIO5_INT
-#elif defined(CONFIG_MIPS_DB1500)
-#define DB1XXX_PCMCIA_CD0	AU1500_GPIO0_INT
-#define DB1XXX_PCMCIA_STSCHG0	AU1500_GPIO1_INT
-#define DB1XXX_PCMCIA_CARD0	AU1500_GPIO2_INT
-#define DB1XXX_PCMCIA_CD1	AU1500_GPIO3_INT
-#define DB1XXX_PCMCIA_STSCHG1	AU1500_GPIO4_INT
-#define DB1XXX_PCMCIA_CARD1	AU1500_GPIO5_INT
-
-static int db1500_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
-{
-	if ((slot < 12) || (slot > 13) || pin == 0)
-		return -1;
-	if (slot == 12)
-		return (pin == 1) ? AU1500_PCI_INTA : 0xff;
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
-static struct alchemy_pci_platdata db1500_pci_pd = {
-	.board_map_irq	= db1500_map_pci_irq,
-};
-
-static struct platform_device db1500_pci_host_dev = {
-	.dev.platform_data = &db1500_pci_pd,
-	.name		= "alchemy-pci",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
-	.resource	= alchemy_pci_host_res,
-};
-
-static int __init db1500_pci_init(void)
-{
-	return platform_device_register(&db1500_pci_host_dev);
-}
-/* must be arch_initcall; MIPS PCI scans busses in a subsys_initcall */
-arch_initcall(db1500_pci_init);
-#endif
-
-#ifdef CONFIG_MIPS_DB1100
-static struct resource au1100_lcd_resources[] = {
-	[0] = {
-		.start	= AU1100_LCD_PHYS_ADDR,
-		.end	= AU1100_LCD_PHYS_ADDR + 0x800 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1100_LCD_INT,
-		.end	= AU1100_LCD_INT,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static u64 au1100_lcd_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device au1100_lcd_device = {
-	.name		= "au1100-lcd",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &au1100_lcd_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(au1100_lcd_resources),
-	.resource	= au1100_lcd_resources,
-};
-#endif
-
-static struct resource alchemy_ac97c_res[] = {
-	[0] = {
-		.start	= AU1000_AC97_PHYS_ADDR,
-		.end	= AU1000_AC97_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DMA_ID_AC97C_TX,
-		.end	= DMA_ID_AC97C_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[2] = {
-		.start	= DMA_ID_AC97C_RX,
-		.end	= DMA_ID_AC97C_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static struct platform_device alchemy_ac97c_dev = {
-	.name		= "alchemy-ac97c",
-	.id		= -1,
-	.resource	= alchemy_ac97c_res,
-	.num_resources	= ARRAY_SIZE(alchemy_ac97c_res),
-};
-
-static struct platform_device alchemy_ac97c_dma_dev = {
-	.name		= "alchemy-pcm-dma",
-	.id		= 0,
-};
-
-static struct platform_device db1x00_codec_dev = {
-	.name		= "ac97-codec",
-	.id		= -1,
-};
-
-static struct platform_device db1x00_audio_dev = {
-	.name		= "db1000-audio",
-};
-
-static int __init db1xxx_dev_init(void)
-{
-	irq_set_irq_type(DB1XXX_PCMCIA_CD0, IRQ_TYPE_EDGE_BOTH);
-	irq_set_irq_type(DB1XXX_PCMCIA_CD1, IRQ_TYPE_EDGE_BOTH);
-	irq_set_irq_type(DB1XXX_PCMCIA_CARD0, IRQ_TYPE_LEVEL_LOW);
-	irq_set_irq_type(DB1XXX_PCMCIA_CARD1, IRQ_TYPE_LEVEL_LOW);
-	irq_set_irq_type(DB1XXX_PCMCIA_STSCHG0, IRQ_TYPE_LEVEL_LOW);
-	irq_set_irq_type(DB1XXX_PCMCIA_STSCHG1, IRQ_TYPE_LEVEL_LOW);
-
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-		DB1XXX_PCMCIA_CARD0, DB1XXX_PCMCIA_CD0,
-		/*DB1XXX_PCMCIA_STSCHG0*/0, 0, 0);
-
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004000000,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
-		DB1XXX_PCMCIA_CARD1, DB1XXX_PCMCIA_CD1,
-		/*DB1XXX_PCMCIA_STSCHG1*/0, 0, 1);
-#ifdef CONFIG_MIPS_DB1100
-	platform_device_register(&au1100_lcd_device);
-#endif
-	platform_device_register(&db1x00_codec_dev);
-	platform_device_register(&alchemy_ac97c_dma_dev);
-	platform_device_register(&alchemy_ac97c_dev);
-	platform_device_register(&db1x00_audio_dev);
-
-	db1x_register_norflash(32 << 20, 4 /* 32bit */, F_SWAPPED);
-	return 0;
-}
-device_initcall(db1xxx_dev_init);
diff --git a/arch/mips/alchemy/devboards/prom.c b/arch/mips/alchemy/devboards/prom.c
index 3a73f96..93a2210 100644
--- a/arch/mips/alchemy/devboards/prom.c
+++ b/arch/mips/alchemy/devboards/prom.c
@@ -34,8 +34,8 @@
 #include <prom.h>
 
 #if defined(CONFIG_MIPS_DB1000) || \
-    defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1100) || \
-    defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_DB1500)
+    defined(CONFIG_MIPS_PB1100) || \
+    defined(CONFIG_MIPS_PB1500)
 #define ALCHEMY_BOARD_DEFAULT_MEMSIZE	0x04000000
 
 #else	/* Au1550/Au1200-based develboards */
diff --git a/arch/mips/configs/db1000_defconfig b/arch/mips/configs/db1000_defconfig
index 4044c9e..17a36c1 100644
--- a/arch/mips/configs/db1000_defconfig
+++ b/arch/mips/configs/db1000_defconfig
@@ -1,118 +1,359 @@
+CONFIG_MIPS=y
 CONFIG_MIPS_ALCHEMY=y
+CONFIG_MIPS_DB1000=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
+CONFIG_HZ=100
+CONFIG_PREEMPT_NONE=y
 CONFIG_EXPERIMENTAL=y
-CONFIG_LOCALVERSION="-db1000"
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE=""
+CONFIG_LOCALVERSION="-db1x00"
+CONFIG_LOCALVERSION_AUTO=y
 CONFIG_KERNEL_LZMA=y
+CONFIG_DEFAULT_HOSTNAME="db1x00"
+CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_FHANDLE=y
+CONFIG_AUDIT=y
 CONFIG_TINY_RCU=y
-CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_LOG_BUF_SHIFT=18
+CONFIG_NAMESPACES=y
+CONFIG_UTS_NS=y
+CONFIG_IPC_NS=y
+CONFIG_USER_NS=y
+CONFIG_PID_NS=y
+CONFIG_NET_NS=y
+CONFIG_SYSCTL=y
 CONFIG_EXPERT=y
-# CONFIG_KALLSYMS is not set
-# CONFIG_PCSPKR_PLATFORM is not set
-# CONFIG_VM_EVENT_COUNTERS is not set
-# CONFIG_COMPAT_BRK is not set
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_AIO=y
+CONFIG_EMBEDDED=y
+CONFIG_HAVE_PERF_EVENTS=y
+CONFIG_PERF_USE_VMALLOC=y
+CONFIG_PCI_QUIRKS=y
 CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_LBDAF is not set
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
+CONFIG_SLABINFO=y
+CONFIG_BLOCK=y
+CONFIG_LBDAF=y
+CONFIG_BLK_DEV_BSG=y
+CONFIG_BLK_DEV_BSGLIB=y
+CONFIG_IOSCHED_NOOP=y
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
+CONFIG_FREEZER=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
 CONFIG_PCCARD=y
+CONFIG_PCMCIA=y
+CONFIG_PCMCIA_LOAD_CIS=y
 CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
-CONFIG_PM=y
+CONFIG_BINFMT_ELF=y
+CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+CONFIG_PM_SLEEP=y
 CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
+CONFIG_XFRM=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_NET_IPIP=y
+CONFIG_INET_TUNNEL=y
+CONFIG_INET_LRO=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+CONFIG_IPV6=y
+CONFIG_INET6_XFRM_MODE_TRANSPORT=y
+CONFIG_INET6_XFRM_MODE_TUNNEL=y
+CONFIG_INET6_XFRM_MODE_BEET=y
+CONFIG_IPV6_SIT=y
+CONFIG_IPV6_NDISC_NODETYPE=y
+CONFIG_STP=y
+CONFIG_GARP=y
+CONFIG_BRIDGE=y
+CONFIG_BRIDGE_IGMP_SNOOPING=y
+CONFIG_VLAN_8021Q=y
+CONFIG_VLAN_8021Q_GVRP=y
+CONFIG_LLC=y
+CONFIG_LLC2=y
+CONFIG_DNS_RESOLVER=y
+CONFIG_BT=y
+CONFIG_BT_L2CAP=y
+CONFIG_BT_SCO=y
+CONFIG_BT_RFCOMM=y
+CONFIG_BT_RFCOMM_TTY=y
+CONFIG_BT_BNEP=y
+CONFIG_BT_BNEP_MC_FILTER=y
+CONFIG_BT_BNEP_PROTO_FILTER=y
+CONFIG_BT_HIDP=y
+CONFIG_BT_HCIBTUSB=y
+CONFIG_UEVENT_HELPER_PATH=""
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
 CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_NOSWAP=y
+CONFIG_MTD_CFI_GEOMETRY=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+CONFIG_MTD_CFI_I4=y
+CONFIG_MTD_CFI_I8=y
+CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_UTIL=y
 CONFIG_MTD_PHYSMAP=y
-# CONFIG_MISC_DEVICES is not set
+CONFIG_SCSI_MOD=y
+CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
+CONFIG_SCSI_PROC_FS=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_SG=y
+CONFIG_SCSI_MULTI_LUN=y
+CONFIG_SCSI_CONSTANTS=y
+CONFIG_ATA=y
+CONFIG_ATA_VERBOSE_ERROR=y
+CONFIG_ATA_SFF=y
+CONFIG_ATA_BMDMA=y
+CONFIG_PATA_HPT37X=y
+CONFIG_PATA_PCMCIA=y
+CONFIG_MD=y
+CONFIG_BLK_DEV_DM=y
+CONFIG_FIREWIRE=y
+CONFIG_FIREWIRE_OHCI=y
+CONFIG_FIREWIRE_OHCI_DEBUG=y
+CONFIG_FIREWIRE_NET=y
 CONFIG_NETDEVICES=y
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
 CONFIG_MII=y
+CONFIG_PHYLIB=y
+CONFIG_NET_ETHERNET=y
 CONFIG_MIPS_AU1X00_ENET=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
-# CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_NET_PCMCIA=y
+CONFIG_PCMCIA_3C589=y
+CONFIG_PCMCIA_PCNET=y
+CONFIG_PPP=y
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPP_FILTER=y
+CONFIG_PPP_ASYNC=y
+CONFIG_PPP_SYNC_TTY=y
+CONFIG_PPP_DEFLATE=y
+CONFIG_PPP_BSDCOMP=y
+CONFIG_PPP_MPPE=y
+CONFIG_PPPOE=y
+CONFIG_INPUT=y
 CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_UINPUT=y
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
+CONFIG_DEVKMEM=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_TTY_PRINTK=y
+CONFIG_DEVPORT=y
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+CONFIG_FB=y
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+CONFIG_FB_AU1100=y
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x16=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_TIMER=y
+CONFIG_SND_PCM=y
+CONFIG_SND_JACK=y
+CONFIG_SND_SEQUENCER=y
+CONFIG_SND_HRTIMER=y
+CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
+CONFIG_SND_DYNAMIC_MINORS=y
+CONFIG_SND_VMASTER=y
+CONFIG_SND_AC97_CODEC=y
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_AC97_BUS=y
+CONFIG_SND_SOC_AU1XAUDIO=y
+CONFIG_SND_SOC_AU1XAC97C=y
+CONFIG_SND_SOC_DB1000=y
+CONFIG_SND_SOC_AC97_CODEC=y
+CONFIG_AC97_BUS=y
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+CONFIG_HIDRAW=y
+CONFIG_USB_HID=y
+CONFIG_USB_SUPPORT=y
 CONFIG_USB=y
-# CONFIG_USB_DEVICE_CLASS is not set
-CONFIG_USB_DYNAMIC_MINORS=y
 CONFIG_USB_SUSPEND=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_TT_NEWSCHED=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_UHCI_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
 CONFIG_RTC_DRV_AU1XXX=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-# CONFIG_EXT3_FS_XATTR is not set
-# CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_USE_FOR_EXT23=y
+CONFIG_EXT4_FS_XATTR=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_JBD2=y
+CONFIG_FS_MBCACHE=y
+CONFIG_FS_POSIX_ACL=y
+CONFIG_EXPORTFS=y
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY_USER=y
+CONFIG_GENERIC_ACL=y
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_SYSFS=y
 CONFIG_TMPFS=y
-CONFIG_CRAMFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TMPFS_XATTR=y
+CONFIG_MISC_FILESYSTEMS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_JFFS2_FS_XATTR=y
+CONFIG_JFFS2_FS_POSIX_ACL=y
+CONFIG_JFFS2_FS_SECURITY=y
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_LZO=y
+CONFIG_JFFS2_RTIME=y
+CONFIG_JFFS2_RUBIN=y
+CONFIG_JFFS2_CMODE_PRIORITY=y
 CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_ZLIB=y
+CONFIG_SQUASHFS_LZO=y
+CONFIG_SQUASHFS_XZ=y
+CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_PNFS_FILE_LAYOUT=y
+CONFIG_PNFS_BLOCK=y
 CONFIG_ROOT_NFS=y
+CONFIG_NFS_USE_KERNEL_DNS=y
+CONFIG_NFS_USE_NEW_IDMAPPER=y
+CONFIG_NFSD=y
+CONFIG_NFSD_V2_ACL=y
+CONFIG_NFSD_V3=y
+CONFIG_NFSD_V3_ACL=y
+CONFIG_NFSD_V4=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_ACL_SUPPORT=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+CONFIG_SUNRPC_BACKCHANNEL=y
+CONFIG_MSDOS_PARTITION=y
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_CODEPAGE_1250=y
+CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_FTRACE is not set
+CONFIG_HAVE_ARCH_KGDB=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="noirqdebug rootwait root=/dev/sda1 rootfstype=ext4 console=ttyS0,115200 video=au1100fb:panel:CRT_800x600_16"
 CONFIG_DEBUG_ZBOOT=y
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
+CONFIG_SECURITYFS=y
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_AEAD2=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_BLKCIPHER2=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG=y
+CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_PCOMP2=y
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MANAGER2=y
+CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
+CONFIG_CRYPTO_WORKQUEUE=y
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_AES=y
+CONFIG_CRYPTO_ANSI_CPRNG=y
+CONFIG_BITREVERSE=y
+CONFIG_CRC_CCITT=y
+CONFIG_CRC16=y
+CONFIG_CRC_ITU_T=y
+CONFIG_CRC32=y
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
+CONFIG_XZ_DEC=y
diff --git a/arch/mips/configs/db1100_defconfig b/arch/mips/configs/db1100_defconfig
deleted file mode 100644
index c6b4993..0000000
--- a/arch/mips/configs/db1100_defconfig
+++ /dev/null
@@ -1,122 +0,0 @@
-CONFIG_MIPS_ALCHEMY=y
-CONFIG_MIPS_DB1100=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
-CONFIG_LOCALVERSION="-db1100"
-CONFIG_KERNEL_LZMA=y
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_TINY_RCU=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EXPERT=y
-# CONFIG_SYSCTL_SYSCALL is not set
-# CONFIG_KALLSYMS is not set
-# CONFIG_PCSPKR_PLATFORM is not set
-# CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_LBDAF is not set
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_PCCARD=y
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
-# CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
-# CONFIG_BLK_DEV is not set
-# CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_IDE_TASK_IOCTL=y
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
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-CONFIG_FB=y
-CONFIG_FB_AU1100=y
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x16=y
-# CONFIG_HID_SUPPORT is not set
-CONFIG_USB=y
-# CONFIG_USB_DEVICE_CLASS is not set
-CONFIG_USB_DYNAMIC_MINORS=y
-CONFIG_USB_SUSPEND=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_AU1XXX=y
-CONFIG_EXT2_FS=y
-# CONFIG_PROC_PAGE_MONITOR is not set
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_SUMMARY=y
-CONFIG_JFFS2_FS_XATTR=y
-CONFIG_JFFS2_COMPRESSION_OPTIONS=y
-CONFIG_JFFS2_LZO=y
-CONFIG_JFFS2_RUBIN=y
-CONFIG_SQUASHFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_ROOT_NFS=y
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_FTRACE is not set
-CONFIG_DEBUG_ZBOOT=y
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
-CONFIG_SECURITYFS=y
diff --git a/arch/mips/configs/db1500_defconfig b/arch/mips/configs/db1500_defconfig
deleted file mode 100644
index b6e21c7..0000000
--- a/arch/mips/configs/db1500_defconfig
+++ /dev/null
@@ -1,128 +0,0 @@
-CONFIG_MIPS_ALCHEMY=y
-CONFIG_MIPS_DB1500=y
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
-CONFIG_LOCALVERSION="-db1500"
-CONFIG_KERNEL_LZMA=y
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EXPERT=y
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
-# CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
-# CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECS=y
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
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-# CONFIG_SERIAL_8250_PCI is not set
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-# CONFIG_VGA_ARB is not set
-# CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
-CONFIG_USB=y
-# CONFIG_USB_DEVICE_CLASS is not set
-CONFIG_USB_DYNAMIC_MINORS=y
-CONFIG_USB_SUSPEND=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_AU1XXX=y
-CONFIG_EXT2_FS=y
-# CONFIG_PROC_PAGE_MONITOR is not set
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_SUMMARY=y
-CONFIG_JFFS2_FS_XATTR=y
-CONFIG_JFFS2_COMPRESSION_OPTIONS=y
-CONFIG_JFFS2_LZO=y
-CONFIG_JFFS2_RUBIN=y
-CONFIG_SQUASHFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_ROOT_NFS=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_CODEPAGE_850=y
-CONFIG_NLS_CODEPAGE_1250=y
-CONFIG_NLS_ASCII=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_NLS_ISO8859_15=y
-CONFIG_NLS_UTF8=y
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-# CONFIG_FTRACE is not set
-CONFIG_DEBUG_ZBOOT=y
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
-CONFIG_SECURITYFS=y
diff --git a/drivers/net/irda/au1k_ir.c b/drivers/net/irda/au1k_ir.c
index d1a77ef..670bb05 100644
--- a/drivers/net/irda/au1k_ir.c
+++ b/drivers/net/irda/au1k_ir.c
@@ -32,7 +32,7 @@
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/au1000.h>
-#if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100)
+#if defined(CONFIG_MIPS_DB1000)
 #include <asm/mach-db1x00/bcsr.h>
 #else 
 #error au1k_ir: unsupported board
@@ -274,7 +274,7 @@ static int au1k_irda_net_init(struct net_device *dev)
 		aup->tx_db_inuse[i] = pDB;
 	}
 
-#if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100)
+#if defined(CONFIG_MIPS_DB1000)
 	/* power on */
 	bcsr_mod(BCSR_RESETS, BCSR_RESETS_IRDA_MODE_MASK,
 			      BCSR_RESETS_IRDA_MODE_FULL);
@@ -662,7 +662,7 @@ au1k_irda_set_speed(struct net_device *dev, int speed)
 	u32 control;
 	int ret = 0, timeout = 10, i;
 	volatile ring_dest_t *ptxd;
-#if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100)
+#if defined(CONFIG_MIPS_DB1000)
 	unsigned long irda_resets;
 #endif
 
@@ -711,14 +711,14 @@ au1k_irda_set_speed(struct net_device *dev, int speed)
 	}
 
 	if (speed == 4000000) {
-#if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100)
+#if defined(CONFIG_MIPS_DB1000)
 		bcsr_mod(BCSR_RESETS, 0, BCSR_RESETS_FIR_SEL);
 #else /* Pb1000 and Pb1100 */
 		writel(1<<13, CPLD_AUX1);
 #endif
 	}
 	else {
-#if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100)
+#if defined(CONFIG_MIPS_DB1000)
 		bcsr_mod(BCSR_RESETS, BCSR_RESETS_FIR_SEL, 0);
 #else /* Pb1000 and Pb1100 */
 		writel(readl(CPLD_AUX1) & ~(1<<13), CPLD_AUX1);
diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index 649cb35..de9da67 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -60,18 +60,6 @@
 
 #include "au1100fb.h"
 
-/*
- * Sanity check. If this is a new Au1100 based board, search for
- * the PB1100 ifdefs to make sure you modify the code accordingly.
- */
-#if defined(CONFIG_MIPS_PB1100)
-  #include <asm/mach-pb1x00/pb1100.h>
-#elif defined(CONFIG_MIPS_DB1100)
-  #include <asm/mach-db1x00/db1x00.h>
-#else
-  #error "Unknown Au1100 board, Au1100 FB driver not supported"
-#endif
-
 #define DRIVER_NAME "au1100fb"
 #define DRIVER_DESC "LCD controller driver for AU1100 processors"
 
-- 
1.7.7.1
