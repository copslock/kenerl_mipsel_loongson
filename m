Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Aug 2013 11:17:23 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:1697 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823124Ab3HKJNeuRe8S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Aug 2013 11:13:34 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 11 Aug 2013 02:03:18 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 11 Aug 2013 02:13:17 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 11 Aug 2013 02:13:17 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id E2AFCF2D73; Sun, 11
 Aug 2013 02:13:15 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Ganesan Ramalingam" <ganesanr@broadcom.com>,
        "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 06/10] MIPS: Netlogic: XLP2XX CPU and PIC frequency
Date:   Sun, 11 Aug 2013 14:43:56 +0530
Message-ID: <1376212440-21038-7-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
References: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E198CDC2L873104932-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37516
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

From: Ganesan Ramalingam <ganesanr@broadcom.com>

Add code to calculate the CPU and PIC frequency for XLP2XX SoCs.

Since the PIC frequency on XLP2XX can be configured, add a new macro
pic_timer_freq() to be used in netlogic/common/time.c.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/pic.h |    5 +-
 arch/mips/include/asm/netlogic/xlp-hal/sys.h |   31 +++++++
 arch/mips/include/asm/netlogic/xlr/pic.h     |    2 +
 arch/mips/netlogic/common/time.c             |    3 +-
 arch/mips/netlogic/xlp/nlm_hal.c             |  123 ++++++++++++++++++++++++--
 5 files changed, 153 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pic.h b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
index 4b5108d..105389b 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/pic.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
@@ -208,13 +208,14 @@
 #define PIC_LOCAL_SCHEDULING		1
 #define PIC_GLOBAL_SCHEDULING		0
 
-#define PIC_CLK_HZ			133333333
-
 #define nlm_read_pic_reg(b, r)	nlm_read_reg64(b, r)
 #define nlm_write_pic_reg(b, r, v) nlm_write_reg64(b, r, v)
 #define nlm_get_pic_pcibase(node) nlm_pcicfg_base(XLP_IO_PIC_OFFSET(node))
 #define nlm_get_pic_regbase(node) (nlm_get_pic_pcibase(node) + XLP_IO_PCI_HDRSZ)
 
+/* We use PIC on node 0 as a timer */
+#define pic_timer_freq()		nlm_get_pic_frequency(0)
+
 /* IRT and h/w interrupt routines */
 static inline int
 nlm_pic_read_irt(uint64_t base, int irt_index)
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/sys.h b/arch/mips/include/asm/netlogic/xlp-hal/sys.h
index 470e52b..fcf2833 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/sys.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/sys.h
@@ -117,6 +117,36 @@
 #define SYS_SCRTCH2				0x4b
 #define SYS_SCRTCH3				0x4c
 
+/* PLL registers XLP2XX */
+#define SYS_PLL_CTRL0				0x240
+#define SYS_PLL_CTRL1				0x241
+#define SYS_PLL_CTRL2				0x242
+#define SYS_PLL_CTRL3				0x243
+#define SYS_DMC_PLL_CTRL0			0x244
+#define SYS_DMC_PLL_CTRL1			0x245
+#define SYS_DMC_PLL_CTRL2			0x246
+#define SYS_DMC_PLL_CTRL3			0x247
+
+#define SYS_PLL_CTRL0_DEVX(x)			(0x248 + (x) * 4)
+#define SYS_PLL_CTRL1_DEVX(x)			(0x249 + (x) * 4)
+#define SYS_PLL_CTRL2_DEVX(x)			(0x24a + (x) * 4)
+#define SYS_PLL_CTRL3_DEVX(x)			(0x24b + (x) * 4)
+
+#define SYS_CPU_PLL_CHG_CTRL			0x288
+#define SYS_PLL_CHG_CTRL			0x289
+#define SYS_CLK_DEV_DIS				0x28a
+#define SYS_CLK_DEV_SEL				0x28b
+#define SYS_CLK_DEV_DIV				0x28c
+#define SYS_CLK_DEV_CHG				0x28d
+#define SYS_CLK_DEV_SEL_REG			0x28e
+#define SYS_CLK_DEV_DIV_REG			0x28f
+#define SYS_CPU_PLL_LOCK			0x29f
+#define SYS_SYS_PLL_LOCK			0x2a0
+#define SYS_PLL_MEM_CMD				0x2a1
+#define SYS_CPU_PLL_MEM_REQ			0x2a2
+#define SYS_SYS_PLL_MEM_REQ			0x2a3
+#define SYS_PLL_MEM_STAT			0x2a4
+
 #ifndef __ASSEMBLY__
 
 #define nlm_read_sys_reg(b, r)		nlm_read_reg(b, r)
