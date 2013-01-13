Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jan 2013 01:29:40 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:33432 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817419Ab3AMA3jYemoZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Jan 2013 01:29:39 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TuBS7-0006qh-L0; Sat, 12 Jan 2013 18:29:31 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org,
        cernekee@gmail.com
Subject: [PATCH] MIPS: Whitespace clean-ups.
Date:   Sat, 12 Jan 2013 18:29:27 -0600
Message-Id: <1358036967-21858-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35415
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

Clean-up tabs, spaces, macros, etc.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/inst.h     |  168 +++++++++++++++++++-------------------
 arch/mips/include/asm/mipsregs.h |   26 +++---
 arch/mips/kernel/traps.c         |    4 +-
 3 files changed, 101 insertions(+), 97 deletions(-)

diff --git a/arch/mips/include/asm/inst.h b/arch/mips/include/asm/inst.h
index ab84064..69b072f 100644
--- a/arch/mips/include/asm/inst.h
+++ b/arch/mips/include/asm/inst.h
@@ -197,71 +197,71 @@ enum lx_func {
  */
 #ifdef __MIPSEB__
 struct j_format {	/* Jump format */
-	unsigned int opcode : 6;
-	unsigned int target : 26;
+	unsigned int opcode:6;
+	unsigned int target:26;
 };
 
 struct i_format {	/* Immediate format (addi, lw, ...) */
-	unsigned int opcode : 6;
-	unsigned int rs : 5;
-	unsigned int rt : 5;
-	signed int simmediate : 16;
+	unsigned int opcode:6;
+	unsigned int rs:5;
+	unsigned int rt:5;
+	signed int simmediate:16;
 };
 
 struct u_format {	/* Unsigned immediate format (ori, xori, ...) */
-	unsigned int opcode : 6;
-	unsigned int rs : 5;
-	unsigned int rt : 5;
-	unsigned int uimmediate : 16;
+	unsigned int opcode:6;
+	unsigned int rs:5;
+	unsigned int rt:5;
+	unsigned int uimmediate:16;
 };
 
 struct c_format {	/* Cache (>= R6000) format */
-	unsigned int opcode : 6;
-	unsigned int rs : 5;
-	unsigned int c_op : 3;
-	unsigned int cache : 2;
-	unsigned int simmediate : 16;
+	unsigned int opcode:6;
+	unsigned int rs:5;
+	unsigned int c_op:3;
+	unsigned int cache:2;
+	unsigned int simmediate:16;
 };
 
 struct r_format {	/* Register format */
-	unsigned int opcode : 6;
-	unsigned int rs : 5;
-	unsigned int rt : 5;
-	unsigned int rd : 5;
-	unsigned int re : 5;
-	unsigned int func : 6;
+	unsigned int opcode:6;
+	unsigned int rs:5;
+	unsigned int rt:5;
+	unsigned int rd:5;
+	unsigned int re:5;
+	unsigned int func:6;
 };
 
 struct p_format {	/* Performance counter format (R10000) */
-	unsigned int opcode : 6;
-	unsigned int rs : 5;
-	unsigned int rt : 5;
-	unsigned int rd : 5;
-	unsigned int re : 5;
-	unsigned int func : 6;
+	unsigned int opcode:6;
+	unsigned int rs:5;
+	unsigned int rt:5;
+	unsigned int rd:5;
+	unsigned int re:5;
+	unsigned int func:6;
 };
 
 struct f_format {	/* FPU register format */
-	unsigned int opcode : 6;
-	unsigned int : 1;
-	unsigned int fmt : 4;
-	unsigned int rt : 5;
-	unsigned int rd : 5;
-	unsigned int re : 5;
-	unsigned int func : 6;
+	unsigned int opcode:6;
+	unsigned int :1;
+	unsigned int fmt:4;
+	unsigned int rt:5;
+	unsigned int rd:5;
+	unsigned int re:5;
+	unsigned int func:6;
 };
 
 struct ma_format {	/* FPU multiply and add format (MIPS IV) */
-	unsigned int opcode : 6;
-	unsigned int fr : 5;
-	unsigned int ft : 5;
-	unsigned int fs : 5;
-	unsigned int fd : 5;
-	unsigned int func : 4;
-	unsigned int fmt : 2;
+	unsigned int opcode:6;
+	unsigned int fr:5;
+	unsigned int ft:5;
+	unsigned int fs:5;
+	unsigned int fd:5;
+	unsigned int func:4;
+	unsigned int fmt:2;
 };
 
-struct b_format { /* BREAK and SYSCALL */
+struct b_format {	/* BREAK and SYSCALL */
 	unsigned int opcode:6;
 	unsigned int code:20;
 	unsigned int func:6;
@@ -270,71 +270,71 @@ struct b_format { /* BREAK and SYSCALL */
 #elif defined(__MIPSEL__)
 
 struct j_format {	/* Jump format */
-	unsigned int target : 26;
-	unsigned int opcode : 6;
+	unsigned int target:26;
+	unsigned int opcode:6;
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
+	unsigned int :1;
+	unsigned int opcode:6;
 };
 
 struct ma_format {	/* FPU multiply and add format (MIPS IV) */
-	unsigned int fmt : 2;
-	unsigned int func : 4;
-	unsigned int fd : 5;
-	unsigned int fs : 5;
-	unsigned int ft : 5;
-	unsigned int fr : 5;
-	unsigned int opcode : 6;
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
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 7e4e6f8..1ad3e34 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1142,17 +1142,21 @@ do {									\
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
 
 #define rddsp(mask)							\
 ({									\
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cf7ac54..e3a5f3d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -518,7 +518,7 @@ static inline int simulate_ll(struct pt_regs *regs, unsigned int opcode)
 	offset >>= 16;
 
 	vaddr = (unsigned long __user *)
-	        ((unsigned long)(regs->regs[(opcode & BASE) >> 21]) + offset);
+		((unsigned long)(regs->regs[(opcode & BASE) >> 21]) + offset);
 
 	if ((unsigned long)vaddr & 3)
 		return SIGBUS;
@@ -558,7 +558,7 @@ static inline int simulate_sc(struct pt_regs *regs, unsigned int opcode)
 	offset >>= 16;
 
 	vaddr = (unsigned long __user *)
-	        ((unsigned long)(regs->regs[(opcode & BASE) >> 21]) + offset);
+		((unsigned long)(regs->regs[(opcode & BASE) >> 21]) + offset);
 	reg = (opcode & RT) >> 16;
 
 	if ((unsigned long)vaddr & 3)
-- 
1.7.9.5
