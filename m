Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 17:59:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39216 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992974AbdDFP67zRexZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 17:58:59 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4F237BD34AD5E;
        Thu,  6 Apr 2017 16:58:49 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 6 Apr 2017 16:58:53 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2] MIPS: Malta: Fix i8259 irqchip setup
Date:   Thu, 6 Apr 2017 16:58:09 +0100
Message-ID: <1491494289-22441-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Since commit 4cfffcfa5106 ("irqchip/mips-gic: Fix local interrupts"),
the gic driver has been allocating virq's for local interrupts during
its initialisation. Unfortunately on Malta platforms, these are the
first IRQs to be allocated and so are allocated virqs 1-3. The i8259
driver uses a legacy irq domain which expects to map virqs 0-15. Probing
of that driver therefore fails because some of those virqs are already
taken, with the warning:

WARNING: CPU: 0 PID: 0 at kernel/irq/irqdomain.c:344
irq_domain_associate+0x1e8/0x228
error: virq1 is already associated
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.10.0-rc6-00011-g4cfffcfa5106 #368
Stack : 00000000 00000000 807ae03a 0000004d 00000000 806c1010 0000000b ffff0a01
        80725467 807258f4 806a64a4 00000000 00000000 807a9acc 00000100 80713e68
        806d5598 8017593c 8072bf90 8072bf94 806ac358 00000000 806abb60 80713ce4
        00000100 801b22d4 806d5598 8017593c 807ae03a 00000000 80713ce4 80720000
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
        ...
Call Trace:
[<8010c480>] show_stack+0x88/0xa4
[<80376758>] dump_stack+0x88/0xd0
[<8012c4a8>] __warn+0x104/0x118
[<8012c4ec>] warn_slowpath_fmt+0x30/0x3c
[<8017edfc>] irq_domain_associate+0x1e8/0x228
[<8017efd0>] irq_domain_add_legacy+0x7c/0xb0
[<80764c50>] __init_i8259_irqs+0x64/0xa0
[<80764ca4>] i8259_of_init+0x18/0x74
[<8076ddc0>] of_irq_init+0x19c/0x310
[<80752dd8>] arch_init_irq+0x28/0x19c
[<80750a08>] start_kernel+0x2a8/0x434

Fix this by reserving the required i8259 virqs in malta platform code
before probing any irq chips.

Fixes: 4cfffcfa5106 ("irqchip/mips-gic: Fix local interrupts")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

Changes in v2:
Drop redundant CONFIG_I8259

 arch/mips/mti-malta/malta-int.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index cb675ec6f283..54f56d5a96c4 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -232,6 +232,17 @@ void __init arch_init_irq(void)
 {
 	int corehi_irq;
 
+	/*
+	 * Preallocate the i8259's expected virq's here. Since irqchip_init()
+	 * will probe the irqchips in hierarchial order, i8259 is probed last.
+	 * If anything allocates a virq before the i8259 is probed, it will
+	 * be given one of the i8259's expected range and consequently setup
+	 * of the i8259 will fail.
+	 */
+	WARN(irq_alloc_descs(I8259A_IRQ_BASE, I8259A_IRQ_BASE,
+			    16, numa_node_id()) < 0,
+		"Cannot reserve i8259 virqs at IRQ%d\n", I8259A_IRQ_BASE);
+
 	i8259_set_poll(mips_pcibios_iack);
 	irqchip_init();
 
-- 
2.7.4
