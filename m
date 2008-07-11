Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 19:34:42 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:59564 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20031665AbYGKSeh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2008 19:34:37 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KHNS0-00055Z-00; Fri, 11 Jul 2008 20:34:36 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 1CEEDC2EB7; Fri, 11 Jul 2008 20:34:32 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] IP22: Add platform device for Indy volume buttons
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080711183432.1CEEDC2EB7@solo.franken.de>
Date:	Fri, 11 Jul 2008 20:34:32 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Create platform device for Indy volume buttons and remove button
handling from ip22-reset.c

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/sgi-ip22/ip22-platform.c |   11 ++++++++
 arch/mips/sgi-ip22/ip22-reset.c    |   51 +----------------------------------
 2 files changed, 13 insertions(+), 49 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-platform.c b/arch/mips/sgi-ip22/ip22-platform.c
index d93d07a..c0eb360 100644
--- a/arch/mips/sgi-ip22/ip22-platform.c
+++ b/arch/mips/sgi-ip22/ip22-platform.c
@@ -182,3 +182,14 @@ static int __init sgi_hal2_devinit(void)
 }
 
 device_initcall(sgi_hal2_devinit);
+
+static int __init sgi_button_devinit(void)
+{
+	if (ip22_is_fullhouse())
+		return 0; /* full house has no volume buttons */
+
+	return IS_ERR(platform_device_register_simple("sgiindybtns",
+						      0, NULL, 0));
+}
+
+device_initcall(sgi_button_devinit);
diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-reset.c
index a435b31..4ad5c33 100644
--- a/arch/mips/sgi-ip22/ip22-reset.c
+++ b/arch/mips/sgi-ip22/ip22-reset.c
@@ -39,7 +39,7 @@
 #define POWERDOWN_FREQ		(HZ / 4)
 #define PANIC_FREQ		(HZ / 8)
 
-static struct timer_list power_timer, blink_timer, debounce_timer, volume_timer;
+static struct timer_list power_timer, blink_timer, debounce_timer;
 
 #define MACHINE_PANICED		1
 #define MACHINE_SHUTTING_DOWN	2
@@ -139,36 +139,6 @@ static inline void power_button(void)
 	add_timer(&power_timer);
 }
 
-void (*indy_volume_button)(int) = NULL;
-
-EXPORT_SYMBOL(indy_volume_button);
-
-static inline void volume_up_button(unsigned long data)
-{
-	del_timer(&volume_timer);
-
-	if (indy_volume_button)
-		indy_volume_button(1);
-
-	if (sgint->istat1 & SGINT_ISTAT1_PWR) {
-		volume_timer.expires = jiffies + (HZ / 100);
-		add_timer(&volume_timer);
-	}
-}
-
-static inline void volume_down_button(unsigned long data)
-{
-	del_timer(&volume_timer);
-
-	if (indy_volume_button)
-		indy_volume_button(-1);
-
-	if (sgint->istat1 & SGINT_ISTAT1_PWR) {
-		volume_timer.expires = jiffies + (HZ / 100);
-		add_timer(&volume_timer);
-	}
-}
-
 static irqreturn_t panel_int(int irq, void *dev_id)
 {
 	unsigned int buttons;
@@ -190,25 +160,8 @@ static irqreturn_t panel_int(int irq, void *dev_id)
 	 * House. Only lowest 2 bits are used. Guiness uses upper four bits
 	 * for volume control". This is not true, all bits are pulled high
 	 * on fullhouse */
-	if (ip22_is_fullhouse() || !(buttons & SGIOC_PANEL_POWERINTR)) {
+	if (!(buttons & SGIOC_PANEL_POWERINTR))
 		power_button();
-		return IRQ_HANDLED;
-	}
-	/* TODO: mute/unmute */
-	/* Volume up button was pressed */
-	if (!(buttons & SGIOC_PANEL_VOLUPINTR)) {
-		init_timer(&volume_timer);
-		volume_timer.function = volume_up_button;
-		volume_timer.expires = jiffies + (HZ / 100);
-		add_timer(&volume_timer);
-	}
-	/* Volume down button was pressed */
-	if (!(buttons & SGIOC_PANEL_VOLDNINTR)) {
-		init_timer(&volume_timer);
-		volume_timer.function = volume_down_button;
-		volume_timer.expires = jiffies + (HZ / 100);
-		add_timer(&volume_timer);
-	}
 
 	return IRQ_HANDLED;
 }
