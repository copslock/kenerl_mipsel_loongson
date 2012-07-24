Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2012 23:44:42 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:49887 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903786Ab2GXVk4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2012 23:40:56 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1StmqX-0003yh-F3; Tue, 24 Jul 2012 16:40:49 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: Whitespace and various formatting clean-ups for microMIPS.
Date:   Tue, 24 Jul 2012 16:40:45 -0500
Message-Id: <1343166045-1974-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.11.1
X-archive-position: 33982
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

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/inst.h | 134 +++++++++++++++++++++----------------------
 arch/mips/kernel/proc.c      |   5 +-
 arch/mips/kernel/traps.c     |   4 +-
 3 files changed, 72 insertions(+), 71 deletions(-)

diff --git a/arch/mips/include/asm/inst.h b/arch/mips/include/asm/inst.h
index 6212f58..39f943c 100644
--- a/arch/mips/include/asm/inst.h
+++ b/arch/mips/include/asm/inst.h
@@ -262,7 +262,7 @@ struct ma_format {	/* FPU multiply and add format (MIPS IV) */
 	unsigned int fmt : 2;
 };
 
-struct b_format { /* BREAK and SYSCALL */
+struct b_format {	/* BREAK and SYSCALL */
 	unsigned int opcode:6;
 	unsigned int code:20;
 	unsigned int func:6;
@@ -276,7 +276,7 @@ struct fb_format {	/* FPU branch format */
 	unsigned int simmediate:16;
 };
 
-struct fp0_format {      /* FPU multipy and add format (MIPS32) */
+struct fp0_format {	/* FPU multipy and add format (MIPS32) */
 	unsigned int opcode:6;
 	unsigned int fmt:5;
 	unsigned int ft:5;
@@ -285,7 +285,7 @@ struct fp0_format {      /* FPU multipy and add format (MIPS32) */
 	unsigned int func:6;
 };
 
-struct mm_fp0_format {      /* FPU multipy and add format (microMIPS) */
+struct mm_fp0_format {	/* FPU multipy and add format (microMIPS) */
 	unsigned int opcode:6;
 	unsigned int ft:5;
 	unsigned int fs:5;
@@ -295,7 +295,7 @@ struct mm_fp0_format {      /* FPU multipy and add format (microMIPS) */
 	unsigned int func:6;
 };
 
-struct fp1_format {      /* FPU mfc1 and cfc1 format (MIPS32) */
+struct fp1_format {	/* FPU mfc1 and cfc1 format (MIPS32) */
 	unsigned int opcode:6;
 	unsigned int op:5;
 	unsigned int rt:5;
@@ -304,7 +304,7 @@ struct fp1_format {      /* FPU mfc1 and cfc1 format (MIPS32) */
 	unsigned int func:6;
 };
 
-struct mm_fp1_format {      /* FPU mfc1 and cfc1 format (microMIPS) */
+struct mm_fp1_format {	/* FPU mfc1 and cfc1 format (microMIPS) */
 	unsigned int opcode:6;
 	unsigned int rt:5;
 	unsigned int fs:5;
@@ -313,7 +313,7 @@ struct mm_fp1_format {      /* FPU mfc1 and cfc1 format (microMIPS) */
 	unsigned int func:6;
 };
 
-struct mm_fp2_format {      /* FPU movt and movf format (microMIPS) */
+struct mm_fp2_format {	/* FPU movt and movf format (microMIPS) */
 	unsigned int opcode:6;
 	unsigned int fd:5;
 	unsigned int fs:5;
@@ -324,7 +324,7 @@ struct mm_fp2_format {      /* FPU movt and movf format (microMIPS) */
 	unsigned int func:6;
 };
 
-struct mm_fp3_format {      /* FPU abs and neg format (microMIPS) */
+struct mm_fp3_format {	/* FPU abs and neg format (microMIPS) */
 	unsigned int opcode:6;
 	unsigned int rt:5;
 	unsigned int fs:5;
@@ -333,7 +333,7 @@ struct mm_fp3_format {      /* FPU abs and neg format (microMIPS) */
 	unsigned int func:6;
 };
 
-struct mm_fp4_format {      /* FPU c.cond format (microMIPS) */
+struct mm_fp4_format {	/* FPU c.cond format (microMIPS) */
 	unsigned int opcode:6;
 	unsigned int rt:5;
 	unsigned int fs:5;
@@ -343,7 +343,7 @@ struct mm_fp4_format {      /* FPU c.cond format (microMIPS) */
 	unsigned int func:6;
 };
 
-struct mm_fp5_format {      /* FPU lwxc1 and swxc1 format (microMIPS) */
+struct mm_fp5_format {	/* FPU lwxc1 and swxc1 format (microMIPS) */
 	unsigned int opcode:6;
 	unsigned int index:5;
 	unsigned int base:5;
@@ -370,20 +370,20 @@ struct mm_fp6_format {	/* FPU madd and msub format (microMIPS) */
 	unsigned int func:6;
 };
 
-struct mm16b1_format {		/* microMIPS 16-bit branch format */
+struct mm16b1_format {	/* microMIPS 16-bit branch format */
 	unsigned int opcode:6;
 	unsigned int rs:3;
 	signed int simmediate:7;
 	unsigned int duplicate:16;	/* a copy of the instr */
 };
 
-struct mm16b0_format {		/* microMIPS 16-bit branch format */
+struct mm16b0_format {	/* microMIPS 16-bit branch format */
 	unsigned int opcode:6;
 	signed int simmediate:10;
 	unsigned int duplicate:16;	/* a copy of the instr */
 };
 
-struct mm_i_format {		/* Immediate format (addi, lw, ...) */
+struct mm_i_format {	/* Immediate format (addi, lw, ...) */
 	unsigned int opcode:6;
 	unsigned int rt:5;
 	unsigned int rs:5;
@@ -495,72 +495,72 @@ struct j_format {	/* Jump format */
 };
 
 struct i_format {	/* Immediate format */
-	signed int simmediate : 16;
-	unsigned int rt : 5;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
+	signed int simmediate:16;
+	unsigned int rt:5;
+	unsigned int rs:5;
+	unsigned int opcode:6;
 };
 
 struct u_format {	/* Unsigned immediate format */
-	unsigned int uimmediate : 16;
-	unsigned int rt : 5;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
+	unsigned int uimmediate:16;
+	unsigned int rt:5;
+	unsigned int rs:5;
+	unsigned int opcode:6;
 };
 
 struct c_format {	/* Cache (>= R6000) format */
-	unsigned int simmediate : 16;
-	unsigned int cache : 2;
-	unsigned int c_op : 3;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
+	unsigned int simmediate:16;
+	unsigned int cache:2;
+	unsigned int c_op:3;
+	unsigned int rs:5;
+	unsigned int opcode:6;
 };
 
 struct r_format {	/* Register format */
-	unsigned int func : 6;
-	unsigned int re : 5;
-	unsigned int rd : 5;
-	unsigned int rt : 5;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
+	unsigned int func:6;
+	unsigned int re:5;
+	unsigned int rd:5;
+	unsigned int rt:5;
+	unsigned int rs:5;
+	unsigned int opcode:6;
 };
 
 struct p_format {	/* Performance counter format (R10000) */
-	unsigned int func : 6;
-	unsigned int re : 5;
-	unsigned int rd : 5;
-	unsigned int rt : 5;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
+	unsigned int func:6;
+	unsigned int re:5;
+	unsigned int rd:5;
+	unsigned int rt:5;
+	unsigned int rs:5;
+	unsigned int opcode:6;
 };
 
 struct f_format {	/* FPU register format */
-	unsigned int func : 6;
-	unsigned int re : 5;
-	unsigned int rd : 5;
-	unsigned int rt : 5;
-	unsigned int fmt : 4;
-	unsigned int : 1;
-	unsigned int opcode : 6;
+	unsigned int func:6;
+	unsigned int re:5;
+	unsigned int rd:5;
+	unsigned int rt:5;
+	unsigned int fmt:4;
+	unsigned int:1;
+	unsigned int opcode:6;
 };
 
-struct ma_format {	/* FPU multiply and add format (MIPS IV) */
-	unsigned int fmt : 2;
-	unsigned int func : 4;
-	unsigned int fd : 5;
-	unsigned int fs : 5;
-	unsigned int ft : 5;
-	unsigned int fr : 5;
-	unsigned int opcode : 6;
+struct ma_format {	/* FPU multipy and add format (MIPS IV) */
+	unsigned int fmt:2;
+	unsigned int func:4;
+	unsigned int fd:5;
+	unsigned int fs:5;
+	unsigned int ft:5;
+	unsigned int fr:5;
+	unsigned int opcode:6;
 };
 
-struct b_format { /* BREAK and SYSCALL */
+struct b_format {	/* BREAK and SYSCALL */
 	unsigned int func:6;
 	unsigned int code:20;
 	unsigned int opcode:6;
 };
 
-struct fb_format {		/* FPU branch format */
+struct fb_format {	/* FPU branch format */
 	unsigned int simmediate:16;
 	unsigned int flag:2;
 	unsigned int cc:3;
@@ -568,7 +568,7 @@ struct fb_format {		/* FPU branch format */
 	unsigned int opcode:6;
 };
 
-struct fp0_format {		/* FPU multipy and add format (MIPS32) */
+struct fp0_format {	/* FPU multipy and add format (MIPS32) */
 	unsigned int func:6;
 	unsigned int fd:5;
 	unsigned int fs:5;
@@ -577,7 +577,7 @@ struct fp0_format {		/* FPU multipy and add format (MIPS32) */
 	unsigned int opcode:6;
 };
 
-struct mm_fp0_format {		/* FPU multipy and add format (microMIPS) */
+struct mm_fp0_format {	/* FPU multipy and add format (microMIPS) */
 	unsigned int func:6;
 	unsigned int op:2;
 	unsigned int fmt:3;
@@ -587,7 +587,7 @@ struct mm_fp0_format {		/* FPU multipy and add format (microMIPS) */
 	unsigned int opcode:6;
 };
 
-struct fp1_format {		/* FPU mfc1 and cfc1 format (MIPS32) */
+struct fp1_format {	/* FPU mfc1 and cfc1 format (MIPS32) */
 	unsigned int func:6;
 	unsigned int fd:5;
 	unsigned int fs:5;
@@ -596,7 +596,7 @@ struct fp1_format {		/* FPU mfc1 and cfc1 format (MIPS32) */
 	unsigned int opcode:6;
 };
 
-struct mm_fp1_format {		/* FPU mfc1 and cfc1 format (microMIPS) */
+struct mm_fp1_format {	/* FPU mfc1 and cfc1 format (microMIPS) */
 	unsigned int func:6;
 	unsigned int op:8;
 	unsigned int fmt:2;
@@ -605,7 +605,7 @@ struct mm_fp1_format {		/* FPU mfc1 and cfc1 format (microMIPS) */
 	unsigned int opcode:6;
 };
 
-struct mm_fp2_format {		/* FPU movt and movf format (microMIPS) */
+struct mm_fp2_format {	/* FPU movt and movf format (microMIPS) */
 	unsigned int func:6;
 	unsigned int op:3;
 	unsigned int fmt:2;
@@ -616,7 +616,7 @@ struct mm_fp2_format {		/* FPU movt and movf format (microMIPS) */
 	unsigned int opcode:6;
 };
 
-struct mm_fp3_format {		/* FPU abs and neg format (microMIPS) */
+struct mm_fp3_format {	/* FPU abs and neg format (microMIPS) */
 	unsigned int func:6;
 	unsigned int op:7;
 	unsigned int fmt:3;
@@ -625,7 +625,7 @@ struct mm_fp3_format {		/* FPU abs and neg format (microMIPS) */
 	unsigned int opcode:6;
 };
 
-struct mm_fp4_format {		/* FPU c.cond format (microMIPS) */
+struct mm_fp4_format {	/* FPU c.cond format (microMIPS) */
 	unsigned int func:6;
 	unsigned int cond:4;
 	unsigned int fmt:3;
@@ -635,7 +635,7 @@ struct mm_fp4_format {		/* FPU c.cond format (microMIPS) */
 	unsigned int opcode:6;
 };
 
-struct mm_fp5_format {		/* FPU lwxc1 and swxc1 format (microMIPS) */
+struct mm_fp5_format {	/* FPU lwxc1 and swxc1 format (microMIPS) */
 	unsigned int func:6;
 	unsigned int op:5;
 	unsigned int fd:5;
@@ -644,7 +644,7 @@ struct mm_fp5_format {		/* FPU lwxc1 and swxc1 format (microMIPS) */
 	unsigned int opcode:6;
 };
 
-struct fp6_format {		/* FPU madd and msub format (MIPS IV) */
+struct fp6_format {	/* FPU madd and msub format (MIPS IV) */
 	unsigned int func:6;
 	unsigned int fd:5;
 	unsigned int fs:5;
@@ -653,7 +653,7 @@ struct fp6_format {		/* FPU madd and msub format (MIPS IV) */
 	unsigned int opcode:6;
 };
 
-struct mm_fp6_format {		/* FPU madd and msub format (microMIPS) */
+struct mm_fp6_format {	/* FPU madd and msub format (microMIPS) */
 	unsigned int func:6;
 	unsigned int fr:5;
 	unsigned int fd:5;
@@ -662,20 +662,20 @@ struct mm_fp6_format {		/* FPU madd and msub format (microMIPS) */
 	unsigned int opcode:6;
 };
 
-struct mm16b1_format {		/* microMIPS 16-bit branch format */
+struct mm16b1_format {	/* microMIPS 16-bit branch format */
 	unsigned int duplicate:16;	/* a copy of the instr */
 	signed int simmediate:7;
 	unsigned int rs:3;
 	unsigned int opcode:6;
 };
 
-struct mm16b0_format {		/* microMIPS 16-bit branch format */
+struct mm16b0_format {	/* microMIPS 16-bit branch format */
 	unsigned int duplicate:16;	/* a copy of the instr */
 	signed int simmediate:10;
 	unsigned int opcode:6;
 };
 
-struct mm_i_format {		/* Immediate format */
+struct mm_i_format {	/* Immediate format */
 	signed int simmediate:16;
 	unsigned int rs:5;
 	unsigned int rt:5;
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 5542817..5569d09 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -64,13 +64,14 @@ static int show_cpuinfo(struct seq_file *m, void *v)
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
 	seq_printf(m, "shadow register sets\t: %d\n",
 		      cpu_data[n].srsets);
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 516668c..8322ce9 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -514,7 +514,7 @@ static inline int simulate_ll(struct pt_regs *regs, unsigned int opcode)
 	offset >>= 16;
 
 	vaddr = (unsigned long __user *)
-	        ((unsigned long)(regs->regs[(opcode & BASE) >> 21]) + offset);
+		((unsigned long)(regs->regs[(opcode & BASE) >> 21]) + offset);
 
 	if ((unsigned long)vaddr & 3)
 		return SIGBUS;
@@ -554,7 +554,7 @@ static inline int simulate_sc(struct pt_regs *regs, unsigned int opcode)
 	offset >>= 16;
 
 	vaddr = (unsigned long __user *)
-	        ((unsigned long)(regs->regs[(opcode & BASE) >> 21]) + offset);
+		((unsigned long)(regs->regs[(opcode & BASE) >> 21]) + offset);
 	reg = (opcode & RT) >> 16;
 
 	if ((unsigned long)vaddr & 3)
-- 
1.7.11.1
