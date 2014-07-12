Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 12:50:13 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:46944 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860082AbaGLKt61CDh0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Jul 2014 12:49:58 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 85EF728B516;
        Sat, 12 Jul 2014 12:47:50 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (dslb-088-073-046-107.pools.arcor-ip.net [88.73.46.107])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 283CD280164;
        Sat, 12 Jul 2014 12:47:45 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Subject: [PATCH 01/10] MIPS: BCM63XX: add width to __dispatch_internal
Date:   Sat, 12 Jul 2014 12:49:33 +0200
Message-Id: <1405162182-30399-2-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
References: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41160
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

Make it follow the same naming convention as the other functions.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index 30c6803..a9fb564 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -19,7 +19,7 @@
 #include <bcm63xx_io.h>
 #include <bcm63xx_irq.h>
 
-static void __dispatch_internal(void) __maybe_unused;
+static void __dispatch_internal_32(void) __maybe_unused;
 static void __dispatch_internal_64(void) __maybe_unused;
 static void __internal_irq_mask_32(unsigned int irq) __maybe_unused;
 static void __internal_irq_mask_64(unsigned int irq) __maybe_unused;
@@ -117,7 +117,7 @@ static void bcm63xx_init_irq(void)
 	}
 
 	if (irq_bits == 32) {
-		dispatch_internal = __dispatch_internal;
+		dispatch_internal = __dispatch_internal_32;
 		internal_irq_mask = __internal_irq_mask_32;
 		internal_irq_unmask = __internal_irq_unmask_32;
 	} else {
@@ -149,7 +149,7 @@ static inline void handle_internal(int intbit)
  * will resume the loop where it ended the last time we left this
  * function.
  */
-static void __dispatch_internal(void)
+static void __dispatch_internal_32(void)
 {
 	u32 pending;
 	static int i;
-- 
2.0.0
