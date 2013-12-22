Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Dec 2013 14:37:13 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:41102 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817090Ab3LVNgvARF75 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Dec 2013 14:36:51 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 1415C8F65;
        Sun, 22 Dec 2013 14:36:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pd4IUWUhtllF; Sun, 22 Dec 2013 14:36:44 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 529378F61;
        Sun, 22 Dec 2013 14:36:44 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, blogic@openwrt.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] MIPS: BCM47XX: add cpu-feature-overrides.h
Date:   Sun, 22 Dec 2013 14:36:31 +0100
Message-Id: <1387719392-17565-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1387719392-17565-1-git-send-email-hauke@hauke-m.de>
References: <1387719392-17565-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38797
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

The BCM47XX SoC code missed a cpu-feature-overrides.h header file, this
patch adds it. This code supports a long line of SoCs with different
features so for some features we still have to rely on the runtime
detection.

This was crated by checking the features of a BCM4712, BCM4704,
BCM5354, BCM4716 and BCM4706 SoC and then tested on these SoCs. There
are some SoCs missing but I hope they do not have any more or less
features.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../asm/mach-bcm47xx/cpu-feature-overrides.h       |   82 ++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-bcm47xx/cpu-feature-overrides.h

diff --git a/arch/mips/include/asm/mach-bcm47xx/cpu-feature-overrides.h b/arch/mips/include/asm/mach-bcm47xx/cpu-feature-overrides.h
new file mode 100644
index 0000000..b7992cd
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm47xx/cpu-feature-overrides.h
@@ -0,0 +1,82 @@
+#ifndef __ASM_MACH_BCM47XX_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_BCM47XX_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_has_tlb			1
+#define cpu_has_4kex			1
+#define cpu_has_3k_cache		0
+#define cpu_has_4k_cache		1
+#define cpu_has_tx39_cache		0
+#define cpu_has_fpu			0
+#define cpu_has_32fpr			0
+#define cpu_has_counter			1
+#if defined(CONFIG_BCM47XX_BCMA) && !defined(CONFIG_BCM47XX_SSB)
+#define cpu_has_watch			1
+#elif defined(CONFIG_BCM47XX_SSB) && !defined(CONFIG_BCM47XX_BCMA)
+#define cpu_has_watch			0
+#endif
+#define cpu_has_divec			1
+#define cpu_has_vce			0
+#define cpu_has_cache_cdex_p		0
+#define cpu_has_cache_cdex_s		0
+#define cpu_has_prefetch		1
+#define cpu_has_mcheck			1
+#define cpu_has_ejtag			1
+#define cpu_has_llsc			1
+
+/* cpu_has_mips16 */
+#define cpu_has_mdmx			0
+#define cpu_has_mips3d			0
+#define cpu_has_rixi			0
+#define cpu_has_mmips			0
+#define cpu_has_smartmips		0
+#define cpu_has_vtag_icache		0
+/* cpu_has_dc_aliases */
+#define cpu_has_ic_fills_f_dc		0
+#define cpu_has_pindexed_dcache		0
+#define cpu_icache_snoops_remote_store	0
+
+#define cpu_has_mips_2			1
+#define cpu_has_mips_3			0
+#define cpu_has_mips32r1		1
+#if defined(CONFIG_BCM47XX_BCMA) && !defined(CONFIG_BCM47XX_SSB)
+#define cpu_has_mips32r2		1
+#elif defined(CONFIG_BCM47XX_SSB) && !defined(CONFIG_BCM47XX_BCMA)
+#define cpu_has_mips32r2		0
+#endif
+#define cpu_has_mips64r1		0
+#define cpu_has_mips64r2		0
+
+#if defined(CONFIG_BCM47XX_BCMA) && !defined(CONFIG_BCM47XX_SSB)
+#define cpu_has_dsp			1
+#define cpu_has_dsp2			1
+#elif defined(CONFIG_BCM47XX_SSB) && !defined(CONFIG_BCM47XX_BCMA)
+#define cpu_has_dsp			0
+#define cpu_has_dsp2			0
+#endif
+#define cpu_has_mipsmt			0
+/* cpu_has_userlocal */
+
+#define cpu_has_nofpuex			0
+#define cpu_has_64bits			0
+#define cpu_has_64bit_zero_reg		0
+#if defined(CONFIG_BCM47XX_BCMA) && !defined(CONFIG_BCM47XX_SSB)
+#define cpu_has_vint			1
+#elif defined(CONFIG_BCM47XX_SSB) && !defined(CONFIG_BCM47XX_BCMA)
+#define cpu_has_vint			0
+#endif
+#define cpu_has_veic			0
+#define cpu_has_inclusive_pcaches	0
+
+#if defined(CONFIG_BCM47XX_BCMA) && !defined(CONFIG_BCM47XX_SSB)
+#define cpu_dcache_line_size()		32
+#define cpu_icache_line_size()		32
+#define cpu_has_perf_cntr_intr_bit	1
+#elif defined(CONFIG_BCM47XX_SSB) && !defined(CONFIG_BCM47XX_BCMA)
+#define cpu_dcache_line_size()		16
+#define cpu_icache_line_size()		16
+#define cpu_has_perf_cntr_intr_bit	0
+#endif
+#define cpu_scache_line_size()		0
+#define cpu_has_vz			0
+
+#endif /* __ASM_MACH_BCM47XX_CPU_FEATURE_OVERRIDES_H */
-- 
1.7.10.4
