Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Feb 2011 07:19:12 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:33660 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491142Ab1BVGTH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Feb 2011 07:19:07 +0100
Received: by ywa8 with SMTP id 8so706156ywa.36
        for <multiple recipients>; Mon, 21 Feb 2011 22:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=YoJ4KQyYyjWGBSfsy7P2T3tquDjDzaKFHxYRSF9l8tw=;
        b=K2AGtkNWTO7pGAfBBPU6tFlKFXQPQX8qPmIXCUnNF5weP37EXfByINAPCkepWnzmtY
         Gz/e/BJ9FXE3NJrvXhTsmB7qFxloknkDzjhVj/8pcPMYoWrj24X8rJaNtE5uYrh9eBmA
         dxBPjcTBZJWOUShthbo00jPuZCf1IlzNXhIek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Uq8vAIJ7KXAjf3bU6dqjZs4+J18CTP4uUWP1eTlyGwsk/tO2qAYFhD0aqRXUQ6RZWI
         9Rl40acpSxRp2WshvZSuzVECesU4fXnKtXRUH1eNvQxf4E18FcZ9vgAFo9bnLaPXnrsi
         f0mAjHy3ljlmtsR58JfHepfFS0vBUx3rJLRS4=
Received: by 10.150.52.3 with SMTP id z3mr2822451ybz.401.1298355540571;
        Mon, 21 Feb 2011 22:19:00 -0800 (PST)
Received: from localhost.localdomain ([59.160.135.215])
        by mx.google.com with ESMTPS id u27sm2866262yba.3.2011.02.21.22.18.56
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 22:18:59 -0800 (PST)
From:   "Anoop P.A" <anoop.pa@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Anoop P A <anoop.pa@gmail.com>
Subject: [PATCH resend] Make msp7120_reset generic
Date:   Tue, 22 Feb 2011 12:11:45 +0530
Message-Id: <1298356905-17316-1-git-send-email-anoop.pa@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <4D610B3A.5070705@mvista.com>
References: <4D610B3A.5070705@mvista.com>
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

From: Anoop P A <anoop.pa@gmail.com>

Remove platform dependency code from msp7120 reset code and make it generic.
Now the code can be reused for other boards running msp71xx family SoC.

Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
Fixing comments indentations as suggested by sergei
 arch/mips/pmc-sierra/msp71xx/msp_setup.c |   84 ++++++++++++++++++------------
 1 files changed, 51 insertions(+), 33 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_setup.c b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
index fb37a10..3bf92cd 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_setup.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
@@ -18,30 +18,32 @@
 
 #include <msp_prom.h>
 #include <msp_regs.h>
+#include <msp_gpio_macros.h>
 
 #if defined(CONFIG_PMC_MSP7120_GW)
-#include <msp_regops.h>
+	/* GPIO 9 is the 4th GPIO of register 3*/
 #define MSP_BOARD_RESET_GPIO	9
+#else
+#undef MSP_BOARD_RESET_GPIO
 #endif
 
 extern void msp_serial_setup(void);
 extern void pmctwiled_setup(void);
 
-#if defined(CONFIG_PMC_MSP7120_EVAL) || \
-    defined(CONFIG_PMC_MSP7120_GW) || \
-    defined(CONFIG_PMC_MSP7120_FPGA)
 /*
- * Performs the reset for MSP7120-based boards
+ * Performs the reset for MSP71xx-based boards
  */
