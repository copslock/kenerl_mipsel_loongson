Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jun 2009 13:12:17 +0100 (WEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:43853 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023313AbZFFMKT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 6 Jun 2009 13:10:19 +0100
Received: by fxm23 with SMTP id 23so2125604fxm.0
        for <multiple recipients>; Sat, 06 Jun 2009 05:10:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MUlS6nT+16Yw4aPDB2QGQd789TSVQinVh/8aNr9oxYA=;
        b=VqYu7OgfyssL3pBry5OSM3InqrtKp9r9iljT3ZaSfDZaq3Rl8ok9+eESt5YCoY04lt
         3mRmlQS0agWlW2zlHw2DihOSLbn4qYWOG+HSXbO8K2Pn6swPr2s9s7lbgNWpL7rsEBtL
         y1IGC8du9KlD2Bl5aJn5hW3JJsznlmulDXSKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YJv0ZUV2pU+x4QnraZ0WXObcNATQw7IsbljF8aHPbom5IrWZdsQi3jayWuLimd+hAW
         gw8i4SSAjlJnkOZ/5p/dggRQM+YvKdspC5kq6yaxf35Igzh+cE+ycsV7ef+T6WnTIpgF
         p5e3acKMclU5N2SIkkOueDC377ueQwrjsDRvc=
Received: by 10.86.59.18 with SMTP id h18mr4963760fga.44.1244290213440;
        Sat, 06 Jun 2009 05:10:13 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id e11sm4489485fga.11.2009.06.06.05.10.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 05:10:13 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 5/5] Alchemy: devboards: convert to gpio calls.
Date:	Sat,  6 Jun 2009 14:09:58 +0200
Message-Id: <1244290198-27162-6-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1244290198-27162-5-git-send-email-manuel.lauss@gmail.com>
References: <1244290198-27162-1-git-send-email-manuel.lauss@gmail.com>
 <1244290198-27162-2-git-send-email-manuel.lauss@gmail.com>
 <1244290198-27162-3-git-send-email-manuel.lauss@gmail.com>
 <1244290198-27162-4-git-send-email-manuel.lauss@gmail.com>
 <1244290198-27162-5-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Replace a few open-coded GPIO register accesses with gpio calls.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/reset.c                 |    5 +++--
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   12 ++++++------
 arch/mips/alchemy/devboards/pb1000/board_setup.c |   10 +++++++---
 arch/mips/alchemy/devboards/pb1100/board_setup.c |    3 ++-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |   10 ++++++----
 arch/mips/alchemy/devboards/pm.c                 |    3 ++-
 6 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/mips/alchemy/common/reset.c b/arch/mips/alchemy/common/reset.c
index 0191c93..4791011 100644
--- a/arch/mips/alchemy/common/reset.c
+++ b/arch/mips/alchemy/common/reset.c
@@ -27,8 +27,9 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <asm/cacheflush.h>
+#include <linux/gpio.h>
 
+#include <asm/cacheflush.h>
 #include <asm/mach-au1x00/au1000.h>
 
 void au1000_restart(char *command)
@@ -161,7 +162,7 @@ void au1000_halt(void)
 #else
 	printk(KERN_NOTICE "\n** You can safely turn off the power\n");
 #ifdef CONFIG_MIPS_MIRAGE
-	au_writel((1 << 26) | (1 << 10), GPIO2_OUTPUT);
+	gpio_direction_output(210, 1);
 #endif
 #ifdef CONFIG_MIPS_DB1200
 	au_writew(au_readw(0xB980001C) | (1 << 14), 0xB980001C);
diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index a75ffbf..de30d8e 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -27,6 +27,7 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/gpio.h>
 #include <linux/init.h>
 
 #include <asm/mach-au1x00/au1000.h>
@@ -94,12 +95,12 @@ void __init board_setup(void)
 #endif
 	bcsr->pcmcia = 0x0000; /* turn off PCMCIA power */
 
-#ifdef CONFIG_MIPS_MIRAGE
 	/* Enable GPIO[31:0] inputs */
-	au_writel(0, SYS_PININPUTEN);
+	alchemy_gpio1_input_enable();
 
-	/* GPIO[20] is output, tristate the other input primary GPIOs */
-	au_writel(~(1 << 20), SYS_TRIOUTCLR);
+#ifdef CONFIG_MIPS_MIRAGE
+	/* GPIO[20] is output */
+	alchemy_gpio_direction_output(20, 0);
 
 	/* Set GPIO[210:208] instead of SSI_0 */
 	pin_func = au_readl(SYS_PINFUNC) | SYS_PF_S0;
