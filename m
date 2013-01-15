Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2013 07:13:56 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:37838 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6832184Ab3AOGNyfL-jC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2013 07:13:54 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TuzmL-000077-72; Tue, 15 Jan 2013 00:13:45 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org,
        cernekee@gmail.com, kevink@paralogos.com
Subject: [PATCH] [RFC] Proposed changes to eliminate 'union mips_instruction' type.
Date:   Tue, 15 Jan 2013 00:13:40 -0600
Message-Id: <1358230420-3575-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35438
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

This patch shows the use of macros in place of 'union mips_instruction'
type. I converted all usages of 'j_format' and 'r_format' to show how
the code and macros could look and be defined. I have tested these
changes on big and little endian platforms.

I want input from everyone, please!!! I want consensus on the macro
definitions, placement of parenthesis for them, spacing in the header
file, etc. This is your chance to be completely anal and have fun
arguments over how things should be. I would also like input on how
the maintainers would like the patchsets to look like. For example:

  [1/X] - Convert 'j_format'
  [2/X] - Convert 'r_format'
  [3/X] - Convert 'f_format'
  [4/X] - Convert 'u_format'
  ...
  [X/X] - Remove usage of 'union mips_instruction' type completely.

Also, I noticed 'p_format' is not used anywhere. Can we kill it? Be
picky and help with this conversion. Thanks.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/inst.h   |   66 +++++++++++-----------------------------
 arch/mips/kernel/branch.c      |   13 ++++----
 arch/mips/kernel/jump_label.c  |   10 +++---
 arch/mips/kernel/kgdb.c        |   10 ++----
 arch/mips/kernel/kprobes.c     |   18 +++++------
 arch/mips/kernel/process.c     |   10 +++---
 arch/mips/oprofile/backtrace.c |    2 +-
 7 files changed, 46 insertions(+), 83 deletions(-)

diff --git a/arch/mips/include/asm/inst.h b/arch/mips/include/asm/inst.h
index ab84064..856b14e 100644
--- a/arch/mips/include/asm/inst.h
+++ b/arch/mips/include/asm/inst.h
@@ -192,15 +192,27 @@ enum lx_func {
 	lbx_op	= 0x16,
 };
 
+#define INSN_OPCODE(insn)		(insn >> 26)
+#define INSN_RS(insn)			((insn >> 21) & 0x1f)
+#define INSN_RT(insn)			((insn >> 16) & 0x1f)
+#define INSN_RD(insn)			((insn >> 11) & 0x1f)
+#define INSN_RE(insn)			((insn >> 6) & 0x1f)
+#define INSN_FUNC(insn)			(insn & 0x0000003f)
+
+#define J_INSN(op,target)		((op << 26) | target)
+#define J_INSN_TARGET(insn)		(insn & 0x03ffffff)
+#define R_INSN(op,rs,rt,rd,re,func)	((op << 26) | (rs << 21) |	\
+					 (rt << 16) | (rd << 11) |	\
+					 (re << 6) | func)
+#define F_INSN(op,fmt,rt,rd,re,func)	R_INSN(op,fmt,rt,rd,re,func)
+#define F_INSN_FMT(insn)		INSN_RS(insn)
+#define U_INSN(op,rs,uimm)		((op << 26) | (rs << 21) | uimmediate)
+#define U_INSN_UIMM(insn)		(insn & 0x0000ffff)
+
 /*
  * Damn ...  bitfields depend from byteorder :-(
  */
 #ifdef __MIPSEB__
