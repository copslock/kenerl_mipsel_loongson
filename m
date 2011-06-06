Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 11:53:09 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:47652 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490948Ab1FFJxC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 11:53:02 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1QTWUY-0002tU-80; Mon, 06 Jun 2011 11:53:02 +0200
Date:   Mon, 6 Jun 2011 11:53:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matt Turner <mattst88@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Regression: d6d5d5c breaks Broadcom BCM91250A
In-Reply-To: <20110606033608.GA14686@localhost.mattst88>
Message-ID: <alpine.LFD.2.02.1106061149460.13964@ionos>
References: <20110606033608.GA14686@localhost.mattst88>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-archive-position: 30241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4029

On Sun, 5 Jun 2011, Matt Turner wrote:

> Hi Thomas,
> 
> Commit d6d5d5c4afd4c8bb4c5e3753a2141e9c3a874629 breaks boot-up on my
> Broadcom BCM91250A. Reverting it solves the problem.
> 
> I looked at the commit but nothing obviously wrong jumped out at me.

The below should fix it.

----------------->
Subject: MIPS: sb1250: Restore dropped irq_mask function
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 06 Jun 2011 11:51:43 +0200

Commit d6d5d5c4a (MIPS: Sibyte: Convert to new irq_chip functions)
removed the mask function which breaks irq_shutdown(). Restore it.

Reported-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
diff --git a/arch/mips/sibyte/sb1250/irq.c b/arch/mips/sibyte/sb1250/irq.c
index be4460a..76ee045 100644
--- a/arch/mips/sibyte/sb1250/irq.c
+++ b/arch/mips/sibyte/sb1250/irq.c
@@ -123,6 +123,13 @@ static int sb1250_set_affinity(struct irq_data *d, const struct cpumask *mask,
 }
 #endif
 
+static void disable_sb1250_irq(struct irq_data *d)
+{
+	unsigned int irq = d->irq;
+
+	sb1250_mask_irq(sb1250_irq_owner[irq], irq);
+}
+
 static void enable_sb1250_irq(struct irq_data *d)
 {
 	unsigned int irq = d->irq;
@@ -180,6 +187,7 @@ static struct irq_chip sb1250_irq_type = {
 	.name = "SB1250-IMR",
 	.irq_mask_ack = ack_sb1250_irq,
 	.irq_unmask = enable_sb1250_irq,
+	.irq_mask = disable_sb1250_irq,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = sb1250_set_affinity
 #endif
