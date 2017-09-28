Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2017 02:16:44 +0200 (CEST)
Received: from lpdvrndsmtp01.broadcom.com ([192.19.229.170]:46829 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990407AbdI1AQhp0glK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Sep 2017 02:16:37 +0200
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id E105C30C08F;
        Wed, 27 Sep 2017 17:16:28 -0700 (PDT)
Received: from stb-bld-02.irv.broadcom.com (stb-bld-02.broadcom.com [10.13.134.28])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id B7A4181EAD;
        Wed, 27 Sep 2017 17:16:28 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     linux-mips@linux-mips.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH] MIPS: BMIPS: Do not mask IPIs during suspend
Date:   Wed, 27 Sep 2017 17:15:15 -0700
Message-Id: <20170928001515.22917-1-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.14.1
Return-Path: <justinpopo6@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinpopo6@gmail.com
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

From: Justin Chen <justinpopo6@gmail.com>

Commit a3e6c1eff548 ("MIPS: IRQ: Fix disabled_irq on CPU IRQs") fixes
an issue where disable_irq did not actually disable the irq. The
bug caused our IPIs to not be disabled, which actually is the correct
behavior.

With the addition of Commit a3e6c1eff548 ("MIPS: IRQ: Fix disabled_irq
on CPU IRQs"), the IPIs were getting disabled going into suspend,
thus schedule_ipi() was not being called. This caused deadlocks where
schedulable task were not being scheduled and other cpus were waiting
for them to do something.

Add the IRQF_NO_SUSPEND flag so an irq_disable will not be called
on the IPIs during suspend.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Fixes: a3e6c1eff548 ("MIPS: IRQ: Fix disabled_irq on CPU IRQs")
---
 arch/mips/kernel/smp-bmips.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 1b070a76fcdd..3b900a04d724 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -168,10 +168,10 @@ static void bmips_prepare_cpus(unsigned int max_cpus)
 		return;
 	}
 
-	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
+	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt, IRQF_PERCPU | IRQF_NO_SUSPEND,
 			"smp_ipi0", NULL))
 		panic("Can't request IPI0 interrupt");
-	if (request_irq(IPI1_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
+	if (request_irq(IPI1_IRQ, bmips_ipi_interrupt, IRQF_PERCPU | IRQF_NO_SUSPEND,
 			"smp_ipi1", NULL))
 		panic("Can't request IPI1 interrupt");
 }
-- 
2.14.1
