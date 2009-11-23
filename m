Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 00:01:38 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.147]:12235 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1493447AbZKWXBe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2009 00:01:34 +0100
Received: by ey-out-1920.google.com with SMTP id 26so1382322eyw.52
        for <linux-mips@linux-mips.org>; Mon, 23 Nov 2009 15:01:33 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nfYTHxf39REUaKUSL1wqeQXVcxFWo4jMdOJr6qrDXiE=;
        b=IztLLN0FduLbHq7fRvpvvoSZS2c4KyzzLO9DmQFXIhNsZdgASM0RBaGL0grfE+N6eN
         MoOHiA5IDoKppXyasFLND5Z/iolNW+rSlwY7SDrd2tsrfbSQ81MjxQYbZ2CJD3RxUUv5
         Ec57o7syMMI1qltg+V7IounCeezyvnCiV9GTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l6yOtZHPqKWHKcsgydrvrxb8jLGgdMRn6O6WgXiw5tVblQs8YkOJhaiyC6PdXjFVYc
         dCfWHNP6fLHVUuvjje0Lr/SLmHFipO9VeqAHl/fL0I6P/5k4eG+1kA1jACvy1Baw8vIh
         Vxr/7krXrWhKdWQ/FHl7Cdb/CSkIswvvQV0pA=
Received: by 10.216.86.3 with SMTP id v3mr1578288wee.165.1259005197389;
        Mon, 23 Nov 2009 11:39:57 -0800 (PST)
Received: from localhost.localdomain (p5496D521.dip.t-dialin.net [84.150.213.33])
        by mx.google.com with ESMTPS id g11sm10270817gve.3.2009.11.23.11.39.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 11:39:56 -0800 (PST)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 3/3] MIPS: Alchemy: irq: use runtime CPU type detection
Date:	Mon, 23 Nov 2009 20:40:02 +0100
Message-Id: <1259005202-7771-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <1259005202-7771-2-git-send-email-manuel.lauss@gmail.com>
References: <1259005202-7771-1-git-send-email-manuel.lauss@gmail.com>
 <1259005202-7771-2-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Use runtime CPU detection instead of relying on preprocessor symbols.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/irq.c |   97 ++++++++++++++++++++++------------------
 1 files changed, 54 insertions(+), 43 deletions(-)

diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index 960a3ee..b2821ac 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -51,8 +51,9 @@ struct au1xxx_irqmap {
 	int im_irq;
 	int im_type;
 	int im_request;		/* set 1 to get higher priority */
-} au1xxx_ic0_map[] __initdata = {
-#if defined(CONFIG_SOC_AU1000)
+};
+
+struct au1xxx_irqmap au1000_irqmap[] __initdata = {
 	{ AU1000_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1000_UART1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1000_UART2_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
@@ -84,9 +85,10 @@ struct au1xxx_irqmap {
 	{ AU1000_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1000_MAC1_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1000_AC97C_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ -1, },
+};
 
-#elif defined(CONFIG_SOC_AU1500)
-
+struct au1xxx_irqmap au1500_irqmap[] __initdata = {
 	{ AU1500_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1500_PCI_INTA,	  IRQ_TYPE_LEVEL_LOW,   0 },
 	{ AU1500_PCI_INTB,	  IRQ_TYPE_LEVEL_LOW,   0 },
@@ -116,9 +118,10 @@ struct au1xxx_irqmap {
 	{ AU1500_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1500_MAC1_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1500_AC97C_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ -1, },
+};
 
-#elif defined(CONFIG_SOC_AU1100)
-
+struct au1xxx_irqmap au1100_irqmap[] __initdata = {
 	{ AU1100_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1100_UART1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1100_SD_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
@@ -150,9 +153,10 @@ struct au1xxx_irqmap {
 	{ AU1100_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1100_LCD_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1100_AC97C_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+	{ -1, },
+};
 
-#elif defined(CONFIG_SOC_AU1550)
-
+struct au1xxx_irqmap au1550_irqmap[] __initdata = {
 	{ AU1550_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1550_PCI_INTA,	  IRQ_TYPE_LEVEL_LOW,   0 },
 	{ AU1550_PCI_INTB,	  IRQ_TYPE_LEVEL_LOW,   0 },
@@ -181,9 +185,10 @@ struct au1xxx_irqmap {
 	{ AU1550_USB_HOST_INT,	  IRQ_TYPE_LEVEL_LOW,   0 },
 	{ AU1550_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1550_MAC1_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+	{ -1, },
+};
 
-#elif defined(CONFIG_SOC_AU1200)
-
+struct au1xxx_irqmap au1200_irqmap[] __initdata = {
 	{ AU1200_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1200_SWT_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1200_SD_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
@@ -207,10 +212,7 @@ struct au1xxx_irqmap {
 	{ AU1200_USB_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1200_LCD_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
 	{ AU1200_MAE_BOTH_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-
-#else
-#error "Error: Unknown Alchemy SOC"
-#endif
+	{ -1, },
 };
 
 
@@ -547,36 +549,9 @@ handle:
 	do_IRQ(off);
 }
 
-/* setup edge/level and assign request 0/1 */
-static void __init setup_irqmap(struct au1xxx_irqmap *map, int count)
+static void __init au1000_init_irq(struct au1xxx_irqmap *map)
 {
 	unsigned int bit, irq_nr;
-
-	while (count--) {
-		irq_nr = map[count].im_irq;
-
-		if (((irq_nr < AU1000_INTC0_INT_BASE) ||
-		     (irq_nr >= AU1000_INTC0_INT_BASE + 32)) &&
-		    ((irq_nr < AU1000_INTC1_INT_BASE) ||
-		     (irq_nr >= AU1000_INTC1_INT_BASE + 32)))
-			continue;
-
-		if (irq_nr >= AU1000_INTC1_INT_BASE) {
-			bit = irq_nr - AU1000_INTC1_INT_BASE;
-			if (map[count].im_request)
-				au_writel(1 << bit, IC1_ASSIGNSET);
-		} else {
-			bit = irq_nr - AU1000_INTC0_INT_BASE;
-			if (map[count].im_request)
-				au_writel(1 << bit, IC0_ASSIGNSET);
-		}
-
-		au1x_ic_settype(irq_nr, map[count].im_type);
-	}
-}
-
-void __init arch_init_irq(void)
-{
 	int i;
 
 	/*
@@ -620,7 +595,43 @@ void __init arch_init_irq(void)
 	/*
 	 * Initialize IC0, which is fixed per processor.
 	 */
-	setup_irqmap(au1xxx_ic0_map, ARRAY_SIZE(au1xxx_ic0_map));
+	while (map->im_irq != -1) {
+		irq_nr = map->im_irq;
+
+		if (irq_nr >= AU1000_INTC1_INT_BASE) {
+			bit = irq_nr - AU1000_INTC1_INT_BASE;
+			if (map->im_request)
+				au_writel(1 << bit, IC1_ASSIGNSET);
+		} else {
+			bit = irq_nr - AU1000_INTC0_INT_BASE;
+			if (map->im_request)
+				au_writel(1 << bit, IC0_ASSIGNSET);
+		}
+
+		au1x_ic_settype(irq_nr, map->im_type);
+		++map;
+	}
 
 	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3);
 }
+
+void __init arch_init_irq(void)
+{
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000:
+		au1000_init_irq(au1000_irqmap);
+		break;
+	case ALCHEMY_CPU_AU1500:
+		au1000_init_irq(au1500_irqmap);
+		break;
+	case ALCHEMY_CPU_AU1100:
+		au1000_init_irq(au1100_irqmap);
+		break;
+	case ALCHEMY_CPU_AU1550:
+		au1000_init_irq(au1550_irqmap);
+		break;
+	case ALCHEMY_CPU_AU1200:
+		au1000_init_irq(au1200_irqmap);
+		break;
+	}
+}
-- 
1.6.5.3