@@ -124,5 +154,6 @@
 #define nlm_get_sys_pcibase(node) nlm_pcicfg_base(XLP_IO_SYS_OFFSET(node))
 #define nlm_get_sys_regbase(node) (nlm_get_sys_pcibase(node) + XLP_IO_PCI_HDRSZ)
 
+unsigned int nlm_get_pic_frequency(int node);
 #endif
 #endif
diff --git a/arch/mips/include/asm/netlogic/xlr/pic.h b/arch/mips/include/asm/netlogic/xlr/pic.h
index 63c9917..3c80a75 100644
--- a/arch/mips/include/asm/netlogic/xlr/pic.h
+++ b/arch/mips/include/asm/netlogic/xlr/pic.h
@@ -36,6 +36,8 @@
 #define _ASM_NLM_XLR_PIC_H
 
 #define PIC_CLK_HZ			66666666
+#define pic_timer_freq()		PIC_CLK_HZ
+
 /* PIC hardware interrupt numbers */
 #define PIC_IRT_WD_INDEX		0
 #define PIC_IRT_TIMER_0_INDEX		1
diff --git a/arch/mips/netlogic/common/time.c b/arch/mips/netlogic/common/time.c
index 045a396..13391b8 100644
--- a/arch/mips/netlogic/common/time.c
+++ b/arch/mips/netlogic/common/time.c
@@ -45,6 +45,7 @@
 #if defined(CONFIG_CPU_XLP)
 #include <asm/netlogic/xlp-hal/iomap.h>
 #include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/sys.h>
 #include <asm/netlogic/xlp-hal/pic.h>
 #elif defined(CONFIG_CPU_XLR)
 #include <asm/netlogic/xlr/iomap.h>
@@ -91,7 +92,7 @@ static void nlm_init_pic_timer(void)
 		csrc_pic.read	= nlm_get_pic_timer;
 	}
 	csrc_pic.rating = 1000;
-	clocksource_register_hz(&csrc_pic, PIC_CLK_HZ);
+	clocksource_register_hz(&csrc_pic, pic_timer_freq());
 }
 
 void __init plat_time_init(void)
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 6f2c210..22e2e02 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -127,18 +127,125 @@ unsigned int nlm_get_core_frequency(int node, int core)
 
 	sysbase = nlm_get_node(node)->sysbase;
 	rstval = nlm_read_sys_reg(sysbase, SYS_POWER_ON_RESET_CFG);
-	dfsval = nlm_read_sys_reg(sysbase, SYS_CORE_DFS_DIV_VALUE);
-	pll_divf = ((rstval >> 10) & 0x7f) + 1;
-	pll_divr = ((rstval >> 8)  & 0x3) + 1;
-	ext_div	 = ((rstval >> 30) & 0x3) + 1;
-	dfs_div	 = ((dfsval >> (core * 4)) & 0xf) + 1;
-
-	num = 800000000ULL * pll_divf;
-	denom = 3 * pll_divr * ext_div * dfs_div;
+	if (cpu_is_xlpii()) {
+		num = 1000000ULL * (400 * 3 + 100 * (rstval >> 26));
+		denom = 3;
+	} else {
+		dfsval = nlm_read_sys_reg(sysbase, SYS_CORE_DFS_DIV_VALUE);
+		pll_divf = ((rstval >> 10) & 0x7f) + 1;
+		pll_divr = ((rstval >> 8)  & 0x3) + 1;
+		ext_div  = ((rstval >> 30) & 0x3) + 1;
+		dfs_div  = ((dfsval >> (core * 4)) & 0xf) + 1;
+
+		num = 800000000ULL * pll_divf;
+		denom = 3 * pll_divr * ext_div * dfs_div;
+	}
 	do_div(num, denom);
 	return (unsigned int)num;
 }
 
