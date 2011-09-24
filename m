Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Sep 2011 17:18:01 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:40915 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491965Ab1IXPRH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Sep 2011 17:17:07 +0200
Received: by fxg7 with SMTP id 7so6005751fxg.36
        for <multiple recipients>; Sat, 24 Sep 2011 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pPg4Zck0Iu4Qk0upFRXmN9F1KerANcdSUC7GRY0KNko=;
        b=rMnx9Kyu4dxEmVbOhggyGAuo5q5IIH8ZMtFYvyiSSmpQaiW5lzwuqyF+SMOoof4qx3
         JW1NeWRqbDj9j6pwMHjWUPQ8TsF1fNJBpmxAbNbmY2u2MIgHF6FEFPn7hl0GkuxY4pen
         Q0FdS5z1RchYwawHP3ht7kok1kGo7GjgECdVc=
Received: by 10.223.26.28 with SMTP id b28mr1225430fac.125.1316877421684;
        Sat, 24 Sep 2011 08:17:01 -0700 (PDT)
Received: from localhost.localdomain (188-22-1-130.adsl.highway.telekom.at. [188.22.1.130])
        by mx.google.com with ESMTPS id w14sm14549396fae.13.2011.09.24.08.17.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 08:17:01 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 2/2] MIPS: Alchemy: drop MIRAGE/BOSPORUS board support
Date:   Sat, 24 Sep 2011 17:16:56 +0200
Message-Id: <1316877416-14958-3-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <1316877416-14958-1-git-send-email-manuel.lauss@googlemail.com>
References: <1316877416-14958-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13883

No test hardware and no (apparent) users.  These boards seem very
similar to the DB1500, so if required support can be brought back
again (I have datasheets) but then with dedicated board code, not
tacked on to DB1000 support.
---
 arch/mips/alchemy/Kconfig                        |   14 ---
 arch/mips/alchemy/Platform                       |   14 ---
 arch/mips/alchemy/devboards/Makefile             |    2 -
 arch/mips/alchemy/devboards/db1x00/board_setup.c |  105 +---------------------
 arch/mips/alchemy/devboards/db1x00/platform.c    |   67 +--------------
 arch/mips/alchemy/devboards/prom.c               |    3 +-
 6 files changed, 3 insertions(+), 202 deletions(-)

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 5a48387..36df5e2 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -22,13 +22,6 @@ config MIPS_MTX1
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
-config MIPS_BOSPORUS
-	bool "Alchemy Bosporus board"
-	select ALCHEMY_GPIOINT_AU1000
-	select DMA_NONCOHERENT
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_HAS_EARLY_PRINTK
-
 config MIPS_DB1000
 	bool "Alchemy DB1000 board"
 	select ALCHEMY_GPIOINT_AU1000
@@ -71,13 +64,6 @@ config MIPS_DB1550
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
-config MIPS_MIRAGE
-	bool "Alchemy Mirage board"
-	select DMA_NONCOHERENT
-	select ALCHEMY_GPIOINT_AU1000
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_HAS_EARLY_PRINTK
-
 config MIPS_PB1100
 	bool "Alchemy PB1100 board"
 	select ALCHEMY_GPIOINT_AU1000
diff --git a/arch/mips/alchemy/Platform b/arch/mips/alchemy/Platform
index 4e07967..2920af9 100644
--- a/arch/mips/alchemy/Platform
+++ b/arch/mips/alchemy/Platform
@@ -68,20 +68,6 @@ cflags-$(CONFIG_MIPS_DB1200)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
 load-$(CONFIG_MIPS_DB1200)	+= 0xffffffff80100000
 
 #
