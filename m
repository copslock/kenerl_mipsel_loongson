Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 01:53:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37771 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012495AbbHEXxwpG2L1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 01:53:52 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C43EDD3EB0F0F;
        Thu,  6 Aug 2015 00:53:41 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 6 Aug
 2015 00:53:46 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Thu, 6 Aug
 2015 00:53:45 +0100
Received: from [127.0.1.1] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 5 Aug 2015
 16:53:42 -0700
Subject: [PATCH] MIPS: R6: emulation of PC-relative instructions
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     <linux-mips@linux-mips.org>, <paul.burton@imgtec.com>,
        <david.daney@cavium.com>, <Steven.Hill@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <markos.chandras@imgtec.com>, <macro@linux-mips.org>
Date:   Wed, 5 Aug 2015 16:53:43 -0700
Message-ID: <20150805235343.21126.29589.stgit@ubuntu-yegoshin>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

MIPS R6 has 6 new PC-relative instructions: LWUPC, LWPC, LDPC, ADDIUPC, ALUIPC
and AUIPC. These instructions can be placed in BD-slot of BC1* branch
instruction and FPU may be not available, which requires emulation of these
instructions.

However, the traditional way to emulate that is via filling some emulation block
in stack or special area and jump to it. This is not suitable for PC-relative
instructions.

So, this patch introduces a universal emulation of that instructions directly by
kernel emulator.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h     |   42 ++++++++++++++-
 arch/mips/kernel/mips-r2-to-r6-emul.c |    3 +
 arch/mips/math-emu/dsemul.c           |   94 +++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 3dce80e67948..6253197d4908 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -33,7 +33,7 @@ enum major_op {
 	sdl_op, sdr_op, swr_op, cache_op,
 	ll_op, lwc1_op, lwc2_op, bc6_op = lwc2_op, pref_op,
 	lld_op, ldc1_op, ldc2_op, beqzcjic_op = ldc2_op, ld_op,
-	sc_op, swc1_op, swc2_op, balc6_op = swc2_op, major_3b_op,
+	sc_op, swc1_op, swc2_op, balc6_op = swc2_op, pcrel_op,
 	scd_op, sdc1_op, sdc2_op, bnezcjialc_op = sdc2_op, sd_op
 };
 
@@ -238,6 +238,17 @@ enum msa_2b_fmt {
 	msa_fmt_d = 3,
 };
 
+enum relpc_op {
+	addiupc_op  = 0,
+	lwpc_op     = 1,
+	lwupc_op    = 2,
+};
+
+enum relpc_func {
+	auipc_func  = 6,
+	aluipc_func = 7,
+};
+
 /*
  * (microMIPS) Major opcodes.
  */
@@ -648,6 +659,32 @@ struct spec3_format {   /* SPEC3 */
 	;)))))
 };
 
