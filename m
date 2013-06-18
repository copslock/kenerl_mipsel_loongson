Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 11:35:48 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:39644 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823064Ab3FRJexPtW13 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 11:34:53 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-012-093.pools.arcor-ip.net [88.73.12.93])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 1B8762803E8;
        Tue, 18 Jun 2013 11:33:23 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 2/2] MIPS: BCM63XX: Enable second core SMP on BCM6328 if available
Date:   Tue, 18 Jun 2013 11:34:32 +0200
Message-Id: <1371548072-6247-3-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1371548072-6247-1-git-send-email-jogo@openwrt.org>
References: <1371548072-6247-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36966
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

BCM6328 has a OTP which tells us if the second core is available.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/prom.c                          |    6 +++++-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |    2 ++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |    7 +++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index 33ddc78..f9ef7f7 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -67,7 +67,11 @@ void __init prom_init(void)
 		 * for now.
 		 */
 		if (BCMCPU_IS_6328()) {
-			bmips_smp_enabled = 0;
+			reg = bcm_readl(BCM_6328_OTP_BASE +
+					OTP_USER_BITS_6328_REG(3));
+
+			if (reg & OTP_6328_REG3_TP1_DISABLED)
+				bmips_smp_enabled = 0;
 		} else if (BCMCPU_IS_6358()) {
 			bmips_smp_enabled = 0;
 		}
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 3362289..6a3020d 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -235,6 +235,8 @@ enum bcm63xx_regs_set {
 #define BCM_6328_PCMDMAS_BASE		(0xdeadbeef)
 #define BCM_6328_RNG_BASE		(0xdeadbeef)
 #define BCM_6328_MISC_BASE		(0xb0001800)
+#define BCM_6328_OTP_BASE		(0xb0000600)
+
 /*
  * 6338 register sets base address
  */
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 3203fe4..ec97aa8 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -1434,4 +1434,11 @@
 
 #define PCIE_DEVICE_OFFSET		0x8000
 
+/*************************************************************************
+ * _REG relative to RSET_OTP
+ *************************************************************************/
+
+#define OTP_USER_BITS_6328_REG(i)	(0x20 + (i) * 4)
+#define   OTP_6328_REG3_TP1_DISABLED	BIT(9)
+
 #endif /* BCM63XX_REGS_H_ */
-- 
1.7.10.4