-# AMD Alchemy Bosporus eval board
-#
-platform-$(CONFIG_MIPS_BOSPORUS) += alchemy/devboards/
-cflags-$(CONFIG_MIPS_BOSPORUS)	 += -I$(srctree)/arch/mips/include/asm/mach-db1x00
-load-$(CONFIG_MIPS_BOSPORUS)	 += 0xffffffff80100000
-
-#
-# AMD Alchemy Mirage eval board
-#
-platform-$(CONFIG_MIPS_MIRAGE)	+= alchemy/devboards/
-cflags-$(CONFIG_MIPS_MIRAGE)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
-load-$(CONFIG_MIPS_MIRAGE)	+= 0xffffffff80100000
-
-#
 # 4G-Systems eval board
 #
 platform-$(CONFIG_MIPS_MTX1)	+= alchemy/mtx-1/
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index bea80d7..5afaf94 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -13,5 +13,3 @@ obj-$(CONFIG_MIPS_DB1100)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1200)	+= db1200/
 obj-$(CONFIG_MIPS_DB1500)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1550)	+= db1x00/
-obj-$(CONFIG_MIPS_BOSPORUS)	+= db1x00/
-obj-$(CONFIG_MIPS_MIRAGE)	+= db1x00/
diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index 7cd36e6..8a222b3 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -40,64 +40,10 @@
 
 #include <prom.h>
 
-#ifdef CONFIG_MIPS_BOSPORUS
-char irq_tab_alchemy[][5] __initdata = {
-	[11] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff }, /* IDSEL 11 - miniPCI  */
-	[12] = { -1, AU1500_PCI_INTA, 0xff, 0xff, 0xff }, /* IDSEL 12 - SN1741   */
-	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD }, /* IDSEL 13 - PCI slot */
-};
-
-/*
- * Micrel/Kendin 5 port switch attached to MAC0,
- * MAC0 is associated with PHY address 5 (== WAN port)
- * MAC1 is not associated with any PHY, since it's connected directly
- * to the switch.
- * no interrupts are used
- */
-static struct au1000_eth_platform_data eth0_pdata = {
-	.phy_static_config	= 1,
-	.phy_addr		= 5,
-};
-
-static void bosporus_power_off(void)
-{
-	while (1)
-		asm volatile (".set mips3 ; wait ; .set mips0");
-}
-
-const char *get_system_type(void)
-{
-	return "Alchemy Bosporus Gateway Reference";
-}
-#endif
-
-
-#ifdef CONFIG_MIPS_MIRAGE
-static void mirage_power_off(void)
-{
-	alchemy_gpio_direction_output(210, 1);
-}
-
-const char *get_system_type(void)
-{
-	return "Alchemy Mirage";
-}
-#endif
-
-
-#if defined(CONFIG_MIPS_BOSPORUS) || defined(CONFIG_MIPS_MIRAGE)
-static void mips_softreset(void)
-{
-	asm volatile ("jr\t%0" : : "r"(0xbfc00000));
-}
-
-#else
-
 const char *get_system_type(void)
 {
 	return "Alchemy Db1x00";
 }
-#endif
 
 
 void __init board_setup(void)
@@ -116,14 +62,6 @@ void __init board_setup(void)
 #ifdef CONFIG_MIPS_DB1100
 	printk(KERN_INFO "AMD Alchemy Au1100/Db1100 Board\n");
 #endif
-#ifdef CONFIG_MIPS_BOSPORUS
-	au1xxx_override_eth_cfg(0, &eth0_pdata);
-
-	printk(KERN_INFO "AMD Alchemy Bosporus Board\n");
-#endif
-#ifdef CONFIG_MIPS_MIRAGE
-	printk(KERN_INFO "AMD Alchemy Mirage Board\n");
-#endif
 #ifdef CONFIG_MIPS_DB1550
 	printk(KERN_INFO "AMD Alchemy Au1550/Db1550 Board\n");
 
@@ -150,52 +88,11 @@ void __init board_setup(void)
 
 	/* Enable GPIO[31:0] inputs */
 	alchemy_gpio1_input_enable();
