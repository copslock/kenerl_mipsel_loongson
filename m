Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2012 06:57:37 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:34764 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903593Ab2EWE5a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 May 2012 06:57:30 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SX3dR-0007af-OI; Tue, 22 May 2012 23:57:21 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH v2,4/9] MIPS: Add microMIPS breakpoints and DSP support.
Date:   Tue, 22 May 2012 23:57:16 -0500
Message-Id: <1337749036-2495-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/break.h |   11 +++++++++--
 arch/mips/include/asm/dsp.h   |    4 ++++
 arch/mips/kernel/proc.c       |    9 +++++++--
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/break.h b/arch/mips/include/asm/break.h
index 9161e68..4e4dc87 100644
--- a/arch/mips/include/asm/break.h
+++ b/arch/mips/include/asm/break.h
@@ -3,8 +3,9 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1995, 2003 by Ralf Baechle
  * Copyright (C) 1999 Silicon Graphics, Inc.
+ * Copyright (C) 1995, 2003 by Ralf Baechle
+ * Copyright (C) 2011, 2012 MIPS Technologies, Inc.
  */
 #ifndef __ASM_BREAK_H
 #define __ASM_BREAK_H
@@ -27,11 +28,17 @@
 #define BRK_STACKOVERFLOW 9	/* For Ada stackchecking */
 #define BRK_NORLD	10	/* No rld found - not used by Linux/MIPS */
 #define _BRK_THREADBP	11	/* For threads, user bp (used by debuggers) */
+
+#ifdef CONFIG_CPU_MICROMIPS
+#define BRK_BUG		12	/* Used by BUG() */
+#define BRK_KDB		13	/* Used in KDB_ENTER() */
+#else
 #define BRK_BUG		512	/* Used by BUG() */
 #define BRK_KDB		513	/* Used in KDB_ENTER() */
+#endif
+#define MM_BRK_MEMU	14	/* Used by FPU emulator (microMIPS) */
 #define BRK_MEMU	514	/* Used by FPU emulator */
 #define BRK_KPROBE_BP	515	/* Kprobe break */
 #define BRK_KPROBE_SSTEPBP 516	/* Kprobe single step software implementation */
-#define BRK_MULOVF	1023	/* Multiply overflow */
 
 #endif /* __ASM_BREAK_H */
diff --git a/arch/mips/include/asm/dsp.h b/arch/mips/include/asm/dsp.h
index e9bfc08..3149b30 100644
--- a/arch/mips/include/asm/dsp.h
+++ b/arch/mips/include/asm/dsp.h
@@ -16,7 +16,11 @@
 #include <asm/mipsregs.h>
 
 #define DSP_DEFAULT	0x00000000
+#ifdef CONFIG_CPU_MICROMIPS
+#define DSP_MASK	0x7f
+#else
 #define DSP_MASK	0x3ff
+#endif
 
 #define __enable_dsp_hazard()						\
 do {									\
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 5542817..c5e97d4 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -64,14 +64,19 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 				cpu_data[n].watch_reg_masks[i]);
 		seq_printf(m, "]\n");
 	}
-	seq_printf(m, "ASEs implemented\t:%s%s%s%s%s%s\n",
+	seq_printf(m, "ASEs implemented\t:%s%s%s%s%s%s%s\n",
 		      cpu_has_mips16 ? " mips16" : "",
 		      cpu_has_mdmx ? " mdmx" : "",
 		      cpu_has_mips3d ? " mips3d" : "",
 		      cpu_has_smartmips ? " smartmips" : "",
 		      cpu_has_dsp ? " dsp" : "",
-		      cpu_has_mipsmt ? " mt" : ""
+		      cpu_has_mipsmt ? " mt" : "",
+		      cpu_has_mmips ? " micromips" : ""
 		);
+	if (cpu_has_mmips) {
+		seq_printf(m, "micromips kernel\t: %s\n",
+			(read_c0_config3() & MIPS_CONF3_ISA_OE) ? "yes" : "no");
+	}
 	seq_printf(m, "shadow register sets\t: %d\n",
 		      cpu_data[n].srsets);
 	seq_printf(m, "kscratch registers\t: %d\n",
-- 
1.7.10
