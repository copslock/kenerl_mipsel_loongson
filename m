Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Dec 2016 12:18:43 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:41664 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990509AbcL3LSgIT7QC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Dec 2016 12:18:36 +0100
Received: from hauke-x201s.congress.ccc.de. (unknown [151.217.251.220])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 8C83F100489;
        Fri, 30 Dec 2016 12:18:34 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: lantiq: lock DMA register accesses for SMP
Date:   Fri, 30 Dec 2016 12:18:27 +0100
Message-Id: <1483096707-21711-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.1.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

The DMA controller channel and port configuration is changed by
selecting the port or channel in one register and then update the
configuration in other registers. This has to be done in an atomic
operation. Previously only the local interrupts were deactivated which
works for single CPU systems. If the system supports SMP a better
locking is needed, use spinlocks instead.
On more recent SoCs (at least xrx200 and later) there are two memory
regions to change the configuration, there we could use one area for
each CPU and do not have to synchronize between the CPUs and more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/xway/dma.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index cef8117..a4ec07b 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
+#include <linux/spinlock.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 
@@ -59,16 +60,17 @@
 						ltq_dma_membase + (z))
 
 static void __iomem *ltq_dma_membase;
+static DEFINE_SPINLOCK(ltq_dma_lock);
 
 void
 ltq_dma_enable_irq(struct ltq_dma_channel *ch)
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&ltq_dma_lock, flags);
 	ltq_dma_w32(ch->nr, LTQ_DMA_CS);
 	ltq_dma_w32_mask(0, 1 << ch->nr, LTQ_DMA_IRNEN);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&ltq_dma_lock, flags);
 }
 EXPORT_SYMBOL_GPL(ltq_dma_enable_irq);
 
@@ -77,10 +79,10 @@ ltq_dma_disable_irq(struct ltq_dma_channel *ch)
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&ltq_dma_lock, flags);
 	ltq_dma_w32(ch->nr, LTQ_DMA_CS);
 	ltq_dma_w32_mask(1 << ch->nr, 0, LTQ_DMA_IRNEN);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&ltq_dma_lock, flags);
 }
 EXPORT_SYMBOL_GPL(ltq_dma_disable_irq);
 
@@ -89,10 +91,10 @@ ltq_dma_ack_irq(struct ltq_dma_channel *ch)
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&ltq_dma_lock, flags);
 	ltq_dma_w32(ch->nr, LTQ_DMA_CS);
 	ltq_dma_w32(DMA_IRQ_ACK, LTQ_DMA_CIS);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&ltq_dma_lock, flags);
 }
 EXPORT_SYMBOL_GPL(ltq_dma_ack_irq);
 
@@ -101,11 +103,11 @@ ltq_dma_open(struct ltq_dma_channel *ch)
 {
 	unsigned long flag;
 
-	local_irq_save(flag);
+	spin_lock_irqsave(&ltq_dma_lock, flag);
 	ltq_dma_w32(ch->nr, LTQ_DMA_CS);
 	ltq_dma_w32_mask(0, DMA_CHAN_ON, LTQ_DMA_CCTRL);
-	ltq_dma_enable_irq(ch);
-	local_irq_restore(flag);
+	ltq_dma_w32_mask(0, 1 << ch->nr, LTQ_DMA_IRNEN);
+	spin_unlock_irqrestore(&ltq_dma_lock, flag);
 }
 EXPORT_SYMBOL_GPL(ltq_dma_open);
 
@@ -114,11 +116,11 @@ ltq_dma_close(struct ltq_dma_channel *ch)
 {
 	unsigned long flag;
 
-	local_irq_save(flag);
+	spin_lock_irqsave(&ltq_dma_lock, flag);
 	ltq_dma_w32(ch->nr, LTQ_DMA_CS);
 	ltq_dma_w32_mask(DMA_CHAN_ON, 0, LTQ_DMA_CCTRL);
-	ltq_dma_disable_irq(ch);
-	local_irq_restore(flag);
+	ltq_dma_w32_mask(1 << ch->nr, 0, LTQ_DMA_IRNEN);
+	spin_unlock_irqrestore(&ltq_dma_lock, flag);
 }
 EXPORT_SYMBOL_GPL(ltq_dma_close);
 
@@ -133,7 +135,7 @@ ltq_dma_alloc(struct ltq_dma_channel *ch)
 				&ch->phys, GFP_ATOMIC);
 	memset(ch->desc_base, 0, LTQ_DESC_NUM * LTQ_DESC_SIZE);
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&ltq_dma_lock, flags);
 	ltq_dma_w32(ch->nr, LTQ_DMA_CS);
 	ltq_dma_w32(ch->phys, LTQ_DMA_CDBA);
 	ltq_dma_w32(LTQ_DESC_NUM, LTQ_DMA_CDLEN);
@@ -142,7 +144,7 @@ ltq_dma_alloc(struct ltq_dma_channel *ch)
 	ltq_dma_w32_mask(0, DMA_CHAN_RST, LTQ_DMA_CCTRL);
 	while (ltq_dma_r32(LTQ_DMA_CCTRL) & DMA_CHAN_RST)
 		;
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&ltq_dma_lock, flags);
 }
 
 void
@@ -152,11 +154,11 @@ ltq_dma_alloc_tx(struct ltq_dma_channel *ch)
 
 	ltq_dma_alloc(ch);
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&ltq_dma_lock, flags);
 	ltq_dma_w32(DMA_DESCPT, LTQ_DMA_CIE);
 	ltq_dma_w32_mask(0, 1 << ch->nr, LTQ_DMA_IRNEN);
 	ltq_dma_w32(DMA_WEIGHT | DMA_TX, LTQ_DMA_CCTRL);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&ltq_dma_lock, flags);
 }
 EXPORT_SYMBOL_GPL(ltq_dma_alloc_tx);
 
@@ -167,11 +169,11 @@ ltq_dma_alloc_rx(struct ltq_dma_channel *ch)
 
 	ltq_dma_alloc(ch);
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&ltq_dma_lock, flags);
 	ltq_dma_w32(DMA_DESCPT, LTQ_DMA_CIE);
 	ltq_dma_w32_mask(0, 1 << ch->nr, LTQ_DMA_IRNEN);
 	ltq_dma_w32(DMA_WEIGHT, LTQ_DMA_CCTRL);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&ltq_dma_lock, flags);
 }
 EXPORT_SYMBOL_GPL(ltq_dma_alloc_rx);
 
-- 
2.1.4