-
-#ifdef CONFIG_MIPS_MIRAGE
-	{
-		u32 pin_func;
-
-		/* GPIO[20] is output */
-		alchemy_gpio_direction_output(20, 0);
-
-		/* Set GPIO[210:208] instead of SSI_0 */
-		pin_func = au_readl(SYS_PINFUNC) | SYS_PF_S0;
-
-		/* Set GPIO[215:211] for LEDs */
-		pin_func |= 5 << 2;
-
-		/* Set GPIO[214:213] for more LEDs */
-		pin_func |= 5 << 12;
-
-		/* Set GPIO[207:200] instead of PCMCIA/LCD */
-		pin_func |= SYS_PF_LCD | SYS_PF_PC;
-		au_writel(pin_func, SYS_PINFUNC);
-
-		/*
-		 * Enable speaker amplifier.  This should
-		 * be part of the audio driver.
-		 */
-		alchemy_gpio_direction_output(209, 1);
-
-		pm_power_off = mirage_power_off;
-		_machine_halt = mirage_power_off;
-		_machine_restart = (void(*)(char *))mips_softreset;
-	}
-#endif
-
-#ifdef CONFIG_MIPS_BOSPORUS
-	pm_power_off = bosporus_power_off;
-	_machine_halt = bosporus_power_off;
-	_machine_restart = (void(*)(char *))mips_softreset;
-#endif
-	au_sync();
 }
 
 static int __init db1x00_init_irq(void)
 {
-#if defined(CONFIG_MIPS_MIRAGE)
-	irq_set_irq_type(AU1500_GPIO7_INT, IRQF_TRIGGER_RISING); /* TS pendown */
-#elif defined(CONFIG_MIPS_DB1550)
+#if defined(CONFIG_MIPS_DB1550)
 	irq_set_irq_type(AU1550_GPIO0_INT, IRQF_TRIGGER_LOW);  /* CD0# */
 	irq_set_irq_type(AU1550_GPIO1_INT, IRQF_TRIGGER_LOW);  /* CD1# */
 	irq_set_irq_type(AU1550_GPIO3_INT, IRQF_TRIGGER_LOW);  /* CARD0# */
diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index 8704865..f3a5e51 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -35,7 +35,6 @@ struct pci_dev;
  * Db1550:	0/1, 21/22, 3/5
  */
 
-#define DB1XXX_HAS_PCMCIA
 #define F_SWAPPED (bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1000_SWAPBOOT)
 
 #if defined(CONFIG_MIPS_DB1000)
@@ -46,7 +45,6 @@ struct pci_dev;
 #define DB1XXX_PCMCIA_STSCHG1	AU1000_GPIO4_INT
 #define DB1XXX_PCMCIA_CARD1	AU1000_GPIO5_INT
 #define BOARD_FLASH_SIZE	0x02000000 /* 32MB */
-#define BOARD_FLASH_WIDTH	4 /* 32-bits */
 #elif defined(CONFIG_MIPS_DB1100)
 #define DB1XXX_PCMCIA_CD0	AU1100_GPIO0_INT
 #define DB1XXX_PCMCIA_STSCHG0	AU1100_GPIO1_INT
@@ -55,7 +53,6 @@ struct pci_dev;
 #define DB1XXX_PCMCIA_STSCHG1	AU1100_GPIO4_INT
 #define DB1XXX_PCMCIA_CARD1	AU1100_GPIO5_INT
 #define BOARD_FLASH_SIZE	0x02000000 /* 32MB */
-#define BOARD_FLASH_WIDTH	4 /* 32-bits */
 #elif defined(CONFIG_MIPS_DB1500)
 #define DB1XXX_PCMCIA_CD0	AU1500_GPIO0_INT
 #define DB1XXX_PCMCIA_STSCHG0	AU1500_GPIO1_INT
@@ -64,7 +61,6 @@ struct pci_dev;
 #define DB1XXX_PCMCIA_STSCHG1	AU1500_GPIO4_INT
 #define DB1XXX_PCMCIA_CARD1	AU1500_GPIO5_INT
 #define BOARD_FLASH_SIZE	0x02000000 /* 32MB */
-#define BOARD_FLASH_WIDTH	4 /* 32-bits */
 #elif defined(CONFIG_MIPS_DB1550)
 #define DB1XXX_PCMCIA_CD0	AU1550_GPIO0_INT
 #define DB1XXX_PCMCIA_STSCHG0	AU1550_GPIO21_INT
@@ -73,19 +69,6 @@ struct pci_dev;
 #define DB1XXX_PCMCIA_STSCHG1	AU1550_GPIO22_INT
 #define DB1XXX_PCMCIA_CARD1	AU1550_GPIO5_INT
 #define BOARD_FLASH_SIZE	0x08000000 /* 128MB */
-#define BOARD_FLASH_WIDTH	4 /* 32-bits */
-#else
-/* other board: no PCMCIA */
-#undef DB1XXX_HAS_PCMCIA
-#undef F_SWAPPED
-#define F_SWAPPED 0
-#if defined(CONFIG_MIPS_BOSPORUS)
-#define BOARD_FLASH_SIZE	0x01000000 /* 16MB */
-#define BOARD_FLASH_WIDTH	2 /* 16-bits */
-#elif defined(CONFIG_MIPS_MIRAGE)
-#define BOARD_FLASH_SIZE	0x04000000 /* 64MB */
-#define BOARD_FLASH_WIDTH	4 /* 32-bits */
-#endif
 #endif
 
 #ifdef CONFIG_PCI
@@ -135,52 +118,6 @@ static int db1xxx_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
 }
 #endif
 