+/* Calculate Frequency to the PIC from PLL.
+ * freq_out = ( ref_freq/2 * (6 + ctrl2[7:0]) + ctrl2[20:8]/2^13 ) /
+ * ((2^ctrl0[7:5]) * Table(ctrl0[26:24]))
+ */
+static unsigned int nlm_2xx_get_pic_frequency(int node)
+{
+	u32 ctrl_val0, ctrl_val2, vco_post_div, pll_post_div;
+	u32 mdiv, fdiv, pll_out_freq_den, reg_select, ref_div, pic_div;
+	u64 ref_clk, sysbase, pll_out_freq_num, ref_clk_select;
+
+	sysbase = nlm_get_node(node)->sysbase;
+
+	/* Find ref_clk_base */
+	ref_clk_select =
+		(nlm_read_sys_reg(sysbase, SYS_POWER_ON_RESET_CFG) >> 18) & 0x3;
+	switch (ref_clk_select) {
+	case 0:
+		ref_clk = 200000000ULL;
+		ref_div = 3;
+		break;
+	case 1:
+		ref_clk = 100000000ULL;
+		ref_div = 1;
+		break;
+	case 2:
+		ref_clk = 125000000ULL;
+		ref_div = 1;
+		break;
+	case 3:
+		ref_clk = 400000000ULL;
+		ref_div = 3;
+		break;
+	}
+
+	/* Find the clock source PLL device for PIC */
+	reg_select = (nlm_read_sys_reg(sysbase, SYS_CLK_DEV_SEL) >> 22) & 0x3;
+	switch (reg_select) {
+	case 0:
+		ctrl_val0 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL0);
+		ctrl_val2 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL2);
+		break;
+	case 1:
+		ctrl_val0 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL0_DEVX(0));
+		ctrl_val2 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL2_DEVX(0));
+		break;
+	case 2:
+		ctrl_val0 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL0_DEVX(1));
+		ctrl_val2 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL2_DEVX(1));
+		break;
+	case 3:
+		ctrl_val0 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL0_DEVX(2));
+		ctrl_val2 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL2_DEVX(2));
+		break;
+	}
+
+	vco_post_div = (ctrl_val0 >> 5) & 0x7;
+	pll_post_div = (ctrl_val0 >> 24) & 0x7;
+	mdiv = ctrl_val2 & 0xff;
+	fdiv = (ctrl_val2 >> 8) & 0xfff;
+
+	/* Find PLL post divider value */
+	switch (pll_post_div) {
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
+	fdiv = fdiv/(1 << 13);
+	pll_out_freq_num = ((ref_clk >> 1) * (6 + mdiv)) + fdiv;
+	pll_out_freq_den = (1 << vco_post_div) * pll_post_div * 3;
+
+	if (pll_out_freq_den > 0)
+		do_div(pll_out_freq_num, pll_out_freq_den);
+
+	/* PIC post divider, which happens after PLL */
+	pic_div = (nlm_read_sys_reg(sysbase, SYS_CLK_DEV_DIV) >> 22) & 0x3;
+	do_div(pll_out_freq_num, 1 << pic_div);
+
+	return pll_out_freq_num;
+}
+
+unsigned int nlm_get_pic_frequency(int node)
+{
+	if (cpu_is_xlpii())
+		return nlm_2xx_get_pic_frequency(node);
+	else
+		return 133333333;
+}
+
 unsigned int nlm_get_cpu_frequency(void)
 {
 	return nlm_get_core_frequency(0, 0);
-- 
1.7.9.5