-struct j_format {	/* Jump format */
-	unsigned int opcode : 6;
-	unsigned int target : 26;
-};
-
 struct i_format {	/* Immediate format (addi, lw, ...) */
 	unsigned int opcode : 6;
 	unsigned int rs : 5;
@@ -223,24 +235,6 @@ struct c_format {	/* Cache (>= R6000) format */
 	unsigned int simmediate : 16;
 };
 
-struct r_format {	/* Register format */
-	unsigned int opcode : 6;
-	unsigned int rs : 5;
-	unsigned int rt : 5;
-	unsigned int rd : 5;
-	unsigned int re : 5;
-	unsigned int func : 6;
-};
-
-struct p_format {	/* Performance counter format (R10000) */
-	unsigned int opcode : 6;
-	unsigned int rs : 5;
-	unsigned int rt : 5;
-	unsigned int rd : 5;
-	unsigned int re : 5;
-	unsigned int func : 6;
-};
-
 struct f_format {	/* FPU register format */
 	unsigned int opcode : 6;
 	unsigned int : 1;
@@ -268,12 +262,6 @@ struct b_format { /* BREAK and SYSCALL */
 };
 
 #elif defined(__MIPSEL__)
-
-struct j_format {	/* Jump format */
-	unsigned int target : 26;
-	unsigned int opcode : 6;
-};
-
 struct i_format {	/* Immediate format */
 	signed int simmediate : 16;
 	unsigned int rt : 5;
@@ -296,24 +284,6 @@ struct c_format {	/* Cache (>= R6000) format */
 	unsigned int opcode : 6;
 };
 
-struct r_format {	/* Register format */
-	unsigned int func : 6;
-	unsigned int re : 5;
-	unsigned int rd : 5;
-	unsigned int rt : 5;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
-};
-
-struct p_format {	/* Performance counter format (R10000) */
-	unsigned int func : 6;
-	unsigned int re : 5;
-	unsigned int rd : 5;
-	unsigned int rt : 5;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
-};
-
 struct f_format {	/* FPU register format */
 	unsigned int func : 6;
 	unsigned int re : 5;
@@ -348,11 +318,9 @@ union mips_instruction {
 	unsigned int word;
 	unsigned short halfword[2];
 	unsigned char byte[4];
-	struct j_format j_format;
 	struct i_format i_format;
 	struct u_format u_format;
 	struct c_format c_format;
-	struct r_format r_format;
 	struct f_format f_format;
 	struct ma_format ma_format;
 	struct b_format b_format;
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 4d735d0..d51fa79 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -34,18 +34,19 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 	unsigned int bit, fcr31, dspcontrol;
 	long epc = regs->cp0_epc;
 	int ret = 0;
+	unsigned int n_insn = insn.word;
 
 	switch (insn.i_format.opcode) {
 	/*
-	 * jr and jalr are in r_format format.
+	 * jr and jalr are in return instruction format.
 	 */
 	case spec_op:
-		switch (insn.r_format.func) {
+		switch (INSN_FUNC(n_insn)) {
 		case jalr_op:
-			regs->regs[insn.r_format.rd] = epc + 8;
+			regs->regs[INSN_RD(n_insn)] = epc + 8;
 			/* Fall through */
 		case jr_op:
-			regs->cp0_epc = regs->regs[insn.r_format.rs];
+			regs->cp0_epc = regs->regs[INSN_RS(n_insn)];
 			break;
 		}
 		break;
@@ -119,7 +120,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		break;
 
 	/*
-	 * These are unconditional and in j_format.
+	 * These are unconditional and are jump instruction format.
 	 */
 	case jal_op:
 		regs->regs[31] = regs->cp0_epc + 8;
@@ -127,7 +128,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		epc += 4;
 		epc >>= 28;
 		epc <<= 28;
-		epc |= (insn.j_format.target << 2);
+		epc |= (J_INSN_TARGET(n_insn) << 2);
 		regs->cp0_epc = epc;
 		break;
 
diff --git a/arch/mips/kernel/jump_label.c b/arch/mips/kernel/jump_label.c
index 6001610..d938642 100644
--- a/arch/mips/kernel/jump_label.c
+++ b/arch/mips/kernel/jump_label.c
@@ -23,9 +23,8 @@
 void arch_jump_label_transform(struct jump_entry *e,
 			       enum jump_label_type type)
 {
-	union mips_instruction insn;
-	union mips_instruction *insn_p =
-		(union mips_instruction *)(unsigned long)e->code;
+	unsigned int insn;
+	unsigned int *insn_p = (unsigned int *)(unsigned long)e->code;
 
 	/* Jump only works within a 256MB aligned region. */
 	BUG_ON((e->target & ~J_RANGE_MASK) != (e->code & ~J_RANGE_MASK));
@@ -34,10 +33,9 @@ void arch_jump_label_transform(struct jump_entry *e,
 	BUG_ON((e->target & 3) != 0);
 
 	if (type == JUMP_LABEL_ENABLE) {
-		insn.j_format.opcode = j_op;
-		insn.j_format.target = (e->target & J_RANGE_MASK) >> 2;
+		insn = J_INSN(j_op, (e->target & J_RANGE_MASK) >> 2);
 	} else {
-		insn.word = 0; /* nop */
+		insn = 0; /* nop */
 	}
 
 	get_online_cpus();
diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
index 23817a6..89887c5 100644
--- a/arch/mips/kernel/kgdb.c
+++ b/arch/mips/kernel/kgdb.c
@@ -368,13 +368,9 @@ struct kgdb_arch arch_kgdb_ops;
  */
 int kgdb_arch_init(void)
 {
-	union mips_instruction insn = {
-		.r_format = {
-			.opcode = spec_op,
-			.func   = break_op,
-		}
-	};
-	memcpy(arch_kgdb_ops.gdb_bpt_instr, insn.byte, BREAK_INSTR_SIZE);
+	unsigned int insn = R_INSN(spec_op, 0, 0, 0, 0, break_op);
+
+	memcpy(arch_kgdb_ops.gdb_bpt_instr, &insn, BREAK_INSTR_SIZE);
 
 	register_die_notifier(&kgdb_notifier);
 
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index 158467d..bc24241 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -53,16 +53,16 @@ static const union mips_instruction breakpoint2_insn = {
 DEFINE_PER_CPU(struct kprobe *, current_kprobe);
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
-static int __kprobes insn_has_delayslot(union mips_instruction insn)
+static int __kprobes insn_has_delayslot(unsigned int insn)
 {
-	switch (insn.i_format.opcode) {
+	switch (INSN_OPCODE(insn)) {
 
 		/*
 		 * This group contains:
-		 * jr and jalr are in r_format format.
+		 * jr and jalr are in return instruction format.
 		 */
 	case spec_op:
-		switch (insn.r_format.func) {
+		switch (R_INSN_FUNC(insn)) {
 		case jr_op:
 		case jalr_op:
 			break;
@@ -78,7 +78,7 @@ static int __kprobes insn_has_delayslot(union mips_instruction insn)
 	case bcond_op:
 
 		/*
-		 * These are unconditional and in j_format.
+		 * These are unconditional and in jump instruction format.
 		 */
 	case jal_op:
 	case j_op:
@@ -155,7 +155,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 
 	if ((probe_kernel_read(&prev_insn, p->addr - 1,
 				sizeof(mips_instruction)) == 0) &&
-				insn_has_delayslot(prev_insn)) {
+				insn_has_delayslot(prev_insn.word)) {
 		pr_notice("Kprobes for branch delayslot are not supported\n");
 		ret = -EINVAL;
 		goto out;
@@ -181,7 +181,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	 * using a normal breakpoint instruction in the next slot.
 	 * So, read the instruction and save it for later execution.
 	 */
-	if (insn_has_delayslot(insn))
+	if (insn_has_delayslot(insn.word))
 		memcpy(&p->ainsn.insn[0], p->addr + 1, sizeof(kprobe_opcode_t));
 	else
 		memcpy(&p->ainsn.insn[0], p->addr, sizeof(kprobe_opcode_t));
@@ -294,7 +294,7 @@ static void prepare_singlestep(struct kprobe *p, struct pt_regs *regs,
 	if (p->opcode.word == breakpoint_insn.word ||
 	    p->opcode.word == breakpoint2_insn.word)
 		regs->cp0_epc = (unsigned long)p->addr;
-	else if (insn_has_delayslot(p->opcode)) {
+	else if (insn_has_delayslot(((union mips_instruction)p->opcode).word)) {
 		ret = evaluate_branch_instruction(p, regs, kcb);
 		if (ret < 0) {
 			pr_notice("Kprobes: Error in evaluating branch\n");
@@ -320,7 +320,7 @@ static void __kprobes resume_execution(struct kprobe *p,
 				       struct pt_regs *regs,
 				       struct kprobe_ctlblk *kcb)
 {
-	if (insn_has_delayslot(p->opcode))
+	if (insn_has_delayslot(((union mips_instruction)p->opcode).word))
 		regs->cp0_epc = kcb->target_epc;
 	else {
 		unsigned long orig_epc = kcb->kprobe_saved_epc;
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index a11c6f9..e160923 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -248,13 +248,13 @@ static inline int is_ra_save_ins(union mips_instruction *ip)
 		ip->i_format.rt == 31;
 }
 
-static inline int is_jal_jalr_jr_ins(union mips_instruction *ip)
+static inline int is_jal_jalr_jr_ins(unsigned int insn)
 {
-	if (ip->j_format.opcode == jal_op)
+	if (INSN_OPCODE(insn) == jal_op)
 		return 1;
-	if (ip->r_format.opcode != spec_op)
+	if (INSN_OPCODE(insn) != spec_op)
 		return 0;
-	return ip->r_format.func == jalr_op || ip->r_format.func == jr_op;
+	return INSN_FUNC(insn) == jalr_op || INSN_FUNC(insn) == jr_op;
 }
 
 static inline int is_sp_move_ins(union mips_instruction *ip)
@@ -285,7 +285,7 @@ static int get_frame_info(struct mips_frame_info *info)
 
 	for (i = 0; i < max_insns; i++, ip++) {
 
-		if (is_jal_jalr_jr_ins(ip))
+		if (is_jal_jalr_jr_ins(ip->word))
 			break;
 		if (!info->frame_size) {
 			if (is_sp_move_ins(ip))
diff --git a/arch/mips/oprofile/backtrace.c b/arch/mips/oprofile/backtrace.c
index 6854ed5..26d05cd 100644
--- a/arch/mips/oprofile/backtrace.c
+++ b/arch/mips/oprofile/backtrace.c
@@ -52,7 +52,7 @@ static inline int is_sp_move_ins(union mips_instruction *ip)
 static inline int is_end_of_function_marker(union mips_instruction *ip)
 {
 	/* jr ra */
-	if (ip->r_format.func == jr_op && ip->r_format.rs == 31)
+	if (R_INSN_FUNC(ip->word) && R_INSN_RS(ip->word) == 31)
 		return 1;
 	/* lui gp */
 	if (ip->i_format.opcode == lui_op && ip->i_format.rt == 28)
-- 
1.7.9.5