@@ -118,8 +119,7 @@ void __init board_setup(void)
 	 * Enable speaker amplifier.  This should
 	 * be part of the audio driver.
 	 */
-	au_writel(au_readl(GPIO2_DIR) | 0x200, GPIO2_DIR);
-	au_writel(0x02000200, GPIO2_OUTPUT);
+	alchemy_gpio_direction_output(209, 1);
 #endif
 
 	au_sync();
diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c b/arch/mips/alchemy/devboards/pb1000/board_setup.c
index aed2fde..cd27354 100644
--- a/arch/mips/alchemy/devboards/pb1000/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1000/board_setup.c
@@ -24,6 +24,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <asm/mach-au1x00/au1000.h>
@@ -130,8 +131,11 @@ void __init board_setup(void)
 	pin_func |= SYS_PF_USB;
 
 	au_writel(pin_func, SYS_PINFUNC);
-	au_writel(0x2800, SYS_TRIOUTCLR);
-	au_writel(0x0030, SYS_OUTPUTCLR);
+
+	alchemy_gpio_direction_input(11);
+	alchemy_gpio_direction_input(13);
+	alchemy_gpio_direction_output(4, 0);
+	alchemy_gpio_direction_output(5, 0);
 #endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
 
 	/* Make GPIO 15 an input (for interrupt line) */
@@ -140,7 +144,7 @@ void __init board_setup(void)
 	pin_func |= SYS_PF_I2S;
 	au_writel(pin_func, SYS_PINFUNC);
 
-	au_writel(0x8000, SYS_TRIOUTCLR);
+	alchemy_gpio_direction_input(15);
 
 	static_cfg0 = au_readl(MEM_STCFG0) & ~0xc00;
 	au_writel(static_cfg0, MEM_STCFG0);
diff --git a/arch/mips/alchemy/devboards/pb1100/board_setup.c b/arch/mips/alchemy/devboards/pb1100/board_setup.c
index 4df57fa..6126308 100644
--- a/arch/mips/alchemy/devboards/pb1100/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1100/board_setup.c
@@ -23,6 +23,7 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -88,7 +89,7 @@ void __init board_setup(void)
 
 	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
 	au_writel(8, SYS_AUXPLL);
-	au_writel(0, SYS_PININPUTEN);
+	alchemy_gpio1_input_enable();
 	udelay(100);
 
 #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
diff --git a/arch/mips/alchemy/devboards/pb1500/board_setup.c b/arch/mips/alchemy/devboards/pb1500/board_setup.c
index fed3b09..d7a5656 100644
--- a/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1500/board_setup.c
@@ -23,8 +23,9 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 
 #include <asm/mach-au1x00/au1000.h>
@@ -90,11 +91,12 @@ void __init board_setup(void)
 	au_writel(0, SYS_PINSTATERD);
 	udelay(100);
 
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-
 	/* GPIO201 is input for PCMCIA card detect */
 	/* GPIO203 is input for PCMCIA interrupt request */
-	au_writel(au_readl(GPIO2_DIR) & ~((1 << 1) | (1 << 3)), GPIO2_DIR);
+	alchemy_gpio_direction_input(201);
+	alchemy_gpio_direction_input(203);
+
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
 
 	/* Zero and disable FREQ2 */
 	sys_freqctrl = au_readl(SYS_FREQCTRL0);
diff --git a/arch/mips/alchemy/devboards/pm.c b/arch/mips/alchemy/devboards/pm.c
index d5eb9c3..632f986 100644
--- a/arch/mips/alchemy/devboards/pm.c
+++ b/arch/mips/alchemy/devboards/pm.c
@@ -9,6 +9,7 @@
 #include <linux/suspend.h>
 #include <linux/sysfs.h>
 #include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/gpio.h>
 
 /*
  * Generic suspend userspace interface for Alchemy development boards.
@@ -26,7 +27,7 @@ static unsigned long db1x_pm_last_wakesrc;
 static int db1x_pm_enter(suspend_state_t state)
 {
 	/* enable GPIO based wakeup */
-	au_writel(1, SYS_PININPUTEN);
+	alchemy_gpio1_input_enable();
 
 	/* clear and setup wake cause and source */
 	au_writel(0, SYS_WAKEMSK);
-- 
1.6.3.1
