Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 20:09:27 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:32904 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903699Ab1KATEs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2011 20:04:48 +0100
Received: by mail-fx0-f49.google.com with SMTP id q17so947590faa.36
        for <multiple recipients>; Tue, 01 Nov 2011 12:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4sW6BKF4+tR/e4zoCMTEAmja+V3fNQzvBEAuUaCX/ss=;
        b=Yrli39Dxa8TZN5Jj9upgFH4YfTUy46LdxXY+SKRlBch7aVCpUycaqf1B80gBb9vwO1
         svkDuHXqq7JFo8GrNiXZ5sNJtxZbqpjwpOzz48IBSqMrasO2iklOmTtAtJEnl8GDzbA9
         JeoB0t3Fb2HldfPFRDnfGCZMG1n/dI/L0yOhY=
Received: by 10.223.76.135 with SMTP id c7mr2533401fak.14.1320174288169;
        Tue, 01 Nov 2011 12:04:48 -0700 (PDT)
Received: from localhost.localdomain (188-22-150-81.adsl.highway.telekom.at. [188.22.150.81])
        by mx.google.com with ESMTPS id a8sm327916faa.11.2011.11.01.12.04.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 12:04:47 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 12/18] MIPS: Alchemy: MMC for DB1100
Date:   Tue,  1 Nov 2011 20:03:38 +0100
Message-Id: <1320174224-27305-13-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 661

This patch hooks up the 2 MMC sockets on the DB1100 board.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/devboards/db1000.c |  201 ++++++++++++++++++++++++++++++++++
 1 files changed, 201 insertions(+), 0 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 57ed5f1..e531bfa 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -23,10 +23,13 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/leds.h>
+#include <linux/mmc/host.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1000_dma.h>
+#include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/mach-db1x00/bcsr.h>
 #include <asm/reboot.h>
 #include <prom.h>
@@ -194,6 +197,198 @@ static struct platform_device db1x00_audio_dev = {
 	.name		= "db1000-audio",
 };
 
