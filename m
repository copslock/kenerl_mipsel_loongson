Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2012 23:40:54 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:49866 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903752Ab2GXVkF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2012 23:40:05 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Stmpj-0003xr-Cj; Tue, 24 Jul 2012 16:39:59 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: Add detection of DSP ASE Revision 2.
Date:   Tue, 24 Jul 2012 16:39:54 -0500
Message-Id: <1343165994-1648-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.11.1
X-archive-position: 33973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Status: A

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/cpu-features.h | 4 ++++
 arch/mips/include/asm/cpu.h          | 1 +
 arch/mips/include/asm/mipsregs.h     | 1 +
 arch/mips/kernel/cpu-probe.c         | 6 ++++--
 arch/mips/kernel/proc.c              | 3 ++-
 5 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 98bee29..bba9398 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -180,6 +180,10 @@
 #define cpu_has_dsp		(cpu_data[0].ases & MIPS_ASE_DSP)
 #endif
 
+#ifndef cpu_has_dsp2
+#define cpu_has_dsp2		(cpu_data[0].ases & MIPS_ASE_DSP2P)
+#endif
+
 #ifndef cpu_has_mipsmt
 #define cpu_has_mipsmt		(cpu_data[0].ases & MIPS_ASE_MIPSMT)
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 559bd12..5fb8aa4 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -331,6 +331,7 @@ enum cpu_type_enum {
 #define MIPS_ASE_SMARTMIPS	0x00000008 /* SmartMIPS */
 #define MIPS_ASE_DSP		0x00000010 /* Signal Processing ASE */
 #define MIPS_ASE_MIPSMT		0x00000020 /* CPU supports MIPS MT */
+#define MIPS_ASE_DSP2P		0x00000040 /* Signal Processing ASE Rev 2 */
 
 
 #endif /* _ASM_CPU_H */
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 7695edb..cdb9c87 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -590,6 +590,7 @@
 #define MIPS_CONF3_VEIC		(_ULCAST_(1) <<  6)
 #define MIPS_CONF3_LPA		(_ULCAST_(1) <<  7)
 #define MIPS_CONF3_DSP		(_ULCAST_(1) << 10)
+#define MIPS_CONF3_DSP2P	(_ULCAST_(1) << 11)
 #define MIPS_CONF3_ULRI		(_ULCAST_(1) << 13)
 #define MIPS_CONF3_ISA		(_ULCAST_(3) << 14)
 #define MIPS_CONF3_ISA_OE	(_ULCAST_(1) << 16)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 4842870..8fd9f9f 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -142,7 +142,7 @@ int __cpuinitdata mips_dsp_disabled;
 
 static int __init dsp_disable(char *s)
 {
-	cpu_data[0].ases &= ~MIPS_ASE_DSP;
+	cpu_data[0].ases &= ~(MIPS_ASE_DSP | MIPS_ASE_DSP2P);
 	mips_dsp_disabled = 1;
 
 	return 1;
@@ -735,6 +735,8 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->ases |= MIPS_ASE_SMARTMIPS;
 	if (config3 & MIPS_CONF3_DSP)
 		c->ases |= MIPS_ASE_DSP;
+	if (config3 & MIPS_CONF3_DSP2P)
+		c->ases |= MIPS_ASE_DSP2P;
 	if (config3 & MIPS_CONF3_VINT)
 		c->options |= MIPS_CPU_VINT;
 	if (config3 & MIPS_CONF3_VEIC)
@@ -1172,7 +1174,7 @@ __cpuinit void cpu_probe(void)
 		c->options &= ~MIPS_CPU_FPU;
 
 	if (mips_dsp_disabled)
-		c->ases &= ~MIPS_ASE_DSP;
+		c->ases &= ~(MIPS_ASE_DSP | MIPS_ASE_DSP2P);
 
 	if (c->options & MIPS_CPU_FPU) {
 		c->fpu_id = cpu_get_fpu_id();
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index c5e97d4..bb5e6dd 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -64,12 +64,13 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 				cpu_data[n].watch_reg_masks[i]);
 		seq_printf(m, "]\n");
 	}
-	seq_printf(m, "ASEs implemented\t:%s%s%s%s%s%s%s\n",
+	seq_printf(m, "ASEs implemented\t:%s%s%s%s%s%s%s%s\n",
 		      cpu_has_mips16 ? " mips16" : "",
 		      cpu_has_mdmx ? " mdmx" : "",
 		      cpu_has_mips3d ? " mips3d" : "",
 		      cpu_has_smartmips ? " smartmips" : "",
 		      cpu_has_dsp ? " dsp" : "",
+		      cpu_has_dsp2 ? " dsp2" : "",
 		      cpu_has_mipsmt ? " mt" : "",
 		      cpu_has_mmips ? " micromips" : ""
 		);
-- 
1.7.11.1