-void msp7120_reset(void)
+void msp71xx_reset(void)
 {
 	void *start, *end, *iptr;
 	register int i;
+	register u32 temp __maybe_unused;
 
 	/* Diasble all interrupts */
 	local_irq_disable();
 #ifdef CONFIG_SYS_SUPPORTS_MULTITHREADING
 	dvpe();
+	dmt();
 #endif
 
 	/* Cache the reset code of this function */
@@ -78,49 +80,56 @@ void msp7120_reset(void)
 	/* Wait a bit for the DDRC to settle */
 	for (i = 0; i < 100000000; i++);
 
-#if defined(CONFIG_PMC_MSP7120_GW)
+#if defined(MSP_BOARD_RESET_GPIO)
 	/*
-	 * Set GPIO 9 HI, (tied to board reset logic)
-	 * GPIO 9 is the 4th GPIO of register 3
+	 * Set reset GPIO  HI, (tied to board reset logic)
 	 *
 	 * NOTE: We cannot use the higher-level msp_gpio_mode()/out()
 	 * as GPIO char driver may not be enabled and it would look up
 	 * data inRAM!
 	 */
-	set_value_reg32(GPIO_CFG3_REG, 0xf000, 0x8000);
-	set_reg32(GPIO_DATA3_REG, 8);
+	temp = __raw_readl(MSP_GPIO_MODE_REGISTER[MSP_BOARD_RESET_GPIO]) &
+					~BASIC_MODE_MASK(MSP_BOARD_RESET_GPIO);
+	__raw_writel(temp | BASIC_MODE(MSP_GPIO_OUTPUT, MSP_BOARD_RESET_GPIO),
+				MSP_GPIO_MODE_REGISTER[MSP_BOARD_RESET_GPIO]);
+	/* Now set the reset gpio pin hi */
+	temp = __raw_readl(MSP_GPIO_DATA_REGISTER[MSP_BOARD_RESET_GPIO]);
+	__raw_writel(temp | BASIC_DATA_MASK(MSP_BOARD_RESET_GPIO),
+			MSP_GPIO_DATA_REGISTER[MSP_BOARD_RESET_GPIO]);
 
 	/*
-	 * In case GPIO9 doesn't reset the board (jumper configurable!)
+	 * In case GPIO doesn't reset the board (jumper configurable!)
 	 * fallback to device reset below.
 	 */
 #endif
-	/* Set bit 1 of the MSP7120 reset register */
-	*RST_SET_REG = 0x00000001;
+	/* Set bit 1 of the MSP71xx reset register */
+	__raw_writel(0x00000001, RST_SET_REG);
 
 	__asm__ __volatile__ (
-		"endpoint:					\n"
+		"endpoint:\n"
 	);
 }
-#endif
 
 void msp_restart(char *command)
 {
-	printk(KERN_WARNING "Now rebooting .......\n");
 
-#if defined(CONFIG_PMC_MSP7120_EVAL) || \
-    defined(CONFIG_PMC_MSP7120_GW) || \
-    defined(CONFIG_PMC_MSP7120_FPGA)
-	msp7120_reset();
-#else
-	/* No chip-specific reset code, just jump to the ROM reset vector */
-	set_c0_status(ST0_BEV | ST0_ERL);
-	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
-	flush_cache_all();
-	write_c0_wired(0);
-
-	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
-#endif
+	unsigned long family = identify_family();
+	switch (family)	{
+	case FAMILY_MSP7100:
+		msp71xx_reset();
+		break;
+	default:
+		/* No chip-specific reset code, just jump
+		 * to the ROM reset vector
+		 */
+		set_c0_status(ST0_BEV | ST0_ERL);
+		change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
+		flush_cache_all();
+		write_c0_wired(0);
+
+		__asm__ __volatile__("jr\t%0" : : "r"(0xbfc00000));
+		break;
+	}
 }
 
 void msp_halt(void)
@@ -141,9 +150,7 @@ void msp_power_off(void)
 
 void __init plat_mem_setup(void)
 {
-	_machine_restart = msp_restart;
-	_machine_halt = msp_halt;
-	pm_power_off = msp_power_off;
+	/*TODO: Move mem setup here */
 }
 
 extern struct plat_smp_ops msp_smtc_smp_ops;
@@ -244,3 +251,14 @@ void __init prom_init(void)
 	pmctwiled_setup();
 #endif
 }
+
+static int __init mips_reboot_setup(void)
+{
+	_machine_restart = msp_restart;
+	_machine_halt = msp_halt;
+	pm_power_off = msp_power_off;
+
+	return 0;
+}
+
+arch_initcall(mips_reboot_setup);
-- 
1.7.0.4
