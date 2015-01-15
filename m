Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2015 19:05:31 +0100 (CET)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:40293
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27010881AbbAOSFaVYGXe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2015 19:05:30 +0100
Received: by nf.local (Postfix, from userid 501)
        id CC350C203730; Thu, 15 Jan 2015 19:05:28 +0100 (CET)
From:   Felix Fietkau <nbd@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 3.19] MIPS: irq: fix disable_irq on CPU IRQs
Date:   Thu, 15 Jan 2015 19:05:28 +0100
Message-Id: <1421345128-83614-1-git-send-email-nbd@openwrt.org>
X-Mailer: git-send-email 2.1.2
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@openwrt.org
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

If the irq_chip does not define .irq_disable, any call to disable_irq
will defer disabling the IRQ until it fires while marked as disabled.
This assumes that the handler function checks for this condition, which
handle_percpu_irq does not. In this case, calling disable_irq leads to
an IRQ storm, if the interrupt fires while disabled.

This optimization is only useful when disabling the IRQ is slow, which
is not true for the MIPS CPU IRQ.

Disable this optimization by implementing .irq_disable and .irq_enable

Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
---
 arch/mips/kernel/irq_cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index 590c2c9..6eb7a3f 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -57,6 +57,8 @@ static struct irq_chip mips_cpu_irq_controller = {
 	.irq_mask_ack	= mask_mips_irq,
 	.irq_unmask	= unmask_mips_irq,
 	.irq_eoi	= unmask_mips_irq,
+	.irq_disable	= mask_mips_irq,
+	.irq_enable	= unmask_mips_irq,
 };
 
 /*
@@ -93,6 +95,8 @@ static struct irq_chip mips_mt_cpu_irq_controller = {
 	.irq_mask_ack	= mips_mt_cpu_irq_ack,
 	.irq_unmask	= unmask_mips_irq,
 	.irq_eoi	= unmask_mips_irq,
+	.irq_disable	= mask_mips_irq,
+	.irq_enable	= unmask_mips_irq,
 };
 
 asmlinkage void __weak plat_irq_dispatch(void)
-- 
2.1.2
