Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:58:19 +0200 (CEST)
Received: from mail-pd0-f201.google.com ([209.85.192.201]:61369 "EHLO
        mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009039AbaIOXvw6iGGL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:52 +0200
Received: by mail-pd0-f201.google.com with SMTP id v10so1027664pde.2
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6c0fpGVaorV45+P0XUDKG0Ebft4g23fApuaPLgLN2eU=;
        b=Ta5jjW8LUj3tsSmAMo4b0o5Oz4MTP8XeqOQeRuKM6eQUZG84mspSw4bSk2tiOC1PTy
         cmMpshMTnXCiFVcS812QKuGsjmuoef4X0+MlxIGsoBhtGGiU+US6MUeSs2Fj2vDB9FjY
         lNz+QbO+dCGsXUTqx3iIgdCNA+9rM5yEj+hM6GcA4mlAiU+vXWKYp/hqCCpYpJ1nPtxG
         uZPPENco9vcqSAVow0DQ3QRSHfeeBXcNX65ocSMouUE8g6Vak3QqYE6eomfgwZKmR3I3
         IUGYoTvda3On779gLa6bGuxw5CdOkwRRHOffbEbYCBacWAlcfF7TNKhZ+RLVCK+ccqFZ
         CvCw==
X-Gm-Message-State: ALoCoQkqnkHlkSeiqHNH12xl1jg15zuWCEim3/s2Ul1u/HiASd7giF+2OA6p0CcQlbiVNcMJ1RGO
X-Received: by 10.70.96.197 with SMTP id du5mr17223928pdb.3.1410825107045;
        Mon, 15 Sep 2014 16:51:47 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id j25si632240yhb.0.2014.09.15.16.51.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:47 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 1oB1jrOM.5; Mon, 15 Sep 2014 16:51:46 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id C7B4C220868; Mon, 15 Sep 2014 16:51:45 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/24] MIPS: Malta: Use generic plat_irq_dispatch
Date:   Mon, 15 Sep 2014 16:51:26 -0700
Message-Id: <1410825087-5497-24-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The generic plat_irq_dispatch provided in irq_cpu.c is sufficient for
dispatching interrupts on Malta in legacy and vectored interrupt modes.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/mti-malta/malta-int.c | 92 -----------------------------------------
 1 file changed, 92 deletions(-)

diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index c6b3548..bcab0b1 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -190,92 +190,6 @@ static irqreturn_t corehi_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static inline int clz(unsigned long x)
-{
-	__asm__(
-	"	.set	push					\n"
-	"	.set	mips32					\n"
-	"	clz	%0, %1					\n"
-	"	.set	pop					\n"
-	: "=r" (x)
-	: "r" (x));
-
-	return x;
-}
-
-/*
- * Version of ffs that only looks at bits 12..15.
- */
-static inline unsigned int irq_ffs(unsigned int pending)
-{
-#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
-	return -clz(pending) + 31 - CAUSEB_IP;
-#else
-	unsigned int a0 = 7;
-	unsigned int t0;
-
-	t0 = pending & 0xf000;
-	t0 = t0 < 1;
-	t0 = t0 << 2;
-	a0 = a0 - t0;
-	pending = pending << t0;
-
-	t0 = pending & 0xc000;
-	t0 = t0 < 1;
-	t0 = t0 << 1;
-	a0 = a0 - t0;
-	pending = pending << t0;
-
-	t0 = pending & 0x8000;
-	t0 = t0 < 1;
-	/* t0 = t0 << 2; */
-	a0 = a0 - t0;
-	/* pending = pending << t0; */
-
-	return a0;
-#endif
-}
-
-/*
- * IRQs on the Malta board look basically (barring software IRQs which we
- * don't use at all and all external interrupt sources are combined together
- * on hardware interrupt 0 (MIPS IRQ 2)) like:
- *
- *	MIPS IRQ	Source
- *	--------	------
- *	       0	Software (ignored)
- *	       1	Software (ignored)
- *	       2	Combined hardware interrupt (hw0)
- *	       3	Hardware (ignored)
- *	       4	Hardware (ignored)
- *	       5	Hardware (ignored)
- *	       6	Hardware (ignored)
- *	       7	R4k timer (what we use)
- *
- * We handle the IRQ according to _our_ priority which is:
- *
- * Highest ----	    R4k Timer
- * Lowest  ----	    Combined hardware interrupt
- *
- * then we just return, if multiple IRQs are pending then we will just take
- * another exception, big deal.
- */
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
-	int irq;
-
-	if (unlikely(!pending)) {
-		spurious_interrupt();
-		return;
-	}
-
-	irq = irq_ffs(pending);
-
-	do_IRQ(MIPS_CPU_IRQ_BASE + irq);
-}
-
 #ifdef CONFIG_MIPS_MT_SMP
 
 #define MIPS_CPU_IPI_RESCHED_IRQ 0	/* SW int 0 for resched */
@@ -438,12 +352,6 @@ void __init arch_init_irq(void)
 			cpu_ipi_resched_irq = MSC01E_INT_SW0;
 			cpu_ipi_call_irq = MSC01E_INT_SW1;
 		} else {
-			if (cpu_has_vint) {
-				set_vi_handler (MIPS_CPU_IPI_RESCHED_IRQ,
-					ipi_resched_dispatch);
-				set_vi_handler (MIPS_CPU_IPI_CALL_IRQ,
-					ipi_call_dispatch);
-			}
 			cpu_ipi_resched_irq = MIPS_CPU_IRQ_BASE +
 				MIPS_CPU_IPI_RESCHED_IRQ;
 			cpu_ipi_call_irq = MIPS_CPU_IRQ_BASE +
-- 
2.1.0.rc2.206.gedb03e5