+/******************************************************************************/
+
+static irqreturn_t db1100_mmc_cd(int irq, void *ptr)
+{
+	void (*mmc_cd)(struct mmc_host *, unsigned long);
+	/* link against CONFIG_MMC=m */
+	mmc_cd = symbol_get(mmc_detect_change);
+	mmc_cd(ptr, msecs_to_jiffies(500));
+	symbol_put(mmc_detect_change);
+
+	return IRQ_HANDLED;
+}
+
+static int db1100_mmc_cd_setup(void *mmc_host, int en)
+{
+	int ret = 0;
+
+	if (en) {
+		irq_set_irq_type(AU1100_GPIO19_INT, IRQ_TYPE_EDGE_BOTH);
+		ret = request_irq(AU1100_GPIO19_INT, db1100_mmc_cd, 0,
+				  "sd0_cd", mmc_host);
+	} else
+		free_irq(AU1100_GPIO19_INT, mmc_host);
+	return ret;
+}
+
+static int db1100_mmc1_cd_setup(void *mmc_host, int en)
+{
+	int ret = 0;
+
+	if (en) {
+		irq_set_irq_type(AU1100_GPIO20_INT, IRQ_TYPE_EDGE_BOTH);
+		ret = request_irq(AU1100_GPIO20_INT, db1100_mmc_cd, 0,
+				  "sd1_cd", mmc_host);
+	} else
+		free_irq(AU1100_GPIO20_INT, mmc_host);
+	return ret;
+}
+
+static int db1100_mmc_card_readonly(void *mmc_host)
+{
+	/* testing suggests that this bit is inverted */
+	return (bcsr_read(BCSR_STATUS) & BCSR_STATUS_SD0WP) ? 0 : 1;
+}
+
+static int db1100_mmc_card_inserted(void *mmc_host)
+{
+	return !alchemy_gpio_get_value(19);
+}
+
+static void db1100_mmc_set_power(void *mmc_host, int state)
+{
+	if (state) {
+		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SD0PWR);
+		msleep(400);	/* stabilization time */
+	} else
+		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SD0PWR, 0);
+}
+
+static void db1100_mmcled_set(struct led_classdev *led, enum led_brightness b)
+{
+	if (b != LED_OFF)
+		bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED0, 0);
+	else
+		bcsr_mod(BCSR_LEDS, 0, BCSR_LEDS_LED0);
+}
+
+static struct led_classdev db1100_mmc_led = {
+	.brightness_set	= db1100_mmcled_set,
+};
+
+static int db1100_mmc1_card_readonly(void *mmc_host)
+{
+	return (bcsr_read(BCSR_BOARD) & BCSR_BOARD_SD1WP) ? 1 : 0;
+}
+
+static int db1100_mmc1_card_inserted(void *mmc_host)
+{
+	return !alchemy_gpio_get_value(20);
+}
+
+static void db1100_mmc1_set_power(void *mmc_host, int state)
+{
+	if (state) {
+		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SD1PWR);
+		msleep(400);	/* stabilization time */
+	} else
+		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SD1PWR, 0);
+}
+
+static void db1100_mmc1led_set(struct led_classdev *led, enum led_brightness b)
+{
+	if (b != LED_OFF)
+		bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED1, 0);
+	else
+		bcsr_mod(BCSR_LEDS, 0, BCSR_LEDS_LED1);
+}
+
+static struct led_classdev db1100_mmc1_led = {
+	.brightness_set	= db1100_mmc1led_set,
+};
+
+static struct au1xmmc_platform_data db1100_mmc_platdata[2] = {
+	[0] = {
+		.cd_setup	= db1100_mmc_cd_setup,
+		.set_power	= db1100_mmc_set_power,
+		.card_inserted	= db1100_mmc_card_inserted,
+		.card_readonly	= db1100_mmc_card_readonly,
+		.led		= &db1100_mmc_led,
+	},
+	[1] = {
+		.cd_setup	= db1100_mmc1_cd_setup,
+		.set_power	= db1100_mmc1_set_power,
+		.card_inserted	= db1100_mmc1_card_inserted,
+		.card_readonly	= db1100_mmc1_card_readonly,
+		.led		= &db1100_mmc1_led,
+	},
+};
+
+static struct resource au1100_mmc0_resources[] = {
+	[0] = {
+		.start	= AU1100_SD0_PHYS_ADDR,
+		.end	= AU1100_SD0_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1100_SD_INT,
+		.end	= AU1100_SD_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= DMA_ID_SD0_TX,
+		.end	= DMA_ID_SD0_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= DMA_ID_SD0_RX,
+		.end	= DMA_ID_SD0_RX,
+		.flags	= IORESOURCE_DMA,
+	}
+};
+
+static u64 au1xxx_mmc_dmamask =  DMA_BIT_MASK(32);
+
+static struct platform_device db1100_mmc0_dev = {
+	.name		= "au1xxx-mmc",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &db1100_mmc_platdata[0],
+	},
+	.num_resources	= ARRAY_SIZE(au1100_mmc0_resources),
+	.resource	= au1100_mmc0_resources,
+};
+
+static struct resource au1100_mmc1_res[] = {
+	[0] = {
+		.start	= AU1100_SD1_PHYS_ADDR,
+		.end	= AU1100_SD1_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1100_SD_INT,
+		.end	= AU1100_SD_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= DMA_ID_SD1_TX,
+		.end	= DMA_ID_SD1_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= DMA_ID_SD1_RX,
+		.end	= DMA_ID_SD1_RX,
+		.flags	= IORESOURCE_DMA,
+	}
+};
+
+static struct platform_device db1100_mmc1_dev = {
+	.name		= "au1xxx-mmc",
+	.id		= 1,
+	.dev = {
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &db1100_mmc_platdata[1],
+	},
+	.num_resources	= ARRAY_SIZE(au1100_mmc1_res),
+	.resource	= au1100_mmc1_res,
+};
+
+
 static struct platform_device *db1x00_devs[] = {
 	&db1x00_codec_dev,
 	&alchemy_ac97c_dma_dev,
@@ -203,6 +398,8 @@ static struct platform_device *db1x00_devs[] = {
 
 static struct platform_device *db1100_devs[] = {
 	&au1100_lcd_device,
+	&db1100_mmc0_dev,
+	&db1100_mmc1_dev,
 };
 
 static int __init db1000_dev_init(void)
@@ -224,6 +421,10 @@ static int __init db1000_dev_init(void)
 		d1 = AU1100_GPIO3_INT;
 		s0 = AU1100_GPIO1_INT;
 		s1 = AU1100_GPIO4_INT;
+
+		gpio_direction_input(19);	/* sd0 cd# */
+		gpio_direction_input(20);	/* sd1 cd# */
+
 		platform_add_devices(db1100_devs, ARRAY_SIZE(db1100_devs));
 	} else if (board == BCSR_WHOAMI_DB1000) {
 		c0 = AU1000_GPIO2_INT;
-- 
1.7.7.1
