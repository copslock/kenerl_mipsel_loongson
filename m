Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 12:50:50 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:46959 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860084AbaGLKuDv0a1T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Jul 2014 12:50:03 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id B7E32280133;
        Sat, 12 Jul 2014 12:47:55 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (dslb-088-073-046-107.pools.arcor-ip.net [88.73.46.107])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 57E002845E6;
        Sat, 12 Jul 2014 12:47:46 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Subject: [PATCH 03/10] MIPS: BCM63XX: replace irq dispatch code with a generic version
Date:   Sat, 12 Jul 2014 12:49:35 +0200
Message-Id: <1405162182-30399-4-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
References: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

The generic version uses a variable length of u32 registers instead of u32/u64.
This allows easier support for "wider" registers without having to rewrite
everything.

This "generic" version is as fast as the old version in the best case
(i == next set bit), and twice as fast in the worst case in 64 bits.

Using a macro was chosen over a (forced) inline version because gcc generated
more compact code with the macro.

The change from (signed) int to unsigned int for i and to_call was intentional
as the value can be only between 0 and (width - 1) anyway, and allowed gcc to
optimise the code a bit further.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/irq.c | 130 +++++++++++++++++++++---------------------------
 1 file changed, 56 insertions(+), 74 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index f6c933a..db9f2ef 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -51,47 +51,65 @@ static inline void handle_internal(int intbit)
  * will resume the loop where it ended the last time we left this
  * function.
  */
-static void __dispatch_internal_32(void)
-{
-	u32 pending;
-	static int i;
-
-	pending = bcm_readl(irq_stat_addr) & bcm_readl(irq_mask_addr);
-
-	if (!pending)
-		return ;
-
-	while (1) {
-		int to_call = i;
 
-		i = (i + 1) & 0x1f;
-		if (pending & (1 << to_call)) {
-			handle_internal(to_call);
-			break;
-		}
-	}
+#define BUILD_IPIC_INTERNAL(width)					\
+void __dispatch_internal_##width(void)					\
+{									\
+	u32 pending[width / 32];					\
+	unsigned int src, tgt;						\
+	bool irqs_pending = false;					\
+	static unsigned int i;						\
+									\
+	/* read registers in reverse order */				\
+	for (src = 0, tgt = (width / 32); src < (width / 32); src++) {	\
+		u32 val;						\
+									\
+		val = bcm_readl(irq_stat_addr + src * sizeof(u32));	\
+		val &= bcm_readl(irq_mask_addr + src * sizeof(u32));	\
+		pending[--tgt] = val;					\
+									\
+		if (val)						\
+			irqs_pending = true;				\
+	}								\
+									\
+	if (!irqs_pending)						\
+		return;							\
+									\
+	while (1) {							\
+		unsigned int to_call = i;				\
+									\
+		i = (i + 1) & (width - 1);				\
+		if (pending[to_call / 32] & (1 << (to_call & 0x1f))) {	\
+			handle_internal(to_call);			\
+			break;						\
+		}							\
+	}								\
+}									\
+									\
+static void __internal_irq_mask_##width(unsigned int irq)		\
+{									\
+	u32 val;							\
+	unsigned reg = (irq / 32) ^ (width/32 - 1);			\
+	unsigned bit = irq & 0x1f;					\
+									\
+	val = bcm_readl(irq_mask_addr + reg * sizeof(u32));		\
+	val &= ~(1 << bit);						\
+	bcm_writel(val, irq_mask_addr + reg * sizeof(u32));		\
+}									\
+									\
+static void __internal_irq_unmask_##width(unsigned int irq)		\
+{									\
+	u32 val;							\
+	unsigned reg = (irq / 32) ^ (width/32 - 1);			\
+	unsigned bit = irq & 0x1f;					\
+									\
+	val = bcm_readl(irq_mask_addr + reg * sizeof(u32));		\
+	val |= (1 << bit);						\
+	bcm_writel(val, irq_mask_addr + reg * sizeof(u32));		\
 }
 
-static void __dispatch_internal_64(void)
-{
-	u64 pending;
-	static int i;
-
-	pending = bcm_readq(irq_stat_addr) & bcm_readq(irq_mask_addr);
-
-	if (!pending)
-		return ;
-
-	while (1) {
-		int to_call = i;
-
-		i = (i + 1) & 0x3f;
-		if (pending & (1ull << to_call)) {
-			handle_internal(to_call);
-			break;
-		}
-	}
-}
+BUILD_IPIC_INTERNAL(32);
+BUILD_IPIC_INTERNAL(64);
 
 asmlinkage void plat_irq_dispatch(void)
 {
@@ -128,42 +146,6 @@ asmlinkage void plat_irq_dispatch(void)
  * internal IRQs operations: only mask/unmask on PERF irq mask
  * register.
  */
-static void __internal_irq_mask_32(unsigned int irq)
-{
-	u32 mask;
-
-	mask = bcm_readl(irq_mask_addr);
-	mask &= ~(1 << irq);
-	bcm_writel(mask, irq_mask_addr);
-}
-
-static void __internal_irq_mask_64(unsigned int irq)
-{
-	u64 mask;
-
-	mask = bcm_readq(irq_mask_addr);
-	mask &= ~(1ull << irq);
-	bcm_writeq(mask, irq_mask_addr);
-}
-
-static void __internal_irq_unmask_32(unsigned int irq)
-{
-	u32 mask;
-
-	mask = bcm_readl(irq_mask_addr);
-	mask |= (1 << irq);
-	bcm_writel(mask, irq_mask_addr);
-}
-
-static void __internal_irq_unmask_64(unsigned int irq)
-{
-	u64 mask;
-
-	mask = bcm_readq(irq_mask_addr);
-	mask |= (1ull << irq);
-	bcm_writeq(mask, irq_mask_addr);
-}
-
 static void bcm63xx_internal_irq_mask(struct irq_data *d)
 {
 	internal_irq_mask(d->irq - IRQ_INTERNAL_BASE);
-- 
2.0.0
