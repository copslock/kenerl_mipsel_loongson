Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2014 16:38:07 +0200 (CEST)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:5264 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854770AbaD2OcYEpWSV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2014 16:32:24 +0200
X-IronPort-AV: E=Sophos;i="4.97,951,1389772800"; 
   d="scan'208";a="26655038"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 29 Apr 2014 07:52:11 -0700
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Tue, 29 Apr 2014 07:32:02 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.3.174.1; Tue, 29 Apr 2014 07:32:03 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 DE6E951E7D;    Tue, 29 Apr 2014 07:32:01 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Ganesan Ramalingam <ganesanr@broadcom.com>, <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 12/17] MIPS: Netlogic: PIC freq calculation for XLP 9XX/2XX
Date:   Tue, 29 Apr 2014 20:07:51 +0530
Message-ID: <e0f5db32ff7a4b66ca878b1c05fb6a5575781352.1398780013.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1398780013.git.jchandra@broadcom.com>
References: <cover.1398780013.git.jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39985
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

Update PIC frequency calculation for XLP9XX and 2XX processors using
the correct PLL registers. This should work for all possible board
configurations.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h |    2 +
 arch/mips/include/asm/netlogic/xlp-hal/sys.h   |   27 ++++++
 arch/mips/netlogic/common/time.c               |    5 +-
 arch/mips/netlogic/xlp/nlm_hal.c               |  114 +++++++++++++++++-------
 4 files changed, 114 insertions(+), 34 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
index 14b2f51..805bfd2 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
@@ -120,6 +120,8 @@
 #define XLP9XX_IO_UART_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 2, 2)
 #define XLP9XX_IO_SYS_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 6, 0)
 #define XLP9XX_IO_FUSE_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 6, 1)
+#define XLP9XX_IO_CLOCK_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 6, 2)
+#define XLP9XX_IO_POWER_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 6, 3)
 #define XLP9XX_IO_JTAG_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 6, 4)
 
 #define XLP9XX_IO_PCIE_OFFSET(node, i)	XLP9XX_HDR_OFFSET(node, 1, i)
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/sys.h b/arch/mips/include/asm/netlogic/xlp-hal/sys.h
index d9b107f..bcb136d 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/sys.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/sys.h
@@ -147,6 +147,28 @@
 #define SYS_SYS_PLL_MEM_REQ			0x2a3
 #define SYS_PLL_MEM_STAT			0x2a4
 
+/* PLL registers XLP9XX */
+#define SYS_9XX_DMC_PLL_CTRL0			0x140
+#define SYS_9XX_DMC_PLL_CTRL1			0x141
+#define SYS_9XX_DMC_PLL_CTRL2			0x142
+#define SYS_9XX_DMC_PLL_CTRL3			0x143
+#define SYS_9XX_PLL_CTRL0			0x144
+#define SYS_9XX_PLL_CTRL1			0x145
+#define SYS_9XX_PLL_CTRL2			0x146
+#define SYS_9XX_PLL_CTRL3			0x147
+
+#define SYS_9XX_PLL_CTRL0_DEVX(x)		(0x148 + (x) * 4)
+#define SYS_9XX_PLL_CTRL1_DEVX(x)		(0x149 + (x) * 4)
+#define SYS_9XX_PLL_CTRL2_DEVX(x)		(0x14a + (x) * 4)
+#define SYS_9XX_PLL_CTRL3_DEVX(x)		(0x14b + (x) * 4)
+
+#define SYS_9XX_CPU_PLL_CHG_CTRL		0x188
+#define SYS_9XX_PLL_CHG_CTRL			0x189
+#define SYS_9XX_CLK_DEV_DIS			0x18a
+#define SYS_9XX_CLK_DEV_SEL			0x18b
+#define SYS_9XX_CLK_DEV_DIV			0x18d
+#define SYS_9XX_CLK_DEV_CHG			0x18f
+
 /* Registers changed on 9XX */
 #define SYS_9XX_POWER_ON_RESET_CFG		0x00
 #define SYS_9XX_CHIP_RESET			0x01
@@ -170,6 +192,11 @@
 #define nlm_get_fuse_regbase(node)	\
 			(nlm_get_fuse_pcibase(node) + XLP_IO_PCI_HDRSZ)
 
+#define nlm_get_clock_pcibase(node)	\
+			nlm_pcicfg_base(XLP9XX_IO_CLOCK_OFFSET(node))
+#define nlm_get_clock_regbase(node)	\
+			(nlm_get_clock_pcibase(node) + XLP_IO_PCI_HDRSZ)
+
 unsigned int nlm_get_pic_frequency(int node);
 #endif
 #endif
