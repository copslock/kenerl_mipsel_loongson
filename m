Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 01:06:19 +0200 (CEST)
Received: from mail-la0-f53.google.com ([209.85.215.53]:54761 "EHLO
        mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012109AbaJUXDvNVSOW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 01:03:51 +0200
Received: by mail-la0-f53.google.com with SMTP id gq15so2005035lab.12
        for <multiple recipients>; Tue, 21 Oct 2014 16:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xFfLVHn/L6rqOnQAEjlggKAHBt57DU2jCXVqQIzmqf8=;
        b=lcS68TYjcZSadUGYeBHSkIjR832J0XxquB6Ow1GcqANX0d/I8mAU79GUNMTeSXbjMN
         KILfe0CHcGVnQJfvE1nbaMx7gtAstUvZOGSv67ps/WT87c51kKiJ0iFnvKtZBIIL9Lvu
         TUkTgxJdGDqWDwTfRldzYf8D96B7a7HqBs4O5SGqWoT0CvbJF/cQAvI6oPUs/iNi00hj
         9uhoCuCu1/bHUqEtlHJ2fj+xCGq81Dadyfjlv3nKKFf2rluP+1PYiZpj9mFYqi9pwSWc
         ItJyUTpNcemDun//j0xEHTB0yZxf5LlGmtUtQ5ArB2DE5OuJFiTnFDqfnTQBXwbDVvzF
         nMhg==
X-Received: by 10.112.77.74 with SMTP id q10mr29331810lbw.66.1413932625868;
        Tue, 21 Oct 2014 16:03:45 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id lk5sm5077133lac.45.2014.10.21.16.03.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 16:03:45 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH v2 09/13] MIPS: ath25: register various chip devices
Date:   Wed, 22 Oct 2014 03:03:47 +0400
Message-Id: <1413932631-12866-10-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Register GPIO, watchdog and flash devices.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---

Changes since v1:
  - rename MIPS machine ar231x -> ath25

 arch/mips/ath25/Kconfig                        |  2 +
 arch/mips/ath25/ar2315.c                       | 86 +++++++++++++++++++++++++-
 arch/mips/ath25/ar5312.c                       | 53 +++++++++++++++-
 arch/mips/include/asm/mach-ath25/ar2315_regs.h |  5 ++
 arch/mips/include/asm/mach-ath25/ar5312_regs.h |  2 +
 5 files changed, 144 insertions(+), 4 deletions(-)

diff --git a/arch/mips/ath25/Kconfig b/arch/mips/ath25/Kconfig
index ca3dde4..7bcdbf3 100644
--- a/arch/mips/ath25/Kconfig
+++ b/arch/mips/ath25/Kconfig
@@ -1,9 +1,11 @@
 config SOC_AR5312
 	bool "Atheros AR5312/AR2312+ SoC support"
 	depends on ATH25
+	select GPIO_AR5312
 	default y
 
 config SOC_AR2315
 	bool "Atheros AR2315+ SoC support"
 	depends on ATH25
+	select GPIO_AR2315
 	default y
diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index f239035..ac784d7 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -16,7 +16,10 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/reboot.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
@@ -136,6 +139,66 @@ void __init ar2315_arch_init_irq(void)
 	irq_set_chained_handler(AR2315_IRQ_MISC, ar2315_misc_irq_handler);
 }
 
