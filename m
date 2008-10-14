Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 10:44:50 +0100 (BST)
Received: from hall.aurel32.net ([88.191.82.174]:7561 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S21457796AbYJNJop (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Oct 2008 10:44:45 +0100
Received: from volta.aurel32.net ([2002:52e8:2fb:1:21e:8cff:feb0:693b])
	by hall.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1KpgSK-0007kg-GK; Tue, 14 Oct 2008 11:44:44 +0200
Received: from aurel32 by volta.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1KpgSJ-000761-VQ; Tue, 14 Oct 2008 11:44:43 +0200
Date:	Tue, 14 Oct 2008 11:44:43 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 4/5] [MIPS] Add WGT634U reset button support
Message-ID: <20081014094443.GE26560@volta.aurel32.net>
References: <20081014094043.GA26560@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20081014094043.GA26560@volta.aurel32.net>
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

This patch adds support for the reset button of WGT634U machine, using
GPIO interrupts. Based on a patch from Michel Lespinasse.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/mips/bcm47xx/wgt634u.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm47xx/wgt634u.c b/arch/mips/bcm47xx/wgt634u.c
index f9e309a..db1a72f 100644
--- a/arch/mips/bcm47xx/wgt634u.c
+++ b/arch/mips/bcm47xx/wgt634u.c
@@ -11,6 +11,9 @@
 #include <linux/leds.h>
 #include <linux/mtd/physmap.h>
 #include <linux/ssb/ssb.h>
+#include <linux/interrupt.h>
+#include <linux/reboot.h>
+#include <asm/gpio.h>
 #include <asm/mach-bcm47xx/bcm47xx.h>
 
 /* GPIO definitions for the WGT634U */
@@ -99,6 +102,30 @@ static struct platform_device *wgt634u_devices[] __initdata = {
 	&wgt634u_gpio_leds,
 };
 
+static irqreturn_t gpio_interrupt(int irq, void *ignored)
+{
+	int state;
+
+	/* Interrupts are shared, check if the current one is
+	   a GPIO interrupt. */
+	if (!ssb_chipco_irq_status(&ssb_bcm47xx.chipco,
+				   SSB_CHIPCO_IRQ_GPIO))
+		return IRQ_NONE;
+
+	state = gpio_get_value(WGT634U_GPIO_RESET);
+
+	/* Interrupt are level triggered, revert the interrupt polarity
+	   to clear the interrupt. */
+	gpio_polarity(WGT634U_GPIO_RESET, state);
+
+	if (!state) {
+		printk(KERN_INFO "Reset button pressed");
+		ctrl_alt_del();
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int __init wgt634u_init(void)
 {
 	/* There is no easy way to detect that we are running on a WGT634U
@@ -115,6 +142,16 @@ static int __init wgt634u_init(void)
 
 		printk(KERN_INFO "WGT634U machine detected.\n");
 
+		if (!request_irq(gpio_to_irq(WGT634U_GPIO_RESET),
+				 gpio_interrupt, IRQF_SHARED,
+				 "WGT634U GPIO", &ssb_bcm47xx.chipco)) {
+			gpio_direction_input(WGT634U_GPIO_RESET);
+			gpio_intmask(WGT634U_GPIO_RESET, 1);
+			ssb_chipco_irq_mask(&ssb_bcm47xx.chipco,
+					    SSB_CHIPCO_IRQ_GPIO,
+					    SSB_CHIPCO_IRQ_GPIO);
+		}
+
 		wgt634u_flash_data.width = mcore->flash_buswidth;
 		wgt634u_flash_resource.start = mcore->flash_window;
 		wgt634u_flash_resource.end = mcore->flash_window
-- 
1.5.6.5


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