diff --git a/arch/mips/netlogic/common/time.c b/arch/mips/netlogic/common/time.c
index 13391b8..0c0a1a6 100644
--- a/arch/mips/netlogic/common/time.c
+++ b/arch/mips/netlogic/common/time.c
@@ -82,6 +82,7 @@ static struct clocksource csrc_pic = {
 static void nlm_init_pic_timer(void)
 {
 	uint64_t picbase = nlm_get_node(0)->picbase;
+	u32 picfreq;
 
 	nlm_pic_set_timer(picbase, PIC_CLOCK_TIMER, ~0ULL, 0, 0);
 	if (current_cpu_data.cputype == CPU_XLR) {
@@ -92,7 +93,9 @@ static void nlm_init_pic_timer(void)
 		csrc_pic.read	= nlm_get_pic_timer;
 	}
 	csrc_pic.rating = 1000;
-	clocksource_register_hz(&csrc_pic, pic_timer_freq());
+	picfreq = pic_timer_freq();
+	clocksource_register_hz(&csrc_pic, picfreq);
+	pr_info("PIC clock source added, frequency %d\n", picfreq);
 }
 
 void __init plat_time_init(void)
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 44dc159..94469a9 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -234,21 +234,28 @@ unsigned int nlm_get_core_frequency(int node, int core)
 	return (unsigned int)num;
 }
 
-/* Calculate Frequency to the PIC from PLL.
- * freq_out = ( ref_freq/2 * (6 + ctrl2[7:0]) + ctrl2[20:8]/2^13 ) /
- * ((2^ctrl0[7:5]) * Table(ctrl0[26:24]))
+/*
+ * Calculate PIC frequency from PLL registers.
+ * freq_out = (ref_freq/2 * (6 + ctrl2[7:0]) + ctrl2[20:8]/2^13) /
+ * 		((2^ctrl0[7:5]) * Table(ctrl0[26:24]))
  */
