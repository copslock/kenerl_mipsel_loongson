Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2009 22:43:10 +0000 (GMT)
Received: from orbit.nwl.cc ([91.121.169.95]:58081 "EHLO mail.nwl.cc")
	by ftp.linux-mips.org with ESMTP id S21365788AbZASWnH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2009 22:43:07 +0000
Received: from base (localhost [127.0.0.1])
	by mail.nwl.cc (Postfix) with ESMTP id 1B5A9400E106;
	Mon, 19 Jan 2009 23:43:02 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Linux-Mips List <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org, florian@openwrt.org
Subject: [PATCH 3/5] MIPS: rb532: move dev3 init code to devices.c
Date:	Mon, 19 Jan 2009 23:42:52 +0100
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <1232404974-18497-2-git-send-email-n0-1@freewrt.org>
References: <1232404974-18497-1-git-send-email-n0-1@freewrt.org>
 <1232404974-18497-2-git-send-email-n0-1@freewrt.org>
Message-Id: <20090119224302.1B5A9400E106@mail.nwl.cc>
Return-Path: <n0-1@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

This code doesn't belong to gpio.c, as it's completely unrelated to
GPIO. As dev1 and dev2 init code is in devices.c, it seems to be a more
adequate place.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/rb532/devices.c |   39 +++++++++++++++++++++++++++++++++++++++
 arch/mips/rb532/gpio.c    |   39 ---------------------------------------
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 3c74561..1a0209e 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -42,6 +42,34 @@
 
 extern unsigned int idt_cpu_freq;
 
+static struct mpmc_device dev3;
+
+void set_latch_u5(unsigned char or_mask, unsigned char nand_mask)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev3.lock, flags);
+
+	dev3.state = (dev3.state | or_mask) & ~nand_mask;
+	writeb(dev3.state, dev3.base);
+
+	spin_unlock_irqrestore(&dev3.lock, flags);
+}
+EXPORT_SYMBOL(set_latch_u5);
+
+unsigned char get_latch_u5(void)
+{
+	return dev3.state;
+}
+EXPORT_SYMBOL(get_latch_u5);
+
+static struct resource rb532_dev3_ctl_res[] = {
+	{
+		.name	= "dev3_ctl",
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct resource korina_dev0_res[] = {
 	{
 		.name = "korina_regs",
@@ -314,6 +342,17 @@ static int __init plat_setup_devices(void)
 	nand_slot0_res[0].start = readl(IDT434_REG_BASE + DEV2BASE);
 	nand_slot0_res[0].end = nand_slot0_res[0].start + 0x1000;
 
+	/* Read the third (multi purpose) resources from the DC */
+	rb532_dev3_ctl_res[0].start = readl(IDT434_REG_BASE + DEV3BASE);
+	rb532_dev3_ctl_res[0].end = rb532_dev3_ctl_res[0].start + 0x1000;
+
+	dev3.base = ioremap_nocache(rb532_dev3_ctl_res[0].start, 0x1000);
+
+	if (!dev3.base) {
+		printk(KERN_ERR "rb532: cannot remap device controller 3\n");
+		return -ENXIO;
+	}
+
 	/* Initialise the NAND device */
 	rb532_nand_setup();
 
diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 7e0cb4f..b9cb428 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -41,8 +41,6 @@ struct rb532_gpio_chip {
 	void __iomem	 *regbase;
 };
 
-struct mpmc_device dev3;
-
 static struct resource rb532_gpio_reg0_res[] = {
 	{
 		.name 	= "gpio_reg0",
@@ -52,13 +50,6 @@ static struct resource rb532_gpio_reg0_res[] = {
 	}
 };
 
-static struct resource rb532_dev3_ctl_res[] = {
-	{
-		.name	= "dev3_ctl",
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
 void set_434_reg(unsigned reg_offs, unsigned bit, unsigned len, unsigned val)
 {
 	unsigned long flags;
@@ -86,25 +77,6 @@ unsigned get_434_reg(unsigned reg_offs)
 }
 EXPORT_SYMBOL(get_434_reg);
 
-void set_latch_u5(unsigned char or_mask, unsigned char nand_mask)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&dev3.lock, flags);
-
-	dev3.state = (dev3.state | or_mask) & ~nand_mask;
-	writeb(dev3.state, dev3.base);
-
-	spin_unlock_irqrestore(&dev3.lock, flags);
-}
-EXPORT_SYMBOL(set_latch_u5);
-
-unsigned char get_latch_u5(void)
-{
-	return dev3.state;
-}
-EXPORT_SYMBOL(get_latch_u5);
-
 /* rb532_set_bit - sanely set a bit
  *
  * bitval: new value for the bit
@@ -241,17 +213,6 @@ int __init rb532_gpio_init(void)
 	/* Register our GPIO chip */
 	gpiochip_add(&rb532_gpio_chip->chip);
 
-	rb532_dev3_ctl_res[0].start = readl(IDT434_REG_BASE + DEV3BASE);
-	rb532_dev3_ctl_res[0].end = rb532_dev3_ctl_res[0].start + 0x1000;
-
-	r = rb532_dev3_ctl_res;
-	dev3.base = ioremap_nocache(r->start, r->end - r->start);
-
-	if (!dev3.base) {
-		printk(KERN_ERR "rb532: cannot remap device controller 3\n");
-		return -ENXIO;
-	}
-
 	return 0;
 }
 arch_initcall(rb532_gpio_init);
-- 
1.5.6.4
