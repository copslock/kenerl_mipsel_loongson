Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2013 14:17:53 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35662 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867283Ab3LRNOJjRB1V (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Dec 2013 14:14:09 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 207B02846CB;
        Wed, 18 Dec 2013 14:11:52 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-137-004.pools.arcor-ip.net [88.73.137.4])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 5C31228A925;
        Wed, 18 Dec 2013 14:11:44 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH V2 08/13] MIPS: BMIPS: add a smp ops registration helper
Date:   Wed, 18 Dec 2013 14:12:06 +0100
Message-Id: <1387372331-23474-9-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
References: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38744
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

Add a helper similar to the generic register_XXX_smp_ops() for bmips.
Register SMP UP ops in case of BMIPS32/3300.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
V1 -> V2:
 * use SMP_UP (ops) in case of BMIPS32_3300

 arch/mips/Kconfig             |  1 +
 arch/mips/bcm63xx/prom.c      |  2 +-
 arch/mips/include/asm/bmips.h | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fa08339..0e53a3c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1478,6 +1478,7 @@ config CPU_LOONGSON1
 	select CPU_SUPPORTS_HIGHMEM
 
 config CPU_BMIPS32_3300
+	select SMP_UP if SMP
 	bool
 
 config CPU_BMIPS4350
diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index 9872ca3..f93f4fc 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -61,7 +61,7 @@ void __init prom_init(void)
 
 	if (IS_ENABLED(CONFIG_CPU_BMIPS4350) && IS_ENABLED(CONFIG_SMP)) {
 		/* set up SMP */
-		register_smp_ops(&bmips43xx_smp_ops);
+		register_bmips_smp_ops();
 
 		/*
 		 * BCM6328 might not have its second CPU enabled, while BCM3368
diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index 880f6aa..cbacceb 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -46,9 +46,35 @@
 
 #include <linux/cpumask.h>
 #include <asm/r4kcache.h>
+#include <asm/smp-ops.h>
 
 extern struct plat_smp_ops bmips43xx_smp_ops;
 extern struct plat_smp_ops bmips5000_smp_ops;
+
+static inline int register_bmips_smp_ops(void)
+{
+#if IS_ENABLED(CONFIG_CPU_BMIPS) && IS_ENABLED(CONFIG_SMP)
+	switch (current_cpu_type()) {
+	case CPU_BMIPS32:
+	case CPU_BMIPS3300:
+		return register_up_smp_ops();
+	case CPU_BMIPS4350:
+	case CPU_BMIPS4380:
+		register_smp_ops(&bmips43xx_smp_ops);
+		break;
+	case CPU_BMIPS5000:
+		register_smp_ops(&bmips5000_smp_ops);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+#else
+	return -ENODEV;
+#endif
+}
+
 extern char bmips_reset_nmi_vec;
 extern char bmips_reset_nmi_vec_end;
 extern char bmips_smp_movevec;
-- 
1.8.5.1
