Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2011 15:17:24 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:40222 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903728Ab1LIORP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Dec 2011 15:17:15 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wolfram Sang <w.sang@pengutronix.de>, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>,
        spi-devel-general@lists.sourceforge.net
Subject: [PATCH V2 2/2] SPI: MIPS: lantiq: add platform code for FALC-ON spi driver
Date:   Fri,  9 Dec 2011 15:17:03 +0100
Message-Id: <1323440223-10636-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1323440223-10636-1-git-send-email-blogic@openwrt.org>
References: <1323440223-10636-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7686

Add code to register the spi driver on FALC-ON based boards.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: spi-devel-general@lists.sourceforge.net
---
 arch/mips/lantiq/falcon/devices.c        |   13 +++++++++++++
 arch/mips/lantiq/falcon/devices.h        |    4 ++++
 arch/mips/lantiq/falcon/mach-easy98000.c |   27 +++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lantiq/falcon/devices.c b/arch/mips/lantiq/falcon/devices.c
index 851d7a6..a585c41 100644
--- a/arch/mips/lantiq/falcon/devices.c
+++ b/arch/mips/lantiq/falcon/devices.c
@@ -143,3 +143,16 @@ falcon_register_i2c(void)
 		falcon_i2c_resources, ARRAY_SIZE(falcon_i2c_resources));
 	ltq_sysctl_activate(SYSCTL_SYS1, ACTS_I2C_ACT);
 }
+
+/* spi flash */
+static struct platform_device ltq_spi = {
+	.name			= "falcon_spi",
+	.num_resources		= 0,
+};
+
+void __init
+falcon_register_spi_flash(struct spi_board_info *data)
+{
+	spi_register_board_info(data, 1);
+	platform_device_register(&ltq_spi);
+}
diff --git a/arch/mips/lantiq/falcon/devices.h b/arch/mips/lantiq/falcon/devices.h
index 2fdcb08..fd27e91 100644
--- a/arch/mips/lantiq/falcon/devices.h
+++ b/arch/mips/lantiq/falcon/devices.h
@@ -11,11 +11,15 @@
 #ifndef _FALCON_DEVICES_H__
 #define _FALCON_DEVICES_H__
 
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
+
 #include "../devices.h"
 
 extern void falcon_register_nand(void);
 extern void falcon_register_gpio(void);
 extern void falcon_register_gpio_extra(void);
 extern void falcon_register_i2c(void);
+extern void falcon_register_spi_flash(struct spi_board_info *data);
 
 #endif
diff --git a/arch/mips/lantiq/falcon/mach-easy98000.c b/arch/mips/lantiq/falcon/mach-easy98000.c
index 411af10..fc5720d 100644
--- a/arch/mips/lantiq/falcon/mach-easy98000.c
+++ b/arch/mips/lantiq/falcon/mach-easy98000.c
@@ -40,6 +40,21 @@ struct physmap_flash_data easy98000_nor_flash_data = {
 	.parts		= easy98000_nor_partitions,
 };
 
+static struct flash_platform_data easy98000_spi_flash_platform_data = {
+	.name = "sflash",
+	.parts = easy98000_nor_partitions,
+	.nr_parts = ARRAY_SIZE(easy98000_nor_partitions)
+};
+
+static struct spi_board_info easy98000_spi_flash_data __initdata = {
+	.modalias		= "m25p80",
+	.bus_num		= 0,
+	.chip_select		= 0,
+	.max_speed_hz		= 10 * 1000 * 1000,
+	.mode			= SPI_MODE_3,
+	.platform_data		= &easy98000_spi_flash_platform_data
+};
+
 /* setup gpio based spi bus/device for access to the eeprom on the board */
 #define SPI_GPIO_MRST		102
 #define SPI_GPIO_MTSR		103
@@ -94,6 +109,13 @@ easy98000_init(void)
 }
 
 static void __init
+easy98000sf_init(void)
+{
+	easy98000_init_common();
+	falcon_register_spi_flash(&easy98000_spi_flash_data);
+}
+
+static void __init
 easy98000nand_init(void)
 {
 	easy98000_init_common();
@@ -105,6 +127,11 @@ MIPS_MACHINE(LANTIQ_MACH_EASY98000,
 			"EASY98000 Eval Board",
 			easy98000_init);
 
+MIPS_MACHINE(LANTIQ_MACH_EASY98000SF,
+			"EASY98000SF",
+			"EASY98000 Eval Board (Serial Flash)",
+			easy98000sf_init);
+
 MIPS_MACHINE(LANTIQ_MACH_EASY98000NAND,
 			"EASY98000NAND",
 			"EASY98000 Eval Board (NAND Flash)",
-- 
1.7.7.1
