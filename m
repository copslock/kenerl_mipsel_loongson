Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 23:44:14 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:59479 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823056Ab3EWVoHQUqNw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 May 2013 23:44:07 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-012-093.pools.arcor-ip.net [88.73.12.93])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 0890E2802DD;
        Thu, 23 May 2013 23:42:52 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        "Steven J. Hill" <sjhill@mips.com>,
        David Daney <david.daney@cavium.com>,
        John Crispin <blogic@openwrt.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] MIPS: define cpu_has_mmips where appropriate
Date:   Thu, 23 May 2013 23:42:14 +0200
Message-Id: <1369345335-28062-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36577
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

Disable cpu_has_mmips for everything but SEAD3 and MALTA. Most of these
platforms are from before the micromips introduction, so they are very
unlikely to implement it.

Reduces an -Os compiled, uncompressed kernel image by 8KiB for BCM63XX.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---

Position chosen is based on asm/cpu-features.h. Missing hardware and/or
data sheets for most platforms I obviously couldn't verify its
non-existence, so maintainer acks are appreciated.

 arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h         |    1 +
 arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h        |    1 +
 arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h       |    1 +
 arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h |    1 +
 arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h        |    1 +
 arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h          |    1 +
 arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h          |    1 +
 arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h          |    1 +
 arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h          |    1 +
 arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h        |    1 +
 arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h      |    1 +
 arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h      |    1 +
 arch/mips/include/asm/mach-pmcs-msp71xx/cpu-feature-overrides.h  |    1 +
 arch/mips/include/asm/mach-powertv/cpu-feature-overrides.h       |    1 +
 arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h |    1 +
 arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h |    1 +
 arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h |    1 +
 arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h       |    1 +
 arch/mips/include/asm/mach-rm/cpu-feature-overrides.h            |    1 +
 arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h        |    1 +
 arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h        |    1 +
 21 files changed, 21 insertions(+)

diff --git a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
index ddb947e..d7d2b91 100644
--- a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
@@ -36,6 +36,7 @@
 #define cpu_has_mdmx		0
 #define cpu_has_mips3d		0
 #define cpu_has_smartmips	0
+#define cpu_has_mmips		0
 
 #define cpu_has_mips32r1	1
 #define cpu_has_mips32r2	1
diff --git a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
index 09f45e6..2c33b1f 100644
--- a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
@@ -28,6 +28,7 @@
 #define cpu_has_mdmx			0
 #define cpu_has_mips3d			0
 #define cpu_has_smartmips		0
+#define cpu_has_mmips			0
 #define cpu_has_vtag_icache		0
 #define cpu_has_dc_aliases		0
 #define cpu_has_ic_fills_f_dc		1
diff --git a/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h b/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
index e9c408e..91d76fa 100644
--- a/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
@@ -22,6 +22,7 @@
 #define cpu_has_mdmx			0
 #define cpu_has_mips3d			0
 #define cpu_has_smartmips		0
+#define cpu_has_mmips			0
 #define cpu_has_vtag_icache		0
 
 #if !defined(BCMCPU_RUNTIME_DETECT) && (defined(CONFIG_BCM63XX_CPU_6348) || defined(CONFIG_BCM63XX_CPU_6345) || defined(CONFIG_BCM63XX_CPU_6338))
diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index 94ed063..862fb99 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -55,6 +55,7 @@
 #define cpu_has_dsp		0
 #define cpu_has_dsp2		0
 #define cpu_has_mipsmt		0
+#define cpu_has_mmips		0
 #define cpu_has_vint		0
 #define cpu_has_veic		0
 #define cpu_hwrena_impl_bits	0xc0000000
diff --git a/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h
index 71d4bfa..89ca55c 100644
--- a/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h
@@ -41,6 +41,7 @@
 #define cpu_has_mdmx		0
 #define cpu_has_mips3d		0
 #define cpu_has_smartmips	0
+#define cpu_has_mmips		0
 #define cpu_has_vtag_icache	0
 #define cpu_has_ic_fills_f_dc	0
 #define cpu_icache_snoops_remote_store	0
diff --git a/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
index f4caacd..704cc54 100644
--- a/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
@@ -23,6 +23,7 @@
 #define cpu_has_prefetch	0
 #define cpu_has_mcheck		0
 #define cpu_has_ejtag		0
+#define cpu_has_mmips		0
 
 #define cpu_has_llsc		1
 #define cpu_has_vtag_icache	0		/* Needs to change for R8000 */
diff --git a/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
index 1d2b6ff..156e4d4 100644
--- a/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
@@ -20,6 +20,7 @@
 #define cpu_has_prefetch	1
 #define cpu_has_mcheck		0
 #define cpu_has_ejtag		0
+#define cpu_has_mmips		0
 
 #define cpu_has_llsc		1
 #define cpu_has_vtag_icache	0
diff --git a/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h
index 65e9c85..7cc6593 100644
--- a/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h
@@ -21,6 +21,7 @@
 #define cpu_has_prefetch	1
 #define cpu_has_mcheck		0
 #define cpu_has_ejtag		0
+#define cpu_has_mmips		0
 
 #define cpu_has_llsc		1
 #define cpu_has_vtag_icache	0
diff --git a/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h
index 2e1ec6c..0c7b7a0 100644
--- a/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h
@@ -34,6 +34,7 @@
 #define cpu_has_cache_cdex_s	0
 #define cpu_has_mcheck		0
 #define cpu_has_ejtag		0
