Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 17:51:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38324 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992029AbcIBPulGhC-A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 17:50:41 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 96E0E673788F9;
        Fri,  2 Sep 2016 16:50:21 +0100 (IST)
Received: from localhost (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 16:50:24 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 03/12] irqchip: i8259: Remove unused i8259A_irq_pending
Date:   Fri, 2 Sep 2016 16:48:49 +0100
Message-ID: <20160902154859.24269-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160902154859.24269-1-paul.burton@imgtec.com>
References: <20160902154859.24269-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.40]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The i8259A_irq_pending function is unused. Remove the dead code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/i8259.h |  1 -
 drivers/irqchip/irq-i8259.c   | 18 ------------------
 2 files changed, 19 deletions(-)

diff --git a/arch/mips/include/asm/i8259.h b/arch/mips/include/asm/i8259.h
index b27fcc4..32229c7 100644
--- a/arch/mips/include/asm/i8259.h
+++ b/arch/mips/include/asm/i8259.h
@@ -37,7 +37,6 @@
 
 extern raw_spinlock_t i8259A_lock;
 
-extern int i8259A_irq_pending(unsigned int irq);
 extern void make_8259A_irq(unsigned int irq);
 
 extern void init_i8259_irqs(void);
diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index 1f4a344..1aec12c 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -95,24 +95,6 @@ static void enable_8259A_irq(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
 }
 
-int i8259A_irq_pending(unsigned int irq)
-{
-	unsigned int mask;
-	unsigned long flags;
-	int ret;
-
-	irq -= I8259A_IRQ_BASE;
-	mask = 1 << irq;
-	raw_spin_lock_irqsave(&i8259A_lock, flags);
-	if (irq < 8)
-		ret = inb(PIC_MASTER_CMD) & mask;
-	else
-		ret = inb(PIC_SLAVE_CMD) & (mask >> 8);
-	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
-
-	return ret;
-}
-
 void make_8259A_irq(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-- 
2.9.3
