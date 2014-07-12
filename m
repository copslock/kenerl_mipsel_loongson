Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 12:52:02 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:46976 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860089AbaGLKuS2xRNs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Jul 2014 12:50:18 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 76D83280133;
        Sat, 12 Jul 2014 12:48:10 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (dslb-088-073-046-107.pools.arcor-ip.net [88.73.46.107])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 7D08528460B;
        Sat, 12 Jul 2014 12:47:48 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Subject: [PATCH 06/10] MIPS: BCM63XX: add cpu argument to dispatch internal
Date:   Sat, 12 Jul 2014 12:49:38 +0200
Message-Id: <1405162182-30399-7-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
References: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41166
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

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/irq.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index f467e44..53be291 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -19,9 +19,10 @@
 #include <bcm63xx_io.h>
 #include <bcm63xx_irq.h>
 
+
 static u32 irq_stat_addr[2];
 static u32 irq_mask_addr[2];
-static void (*dispatch_internal)(void);
+static void (*dispatch_internal)(int cpu);
 static int is_ext_irq_cascaded;
 static unsigned int ext_irq_count;
 static unsigned int ext_irq_start, ext_irq_end;
@@ -54,19 +55,20 @@ static inline void handle_internal(int intbit)
  */
 
 #define BUILD_IPIC_INTERNAL(width)					\
-void __dispatch_internal_##width(void)					\
+void __dispatch_internal_##width(int cpu)				\
 {									\
 	u32 pending[width / 32];					\
 	unsigned int src, tgt;						\
 	bool irqs_pending = false;					\
-	static unsigned int i;						\
+	static unsigned int i[2];					\
+	unsigned int *next = &i[cpu];					\
 									\
 	/* read registers in reverse order */				\
 	for (src = 0, tgt = (width / 32); src < (width / 32); src++) {	\
 		u32 val;						\
 									\
-		val = bcm_readl(irq_stat_addr[0] + src * sizeof(u32));	\
-		val &= bcm_readl(irq_mask_addr[0] + src * sizeof(u32));	\
+		val = bcm_readl(irq_stat_addr[cpu] + src * sizeof(u32)); \
+		val &= bcm_readl(irq_mask_addr[cpu] + src * sizeof(u32)); \
 		pending[--tgt] = val;					\
 									\
 		if (val)						\
@@ -77,9 +79,9 @@ void __dispatch_internal_##width(void)					\
 		return;							\
 									\
 	while (1) {							\
-		unsigned int to_call = i;				\
+		unsigned int to_call = *next;				\
 									\
-		i = (i + 1) & (width - 1);				\
+		*next = (*next + 1) & (width - 1);			\
 		if (pending[to_call / 32] & (1 << (to_call & 0x1f))) {	\
 			handle_internal(to_call);			\
 			break;						\
@@ -129,7 +131,7 @@ asmlinkage void plat_irq_dispatch(void)
 		if (cause & CAUSEF_IP1)
 			do_IRQ(1);
 		if (cause & CAUSEF_IP2)
-			dispatch_internal();
+			dispatch_internal(0);
 		if (!is_ext_irq_cascaded) {
 			if (cause & CAUSEF_IP3)
 				do_IRQ(IRQ_EXT_0);
-- 
2.0.0
