Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:54:53 +0200 (CEST)
Received: from mail-pd0-f202.google.com ([209.85.192.202]:37117 "EHLO
        mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009228AbaIRVryy0EGB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:54 +0200
Received: by mail-pd0-f202.google.com with SMTP id ft15so499158pdb.1
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dThKiuZbMTQ1UxDXYtNF5w06AVDRIUu1+YpIEdJUH6E=;
        b=WcEjQ4gbFURTIvwPpFNoN6hd0Z/lMlwVqORbrZJuqoM4casyh6jEtltZ1ruMteALN9
         DTnlFkrG3KM2mU0kWOOgn83FIAqmINT4Li45ah5PDe/lCIbydW6f8wALSKs2N+FFA8l6
         j3EikWJzbuR6QWTW17ITeIAkLx+DLYtKMOH4B7pxvdR7f7djbOnWnEyTaTdhUpO0vQC2
         XmbKhTUpmmVAvCv49z/cn9yTMY23/1PVnY/MSxasx3bTxw2a2O6iK8t8hghi92JXk4c/
         1d+ZaOH93oGrnzXVGnD6ORTaPEa2i2CTVCGti5tl/BUWM6PD1bVKt/cFDoHTLqOy3rJg
         z9jA==
X-Gm-Message-State: ALoCoQn1SgVU7E1K2Zrmd8pTjxRIFZQM+0Way8caZFmu5WWtMEMQ6wfaaQn5UxTi+aDfcrhzPTiw
X-Received: by 10.66.227.37 with SMTP id rx5mr5852277pac.25.1411076868892;
        Thu, 18 Sep 2014 14:47:48 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si3560yhe.3.2014.09.18.14.47.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:48 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id lBwURzVy.7; Thu, 18 Sep 2014 14:47:48 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id AEB1C220B91; Thu, 18 Sep 2014 14:47:47 -0700 (PDT)
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
Subject: [PATCH V2 23/24] MIPS: Malta: Use generic plat_irq_dispatch
Date:   Thu, 18 Sep 2014 14:47:29 -0700
Message-Id: <1411076851-28242-24-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42703
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
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
No changes from v1.
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
