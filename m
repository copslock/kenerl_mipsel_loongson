Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2009 22:44:29 +0000 (GMT)
Received: from orbit.nwl.cc ([91.121.169.95]:61409 "EHLO mail.nwl.cc")
	by ftp.linux-mips.org with ESMTP id S21366189AbZASWnh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2009 22:43:37 +0000
Received: from base (localhost [127.0.0.1])
	by mail.nwl.cc (Postfix) with ESMTP id C9AB7400E106;
	Mon, 19 Jan 2009 23:43:31 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Linux-Mips List <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org, florian@openwrt.org
Subject: [PATCH 1/5] MIPS: rb532: fix init of rb532_dev3_ctl_res
Date:	Mon, 19 Jan 2009 23:42:50 +0100
X-Mailer: git-send-email 1.5.6.4
Message-Id: <20090119224331.C9AB7400E106@mail.nwl.cc>
Return-Path: <n0-1@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

This register just contains the address of the actual resource, so
initialisation has to be the same as cf_slot0_res and nand_slot0_res.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/rb532/gpio.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index d75eb19..40deb11 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -55,8 +55,6 @@ static struct resource rb532_gpio_reg0_res[] = {
 static struct resource rb532_dev3_ctl_res[] = {
 	{
 		.name	= "dev3_ctl",
-		.start	= REGBASE + DEV3BASE,
-		.end	= REGBASE + DEV3BASE + sizeof(struct dev_reg) - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
@@ -243,6 +241,9 @@ int __init rb532_gpio_init(void)
 	/* Register our GPIO chip */
 	gpiochip_add(&rb532_gpio_chip->chip);
 
+	rb532_dev3_ctl_res[0].start = readl(IDT434_REG_BASE + DEV3BASE);
+	rb532_dev3_ctl_res[0].end = rb532_dev3_ctl_res[0].start + 0x1000;
+
 	r = rb532_dev3_ctl_res;
 	dev3.base = ioremap_nocache(r->start, r->end - r->start);
 
-- 
1.5.6.4
