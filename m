Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 06:06:33 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60307 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823732Ab2LGFFvujJVR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 06:05:51 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Tgq89-0007MA-6E; Thu, 06 Dec 2012 23:05:45 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v99,02/13] MIPS: Whitespace clean-ups after microMIPS additions.
Date:   Thu,  6 Dec 2012 23:05:26 -0600
Message-Id: <1354856737-28678-3-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1354856737-28678-1-git-send-email-sjhill@mips.com>
References: <1354856737-28678-1-git-send-email-sjhill@mips.com>
X-archive-position: 35213
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

Clean-up tabs, spaces, macros, etc. after adding in microMIPS
instructions for the micro-assembler.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/inst.h     |  134 +++++++++++++++++++-------------------
 arch/mips/include/asm/mipsregs.h |   40 +++++++-----
 arch/mips/kernel/proc.c          |    1 +
 arch/mips/kernel/traps.c         |    4 +-
 4 files changed, 92 insertions(+), 87 deletions(-)

diff --git a/arch/mips/include/asm/inst.h b/arch/mips/include/asm/inst.h
index c76899f..2b2e0e3 100644
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
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 0c0e4a6..4b55a5a 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1151,17 +1151,21 @@ do {									\
 /*
  * Macros to access the floating point coprocessor control registers
  */
-#define read_32bit_cp1_register(source)                         \
-({ int __res;                                                   \
-	__asm__ __volatile__(                                   \
-	".set\tpush\n\t"					\
-	".set\treorder\n\t"					\
-	/* gas fails to assemble cfc1 for some archs (octeon).*/ \
-	".set\tmips1\n\t"					\
-        "cfc1\t%0,"STR(source)"\n\t"                            \
-	".set\tpop"						\
-        : "=r" (__res));                                        \
-        __res;})
+#define read_32bit_cp1_register(source)					\
+({									\
+	int __res;							\
+									\
+	__asm__ __volatile__(						\
+	"	.set	push					\n"	\
+	"	.set	reorder					\n"	\
+	"	# gas fails to assemble cfc1 for some archs,	\n"	\
+	"	# like Octeon.					\n"	\
+	"	.set	mips1					\n"	\
+	"	cfc1	%0,"STR(source)"			\n"	\
+	"	.set	pop					\n"	\
+	: "=r" (__res));						\
+	__res;								\
+})
 
 #ifdef HAVE_AS_DSP
 #define rddsp(mask)							\
@@ -1298,12 +1302,12 @@ do {									\
 	unsigned int __res;						\
 									\
 	__asm__ __volatile__(						\
-	"	.set	push				\n"		\
-	"	.set	noat				\n"		\
-	"	# rddsp $1, %x1				\n"		\
-	"	.word	0x7c000cb8 | (%x1 << 16)	\n"		\
-	"	move	%0, $1				\n"		\
-	"	.set	pop				\n"		\
+	"	.set	push					\n"	\
+	"	.set	noat					\n"	\
+	"	# rddsp $1, %x1					\n"	\
+	"	.word	0x7c000cb8 | (%x1 << 16)		\n"	\
+	"	move	%0, $1					\n"	\
+	"	.set	pop					\n"	\
 	: "=r" (__res)							\
 	: "i" (mask));							\
 	__res;								\
@@ -1318,7 +1322,7 @@ do {									\
 	"	# wrdsp $1, %x1					\n"	\
 	"	.word	0x7c2004f8 | (%x1 << 11)		\n"	\
 	"	.set	pop					\n"	\
-        :								\
+	:								\
 	: "r" (val), "i" (mask));					\
 } while (0)
 
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 07dff54..239ae03 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -73,6 +73,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (cpu_has_dsp)	seq_printf(m, "%s", " dsp");
 	if (cpu_has_dsp2)	seq_printf(m, "%s", " dsp2");
 	if (cpu_has_mipsmt)	seq_printf(m, "%s", " mt");
+	if (cpu_has_mmips)	seq_printf(m, "%s", " micromips");
 	seq_printf(m, "\n");
 
 	seq_printf(m, "shadow register sets\t: %d\n",
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 9260986..cc7f4cc 100644
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
1.7.9.5
