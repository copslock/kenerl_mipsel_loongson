Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 02:39:10 +0000 (GMT)
Received: from p508B65B9.dip.t-dialin.net ([IPv6:::ffff:80.139.101.185]:14489
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225223AbTA1CjK>; Tue, 28 Jan 2003 02:39:10 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0S2d1Q24186;
	Tue, 28 Jan 2003 03:39:01 +0100
Date: Tue, 28 Jan 2003 03:39:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mike Uhler <uhler@mips.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: unaligned load in branch delay slot
Message-ID: <20030128033901.A23492@linux-mips.org>
References: <200301131719.h0DHJkG29389@uhler-linux.mips.com> <Pine.GSO.4.21.0301131901500.21279-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0301131901500.21279-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Mon, Jan 13, 2003 at 07:04:36PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 13, 2003 at 07:04:36PM +0100, Geert Uytterhoeven wrote:

> The following patch (against linux-mips-2.4.x CVS) cures my crash.
> 
> I don't know on which CPUs this may happen (need #ifdef CONFIG_CPU_VR41XX?),
> nor whether all branch and jump instructions are affected (I included
> everything that starts with a `b' or `j').

I'm suggesting this alternative patch below.  Comments?

  Ralf

diff -u -r1.4.2.1 branch.h
--- include/asm-mips/branch.h 7 May 2002 03:48:08 -0000
+++ include/asm-mips/branch.h 28 Jan 2003 02:34:12 -0000
@@ -8,11 +8,52 @@
 #ifndef _ASM_BRANCH_H
 #define _ASM_BRANCH_H
 
+#include <asm/inst.h>
 #include <asm/ptrace.h>
+#include <asm/uaccess.h>
+#include <asm/war.h>
 
 static inline int delay_slot(struct pt_regs *regs)
 {
-	return regs->cp0_cause & CAUSEF_BD;
+#ifdef BDSLOT_WAR
+	union mips_instruction insn;
+	mm_segment_t seg;
+#endif
+	int ds;
+
+	ds = regs->cp0_cause & CAUSEF_BD;
+	if (ds)
+		return ds;
+
+#ifdef BDSLOT_WAR
+	if (!user_mode(regs))
+		set_fs(KERNEL_DS);
+	__get_user(insn.word, (unsigned int *)regs->cp0_epc);
+	set_fs(seg);
+
+	switch (insn.i_format.opcode) {
+	/*
+	 * On some CPUs, if an unaligned access happens in a branch delay slot
+	 * and the branch is not taken, EPC points at the branch instruction,
+	 * but the BD bit in the cause register is not set.
+	 */
+	case bcond_op:
+	case j_op:
+	case jal_op:
+	case beq_op:
+	case bne_op:
+	case blez_op:
+	case bgtz_op:
+	case beql_op:
+	case bnel_op:
+	case blezl_op:
+	case bgtzl_op:
+	case jalx_op:
+		return 1;	
+	}
+#endif
+
+	return 0;
 }
 
 static inline unsigned long exception_epc(struct pt_regs *regs)
diff -u -r1.1.2.4 war.h
--- include/asm-mips/war.h 2 Oct 2002 19:42:04 -0000
+++ include/asm-mips/war.h 28 Jan 2003 02:34:13 -0000
@@ -84,4 +84,17 @@
 
 #endif
 
+#if !defined(CONFIG_CPU_MIPS32) && !defined(CONFIG_CPU_MIPS64)
+
+/*
+ * A bunch of CPUs predating the MIPS32 and MIPS64 specs do not always set
+ * the BD bit in c0_cause on an exception.  For those we need to look at
+ * the faulting instruction to deciede if we were faulting in a delay slot.
+ * There might be further CPUs where BD works as expected but for now we're
+ * paranoid.
+ */
+#define BDSLOT_WAR
+
+#endif
+
 #endif /* _ASM_WAR_H */