+#define cpu_has_mmips		0
 #define cpu_has_vtag_icache	0
 #define cpu_has_ic_fills_f_dc	0
 #define cpu_has_dsp		0
diff --git a/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h b/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h
index a225baa..4da0711 100644
--- a/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h
@@ -28,6 +28,7 @@
 #define cpu_has_mdmx 0
 #define cpu_has_mips3d 0
 #define cpu_has_smartmips 0
+#define cpu_has_mmips		0
 #define kernel_uses_llsc	1
 #define cpu_has_vtag_icache	1
 #define cpu_has_dc_aliases	0
diff --git a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
index c0f3ef4..ca34d19 100644
--- a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
@@ -49,6 +49,7 @@
 #define cpu_has_mipsmt		0
 #define cpu_has_prefetch	0
 #define cpu_has_smartmips	0
+#define cpu_has_mmips		0
 #define cpu_has_tlb		1
 #define cpu_has_tx39_cache	0
 #define cpu_has_userlocal	0
diff --git a/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
index 091deb17..49d58ee 100644
--- a/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
@@ -21,6 +21,7 @@
 #define cpu_has_prefetch	1
 #define cpu_has_mcheck		1
 #define cpu_has_ejtag		1
+#define cpu_has_mmips		0
 
 #define cpu_has_llsc		1
 #define cpu_has_vtag_icache	0
diff --git a/arch/mips/include/asm/mach-pmcs-msp71xx/cpu-feature-overrides.h b/arch/mips/include/asm/mach-pmcs-msp71xx/cpu-feature-overrides.h
index 016fa94..3a6805a 100644
--- a/arch/mips/include/asm/mach-pmcs-msp71xx/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-pmcs-msp71xx/cpu-feature-overrides.h
@@ -13,6 +13,7 @@
 /* #define cpu_has_dsp2		??? - do runtime detection */
 #define cpu_has_mipsmt		1
 #define cpu_has_fpu		0
+#define cpu_has_mmips		0
 
 #define cpu_has_mips32r1	0
 #define cpu_has_mips32r2	1
diff --git a/arch/mips/include/asm/mach-powertv/cpu-feature-overrides.h b/arch/mips/include/asm/mach-powertv/cpu-feature-overrides.h
index 58c76ec..fdfcb57 100644
--- a/arch/mips/include/asm/mach-powertv/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-powertv/cpu-feature-overrides.h
@@ -37,6 +37,7 @@
 #define cpu_has_mdmx			0
 #define cpu_has_mips3d			0
 #define cpu_has_smartmips		0
+#define cpu_has_mmips			0
 #define cpu_has_vtag_icache		0
 #define cpu_has_dc_aliases		0
 #define cpu_has_ic_fills_f_dc		0
diff --git a/arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h
index 72fc106..ac98538 100644
--- a/arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h
@@ -36,6 +36,7 @@
 #define cpu_has_mdmx		0
 #define cpu_has_mips3d		0
 #define cpu_has_smartmips	0
+#define cpu_has_mmips		0
 
 #define cpu_has_mips32r1	1
 #define cpu_has_mips32r2	1
diff --git a/arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h
index 917c286..a1f1c29 100644
--- a/arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h
@@ -36,6 +36,7 @@
 #define cpu_has_mdmx		0
 #define cpu_has_mips3d		0
 #define cpu_has_smartmips	0
+#define cpu_has_mmips		0
 
 #define cpu_has_mips32r1	1
 #define cpu_has_mips32r2	1
diff --git a/arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h
index 181fbf4..9c88896 100644
--- a/arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h
@@ -35,6 +35,7 @@
 #define cpu_has_mdmx		0
 #define cpu_has_mips3d		0
 #define cpu_has_smartmips	0
+#define cpu_has_mmips		0
 
 #define cpu_has_mips32r1	1
 #define cpu_has_mips32r2	1
diff --git a/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h b/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h
index b153075..2801166 100644
--- a/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h
@@ -51,6 +51,7 @@
 #define cpu_has_mdmx			0
 #define cpu_has_mips3d			0
 #define cpu_has_smartmips		0
+#define cpu_has_mmips			0
 
 #define cpu_has_vtag_icache		0
 
diff --git a/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h b/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h
index f095c52..44d0daf 100644
--- a/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h
@@ -25,6 +25,7 @@
 #define cpu_has_prefetch	0
 #define cpu_has_mcheck		0
 #define cpu_has_ejtag		0
+#define cpu_has_mmips		0
 #define cpu_has_llsc		1
 #define cpu_has_vtag_icache	0
 #define cpu_has_dc_aliases	(PAGE_SIZE < 0x4000)
diff --git a/arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h b/arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h
index 92927b6..152c9a6 100644
--- a/arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h
@@ -20,6 +20,7 @@
 #define cpu_has_prefetch	1
 #define cpu_has_mcheck		1
 #define cpu_has_ejtag		1
+#define cpu_has_mmips		0
 
 #define cpu_has_llsc		1
 #define cpu_has_vtag_icache	1
diff --git a/arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h b/arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h
index 7f5144c..6913da4 100644
--- a/arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h
@@ -9,6 +9,7 @@
 #define cpu_has_mdmx		0
 #define cpu_has_mips3d		0
 #define cpu_has_smartmips	0
+#define cpu_has_mmips		0
 #define cpu_has_vtag_icache	0
 #define cpu_has_ic_fills_f_dc	0
 #define cpu_has_dsp	0
-- 
1.7.10.4