+struct rel_format {        /* PC-relative */
+	__BITFIELD_FIELD(unsigned int opcode : 6,
+	__BITFIELD_FIELD(unsigned int rs : 5,
+	__BITFIELD_FIELD(unsigned int op : 2,
+	__BITFIELD_FIELD(signed int simmediate : 19,
+	;))))
+};
+
+struct rl16_format {        /* PC-relative, 16bit offset */
+	__BITFIELD_FIELD(unsigned int opcode : 6,
+	__BITFIELD_FIELD(unsigned int rs : 5,
+	__BITFIELD_FIELD(unsigned int op : 2,
+	__BITFIELD_FIELD(unsigned int func : 3,
+	__BITFIELD_FIELD(signed int simmediate : 16,
+	;)))))
+};
+
+struct rl18_format {        /* PC-relative, 18bit offset */
+	__BITFIELD_FIELD(unsigned int opcode : 6,
+	__BITFIELD_FIELD(unsigned int rs : 5,
+	__BITFIELD_FIELD(unsigned int op : 2,
+	__BITFIELD_FIELD(unsigned int unused : 1,
+	__BITFIELD_FIELD(signed int simmediate : 18,
+	;)))))
+};
+
 /*
  * microMIPS instruction formats (32-bit length)
  *
@@ -917,6 +954,9 @@ union mips_instruction {
 	struct f_format f_format;
 	struct ma_format ma_format;
 	struct msa_mi10_format msa_mi10_format;
+	struct rel_format rel_format;
+	struct rl16_format rl16_format;
+	struct rl18_format rl18_format;
 	struct b_format b_format;
 	struct ps_format ps_format;
 	struct v_format v_format;
diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index 040842a3aec4..c2e132f8e391 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -1033,6 +1033,7 @@ repeat:
 			if (nir) {
 				err = mipsr6_emul(regs, nir);
 				if (err > 0) {
+					regs->cp0_epc = nepc;
 					err = mips_dsemul(regs, nir, cpc, epc, r31);
 					if (err == SIGILL)
 						err = SIGEMT;
@@ -1082,6 +1083,7 @@ repeat:
 			if (nir) {
 				err = mipsr6_emul(regs, nir);
 				if (err > 0) {
+					regs->cp0_epc = nepc;
 					err = mips_dsemul(regs, nir, cpc, epc, r31);
 					if (err == SIGILL)
 						err = SIGEMT;
@@ -1149,6 +1151,7 @@ repeat:
 		if (nir) {
 			err = mipsr6_emul(regs, nir);
 			if (err > 0) {
+				regs->cp0_epc = nepc;
 				err = mips_dsemul(regs, nir, cpc, epc, r31);
 				if (err == SIGILL)
 					err = SIGEMT;
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index eac76a09d822..9b388aaf594f 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -8,6 +8,95 @@
 
 #include "ieee754.h"
 
+#ifdef CONFIG_CPU_MIPSR6
+
+static int mipsr6_pc(struct pt_regs *regs, mips_instruction inst, unsigned long cpc,
+		    unsigned long bpc, unsigned long r31)
+{
+	union mips_instruction ir = (union mips_instruction)inst;
+	register unsigned long vaddr;
+	unsigned int val;
+	int err = SIGILL;
+
+	if (ir.rel_format.opcode != pcrel_op)
+		return SIGILL;
+
+	switch (ir.rel_format.op) {
+	case addiupc_op:
+		vaddr = regs->cp0_epc + (ir.rel_format.simmediate << 2);
+		if (config_enabled(CONFIG_64BIT) && !(regs->cp0_status & ST0_UX))
+			__asm__ __volatile__("sll %0, %0, 0":"+&r"(vaddr)::);
+		regs->regs[ir.rel_format.rs] = vaddr;
+		return 0;
+#ifdef CONFIG_CPU_MIPS64
+	case lwupc_op:
+		vaddr = regs->cp0_epc + (ir.rel_format.simmediate << 2);
+		if (config_enabled(CONFIG_64BIT) && !(regs->cp0_status & ST0_UX))
+			__asm__ __volatile__("sll %0, %0, 0":"+&r"(vaddr)::);
+		if (get_user(val, (u32 __user *)vaddr)) {
+			current->thread.cp0_baduaddr = vaddr;
+			err = SIGSEGV;
+			break;
+		}
+		regs->regs[ir.rel_format.rs] = val;
+		return 0;
+#endif
+	case lwpc_op:
+		vaddr = regs->cp0_epc + (ir.rel_format.simmediate << 2);
+		if (config_enabled(CONFIG_64BIT) && !(regs->cp0_status & ST0_UX))
+			__asm__ __volatile__("sll %0, %0, 0":"+&r"(vaddr)::);
+		if (get_user(val, (u32 __user *)vaddr)) {
+			current->thread.cp0_baduaddr = vaddr;
+			err = SIGSEGV;
+			break;
+		}
+		regs->regs[ir.rel_format.rs] = (int)val;
+		return 0;
+	default:
+		switch (ir.rl16_format.func) {
+		case aluipc_func:
+			vaddr = regs->cp0_epc + (ir.rl16_format.simmediate << 16);
+			if (config_enabled(CONFIG_64BIT) &&
+			    !(regs->cp0_status & ST0_UX))
+				__asm__ __volatile__("sll %0, %0, 0":"+&r"(vaddr)::);
+			vaddr &= ~0xffff;
+			regs->regs[ir.rel_format.rs] = vaddr;
+			return 0;
+		case auipc_func:
+			vaddr = regs->cp0_epc + (ir.rl16_format.simmediate << 16);
+			if (config_enabled(CONFIG_64BIT) &&
+			    !(regs->cp0_status & ST0_UX))
+				__asm__ __volatile__("sll %0, %0, 0":"+&r"(vaddr)::);
+			regs->regs[ir.rel_format.rs] = vaddr;
+			return 0;
+		default: {
+#ifdef CONFIG_CPU_MIPS64
+				unsigned long dval;
+
+				if (ir.rl18_format.unused)
+					break;
+				/* LDPC */
+				vaddr = regs->cp0_epc & ~0x7;
+				vaddr += (ir.rl18_format.simmediate << 3);
+				if (config_enabled(CONFIG_64BIT) &&
+				    !(regs->cp0_status & ST0_UX))
+					__asm__ __volatile__("sll %0, %0, 0":"+&r"(vaddr)::);
+				if (get_user(dval, (u64 __user *)vaddr)) {
+					current->thread.cp0_baduaddr = vaddr;
+					err = SIGSEGV;
+					break;
+				}
+				regs->regs[ir.rel_format.rs] = dval;
+				return 0;
+#endif
+			}
+		}
+		break;
+	}
+	return err;
+}
+#endif
+
 /*
  * Emulate the arbritrary instruction ir at xcp->cp0_epc.  Required when
  * we have to emulate the instruction in a COP1 branch delay slot.  Do
@@ -54,6 +143,11 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc,
 
 	pr_debug("dsemul %lx %lx\n", regs->cp0_epc, cpc);
 
+#ifdef CONFIG_CPU_MIPSR6
+	err = mipsr6_pc(regs, ir, cpc, bpc, r31);
+	if (err != SIGILL)
+		return err;
+#endif
 	/*
 	 * The strategy is to push the instruction onto the user stack/VDSO page
 	 * and put a trap after it which we can catch and jump to
