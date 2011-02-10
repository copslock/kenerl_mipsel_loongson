Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Feb 2011 10:08:08 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:58517 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491009Ab1BJJHO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Feb 2011 10:07:14 +0100
Received: by bwz5 with SMTP id 5so1758181bwz.36
        for <multiple recipients>; Thu, 10 Feb 2011 01:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=hu//ZVmo3mzMJjdgUFPEC0g1/PRPDmo2C38deEz9f0M=;
        b=bc8iFK7r19Swr7lB2QJeyyw8jUqZ3id7CT6XWbR9ZyyLbIGUGSTcxSBb/ziXItIrm5
         A2yCzIyGv73+4dD6T/K1Y9XF94gxhibD8KHMOgLWFMZqDAGd5ZFJW2a66Jv/TxgHiXIZ
         nDnuLR/rQCFZboovdt+l5kq78g4cjPbsABRyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gbKoY5yEub1z4Vcl/8Xv8lQ+lyRMx56EZiQl++6GSmpcDa842Yzzu1CGywwJViQZ/s
         NM/dObZUWlPxOMs/8CP+OpvZQ5RtptqGRTr70fkB+5qzAzJRGh93fsGz7a3BdRJQB3yC
         Uct/xyWP0NolygpKsQy/7rg3ax02bmUfzReeE=
Received: by 10.204.61.199 with SMTP id u7mr1677607bkh.6.1297328828663;
        Thu, 10 Feb 2011 01:07:08 -0800 (PST)
Received: from localhost.localdomain (178-191-14-1.adsl.highway.telekom.at [178.191.14.1])
        by mx.google.com with ESMTPS id v1sm817617bkt.5.2011.02.10.01.07.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Feb 2011 01:07:08 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     =?UTF-8?q?Ralf=20B=E4chle?= <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 2/2] Alchemy: Convert to new irq methods.
Date:   Thu, 10 Feb 2011 10:07:02 +0100
Message-Id: <1297328822-4621-3-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297328822-4621-1-git-send-email-manuel.lauss@googlemail.com>
References: <1297328822-4621-1-git-send-email-manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Convert Alchmey core and board code to use new .irq_xxx methods.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Run-tested on DB1200.

 arch/mips/Kconfig                  |    1 +
 arch/mips/alchemy/common/irq.c     |   83 +++++++++++++++++++-----------------
 arch/mips/alchemy/devboards/bcsr.c |   18 ++++----
 3 files changed, 54 insertions(+), 48 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f5ecc05..401fc8f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -44,6 +44,7 @@ config MIPS_ALCHEMY
 	select GENERIC_GPIO
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select SYS_SUPPORTS_ZBOOT
+	select GENERIC_HARDIRQS_NO_DEPRECATED
 
 config AR7
 	bool "Texas Instruments AR7"
diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index 9f78ada..baef9a5 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -39,7 +39,7 @@
 #include <asm/mach-pb1x00/pb1000.h>
 #endif
 
-static int au1x_ic_settype(unsigned int irq, unsigned int flow_type);
+static int ic_settype(unsigned int irq, unsigned int flow_type);
 
 /* NOTE on interrupt priorities: The original writers of this code said:
  *
@@ -218,17 +218,17 @@ struct au1xxx_irqmap au1200_irqmap[] __initdata = {
 };
 
 
-static void au1x_ic0_unmask(unsigned int irq_nr)
+static void alchemy_ic0_unmask(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC0_INT_BASE;
 	au_writel(1 << bit, IC0_MASKSET);
 	au_writel(1 << bit, IC0_WAKESET);
 	au_sync();
 }
 
-static void au1x_ic1_unmask(unsigned int irq_nr)
+static void alchemy_ic1_unmask(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC1_INT_BASE;
 	au_writel(1 << bit, IC1_MASKSET);
 	au_writel(1 << bit, IC1_WAKESET);
 
@@ -236,31 +236,31 @@ static void au1x_ic1_unmask(unsigned int irq_nr)
  * nowhere in the current kernel sources is it disabled.	--mlau
  */
 #if defined(CONFIG_MIPS_PB1000)
-	if (irq_nr == AU1000_GPIO15_INT)
+	if (d->irq == AU1000_GPIO15_INT)
 		au_writel(0x4000, PB1000_MDR); /* enable int */
 #endif
 	au_sync();
 }
 
-static void au1x_ic0_mask(unsigned int irq_nr)
+static void alchemy_ic0_mask(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC0_INT_BASE;
 	au_writel(1 << bit, IC0_MASKCLR);
 	au_writel(1 << bit, IC0_WAKECLR);
 	au_sync();
 }
 
