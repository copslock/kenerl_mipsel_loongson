Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 11:34:55 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:39638 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822429Ab3FRJexPh6AC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 11:34:53 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-012-093.pools.arcor-ip.net [88.73.12.93])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 8D1DA280F38;
        Tue, 18 Jun 2013 11:33:22 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 1/2] MIPS: BCM63XX: Add SMP support to prom.c
Date:   Tue, 18 Jun 2013 11:34:31 +0200
Message-Id: <1371548072-6247-2-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1371548072-6247-1-git-send-email-jogo@openwrt.org>
References: <1371548072-6247-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36964
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

From: Kevin Cernekee <cernekee@gmail.com>

This involves two changes to the BSP code:

1) register_smp_ops() for BMIPS SMP

2) The CPU1 boot vector on some of the BCM63xx platforms conflicts with
the special interrupt vector (IV).  Move it to 0x8000_0380 at boot time,
to resolve the conflict.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
[jogo@openwrt.org: moved SMP ops registration into ifdef guard,
 changed ifdef guards to if (IS_ENABLED())]
Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
V1 -> V2:
 * changed ifdef guards to if (IS_ENABLED())

 arch/mips/bcm63xx/prom.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index fd69808..33ddc78 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -8,7 +8,11 @@
 
 #include <linux/init.h>
 #include <linux/bootmem.h>
+#include <linux/smp.h>
 #include <asm/bootinfo.h>
+#include <asm/bmips.h>
+#include <asm/smp-ops.h>
+#include <asm/mipsregs.h>
 #include <bcm63xx_board.h>
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_io.h>
@@ -52,6 +56,43 @@ void __init prom_init(void)
 
 	/* do low level board init */
 	board_prom_init();
+
+	if (IS_ENABLED(CONFIG_CPU_BMIPS4350) && IS_ENABLED(CONFIG_SMP)) {
+		/* set up SMP */
+		register_smp_ops(&bmips_smp_ops);
+
+		/*
+		 * BCM6328 might not have its second CPU enabled, while BCM6358
+		 * needs special handling for its shared TLB, so disable SMP
+		 * for now.
+		 */
+		if (BCMCPU_IS_6328()) {
+			bmips_smp_enabled = 0;
+		} else if (BCMCPU_IS_6358()) {
+			bmips_smp_enabled = 0;
+		}
+
+		if (!bmips_smp_enabled)
+			return;
+
+		/*
+		 * The bootloader has set up the CPU1 reset vector at
+		 * 0xa000_0200.
+		 * This conflicts with the special interrupt vector (IV).
+		 * The bootloader has also set up CPU1 to respond to the wrong
+		 * IPI interrupt.
+		 * Here we will start up CPU1 in the background and ask it to
+		 * reconfigure itself then go back to sleep.
+		 */
+		memcpy((void *)0xa0000200, &bmips_smp_movevec, 0x20);
+		__sync();
+		set_c0_cause(C_SW0);
+		cpumask_set_cpu(1, &bmips_booted_mask);
+
+		/*
+		 * FIXME: we really should have some sort of hazard barrier here
+		 */
+	}
 }
 
 void __init prom_free_prom_memory(void)
-- 
1.7.10.4
