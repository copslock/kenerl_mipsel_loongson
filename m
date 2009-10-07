Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2009 20:16:19 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:64501 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493065AbZJGSP0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Oct 2009 20:15:26 +0200
Received: by ewy12 with SMTP id 12so10566879ewy.0
        for <multiple recipients>; Wed, 07 Oct 2009 11:15:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oX/Z9SmEtPSOE+0ZnGmQOwk1gdKhGlYR5SNQyCZP/oU=;
        b=gD89z9gajyzDRa9RlWFSOu8ay3z11mly5ulk0mslsp+oHonkPdc7Bk2st/doV+lhPH
         3vKOEhjkZuweQiRQGWDDMvuvzkOreFMjr/dLYMYgDH58XAx8MhUtp3P1kciqQWOd7wq/
         rUp7N1iN5YpiCKlYNu3a/4MidVaD3exciqSls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hH37opULAU0Mv0iYmnt/bfBPuPAdOztSKZy8jnqn0Ymvq8G8pZW9kufIvelDU0JWfh
         DTFmjr0ECxJ/cSULDhxQsVjTHmMEpOPlxiespgzEaOaSVfjV2r5c7ICFv6BynXuGCF6W
         uD0vjbv0hIuT1j0t/UdSx0PwySsKnUc+/tKC8=
Received: by 10.216.88.68 with SMTP id z46mr77705wee.27.1254939319331;
        Wed, 07 Oct 2009 11:15:19 -0700 (PDT)
Received: from localhost.localdomain (p5496B5E8.dip.t-dialin.net [84.150.181.232])
        by mx.google.com with ESMTPS id f13sm94596gvd.21.2009.10.07.11.15.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 11:15:18 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 1/4] Alchemy: remove USB_DEV_REQ_INT prioritization hack
Date:	Wed,  7 Oct 2009 20:15:12 +0200
Message-Id: <1254939315-8158-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
In-Reply-To: <1254939315-8158-1-git-send-email-manuel.lauss@gmail.com>
References: <1254939315-8158-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

The Alchemy hardware provides a method to prioritize interrupts
on a controller by assigning them to a differenct core request line.
Assign usb device request interrupt to IC0 Request 0 (which has
highest priority in the core and the dispatcher) and others to
Request 1.  The explicit check for usb device request occurrence
should be obsolete now.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/irq.c |   50 +++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index cd264b1..81acd2a 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -39,11 +39,18 @@
 
 static int au1x_ic_settype(unsigned int irq, unsigned int flow_type);
 
