Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 23:39:21 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37615 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011818AbbJ1Wh4ef6LO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 23:37:56 +0100
Received: from hauke-desktop.fritz.box (p5DE94D64.dip0.t-ipconnect.de [93.233.77.100])
        by hauke-m.de (Postfix) with ESMTPSA id 1D7C0100030;
        Wed, 28 Oct 2015 23:37:56 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH 05/15] MIPS: lantiq: add clock detection for grx390 and ar10
Date:   Wed, 28 Oct 2015 23:37:34 +0100
Message-Id: <1446071865-21936-6-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

From: Hauke Mehrtens <hauke.mehrtens@lantiq.com>

From: Hauke Mehrtens <hauke.mehrtens@lantiq.com>

This add detection of some clocks on the ar10 and grx390.

Signed-off-by: Hauke Mehrtens <hauke.mehrtens@lantiq.com>
---
 arch/mips/lantiq/clk.h      |  11 ++++
 arch/mips/lantiq/xway/clk.c | 157 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 167 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/clk.h b/arch/mips/lantiq/clk.h
index 101afcb..7376ce8 100644
--- a/arch/mips/lantiq/clk.h
+++ b/arch/mips/lantiq/clk.h
@@ -34,12 +34,15 @@
 #define CLOCK_288M	288888888
 #define CLOCK_300M	300000000
 #define CLOCK_333M	333333333
+#define CLOCK_360M	360000000
 #define CLOCK_393M	393215332
 #define CLOCK_400M	400000000
 #define CLOCK_432M	432000000
 #define CLOCK_450M	450000000
 #define CLOCK_500M	500000000
 #define CLOCK_600M	600000000
+#define CLOCK_666M	666666666
+#define CLOCK_720M	720000000
 
 /* clock out speeds */
 #define CLOCK_32_768K	32768
@@ -82,4 +85,12 @@ extern unsigned long ltq_vr9_cpu_hz(void);
 extern unsigned long ltq_vr9_fpi_hz(void);
 extern unsigned long ltq_vr9_pp32_hz(void);
 
+extern unsigned long ltq_ar10_cpu_hz(void);
+extern unsigned long ltq_ar10_fpi_hz(void);
+extern unsigned long ltq_ar10_pp32_hz(void);
+
+extern unsigned long ltq_grx390_cpu_hz(void);
+extern unsigned long ltq_grx390_fpi_hz(void);
+extern unsigned long ltq_grx390_pp32_hz(void);
+
 #endif
diff --git a/arch/mips/lantiq/xway/clk.c b/arch/mips/lantiq/xway/clk.c
index ba58ec8..619bff7 100644
--- a/arch/mips/lantiq/xway/clk.c
+++ b/arch/mips/lantiq/xway/clk.c
@@ -27,7 +27,7 @@ static unsigned int ram_clocks[] = {
 
 /* vr9, ar10/grx390 clock */
 #define CGU_SYS_XRX		0x0c
-#define CGU_IF_CLK_VR9		0x24
+#define CGU_IF_CLK_AR10		0x24
 
 unsigned long ltq_danube_fpi_hz(void)
 {
@@ -194,3 +194,158 @@ unsigned long ltq_vr9_pp32_hz(void)
 
 	return clk;
 }
+
+unsigned long ltq_ar10_cpu_hz(void)
+{
+	unsigned int clksys;
+	int cpu_fs = (ltq_cgu_r32(CGU_SYS_XRX) >> 8) & 0x1;
+	int freq_div = (ltq_cgu_r32(CGU_SYS_XRX) >> 4) & 0x7;
+
+	switch (cpu_fs) {
+	case 0:
+		clksys = CLOCK_500M;
+		break;
+	case 1:
+		clksys = CLOCK_600M;
+		break;
+	default:
+		clksys = CLOCK_500M;
+		break;
+	}
+
+	switch (freq_div) {
+	case 0:
+		return clksys;
+	case 1:
+		return clksys >> 1;
+	case 2:
+		return clksys >> 2;
+	default:
+		return clksys;
+	}
+}
+
+unsigned long ltq_ar10_fpi_hz(void)
+{
+	int freq_fpi = (ltq_cgu_r32(CGU_IF_CLK_AR10) >> 25) & 0xf;
+
+	switch (freq_fpi) {
+	case 1:
+		return CLOCK_300M;
+	case 5:
+		return CLOCK_250M;
+	case 2:
+		return CLOCK_150M;
+	case 6:
+		return CLOCK_125M;
+
+	default:
+		return CLOCK_125M;
+	}
+}
+
+unsigned long ltq_ar10_pp32_hz(void)
+{
+	unsigned int clksys = (ltq_cgu_r32(CGU_SYS) >> 16) & 0x7;
+	unsigned long clk;
+
+	switch (clksys) {
+	case 1:
+		clk = CLOCK_250M;
+		break;
+	case 4:
+		clk = CLOCK_400M;
+		break;
+	default:
+		clk = CLOCK_250M;
+		break;
+	}
+
+	return clk;
+}
+
+unsigned long ltq_grx390_cpu_hz(void)
+{
+	unsigned int clksys;
+	int cpu_fs = ((ltq_cgu_r32(CGU_SYS_XRX) >> 9) & 0x3);
+	int freq_div = ((ltq_cgu_r32(CGU_SYS_XRX) >> 4) & 0x7);
+
+	switch (cpu_fs) {
+	case 0:
+		clksys = CLOCK_600M;
+		break;
+	case 1:
+		clksys = CLOCK_666M;
+		break;
+	case 2:
+		clksys = CLOCK_720M;
+		break;
+	default:
+		clksys = CLOCK_600M;
+		break;
+	}
+
+	switch (freq_div) {
+	case 0:
+		return clksys;
+	case 1:
+		return clksys >> 1;
+	case 2:
+		return clksys >> 2;
+	default:
+		return clksys;
+	}
+}
+
+unsigned long ltq_grx390_fpi_hz(void)
+{
+	/* fpi clock is derived from ddr_clk */
+	unsigned int clksys;
+	int cpu_fs = ((ltq_cgu_r32(CGU_SYS_XRX) >> 9) & 0x3);
+	int freq_div = ((ltq_cgu_r32(CGU_SYS_XRX)) & 0x7);
+	switch (cpu_fs) {
+	case 0:
+		clksys = CLOCK_600M;
+		break;
+	case 1:
+		clksys = CLOCK_666M;
+		break;
+	case 2:
+		clksys = CLOCK_720M;
+		break;
+	default:
+		clksys = CLOCK_600M;
+		break;
+	}
+
+	switch (freq_div) {
+	case 1:
+		return clksys >> 1;
+	case 2:
+		return clksys >> 2;
+	default:
+		return clksys >> 1;
+	}
+}
+
+unsigned long ltq_grx390_pp32_hz(void)
+{
+	unsigned int clksys = (ltq_cgu_r32(CGU_SYS) >> 16) & 0x7;
+	unsigned long clk;
+
+	switch (clksys) {
+	case 1:
+		clk = CLOCK_250M;
+		break;
+	case 2:
+		clk = CLOCK_432M;
+		break;
+	case 4:
+		clk = CLOCK_400M;
+		break;
+	default:
+		clk = CLOCK_250M;
+		break;
+	}
+	return clk;
+}
-- 
2.6.1