+static struct resource ar2315_spiflash_res[] = {
+	{
+		.name = "spiflash_read",
+		.flags = IORESOURCE_MEM,
+		.start = AR2315_SPI_READ,
+		.end = AR2315_SPI_READ + 0x1000000 - 1,
+	},
+	{
+		.name = "spiflash_mmr",
+		.flags = IORESOURCE_MEM,
+		.start = AR2315_SPI_MMR,
+		.end = AR2315_SPI_MMR + 12 - 1,
+	},
+};
+
+static struct platform_device ar2315_spiflash = {
+	.id = -1,
+	.name = "ar2315-spiflash",
+	.resource = ar2315_spiflash_res,
+	.num_resources = ARRAY_SIZE(ar2315_spiflash_res)
+};
+
+static struct resource ar2315_wdt_res[] = {
+	{
+		.flags = IORESOURCE_MEM,
+		.start = AR2315_WD,
+		.end = AR2315_WD + 8 - 1,
+	},
+	{
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device ar2315_wdt = {
+	.id = -1,
+	.name = "ar2315-wdt",
+	.resource = ar2315_wdt_res,
+	.num_resources = ARRAY_SIZE(ar2315_wdt_res)
+};
+
+static struct resource ar2315_gpio_res[] = {
+	{
+		.name = "ar2315-gpio",
+		.flags = IORESOURCE_MEM,
+		.start = AR2315_GPIO,
+		.end = AR2315_GPIO + 0x10 - 1,
+	},
+	{
+		.name = "ar2315-gpio",
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ar2315_gpio = {
+	.id = -1,
+	.name = "ar2315-gpio",
+	.resource = ar2315_gpio_res,
+	.num_resources = ARRAY_SIZE(ar2315_gpio_res)
+};
+
 /*
  * NB: We use mapping size that is larger than the actual flash size,
  * but this shouldn't be a problem here, because the flash will simply
@@ -146,8 +209,20 @@ ar2315_flash_limit = (u8 *)KSEG1ADDR(AR2315_SPI_READ + 0x1000000);
 
 void __init ar2315_init_devices(void)
 {
+	struct resource *res;
+
 	/* Find board configuration */
 	ath25_find_config(ar2315_flash_limit);
+
+	res = &ar2315_gpio_res[1];
+	res->start = ar2315_misc_irq_base + AR2315_MISC_IRQ_GPIO;
+	res->end = res->start;
+	platform_device_register(&ar2315_gpio);
+	res = &ar2315_wdt_res[1];
+	res->start = ar2315_misc_irq_base + AR2315_MISC_IRQ_WATCHDOG;
+	res->end = res->start;
+	platform_device_register(&ar2315_wdt);
+	platform_device_register(&ar2315_spiflash);
 }
 
 static void ar2315_restart(char *command)
@@ -159,8 +234,15 @@ static void ar2315_restart(char *command)
 	/* try reset the system via reset control */
 	ath25_write_reg(AR2315_COLD_RESET, AR2317_RESET_SYSTEM);
 
-	/* Attempt to jump to the mips reset location - the boot loader
-	 * itself might be able to recover the system */
+	/* Cold reset does not work on the AR2315/6, use the GPIO reset bits
+	 * a workaround. Give it some time to attempt a gpio based hardware
+	 * reset (atheros reference design workaround) */
+	gpio_request_one(AR2315_RESET_GPIO, GPIOF_OUT_INIT_LOW, "Reset");
+	mdelay(100);
+
+	/* Some boards (e.g. Senao EOC-2610) don't implement the reset logic
+	 * workaround. Attempt to jump to the mips reset location -
+	 * the boot loader itself might be able to recover the system */
 	mips_reset_vec();
 }
 
diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index faa0633..99c2745 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -16,6 +16,8 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
 #include <linux/reboot.h>
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
@@ -131,15 +133,59 @@ void __init ar5312_arch_init_irq(void)
 	irq_set_chained_handler(AR5312_IRQ_MISC, ar5312_misc_irq_handler);
 }
 
+static struct physmap_flash_data ar5312_flash_data = {
+	.width = 2,
+};
+
+static struct resource ar5312_flash_resource = {
+	.start = AR5312_FLASH,
+	.end = AR5312_FLASH + 0x800000 - 1,
+	.flags = IORESOURCE_MEM,
+};
+
+static struct platform_device ar5312_physmap_flash = {
+	.name = "physmap-flash",
+	.id = 0,
+	.dev.platform_data = &ar5312_flash_data,
+	.resource = &ar5312_flash_resource,
+	.num_resources = 1,
+};
+
+static struct resource ar5312_gpio_res[] = {
+	{
+		.name = "ar5312-gpio",
+		.flags = IORESOURCE_MEM,
+		.start = AR5312_GPIO,
+		.end = AR5312_GPIO + 0x0c - 1,
+	},
+};
+
+static struct platform_device ar5312_gpio = {
+	.name = "ar5312-gpio",
+	.id = -1,
+	.resource = ar5312_gpio_res,
+	.num_resources = ARRAY_SIZE(ar5312_gpio_res),
+};
+
 static void __init ar5312_flash_init(void)
 {
-	u32 ctl;
+	u32 ctl = ath25_read_reg(AR5312_FLASHCTL0) & AR5312_FLASHCTL_MW;
+
+	/* fixup flash width */
+	switch (ctl) {
+	case AR5312_FLASHCTL_MW16:
+		ar5312_flash_data.width = 2;
+		break;
+	case AR5312_FLASHCTL_MW8:
+	default:
+		ar5312_flash_data.width = 1;
+		break;
+	}
 
 	/*
 	 * Configure flash bank 0.
 	 * Assume 8M window size. Flash will be aliased if it's smaller
 	 */
-	ctl = ath25_read_reg(AR5312_FLASHCTL0) & AR5312_FLASHCTL_MW;
 	ctl |= AR5312_FLASHCTL_E | AR5312_FLASHCTL_AC_8M | AR5312_FLASHCTL_RBLE;
 	ctl |= 0x01 << AR5312_FLASHCTL_IDCY_S;
 	ctl |= 0x07 << AR5312_FLASHCTL_WST1_S;
@@ -182,6 +228,9 @@ void __init ar5312_init_devices(void)
 	/* Everything else is probably AR5312 or compatible */
 	else
 		ath25_soc = ATH25_SOC_AR5312;
+
+	platform_device_register(&ar5312_physmap_flash);
+	platform_device_register(&ar5312_gpio);
 }
 
 static void ar5312_restart(char *command)
diff --git a/arch/mips/include/asm/mach-ath25/ar2315_regs.h b/arch/mips/include/asm/mach-ath25/ar2315_regs.h
index e680abc..d61c8a1 100644
--- a/arch/mips/include/asm/mach-ath25/ar2315_regs.h
+++ b/arch/mips/include/asm/mach-ath25/ar2315_regs.h
@@ -283,6 +283,11 @@
 #define AR2315_AMBACLK_CLK_DIV_M	0x0000000c
 #define AR2315_AMBACLK_CLK_DIV_S	2
 
+/* GPIO MMR base address */
+#define AR2315_GPIO			(AR2315_DSLBASE + 0x0088)
+
+#define AR2315_RESET_GPIO	5
+
 /*
  *  PCI Clock Control
  */
diff --git a/arch/mips/include/asm/mach-ath25/ar5312_regs.h b/arch/mips/include/asm/mach-ath25/ar5312_regs.h
index afcd0b2..d715385 100644
--- a/arch/mips/include/asm/mach-ath25/ar5312_regs.h
+++ b/arch/mips/include/asm/mach-ath25/ar5312_regs.h
@@ -210,4 +210,6 @@
 #define AR5312_MEM_CFG1_AC1_M	0x00007000	/* bank 1: SDRAM addr check */
 #define AR5312_MEM_CFG1_AC1_S	12
 
+#define AR5312_GPIO		(AR5312_APBBASE  + 0x2000)
+
 #endif	/* __ASM_MACH_ATH25_AR5312_REGS_H */
-- 
1.8.5.5
