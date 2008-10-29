Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 20:00:28 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:13466 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S22678111AbYJ2UAY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Oct 2008 20:00:24 +0000
Received: from base (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id DA4FF3891A92;
	Wed, 29 Oct 2008 21:00:12 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Linux-Mips List <linux-mips@linux-mips.org>
Subject: [PATCH] provide functions for gpio configuration
Date:	Wed, 29 Oct 2008 21:00:09 +0100
Message-Id: <1225310409-4440-1-git-send-email-n0-1@freewrt.org>
X-Mailer: git-send-email 1.5.6.4
Return-Path: <phil@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

As gpiolib doesn't support pin multiplexing, it provides no way to
access the GPIOFUNC register. Also there is no support for setting
interrupt status and level. These functions provide access to them and
are needed by the CompactFlash driver.

The function rb532_gpio_set_cfg is redundant with
rb532_gpio_direction_{input,output} but was added for simplicity's sake.
Maybe gpiolib support could be dropped completely as there are not many
users of it.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/include/asm/mach-rc32434/rb.h |    1 +
 arch/mips/rb532/gpio.c                  |   39 +++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-rc32434/rb.h b/arch/mips/include/asm/mach-rc32434/rb.h
index 0cb9466..f25a849 100644
--- a/arch/mips/include/asm/mach-rc32434/rb.h
+++ b/arch/mips/include/asm/mach-rc32434/rb.h
@@ -41,6 +41,7 @@
 #define BTCOMPARE	0x010044
 #define GPIOBASE	0x050000
 /* Offsets relative to GPIOBASE */
+#define GPIOFUNC	0x00
 #define GPIOCFG		0x04
 #define GPIOD		0x08
 #define GPIOILEVEL	0x0C
diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 70c4a67..f56f73b 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -287,6 +287,45 @@ static struct rb532_gpio_chip rb532_gpio_chip[] = {
 	},
 };
 
+static void rb532_do_gpio_set(int bit, unsigned gpio, void __iomem *addr)
+{
+	unsigned long flags;
+	u32 val;
+
+	local_irq_save(flags);
+	val = readl(addr);
+	if (bit)
+		val |= (1 << gpio);
+	else
+		val &= ~(1 << gpio);
+	writel(val, addr);
+	local_irq_restore(flags);
+}
+
+void  rb532_gpio_set_func(int bit, unsigned gpio)
+{
+	rb532_do_gpio_set(bit, gpio, rb532_gpio_chip->regbase + GPIOFUNC);
+}
+EXPORT_SYMBOL(rb532_gpio_set_func);
+
+void  rb532_gpio_set_cfg(int bit, unsigned gpio)
+{
+	rb532_do_gpio_set(bit, gpio, rb532_gpio_chip->regbase + GPIOCFG);
+}
+EXPORT_SYMBOL(rb532_gpio_set_cfg);
+
+void  rb532_gpio_set_ilevel(int bit, unsigned gpio)
+{
+	rb532_do_gpio_set(bit, gpio, rb532_gpio_chip->regbase + GPIOILEVEL);
+}
+EXPORT_SYMBOL(rb532_gpio_set_ilevel);
+
+void  rb532_gpio_set_istat(int bit, unsigned gpio)
+{
+	rb532_do_gpio_set(bit, gpio, rb532_gpio_chip->regbase + GPIOISTAT);
+}
+EXPORT_SYMBOL(rb532_gpio_set_istat);
+
 int __init rb532_gpio_init(void)
 {
 	struct resource *r;
-- 
1.5.6.4
