Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 18:52:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57612 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992285AbcIAQvsjx3p2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 18:51:48 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3D6D6968E8221;
        Thu,  1 Sep 2016 17:51:29 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 1 Sep 2016 17:51:32 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
CC:     <soren.brinkmann@xilinx.com>, <Zubair.Kakakhel@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <michal.simek@xilinx.com>, <netdev@vger.kernel.org>
Subject: [Patch v4 03/12] irqchip: axi-intc: Rename get_irq to xintc_get_irq
Date:   Thu, 1 Sep 2016 17:50:56 +0100
Message-ID: <1472748665-47774-4-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Now that the driver is generic and used by multiple archs,
get_irq is too generic.

Rename get_irq to xintc_get_irq to avoid any conflicts

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V3 -> V4
New patch.
---
 arch/microblaze/include/asm/irq.h | 2 +-
 arch/microblaze/kernel/irq.c      | 4 ++--
 drivers/irqchip/irq-axi-intc.c    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/asm/irq.h
index bab3b13..d785def 100644
--- a/arch/microblaze/include/asm/irq.h
+++ b/arch/microblaze/include/asm/irq.h
@@ -16,6 +16,6 @@ struct pt_regs;
 extern void do_IRQ(struct pt_regs *regs);
 
 /* should be defined in each interrupt controller driver */
-extern unsigned int get_irq(void);
+extern unsigned int xintc_get_irq(void);
 
 #endif /* _ASM_MICROBLAZE_IRQ_H */
diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
index 11e24de..903dad8 100644
--- a/arch/microblaze/kernel/irq.c
+++ b/arch/microblaze/kernel/irq.c
@@ -29,12 +29,12 @@ void __irq_entry do_IRQ(struct pt_regs *regs)
 	trace_hardirqs_off();
 
 	irq_enter();
-	irq = get_irq();
+	irq = xintc_get_irq();
 next_irq:
 	BUG_ON(!irq);
 	generic_handle_irq(irq);
 
-	irq = get_irq();
+	irq = xintc_get_irq();
 	if (irq != -1U) {
 		pr_debug("next irq: %d\n", irq);
 		++concurrent_irq;
diff --git a/drivers/irqchip/irq-axi-intc.c b/drivers/irqchip/irq-axi-intc.c
index 7ab0762..ac31548 100644
--- a/drivers/irqchip/irq-axi-intc.c
+++ b/drivers/irqchip/irq-axi-intc.c
@@ -119,7 +119,7 @@ static struct irq_chip intc_dev = {
 
 static struct irq_domain *root_domain;
 
-unsigned int get_irq(void)
+unsigned int xintc_get_irq(void)
 {
 	unsigned int hwirq, irq = -1;
 
@@ -127,7 +127,7 @@ unsigned int get_irq(void)
 	if (hwirq != -1U)
 		irq = irq_find_mapping(root_domain, hwirq);
 
-	pr_debug("get_irq: hwirq=%d, irq=%d\n", hwirq, irq);
+	pr_debug("xintc_get_irq: hwirq=%d, irq=%d\n", hwirq, irq);
 
 	return irq;
 }
-- 
1.9.1
