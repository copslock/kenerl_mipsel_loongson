Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2015 11:50:40 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37377 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011142AbbKDKuZVMxkw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Nov 2015 11:50:25 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id C2FCD28098D;
        Wed,  4 Nov 2015 11:48:33 +0100 (CET)
Received: from localhost.localdomain (p548C90D8.dip0.t-ipconnect.de [84.140.144.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed,  4 Nov 2015 11:48:33 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 2/9] arch: mips: ralink: unify SoC id handling
Date:   Wed,  4 Nov 2015 11:50:07 +0100
Message-Id: <1446634214-11564-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
References: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

This makes detection a lot easier for audio, wifi, ... drivers.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/mt7620.h      |    7 -------
 arch/mips/include/asm/mach-ralink/ralink_regs.h |   17 +++++++++++++++++
 arch/mips/include/asm/mach-ralink/rt305x.h      |   21 ++++++---------------
 arch/mips/ralink/mt7620.c                       |   15 ++++++---------
 arch/mips/ralink/prom.c                         |    5 +++++
 arch/mips/ralink/rt288x.c                       |    1 +
 arch/mips/ralink/rt305x.c                       |   12 +++++-------
 arch/mips/ralink/rt3883.c                       |    2 ++
 8 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
index 590681a..455d406 100644
--- a/arch/mips/include/asm/mach-ralink/mt7620.h
+++ b/arch/mips/include/asm/mach-ralink/mt7620.h
@@ -13,13 +13,6 @@
 #ifndef _MT7620_REGS_H_
 #define _MT7620_REGS_H_
 
-enum mt762x_soc_type {
-	MT762X_SOC_UNKNOWN = 0,
-	MT762X_SOC_MT7620A,
-	MT762X_SOC_MT7620N,
-	MT762X_SOC_MT7628AN,
-};
-
 #define MT7620_SYSC_BASE		0x10000000
 
 #define SYSC_REG_CHIP_NAME0		0x00
diff --git a/arch/mips/include/asm/mach-ralink/ralink_regs.h b/arch/mips/include/asm/mach-ralink/ralink_regs.h
index bd93014..4c9fba6 100644
--- a/arch/mips/include/asm/mach-ralink/ralink_regs.h
+++ b/arch/mips/include/asm/mach-ralink/ralink_regs.h
@@ -13,6 +13,23 @@
 #ifndef _RALINK_REGS_H_
 #define _RALINK_REGS_H_
 
+enum ralink_soc_type {
+	RALINK_UNKNOWN = 0,
+	RT2880_SOC,
+	RT3883_SOC,
+	RT305X_SOC_RT3050,
+	RT305X_SOC_RT3052,
+	RT305X_SOC_RT3350,
+	RT305X_SOC_RT3352,
+	RT305X_SOC_RT5350,
+	MT762X_SOC_MT7620A,
+	MT762X_SOC_MT7620N,
+	MT762X_SOC_MT7621AT,
+	MT762X_SOC_MT7628AN,
+	MT762X_SOC_MT7688,
+};
+extern enum ralink_soc_type ralink_soc;
+
 extern __iomem void *rt_sysc_membase;
 extern __iomem void *rt_memc_membase;
 
diff --git a/arch/mips/include/asm/mach-ralink/rt305x.h b/arch/mips/include/asm/mach-ralink/rt305x.h
index 96f731b..2eea793 100644
--- a/arch/mips/include/asm/mach-ralink/rt305x.h
+++ b/arch/mips/include/asm/mach-ralink/rt305x.h
@@ -13,25 +13,16 @@
 #ifndef _RT305X_REGS_H_
 #define _RT305X_REGS_H_
 
-enum rt305x_soc_type {
-	RT305X_SOC_UNKNOWN = 0,
-	RT305X_SOC_RT3050,
-	RT305X_SOC_RT3052,
-	RT305X_SOC_RT3350,
-	RT305X_SOC_RT3352,
-	RT305X_SOC_RT5350,
-};
-
-extern enum rt305x_soc_type rt305x_soc;
+extern enum ralink_soc_type ralink_soc;
 
 static inline int soc_is_rt3050(void)
 {
-	return rt305x_soc == RT305X_SOC_RT3050;
+	return ralink_soc == RT305X_SOC_RT3050;
 }
 
 static inline int soc_is_rt3052(void)
 {
-	return rt305x_soc == RT305X_SOC_RT3052;
+	return ralink_soc == RT305X_SOC_RT3052;
 }
 
 static inline int soc_is_rt305x(void)
@@ -41,17 +32,17 @@ static inline int soc_is_rt305x(void)
 
 static inline int soc_is_rt3350(void)
 {
-	return rt305x_soc == RT305X_SOC_RT3350;
+	return ralink_soc == RT305X_SOC_RT3350;
 }
 
 static inline int soc_is_rt3352(void)
 {
-	return rt305x_soc == RT305X_SOC_RT3352;
+	return ralink_soc == RT305X_SOC_RT3352;
 }
 
 static inline int soc_is_rt5350(void)
 {
-	return rt305x_soc == RT305X_SOC_RT5350;
+	return ralink_soc == RT305X_SOC_RT5350;
 }
 
 #define RT305X_SYSC_BASE		0x10000000
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 4d1a033..f3a4a08 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -37,9 +37,6 @@
 #define PMU1_CFG		0x8C
 #define DIG_SW_SEL		BIT(25)
 
-/* is this a MT7620 or a MT7628 */
-enum mt762x_soc_type mt762x_soc;
-
 /* EFUSE bits */
 #define EFUSE_MT7688		0x100000
 
@@ -235,8 +232,8 @@ static struct rt2880_pmx_group mt7628an_pinmux_data[] = {
 
 static inline int is_mt76x8(void)
 {
-	return mt762x_soc == MT762X_SOC_MT7628AN ||
-	       mt762x_soc == MT762X_SOC_MT7688;
+	return ralink_soc == MT762X_SOC_MT7628AN ||
+	       ralink_soc == MT762X_SOC_MT7688;
 }
 
 static __init u32
@@ -511,11 +508,11 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 
 	if (n0 == MT7620_CHIP_NAME0 && n1 == MT7620_CHIP_NAME1) {
 		if (bga) {
-			mt762x_soc = MT762X_SOC_MT7620A;
+			ralink_soc = MT762X_SOC_MT7620A;
 			name = "MT7620A";
 			soc_info->compatible = "ralink,mt7620a-soc";
 		} else {
-			mt762x_soc = MT762X_SOC_MT7620N;
+			ralink_soc = MT762X_SOC_MT7620N;
 			name = "MT7620N";
 			soc_info->compatible = "ralink,mt7620n-soc";
 #ifdef CONFIG_PCI
@@ -526,10 +523,10 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 		u32 efuse = __raw_readl(sysc + SYSC_REG_EFUSE_CFG);
 
 		if (efuse & EFUSE_MT7688) {
-			mt762x_soc = MT762X_SOC_MT7688;
+			ralink_soc = MT762X_SOC_MT7688;
 			name = "MT7688";
 		} else {
-			mt762x_soc = MT762X_SOC_MT7628AN;
+			ralink_soc = MT762X_SOC_MT7628AN;
 			name = "MT7628AN";
 		}
 		soc_info->compatible = "ralink,mt7628an-soc";
diff --git a/arch/mips/ralink/prom.c b/arch/mips/ralink/prom.c
index 09419f6..39a9142f 100644
--- a/arch/mips/ralink/prom.c
+++ b/arch/mips/ralink/prom.c
@@ -15,11 +15,16 @@
 #include <asm/bootinfo.h>
 #include <asm/addrspace.h>
 
+#include <asm/mach-ralink/ralink_regs.h>
+
 #include "common.h"
 
 struct ralink_soc_info soc_info;
 struct rt2880_pmx_group *rt2880_pinmux_data = NULL;
 
+enum ralink_soc_type ralink_soc;
+EXPORT_SYMBOL_GPL(ralink_soc);
+
 const char *get_system_type(void)
 {
 	return soc_info.sys_type;
diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index 738cec8..844f5cd 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -119,4 +119,5 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 	soc_info->mem_size_max = RT2880_MEM_SIZE_MAX;
 
 	rt2880_pinmux_data = rt2880_pinmux_data_act;
+	ralink_soc == RT2880_SOC;
 }
diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index c40776a..7e11f00 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -21,8 +21,6 @@
 
 #include "common.h"
 
-enum rt305x_soc_type rt305x_soc;
-
 static struct rt2880_pmx_func i2c_func[] =  { FUNC("i2c", 0, 1, 2) };
 static struct rt2880_pmx_func spi_func[] = { FUNC("spi", 0, 3, 4) };
 static struct rt2880_pmx_func uartf_func[] = {
@@ -235,24 +233,24 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 
 		icache_sets = (read_c0_config1() >> 22) & 7;
 		if (icache_sets == 1) {
-			rt305x_soc = RT305X_SOC_RT3050;
+			ralink_soc = RT305X_SOC_RT3050;
 			name = "RT3050";
 			soc_info->compatible = "ralink,rt3050-soc";
 		} else {
-			rt305x_soc = RT305X_SOC_RT3052;
+			ralink_soc = RT305X_SOC_RT3052;
 			name = "RT3052";
 			soc_info->compatible = "ralink,rt3052-soc";
 		}
 	} else if (n0 == RT3350_CHIP_NAME0 && n1 == RT3350_CHIP_NAME1) {
-		rt305x_soc = RT305X_SOC_RT3350;
+		ralink_soc = RT305X_SOC_RT3350;
 		name = "RT3350";
 		soc_info->compatible = "ralink,rt3350-soc";
 	} else if (n0 == RT3352_CHIP_NAME0 && n1 == RT3352_CHIP_NAME1) {
-		rt305x_soc = RT305X_SOC_RT3352;
+		ralink_soc = RT305X_SOC_RT3352;
 		name = "RT3352";
 		soc_info->compatible = "ralink,rt3352-soc";
 	} else if (n0 == RT5350_CHIP_NAME0 && n1 == RT5350_CHIP_NAME1) {
-		rt305x_soc = RT305X_SOC_RT5350;
+		ralink_soc = RT305X_SOC_RT5350;
 		name = "RT5350";
 		soc_info->compatible = "ralink,rt5350-soc";
 	} else {
diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index 86a535c..582995a 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -153,4 +153,6 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 	soc_info->mem_size_max = RT3883_MEM_SIZE_MAX;
 
 	rt2880_pinmux_data = rt3883_pinmux_data;
+
+	ralink_soc == RT3883_SOC;
 }
-- 
1.7.10.4
