Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:44:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60812 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992487AbcHZPl5wCJxI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:41:57 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 10D6BF8FEF3D3;
        Fri, 26 Aug 2016 16:41:38 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:41:41 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 15/26] irqchip: mips-cpu: Replace magic 0x100 with IE_SW0
Date:   Fri, 26 Aug 2016 16:37:14 +0100
Message-ID: <20160826153725.11629-16-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826153725.11629-1-paul.burton@imgtec.com>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54799
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

Replace use of the magic number 0x100 (ie. bit 8) with the more
explanatory IE_SW0 (ie. interrupt enable for software interrupt 0) or
C_SW0 (ie. cause bit for software interrupt 0) as appropriate.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/irqchip/irq-mips-cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-mips-cpu.c b/drivers/irqchip/irq-mips-cpu.c
index 8c504f5..e6b4136 100644
--- a/drivers/irqchip/irq-mips-cpu.c
+++ b/drivers/irqchip/irq-mips-cpu.c
@@ -41,13 +41,13 @@
 
 static inline void unmask_mips_irq(struct irq_data *d)
 {
-	set_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
+	set_c0_status(IE_SW0 << (d->irq - MIPS_CPU_IRQ_BASE));
 	irq_enable_hazard();
 }
 
 static inline void mask_mips_irq(struct irq_data *d)
 {
-	clear_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
+	clear_c0_status(IE_SW0 << (d->irq - MIPS_CPU_IRQ_BASE));
 	irq_disable_hazard();
 }
 
@@ -70,7 +70,7 @@ static unsigned int mips_mt_cpu_irq_startup(struct irq_data *d)
 {
 	unsigned int vpflags = dvpe();
 
-	clear_c0_cause(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
+	clear_c0_cause(C_SW0 << (d->irq - MIPS_CPU_IRQ_BASE));
 	evpe(vpflags);
 	unmask_mips_irq(d);
 	return 0;
@@ -83,7 +83,7 @@ static unsigned int mips_mt_cpu_irq_startup(struct irq_data *d)
 static void mips_mt_cpu_irq_ack(struct irq_data *d)
 {
 	unsigned int vpflags = dvpe();
-	clear_c0_cause(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
+	clear_c0_cause(C_SW0 << (d->irq - MIPS_CPU_IRQ_BASE));
 	evpe(vpflags);
 	mask_mips_irq(d);
 }
-- 
2.9.3