-static unsigned int nlm_2xx_get_pic_frequency(int node)
+static unsigned int nlm_xlp2_get_pic_frequency(int node)
 {
-	u32 ctrl_val0, ctrl_val2, vco_post_div, pll_post_div;
+	u32 ctrl_val0, ctrl_val2, vco_post_div, pll_post_div, cpu_xlp9xx;
 	u32 mdiv, fdiv, pll_out_freq_den, reg_select, ref_div, pic_div;
-	u64 ref_clk, sysbase, pll_out_freq_num, ref_clk_select;
+	u64 sysbase, pll_out_freq_num, ref_clk_select, clockbase, ref_clk;
 
 	sysbase = nlm_get_node(node)->sysbase;
+	clockbase = nlm_get_clock_regbase(node);
+	cpu_xlp9xx = cpu_is_xlp9xx();
 
 	/* Find ref_clk_base */
-	ref_clk_select =
-		(nlm_read_sys_reg(sysbase, SYS_POWER_ON_RESET_CFG) >> 18) & 0x3;
+	if (cpu_xlp9xx)
+		ref_clk_select = (nlm_read_sys_reg(sysbase,
+				SYS_9XX_POWER_ON_RESET_CFG) >> 18) & 0x3;
+	else
+		ref_clk_select = (nlm_read_sys_reg(sysbase,
+					SYS_POWER_ON_RESET_CFG) >> 18) & 0x3;
 	switch (ref_clk_select) {
 	case 0:
 		ref_clk = 200000000ULL;
@@ -269,30 +276,70 @@ static unsigned int nlm_2xx_get_pic_frequency(int node)
 	}
 
 	/* Find the clock source PLL device for PIC */
-	reg_select = (nlm_read_sys_reg(sysbase, SYS_CLK_DEV_SEL) >> 22) & 0x3;
-	switch (reg_select) {
-	case 0:
-		ctrl_val0 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL0);
-		ctrl_val2 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL2);
-		break;
-	case 1:
-		ctrl_val0 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL0_DEVX(0));
-		ctrl_val2 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL2_DEVX(0));
-		break;
-	case 2:
-		ctrl_val0 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL0_DEVX(1));
-		ctrl_val2 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL2_DEVX(1));
-		break;
-	case 3:
-		ctrl_val0 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL0_DEVX(2));
-		ctrl_val2 = nlm_read_sys_reg(sysbase, SYS_PLL_CTRL2_DEVX(2));
-		break;
+	if (cpu_xlp9xx) {
+		reg_select = nlm_read_sys_reg(clockbase,
+				SYS_9XX_CLK_DEV_SEL) & 0x3;
+		switch (reg_select) {
+		case 0:
+			ctrl_val0 = nlm_read_sys_reg(clockbase,
+					SYS_9XX_PLL_CTRL0);
+			ctrl_val2 = nlm_read_sys_reg(clockbase,
+					SYS_9XX_PLL_CTRL2);
+			break;
+		case 1:
+			ctrl_val0 = nlm_read_sys_reg(clockbase,
+					SYS_9XX_PLL_CTRL0_DEVX(0));
+			ctrl_val2 = nlm_read_sys_reg(clockbase,
+					SYS_9XX_PLL_CTRL2_DEVX(0));
+			break;
+		case 2:
+			ctrl_val0 = nlm_read_sys_reg(clockbase,
+					SYS_9XX_PLL_CTRL0_DEVX(1));
+			ctrl_val2 = nlm_read_sys_reg(clockbase,
+					SYS_9XX_PLL_CTRL2_DEVX(1));
+			break;
+		case 3:
+			ctrl_val0 = nlm_read_sys_reg(clockbase,
+					SYS_9XX_PLL_CTRL0_DEVX(2));
+			ctrl_val2 = nlm_read_sys_reg(clockbase,
+					SYS_9XX_PLL_CTRL2_DEVX(2));
+			break;
+		}
+	} else {
+		reg_select = (nlm_read_sys_reg(sysbase,
+					SYS_CLK_DEV_SEL) >> 22) & 0x3;
+		switch (reg_select) {
+		case 0:
+			ctrl_val0 = nlm_read_sys_reg(sysbase,
+					SYS_PLL_CTRL0);
+			ctrl_val2 = nlm_read_sys_reg(sysbase,
+					SYS_PLL_CTRL2);
+			break;
+		case 1:
+			ctrl_val0 = nlm_read_sys_reg(sysbase,
+					SYS_PLL_CTRL0_DEVX(0));
+			ctrl_val2 = nlm_read_sys_reg(sysbase,
+					SYS_PLL_CTRL2_DEVX(0));
+			break;
+		case 2:
+			ctrl_val0 = nlm_read_sys_reg(sysbase,
+					SYS_PLL_CTRL0_DEVX(1));
+			ctrl_val2 = nlm_read_sys_reg(sysbase,
+					SYS_PLL_CTRL2_DEVX(1));
+			break;
+		case 3:
+			ctrl_val0 = nlm_read_sys_reg(sysbase,
+					SYS_PLL_CTRL0_DEVX(2));
+			ctrl_val2 = nlm_read_sys_reg(sysbase,
+					SYS_PLL_CTRL2_DEVX(2));
+			break;
+		}
 	}
 
 	vco_post_div = (ctrl_val0 >> 5) & 0x7;
 	pll_post_div = (ctrl_val0 >> 24) & 0x7;
 	mdiv = ctrl_val2 & 0xff;
-	fdiv = (ctrl_val2 >> 8) & 0xfff;
+	fdiv = (ctrl_val2 >> 8) & 0x1fff;
 
 	/* Find PLL post divider value */
 	switch (pll_post_div) {
@@ -322,7 +369,12 @@ static unsigned int nlm_2xx_get_pic_frequency(int node)
 		do_div(pll_out_freq_num, pll_out_freq_den);
 
 	/* PIC post divider, which happens after PLL */
-	pic_div = (nlm_read_sys_reg(sysbase, SYS_CLK_DEV_DIV) >> 22) & 0x3;
+	if (cpu_xlp9xx)
+		pic_div = nlm_read_sys_reg(clockbase,
+				SYS_9XX_CLK_DEV_DIV) & 0x3;
+	else
+		pic_div = (nlm_read_sys_reg(sysbase,
+					SYS_CLK_DEV_DIV) >> 22) & 0x3;
 	do_div(pll_out_freq_num, 1 << pic_div);
 
 	return pll_out_freq_num;
@@ -330,12 +382,8 @@ static unsigned int nlm_2xx_get_pic_frequency(int node)
 
 unsigned int nlm_get_pic_frequency(int node)
 {
-	/* TODO Has to calculate freq as like 2xx */
-	if (cpu_is_xlp9xx())
-		return 250000000;
-
 	if (cpu_is_xlpii())
-		return nlm_2xx_get_pic_frequency(node);
+		return nlm_xlp2_get_pic_frequency(node);
 	else
 		return 133333333;
 }
-- 
1.7.9.5
