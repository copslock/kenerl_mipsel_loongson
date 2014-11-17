Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 17:10:46 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:64522 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013838AbaKQQKoTOzSC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 17:10:44 +0100
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1XqOsu-0004fU-Uq from Maciej_Rozycki@mentor.com ; Mon, 17 Nov 2014 08:10:37 -0800
Received: from localhost (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server (TLS) id 14.3.181.6; Mon, 17 Nov
 2014 16:10:35 +0000
Date:   Mon, 17 Nov 2014 16:10:32 +0000
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] MIPS: jump_label.c: Handle the microMIPS J instruction
 encoding
In-Reply-To: <alpine.DEB.1.10.1411170524070.2881@tp.orcam.me.uk>
Message-ID: <alpine.DEB.1.10.1411170530220.2881@tp.orcam.me.uk>
References: <alpine.DEB.1.10.1411170524070.2881@tp.orcam.me.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <Maciej_Rozycki@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
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

Implement the microMIPS encoding of the J instruction for the purpose of 
the static keys feature, fixing a crash early on in bootstrap as the 
kernel is unhappy seeing the ISA bit set in jump table entries.  Make 
sure the ISA bit correctly reflects the instruction encoding chosen for 
the kernel, 0 for the standard MIPS and 1 for the microMIPS encoding.

Also make sure the instruction to patch is a 32-bit NOP in the microMIPS 
mode as by default the 16-bit short encoding is assumed

Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
---
Hi,

 Rather obvious, mostly a bit different bit shuffling.  I think all code 
that reads or writes microMIPS instructions should be audited and the 
operations abstracted so that every place does not have to repeat the 
same steps manually, but that is something for another occasion.  

 Meanwhile, please apply.

  Maciej

linux-umips-jump-label.diff
Index: linux-3.17-stable-malta-el/arch/mips/include/asm/jump_label.h
===================================================================
--- linux-3.17-stable-malta-el.orig/arch/mips/include/asm/jump_label.h	2014-11-17 02:12:17.000000000 +0000
+++ linux-3.17-stable-malta-el/arch/mips/include/asm/jump_label.h	2014-11-17 07:06:18.491909609 +0000
@@ -20,9 +20,15 @@
 #define WORD_INSN ".word"
 #endif
 
+#ifdef CONFIG_CPU_MICROMIPS
+#define NOP_INSN "nop32"
+#else
+#define NOP_INSN "nop"
+#endif
+
 static __always_inline bool arch_static_branch(struct static_key *key)
 {
-	asm_volatile_goto("1:\tnop\n\t"
+	asm_volatile_goto("1:\t" NOP_INSN "\n\t"
 		"nop\n\t"
 		".pushsection __jump_table,  \"aw\"\n\t"
 		WORD_INSN " 1b, %l[l_yes], %0\n\t"
Index: linux-3.17-stable-malta-el/arch/mips/kernel/jump_label.c
===================================================================
--- linux-3.17-stable-malta-el.orig/arch/mips/kernel/jump_label.c	2014-11-17 07:06:18.000000000 +0000
+++ linux-3.17-stable-malta-el/arch/mips/kernel/jump_label.c	2014-11-17 08:28:23.781948719 +0000
@@ -18,31 +18,53 @@
 
 #ifdef HAVE_JUMP_LABEL
 
-#define J_RANGE_MASK ((1ul << 28) - 1)
+/*
+ * Define parameters for the standard MIPS and the microMIPS jump
+ * instruction encoding respectively:
+ *
+ * - the ISA bit of the target, either 0 or 1 respectively,
+ *
+ * - the amount the jump target address is shifted right to fit in the
+ *   immediate field of the machine instruction, either 2 or 1,
+ *
+ * - the mask determining the size of the jump region relative to the
+ *   delay-slot instruction, either 256MB or 128MB,
+ *
+ * - the jump target alignment, either 4 or 2 bytes.
+ */
+#define J_ISA_BIT	IS_ENABLED(CONFIG_CPU_MICROMIPS)
+#define J_RANGE_SHIFT	(2 - J_ISA_BIT)
+#define J_RANGE_MASK	((1ul << (26 + J_RANGE_SHIFT)) - 1)
+#define J_ALIGN_MASK	((1ul << J_RANGE_SHIFT) - 1)
 
 void arch_jump_label_transform(struct jump_entry *e,
 			       enum jump_label_type type)
 {
+	union mips_instruction *insn_p;
 	union mips_instruction insn;
-	union mips_instruction *insn_p =
-		(union mips_instruction *)(unsigned long)e->code;
 
-	/* Jump only works within a 256MB aligned region of its delay slot. */
+	insn_p = (union mips_instruction *)msk_isa16_mode(e->code);
+
+	/* Jump only works within an aligned region its delay slot is in. */
 	BUG_ON((e->target & ~J_RANGE_MASK) != ((e->code + 4) & ~J_RANGE_MASK));
 
-	/* Target must have 4 byte alignment. */
-	BUG_ON((e->target & 3) != 0);
+	/* Target must have the right alignment and ISA must be preserved. */
+	BUG_ON((e->target & J_ALIGN_MASK) != J_ISA_BIT);
 
 	if (type == JUMP_LABEL_ENABLE) {
-		insn.j_format.opcode = j_op;
-		insn.j_format.target = (e->target & J_RANGE_MASK) >> 2;
+		insn.j_format.opcode = J_ISA_BIT ? mm_j32_op : j_op;
+		insn.j_format.target = e->target >> J_RANGE_SHIFT;
 	} else {
 		insn.word = 0; /* nop */
 	}
 
 	get_online_cpus();
 	mutex_lock(&text_mutex);
-	*insn_p = insn;
+	if (IS_ENABLED(CONFIG_CPU_MICROMIPS)) {
+		insn_p->halfword[0] = insn.word >> 16;
+		insn_p->halfword[1] = insn.word;
+	} else
+		*insn_p = insn;
 
 	flush_icache_range((unsigned long)insn_p,
 			   (unsigned long)insn_p + sizeof(*insn_p));