+/* NOTE on interrupt priorities: The original writers of this code said:
+ *
+ * Because of the tight timing of SETUP token to reply transactions,
+ * the USB devices-side packet complete interrupt (USB_DEV_REQ_INT)
+ * needs the highest priority.
+ */
+
 /* per-processor fixed function irqs */
 struct au1xxx_irqmap {
 	int im_irq;
 	int im_type;
-	int im_request;
+	int im_request;		/* set 1 to get higher priority */
 } au1xxx_ic0_map[] __initdata = {
 #if defined(CONFIG_SOC_AU1000)
 	{ AU1000_UART0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
@@ -63,14 +70,14 @@ struct au1xxx_irqmap {
 	{ AU1000_TOY_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
+	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_IRDA_TX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
 	{ AU1000_IRDA_RX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 1 },
 	{ AU1000_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_USB_HOST_INT, IRQ_TYPE_LEVEL_LOW, 0 },
 	{ AU1000_ACSYNC_INT, IRQ_TYPE_EDGE_RISING, 0 },
@@ -97,12 +104,12 @@ struct au1xxx_irqmap {
 	{ AU1000_TOY_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
+	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 1 },
 	{ AU1000_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_USB_HOST_INT, IRQ_TYPE_LEVEL_LOW, 0 },
 	{ AU1000_ACSYNC_INT, IRQ_TYPE_EDGE_RISING, 0 },
@@ -129,14 +136,14 @@ struct au1xxx_irqmap {
 	{ AU1000_TOY_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
+	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_IRDA_TX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
 	{ AU1000_IRDA_RX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 1 },
 	{ AU1000_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_USB_HOST_INT, IRQ_TYPE_LEVEL_LOW, 0 },
 	{ AU1000_ACSYNC_INT, IRQ_TYPE_EDGE_RISING, 0 },
@@ -163,13 +170,13 @@ struct au1xxx_irqmap {
 	{ AU1000_TOY_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
+	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1550_NAND_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1550_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
+	{ AU1550_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 1 },
 	{ AU1550_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1550_USB_HOST_INT, IRQ_TYPE_LEVEL_LOW, 0 },
 	{ AU1550_MAC0_DMA_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
@@ -191,7 +198,7 @@ struct au1xxx_irqmap {
 	{ AU1000_TOY_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
+	{ AU1000_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
@@ -489,7 +496,7 @@ static int au1x_ic_settype(unsigned int irq, unsigned int flow_type)
 asmlinkage void plat_irq_dispatch(void)
 {
 	unsigned int pending = read_c0_status() & read_c0_cause();
-	unsigned long s, off, bit;
+	unsigned long s, off;
 
 	if (pending & CAUSEF_IP7) {
 		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
@@ -509,25 +516,12 @@ asmlinkage void plat_irq_dispatch(void)
 	} else
 		goto spurious;
 
-	bit = 0;
 	s = au_readl(s);
 	if (unlikely(!s)) {
 spurious:
 		spurious_interrupt();
 		return;
 	}
-#ifdef AU1000_USB_DEV_REQ_INT
-	/*
-	 * Because of the tight timing of SETUP token to reply
-	 * transactions, the USB devices-side packet complete
-	 * interrupt needs the highest priority.
-	 */
-	bit = 1 << (AU1000_USB_DEV_REQ_INT - AU1000_INTC0_INT_BASE);
-	if ((pending & CAUSEF_IP2) && (s & bit)) {
-		do_IRQ(AU1000_USB_DEV_REQ_INT);
-		return;
-	}
-#endif
 	do_IRQ(__ffs(s) + off);
 }
 
@@ -548,11 +542,11 @@ static void __init setup_irqmap(struct au1xxx_irqmap *map, int count)
 		if (irq_nr >= AU1000_INTC1_INT_BASE) {
 			bit = irq_nr - AU1000_INTC1_INT_BASE;
 			if (map[count].im_request)
-				au_writel(1 << bit, IC1_ASSIGNCLR);
+				au_writel(1 << bit, IC1_ASSIGNSET);
 		} else {
 			bit = irq_nr - AU1000_INTC0_INT_BASE;
 			if (map[count].im_request)
-				au_writel(1 << bit, IC0_ASSIGNCLR);
+				au_writel(1 << bit, IC0_ASSIGNSET);
 		}
 
 		au1x_ic_settype(irq_nr, map[count].im_type);
@@ -570,7 +564,7 @@ void __init arch_init_irq(void)
 	au_writel(0xffffffff, IC0_CFG1CLR);
 	au_writel(0xffffffff, IC0_CFG2CLR);
 	au_writel(0xffffffff, IC0_MASKCLR);
-	au_writel(0xffffffff, IC0_ASSIGNSET);
+	au_writel(0xffffffff, IC0_ASSIGNCLR);
 	au_writel(0xffffffff, IC0_WAKECLR);
 	au_writel(0xffffffff, IC0_SRCSET);
 	au_writel(0xffffffff, IC0_FALLINGCLR);
@@ -581,7 +575,7 @@ void __init arch_init_irq(void)
 	au_writel(0xffffffff, IC1_CFG1CLR);
 	au_writel(0xffffffff, IC1_CFG2CLR);
 	au_writel(0xffffffff, IC1_MASKCLR);
-	au_writel(0xffffffff, IC1_ASSIGNSET);
+	au_writel(0xffffffff, IC1_ASSIGNCLR);
 	au_writel(0xffffffff, IC1_WAKECLR);
 	au_writel(0xffffffff, IC1_SRCSET);
 	au_writel(0xffffffff, IC1_FALLINGCLR);
-- 
1.6.5.rc2
