Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 20:11:59 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:32904 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903707Ab1KATFI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2011 20:05:08 +0100
Received: by mail-fx0-f49.google.com with SMTP id q17so947590faa.36
        for <multiple recipients>; Tue, 01 Nov 2011 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NnmXdXD/0DgfnDhDYJcOSPC4DFygYrh2MFd1DUBU5hg=;
        b=onj8yZGBY2BdLstsAqqd19/TwMB5qIrKicYcKdPSQoY5Pl3vg9IoQjR4qqU91ytpw6
         aORjguU5DEUrc1BOejZJt79Z6G7W5JSTl9OR+0OD2dZkUmE8kycUBjJQ9acnhExy6Ojb
         1Usf6tI5Z64BuGOPjhJbdFvEFljDiVqHC0vn4=
Received: by 10.223.15.13 with SMTP id i13mr2440072faa.36.1320174307970;
        Tue, 01 Nov 2011 12:05:07 -0700 (PDT)
Received: from localhost.localdomain (188-22-150-81.adsl.highway.telekom.at. [188.22.150.81])
        by mx.google.com with ESMTPS id a8sm327916faa.11.2011.11.01.12.05.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 12:05:07 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 18/18] MIPS: Alchemy: Touchscreen support on DB1100
Date:   Tue,  1 Nov 2011 20:03:44 +0100
Message-Id: <1320174224-27305-19-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 667

Wire up the ADS7846 touchscreen controller on the DB1100.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/devboards/db1000.c |   56 ++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index f62b180..e110f6d 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -27,6 +27,9 @@
 #include <linux/mmc/host.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_gpio.h>
+#include <linux/spi/ads7846.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1000_dma.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
@@ -423,6 +426,43 @@ static struct platform_device db1000_irda_dev = {
 	.num_resources	= ARRAY_SIZE(au1000_irda_res),
 };
 
+/******************************************************************************/
+
+static struct ads7846_platform_data db1100_touch_pd = {
+	.model		= 7846,
+	.vref_mv	= 3300,
+	.gpio_pendown	= 21,
+};
+
+static struct spi_gpio_platform_data db1100_spictl_pd = {
+	.sck		= 209,
+	.mosi		= 208,
+	.miso		= 207,
+	.num_chipselect = 1,
+};
+
+static struct spi_board_info db1100_spi_info[] __initdata = {
+	[0] = {
+		.modalias	 = "ads7846",
+		.max_speed_hz	 = 3250000,
+		.bus_num	 = 0,
+		.chip_select	 = 0,
+		.mode		 = 0,
+		.irq		 = AU1100_GPIO21_INT,
+		.platform_data	 = &db1100_touch_pd,
+		.controller_data = (void *)210,	/* for spi_gpio: CS# GPIO210 */
+	},
+};
+
+static struct platform_device db1100_spi_dev = {
+	.name		= "spi_gpio",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &db1100_spictl_pd,
+	},
+};
+
+
 static struct platform_device *db1x00_devs[] = {
 	&db1x00_codec_dev,
 	&alchemy_ac97c_dma_dev,
@@ -439,12 +479,14 @@ static struct platform_device *db1100_devs[] = {
 	&db1100_mmc0_dev,
 	&db1100_mmc1_dev,
 	&db1000_irda_dev,
+	&db1100_spi_dev,
 };
 
 static int __init db1000_dev_init(void)
 {
 	int board = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
 	int c0, c1, d0, d1, s0, s1;
+	unsigned long pfc;
 
 	if (board == BCSR_WHOAMI_DB1500) {
 		c0 = AU1500_GPIO2_INT;
@@ -463,6 +505,20 @@ static int __init db1000_dev_init(void)
 
 		gpio_direction_input(19);	/* sd0 cd# */
 		gpio_direction_input(20);	/* sd1 cd# */
+		gpio_direction_input(21);	/* touch pendown# */
+		gpio_direction_input(207);	/* SPI MISO */
+		gpio_direction_output(208, 0);	/* SPI MOSI */
+		gpio_direction_output(209, 1);	/* SPI SCK */
+		gpio_direction_output(210, 1);	/* SPI CS# */
+
+		/* spi_gpio on SSI0 pins */
+		pfc = __raw_readl((void __iomem *)SYS_PINFUNC);
+		pfc |= (1 << 0);	/* SSI0 pins as GPIOs */
+		__raw_writel(pfc, (void __iomem *)SYS_PINFUNC);
+		wmb();
+
+		spi_register_board_info(db1100_spi_info,
+					ARRAY_SIZE(db1100_spi_info));
 
 		platform_add_devices(db1100_devs, ARRAY_SIZE(db1100_devs));
 	} else if (board == BCSR_WHOAMI_DB1000) {
-- 
1.7.7.1
