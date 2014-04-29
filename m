Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2014 16:35:54 +0200 (CEST)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:29457 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843090AbaD2OcGYq0a9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2014 16:32:06 +0200
X-IronPort-AV: E=Sophos;i="4.97,951,1389772800"; 
   d="scan'208";a="26850062"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw2-out.broadcom.com with ESMTP; 29 Apr 2014 07:57:14 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Tue, 29 Apr 2014 07:32:03 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.174.1; Tue, 29 Apr 2014 07:32:04 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 8295651E7F;    Tue, 29 Apr 2014 07:32:03 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 13/17] MIPS: Netlogic: Update XLP9XX/2XX core freq calculation
Date:   Tue, 29 Apr 2014 20:07:52 +0530
Message-ID: <73670cae5cdfb7acbdbb57dabb7644426e0b0717.1398780013.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1398780013.git.jchandra@broadcom.com>
References: <cover.1398780013.git.jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Calculate XLP 9XX and 2XX core frequency from the per-core PLL. This
should give the correct value for all board configurations.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/sys.h |    8 +++
 arch/mips/netlogic/xlp/nlm_hal.c             |   83 ++++++++++++++++++++------
 2 files changed, 73 insertions(+), 18 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/sys.h b/arch/mips/include/asm/netlogic/xlp-hal/sys.h
index bcb136d..bc7bddf 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/sys.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/sys.h
@@ -118,6 +118,10 @@
 #define SYS_SCRTCH3				0x4c
 
 /* PLL registers XLP2XX */
+#define SYS_CPU_PLL_CTRL0(core)			(0x1c0 + (core * 4))
+#define SYS_CPU_PLL_CTRL1(core)			(0x1c1 + (core * 4))
+#define SYS_CPU_PLL_CTRL2(core)			(0x1c2 + (core * 4))
+#define SYS_CPU_PLL_CTRL3(core)			(0x1c3 + (core * 4))
 #define SYS_PLL_CTRL0				0x240
 #define SYS_PLL_CTRL1				0x241
 #define SYS_PLL_CTRL2				0x242
@@ -148,6 +152,10 @@
 #define SYS_PLL_MEM_STAT			0x2a4
 
 /* PLL registers XLP9XX */
+#define SYS_9XX_CPU_PLL_CTRL0(core)		(0xc0 + (core * 4))
+#define SYS_9XX_CPU_PLL_CTRL1(core)		(0xc1 + (core * 4))
+#define SYS_9XX_CPU_PLL_CTRL2(core)		(0xc2 + (core * 4))
+#define SYS_9XX_CPU_PLL_CTRL3(core)		(0xc3 + (core * 4))
 #define SYS_9XX_DMC_PLL_CTRL0			0x140
 #define SYS_9XX_DMC_PLL_CTRL1			0x141
 #define SYS_9XX_DMC_PLL_CTRL2			0x142
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 94469a9..a97b0d0 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -206,34 +206,81 @@ int nlm_irq_to_irt(int irq)
 		return xlp_irq_to_irt(irq);
 }
 
-unsigned int nlm_get_core_frequency(int node, int core)
+static unsigned int nlm_xlp2_get_core_frequency(int node, int core)
+{
+	unsigned int pll_post_div, ctrl_val0, ctrl_val1, denom;
+	uint64_t num, sysbase, clockbase;
+
+	if (cpu_is_xlp9xx()) {
+		clockbase = nlm_get_clock_regbase(node);
+		ctrl_val0 = nlm_read_sys_reg(clockbase,
+					SYS_9XX_CPU_PLL_CTRL0(core));
+		ctrl_val1 = nlm_read_sys_reg(clockbase,
+					SYS_9XX_CPU_PLL_CTRL1(core));
+	} else {
+		sysbase = nlm_get_node(node)->sysbase;
+		ctrl_val0 = nlm_read_sys_reg(sysbase,
+						SYS_CPU_PLL_CTRL0(core));
+		ctrl_val1 = nlm_read_sys_reg(sysbase,
+						SYS_CPU_PLL_CTRL1(core));
+	}
+
+	/* Find PLL post divider value */
+	switch ((ctrl_val0 >> 24) & 0x7) {
+	case 1:
+		pll_post_div = 2;
+		break;
+	case 3:
+		pll_post_div = 4;
+		break;
+	case 7:
+		pll_post_div = 8;
+		break;
+	case 6:
+		pll_post_div = 16;
+		break;
+	case 0:
+	default:
+		pll_post_div = 1;
+		break;
+	}
+
+	num = 1000000ULL * (400 * 3 + 100 * (ctrl_val1 & 0x3f));
+	denom = 3 * pll_post_div;
+	do_div(num, denom);
+
+	return (unsigned int)num;
+}
+
+static unsigned int nlm_xlp_get_core_frequency(int node, int core)
 {
 	unsigned int pll_divf, pll_divr, dfs_div, ext_div;
 	unsigned int rstval, dfsval, denom;
 	uint64_t num, sysbase;
 
 	sysbase = nlm_get_node(node)->sysbase;
-	if (cpu_is_xlp9xx())
-		rstval = nlm_read_sys_reg(sysbase, SYS_9XX_POWER_ON_RESET_CFG);
-	else
-		rstval = nlm_read_sys_reg(sysbase, SYS_POWER_ON_RESET_CFG);
-	if (cpu_is_xlpii()) {
-		num = 1000000ULL * (400 * 3 + 100 * (rstval >> 26));
-		denom = 3;
-	} else {
-		dfsval = nlm_read_sys_reg(sysbase, SYS_CORE_DFS_DIV_VALUE);
-		pll_divf = ((rstval >> 10) & 0x7f) + 1;
-		pll_divr = ((rstval >> 8)  & 0x3) + 1;
-		ext_div  = ((rstval >> 30) & 0x3) + 1;
-		dfs_div  = ((dfsval >> (core * 4)) & 0xf) + 1;
-
-		num = 800000000ULL * pll_divf;
-		denom = 3 * pll_divr * ext_div * dfs_div;
-	}
+	rstval = nlm_read_sys_reg(sysbase, SYS_POWER_ON_RESET_CFG);
+	dfsval = nlm_read_sys_reg(sysbase, SYS_CORE_DFS_DIV_VALUE);
+	pll_divf = ((rstval >> 10) & 0x7f) + 1;
+	pll_divr = ((rstval >> 8)  & 0x3) + 1;
+	ext_div  = ((rstval >> 30) & 0x3) + 1;
+	dfs_div  = ((dfsval >> (core * 4)) & 0xf) + 1;
+
+	num = 800000000ULL * pll_divf;
+	denom = 3 * pll_divr * ext_div * dfs_div;
 	do_div(num, denom);
+
 	return (unsigned int)num;
 }
 
+unsigned int nlm_get_core_frequency(int node, int core)
+{
+	if (cpu_is_xlpii())
+		return nlm_xlp2_get_core_frequency(node, core);
+	else
+		return nlm_xlp_get_core_frequency(node, core);
+}
+
 /*
  * Calculate PIC frequency from PLL registers.
  * freq_out = (ref_freq/2 * (6 + ctrl2[7:0]) + ctrl2[20:8]/2^13) /
-- 
1.7.9.5
