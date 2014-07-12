Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 12:51:08 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:46961 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860085AbaGLKuEkFppL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Jul 2014 12:50:04 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id B2ECF2845E6;
        Sat, 12 Jul 2014 12:47:56 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (dslb-088-073-046-107.pools.arcor-ip.net [88.73.46.107])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 6694828470E;
        Sat, 12 Jul 2014 12:47:50 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Subject: [PATCH 09/10] MIPS: BCM63XX: use irq_desc as argument for (un)mask
Date:   Sat, 12 Jul 2014 12:49:41 +0200
Message-Id: <1405162182-30399-10-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
References: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41163
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

In preparation for applying affinity, use the irq descriptor as the
argument for (un)mask.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/irq.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index 615b25b..a53305f 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -31,8 +31,8 @@ static int is_ext_irq_cascaded;
 static unsigned int ext_irq_count;
 static unsigned int ext_irq_start, ext_irq_end;
 static unsigned int ext_irq_cfg_reg1, ext_irq_cfg_reg2;
-static void (*internal_irq_mask)(unsigned int irq);
-static void (*internal_irq_unmask)(unsigned int irq);
+static void (*internal_irq_mask)(struct irq_data *d);
+static void (*internal_irq_unmask)(struct irq_data *d);
 
 
 static inline u32 get_ext_irq_perf_reg(int irq)
@@ -96,9 +96,10 @@ void __dispatch_internal_##width(int cpu)				\
 	}								\
 }									\
 									\
-static void __internal_irq_mask_##width(unsigned int irq)		\
+static void __internal_irq_mask_##width(struct irq_data *d)		\
 {									\
 	u32 val;							\
+	unsigned irq = d->irq - IRQ_INTERNAL_BASE;			\
 	unsigned reg = (irq / 32) ^ (width/32 - 1);			\
 	unsigned bit = irq & 0x1f;					\
 	unsigned long flags;						\
@@ -116,9 +117,10 @@ static void __internal_irq_mask_##width(unsigned int irq)		\
 	spin_unlock_irqrestore(&ipic_lock, flags);			\
 }									\
 									\
-static void __internal_irq_unmask_##width(unsigned int irq)		\
+static void __internal_irq_unmask_##width(struct irq_data *d)		\
 {									\
 	u32 val;							\
+	unsigned irq = d->irq - IRQ_INTERNAL_BASE;			\
 	unsigned reg = (irq / 32) ^ (width/32 - 1);			\
 	unsigned bit = irq & 0x1f;					\
 	unsigned long flags;						\
@@ -182,12 +184,12 @@ asmlinkage void plat_irq_dispatch(void)
  */
 static void bcm63xx_internal_irq_mask(struct irq_data *d)
 {
-	internal_irq_mask(d->irq - IRQ_INTERNAL_BASE);
+	internal_irq_mask(d);
 }
 
 static void bcm63xx_internal_irq_unmask(struct irq_data *d)
 {
-	internal_irq_unmask(d->irq - IRQ_INTERNAL_BASE);
+	internal_irq_unmask(d);
 }
 
 /*
@@ -213,7 +215,7 @@ static void bcm63xx_external_irq_mask(struct irq_data *d)
 	spin_unlock_irqrestore(&epic_lock, flags);
 
 	if (is_ext_irq_cascaded)
-		internal_irq_mask(irq + ext_irq_start);
+		internal_irq_mask(irq_get_irq_data(irq + ext_irq_start));
 }
 
 static void bcm63xx_external_irq_unmask(struct irq_data *d)
@@ -235,7 +237,7 @@ static void bcm63xx_external_irq_unmask(struct irq_data *d)
 	spin_unlock_irqrestore(&epic_lock, flags);
 
 	if (is_ext_irq_cascaded)
-		internal_irq_unmask(irq + ext_irq_start);
+		internal_irq_unmask(irq_get_irq_data(irq + ext_irq_start));
 }
 
 static void bcm63xx_external_irq_clear(struct irq_data *d)
-- 
2.0.0
