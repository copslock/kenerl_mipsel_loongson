Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 20:09:52 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:32904 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903688Ab1KATEv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2011 20:04:51 +0100
Received: by mail-fx0-f49.google.com with SMTP id q17so947590faa.36
        for <multiple recipients>; Tue, 01 Nov 2011 12:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jTtyZgtv1BWaFkpWh8xd4dOHFchUG1Gnyf4298jwjo0=;
        b=Ojx/QtM/HFZ5XSIBUt6SXZ07gAJCqg0aPioiHcu5ZI2l8jPA6o7EsmxIU2xDT0ezJf
         mrQqHJsUtg0b/lCOMe+slM0y0bO4G0owCm+3RV8Uomr4xSd45GBOtAkyqc4sfOXr+XCQ
         STSSQdpCMotkS070KaHzQ63vSvvIqqCHQz8q4=
Received: by 10.223.5.201 with SMTP id 9mr2697934faw.5.1320174290792;
        Tue, 01 Nov 2011 12:04:50 -0700 (PDT)
Received: from localhost.localdomain (188-22-150-81.adsl.highway.telekom.at. [188.22.150.81])
        by mx.google.com with ESMTPS id a8sm327916faa.11.2011.11.01.12.04.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 12:04:50 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 13/18] MIPS: Alchemy: add RTC device to all devboards
Date:   Tue,  1 Nov 2011 20:03:39 +0100
Message-Id: <1320174224-27305-14-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 662

All Devboards can use the 32kHz counter as a RTC device.

Also delete the custom CMOS RTC header, which can be used for the
DS1693 on the PB1500.  But since it doesn't have a buffer battery
it is as useful as the on-chip RTC which I prefer.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/devboards/db1200.c            |    8 -----
 arch/mips/alchemy/devboards/db1300.c            |    8 -----
 arch/mips/alchemy/devboards/db1550.c            |    8 -----
 arch/mips/alchemy/devboards/platform.c          |   13 +++++++-
 arch/mips/include/asm/mach-pb1x00/mc146818rtc.h |   34 -----------------------
 5 files changed, 11 insertions(+), 60 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-pb1x00/mc146818rtc.h

diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index ec481f3..1181241 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -312,13 +312,6 @@ static struct platform_device db1200_ide_dev = {
 
 /**********************************************************************/
 
-static struct platform_device db1200_rtc_dev = {
-	.name	= "rtc-au1xxx",
-	.id	= -1,
-};
-
-/**********************************************************************/
-
 /* SD carddetects:  they're supposed to be edge-triggered, but ack
  * doesn't seem to work (CPLD Rev 2).  Instead, the screaming one
  * is disabled and its counterpart enabled.  The 500ms timeout is
@@ -755,7 +748,6 @@ static struct platform_device *db1200_devs[] __initdata = {
 	&db1200_mmc0_dev,
 	&au1200_lcd_dev,
 	&db1200_eth_dev,
-	&db1200_rtc_dev,
 	&db1200_nand_dev,
 	&db1200_audiodma_dev,
 	&db1200_audio_dev,
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index d1a7344..23fd4ff 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -385,13 +385,6 @@ static struct platform_device db1300_5waysw_dev = {
 
 /**********************************************************************/
 
-static struct platform_device db1300_rtc_dev = {
-	.name	= "rtc-au1xxx",
-	.id	= -1,
-};
-
-/**********************************************************************/
-
 static struct pata_platform_info db1300_ide_info = {
 	.ioport_shift	= DB1300_IDE_REG_SHIFT,
 };
@@ -696,7 +689,6 @@ static struct platform_device *db1300_dev[] __initdata = {
 	&db1300_eth_dev,
 	&db1300_i2c_dev,
 	&db1300_5waysw_dev,
-	&db1300_rtc_dev,
 	&db1300_nand_dev,
 	&db1300_ide_dev,
 	&db1300_sd0_dev,
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index a4755b0..6815d07 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -372,13 +372,6 @@ static struct platform_device db1550_sndi2s_dev = {
 
 /**********************************************************************/
 
-static struct platform_device db1550_rtc_dev = {
-	.name	= "rtc-au1xxx",
-	.id	= -1,
-};
-
-/**********************************************************************/
-
 static int db1550_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
 {
 	if ((slot < 11) || (slot > 13) || pin == 0)
@@ -427,7 +420,6 @@ static struct platform_device db1550_pci_host_dev = {
 /**********************************************************************/
 
 static struct platform_device *db1550_devs[] __initdata = {
-	&db1550_rtc_dev,
 	&db1550_nand_dev,
 	&db1550_i2c_dev,
 	&db1550_ac97_dev,
diff --git a/arch/mips/alchemy/devboards/platform.c b/arch/mips/alchemy/devboards/platform.c
index 49a4b32..621f70a 100644
--- a/arch/mips/alchemy/devboards/platform.c
+++ b/arch/mips/alchemy/devboards/platform.c
@@ -13,6 +13,13 @@
 #include <asm/reboot.h>
 #include <asm/mach-db1x00/bcsr.h>
 
+
+static struct platform_device db1x00_rtc_dev = {
+	.name	= "rtc-au1xxx",
+	.id	= -1,
+};
+
+
 static void db1x_power_off(void)
 {
 	bcsr_write(BCSR_RESETS, 0);
@@ -25,7 +32,7 @@ static void db1x_reset(char *c)
 	bcsr_write(BCSR_SYSTEM, 0);
 }
 
-static int __init db1x_poweroff_setup(void)
+static int __init db1x_late_setup(void)
 {
 	if (!pm_power_off)
 		pm_power_off = db1x_power_off;
@@ -34,9 +41,11 @@ static int __init db1x_poweroff_setup(void)
 	if (!_machine_restart)
 		_machine_restart = db1x_reset;
 
+	platform_device_register(&db1x00_rtc_dev);
+
 	return 0;
 }
-late_initcall(db1x_poweroff_setup);
+device_initcall(db1x_late_setup);
 
 /* register a pcmcia socket */
 int __init db1x_register_pcmcia_socket(phys_addr_t pcmcia_attr_start,
diff --git a/arch/mips/include/asm/mach-pb1x00/mc146818rtc.h b/arch/mips/include/asm/mach-pb1x00/mc146818rtc.h
deleted file mode 100644
index 622c587..0000000
--- a/arch/mips/include/asm/mach-pb1x00/mc146818rtc.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1998, 2001, 03 by Ralf Baechle
- *
- * RTC routines for PC style attached Dallas chip.
- */
-#ifndef __ASM_MACH_AU1XX_MC146818RTC_H
-#define __ASM_MACH_AU1XX_MC146818RTC_H
-
-#include <asm/io.h>
-#include <asm/mach-au1x00/au1000.h>
-
-#define RTC_PORT(x)	(0x0c000000 + (x))
-#define RTC_IRQ		8
-#define PB1500_RTC_ADDR 0x0c000000
-
-static inline unsigned char CMOS_READ(unsigned long offset)
-{
-	offset <<= 2;
-	return (u8)(au_readl(offset + PB1500_RTC_ADDR) & 0xff);
-}
-
-static inline void CMOS_WRITE(unsigned char data, unsigned long offset)
-{
-	offset <<= 2;
-	au_writel(data, offset + PB1500_RTC_ADDR);
-}
-
-#define RTC_ALWAYS_BCD	1
-
-#endif /* __ASM_MACH_AU1XX_MC146818RTC_H */
-- 
1.7.7.1