-static void au1x_ic1_mask(unsigned int irq_nr)
+static void alchemy_ic1_mask(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC1_INT_BASE;
 	au_writel(1 << bit, IC1_MASKCLR);
 	au_writel(1 << bit, IC1_WAKECLR);
 	au_sync();
 }
 
-static void au1x_ic0_ack(unsigned int irq_nr)
+static void alchemy_ic0_ack(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC0_INT_BASE;
 
 	/*
 	 * This may assume that we don't get interrupts from
@@ -271,9 +271,9 @@ static void au1x_ic0_ack(unsigned int irq_nr)
 	au_sync();
 }
 
-static void au1x_ic1_ack(unsigned int irq_nr)
+static void alchemy_ic1_ack(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC1_INT_BASE;
 
 	/*
 	 * This may assume that we don't get interrupts from
@@ -284,9 +284,9 @@ static void au1x_ic1_ack(unsigned int irq_nr)
 	au_sync();
 }
 
-static void au1x_ic0_maskack(unsigned int irq_nr)
+static void alchemy_ic0_maskack(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC0_INT_BASE;
 
 	au_writel(1 << bit, IC0_WAKECLR);
 	au_writel(1 << bit, IC0_MASKCLR);
@@ -295,9 +295,9 @@ static void au1x_ic0_maskack(unsigned int irq_nr)
 	au_sync();
 }
 
-static void au1x_ic1_maskack(unsigned int irq_nr)
+static void alchemy_ic1_maskack(struct irq_data *d)
 {
-	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
+	unsigned int bit = d->irq - AU1000_INTC1_INT_BASE;
 
 	au_writel(1 << bit, IC1_WAKECLR);
 	au_writel(1 << bit, IC1_MASKCLR);
@@ -306,9 +306,9 @@ static void au1x_ic1_maskack(unsigned int irq_nr)
 	au_sync();
 }
 
-static int au1x_ic1_setwake(unsigned int irq, unsigned int on)
+static int alchemy_ic1_setwake(struct irq_data *d, unsigned int on)
 {
-	int bit = irq - AU1000_INTC1_INT_BASE;
+	int bit = d->irq - AU1000_INTC1_INT_BASE;
 	unsigned long wakemsk, flags;
 
 	/* only GPIO 0-7 can act as wakeup source.  Fortunately these
@@ -330,30 +330,35 @@ static int au1x_ic1_setwake(unsigned int irq, unsigned int on)
 	return 0;
 }
 
+static int alchemy_ic_settype(struct irq_data *d, unsigned int flow_type)
+{
+	return ic_settype(d->irq, flow_type);
+}
+
 /*
  * irq_chips for both ICs; this way the mask handlers can be
  * as short as possible.
  */
-static struct irq_chip au1x_ic0_chip = {
+static struct irq_chip alchemy_ic0_chip = {
 	.name		= "Alchemy-IC0",
-	.ack		= au1x_ic0_ack,
-	.mask		= au1x_ic0_mask,
-	.mask_ack	= au1x_ic0_maskack,
-	.unmask		= au1x_ic0_unmask,
-	.set_type	= au1x_ic_settype,
+	.irq_ack	= alchemy_ic0_ack,
+	.irq_mask	= alchemy_ic0_mask,
+	.irq_mask_ack	= alchemy_ic0_maskack,
+	.irq_unmask	= alchemy_ic0_unmask,
+	.irq_set_type	= alchemy_ic_settype,
 };
 
-static struct irq_chip au1x_ic1_chip = {
+static struct irq_chip alchemy_ic1_chip = {
 	.name		= "Alchemy-IC1",
-	.ack		= au1x_ic1_ack,
-	.mask		= au1x_ic1_mask,
-	.mask_ack	= au1x_ic1_maskack,
-	.unmask		= au1x_ic1_unmask,
-	.set_type	= au1x_ic_settype,
-	.set_wake	= au1x_ic1_setwake,
+	.irq_ack	= alchemy_ic1_ack,
+	.irq_mask	= alchemy_ic1_mask,
+	.irq_mask_ack	= alchemy_ic1_maskack,
+	.irq_unmask	= alchemy_ic1_unmask,
+	.irq_set_type	= alchemy_ic_settype,
+	.irq_set_wake	= alchemy_ic1_setwake,
 };
 
-static int au1x_ic_settype(unsigned int irq, unsigned int flow_type)
+static int ic_settype(unsigned int irq, unsigned int flow_type)
 {
 	struct irq_chip *chip;
 	unsigned long icr[6];
@@ -362,11 +367,11 @@ static int au1x_ic_settype(unsigned int irq, unsigned int flow_type)
 
 	if (irq >= AU1000_INTC1_INT_BASE) {
 		bit = irq - AU1000_INTC1_INT_BASE;
-		chip = &au1x_ic1_chip;
+		chip = &alchemy_ic1_chip;
 		ic = 1;
 	} else {
 		bit = irq - AU1000_INTC0_INT_BASE;
-		chip = &au1x_ic0_chip;
+		chip = &alchemy_ic0_chip;
 		ic = 0;
 	}
 
@@ -504,11 +509,11 @@ static void __init au1000_init_irq(struct au1xxx_irqmap *map)
 	 */
 	for (i = AU1000_INTC0_INT_BASE;
 	     (i < AU1000_INTC0_INT_BASE + 32); i++)
-		au1x_ic_settype(i, IRQ_TYPE_NONE);
+		ic_settype(i, IRQ_TYPE_NONE);
 
 	for (i = AU1000_INTC1_INT_BASE;
 	     (i < AU1000_INTC1_INT_BASE + 32); i++)
-		au1x_ic_settype(i, IRQ_TYPE_NONE);
+		ic_settype(i, IRQ_TYPE_NONE);
 
 	/*
 	 * Initialize IC0, which is fixed per processor.
@@ -526,7 +531,7 @@ static void __init au1000_init_irq(struct au1xxx_irqmap *map)
 				au_writel(1 << bit, IC0_ASSIGNSET);
 		}
 
-		au1x_ic_settype(irq_nr, map->im_type);
+		ic_settype(irq_nr, map->im_type);
 		++map;
 	}
 
diff --git a/arch/mips/alchemy/devboards/bcsr.c b/arch/mips/alchemy/devboards/bcsr.c
index c52af88..f91c43a 100644
--- a/arch/mips/alchemy/devboards/bcsr.c
+++ b/arch/mips/alchemy/devboards/bcsr.c
@@ -97,26 +97,26 @@ static void bcsr_csc_handler(unsigned int irq, struct irq_desc *d)
  * CPLD generates tons of spurious interrupts (at least on my DB1200).
  *	-- mlau
  */
-static void bcsr_irq_mask(unsigned int irq_nr)
+static void bcsr_irq_mask(struct irq_data *d)
 {
-	unsigned short v = 1 << (irq_nr - bcsr_csc_base);
+	unsigned short v = 1 << (d->irq - bcsr_csc_base);
 	__raw_writew(v, bcsr_virt + BCSR_REG_INTCLR);
 	__raw_writew(v, bcsr_virt + BCSR_REG_MASKCLR);
 	wmb();
 }
 
-static void bcsr_irq_maskack(unsigned int irq_nr)
+static void bcsr_irq_maskack(struct irq_data *d)
 {
-	unsigned short v = 1 << (irq_nr - bcsr_csc_base);
+	unsigned short v = 1 << (d->irq - bcsr_csc_base);
 	__raw_writew(v, bcsr_virt + BCSR_REG_INTCLR);
 	__raw_writew(v, bcsr_virt + BCSR_REG_MASKCLR);
 	__raw_writew(v, bcsr_virt + BCSR_REG_INTSTAT);	/* ack */
 	wmb();
 }
 
-static void bcsr_irq_unmask(unsigned int irq_nr)
+static void bcsr_irq_unmask(struct irq_data *d)
 {
-	unsigned short v = 1 << (irq_nr - bcsr_csc_base);
+	unsigned short v = 1 << (d->irq - bcsr_csc_base);
 	__raw_writew(v, bcsr_virt + BCSR_REG_INTSET);
 	__raw_writew(v, bcsr_virt + BCSR_REG_MASKSET);
 	wmb();
@@ -124,9 +124,9 @@ static void bcsr_irq_unmask(unsigned int irq_nr)
 
 static struct irq_chip bcsr_irq_type = {
 	.name		= "CPLD",
-	.mask		= bcsr_irq_mask,
-	.mask_ack	= bcsr_irq_maskack,
-	.unmask		= bcsr_irq_unmask,
+	.irq_mask	= bcsr_irq_mask,
+	.irq_mask_ack	= bcsr_irq_maskack,
+	.irq_unmask	= bcsr_irq_unmask,
 };
 
 void __init bcsr_init_irq(int csc_start, int csc_end, int hook_irq)
-- 
1.7.4