-#ifdef CONFIG_MIPS_BOSPORUS
-static int db1xxx_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
-{
-	if ((slot < 11) || (slot > 13) || pin == 0)
-		return -1;
-	if (slot == 12)
-		return (pin == 1) ? AU1500_PCI_INTA : 0xff;
-	if (slot == 11) {
-		switch (pin) {
-		case 1: return AU1500_PCI_INTA;
-		case 2: return AU1500_PCI_INTB;
-		default: return 0xff;
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
-#endif
-
-#ifdef CONFIG_MIPS_MIRAGE
-static int db1xxx_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
-{
-	if ((slot < 11) || (slot > 13) || pin == 0)
-		return -1;
-	if (slot == 11)
-		return (pin == 1) ? AU1500_PCI_INTD : 0xff;
-	if (slot == 12)
-		return (pin == 3) ? AU1500_PCI_INTC : 0xff;
-	if (slot == 13) {
-		switch (pin) {
-		case 1: return AU1500_PCI_INTA;
-		case 2: return AU1500_PCI_INTB;
-		default: return 0xff;
-		}
-	}
-	return -1;
-}
-#endif
-
 static struct resource alchemy_pci_host_res[] = {
 	[0] = {
 		.start	= AU1500_PCI_PHYS_ADDR,
@@ -239,7 +176,6 @@ static struct platform_device au1100_lcd_device = {
 
 static int __init db1xxx_dev_init(void)
 {
-#ifdef DB1XXX_HAS_PCMCIA
 	db1x_register_pcmcia_socket(
 		AU1000_PCMCIA_ATTR_PHYS_ADDR,
 		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
@@ -259,11 +195,10 @@ static int __init db1xxx_dev_init(void)
 		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
 		DB1XXX_PCMCIA_CARD1, DB1XXX_PCMCIA_CD1,
 		/*DB1XXX_PCMCIA_STSCHG1*/0, 0, 1);
-#endif
 #ifdef CONFIG_MIPS_DB1100
 	platform_device_register(&au1100_lcd_device);
 #endif
-	db1x_register_norflash(BOARD_FLASH_SIZE, BOARD_FLASH_WIDTH, F_SWAPPED);
+	db1x_register_norflash(BOARD_FLASH_SIZE, 4 /* 32bit */, F_SWAPPED);
 	return 0;
 }
 device_initcall(db1xxx_dev_init);
diff --git a/arch/mips/alchemy/devboards/prom.c b/arch/mips/alchemy/devboards/prom.c
index 56d7ea5..f734833 100644
--- a/arch/mips/alchemy/devboards/prom.c
+++ b/arch/mips/alchemy/devboards/prom.c
@@ -35,8 +35,7 @@
 
 #if defined(CONFIG_MIPS_DB1000) || \
     defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1100) || \
-    defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_DB1500) || \
-    defined(CONFIG_MIPS_BOSPORUS) || defined(CONFIG_MIPS_MIRAGE)
+    defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_DB1500)
 #define ALCHEMY_BOARD_DEFAULT_MEMSIZE	0x04000000
 
 #else	/* Au1550/Au1200-based develboards */
-- 
1.7.6.1
