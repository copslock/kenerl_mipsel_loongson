Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 19:27:02 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38056 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S1493162AbZKXSQw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Nov 2009 19:16:52 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAOIH5X1014475;
	Tue, 24 Nov 2009 18:17:05 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAOIH4E7014473;
	Tue, 24 Nov 2009 18:17:04 GMT
Date:	Tue, 24 Nov 2009 18:17:04 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mikael Starvik <mikael.starvik@axis.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	David Daney <ddaney@caviumnetworks.com>
Subject: Re: COP2 unaligned -> SIGBUS
Message-ID: <20091124181704.GA14412@linux-mips.org>
References: <4BEA3FF3CAA35E408EA55C7BE2E61D0546A5E6F9DC@xmail3.se.axis.com> <20091123113820.GA4217@linux-mips.org> <20091123115619.GB4217@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091123115619.GB4217@linux-mips.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25101
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 23, 2009 at 11:56:19AM +0000, Ralf Baechle wrote:

> 
> > > Since there are now at least two users of cop2 I propose the following:
> > 
> > Yes, the comment is not quite correct.  CP2 has always been available for
> > application specific extensions and a few imlementations have made use of
> > that.  I'll update the comment.  Oh and the Praystation has a TLB.
> 
> On 2nd thought - there is one user of CU2 in the kernel - the Cavium support.
> 
> Nothing else in the stock Linux/MIPS kernel will ever enable c0_status.cu2,
> so the attempt to execute a CP2 load or store instruction would result in a
> Coprocessor Unusable exception which whould result in a SIGILL being
> delivered to the offending process.  On Cavium the instructions COP2 is
> documented to not deliver any exceptions so there isn't really anything
> that would need to be changed.
> 
> David - I think we should try to get rid of the processor specifics from
> this core code so probably having notifiers to run on Address Error or
> Coprocessor Unusable exceptions would be a solution?  I also want to get
> rid of the Cavium #ifdef from traps.c.

So how about this patch below?  It uses notifiers as a halfway clean and
reasonably fast hook mechanism.  Might be over-engineered though :-)
Compiles but not runtime tested.

  Ralf

From: Ralf Baechle <ralf@linux-mips.org>

MIPS: COP2 cleanups.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 1394362..3e98763 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -9,7 +9,7 @@
 # Copyright (C) 2005-2009 Cavium Networks
 #
 
-obj-y := setup.o serial.o octeon-platform.o octeon-irq.o csrc-octeon.o
+obj-y := cpu.o setup.o serial.o octeon-platform.o octeon-irq.o csrc-octeon.o
 obj-y += dma-octeon.o flash_setup.o
 obj-y += octeon-memcpy.o
 
diff --git a/arch/mips/cavium-octeon/cpu.c b/arch/mips/cavium-octeon/cpu.c
new file mode 100644
index 0000000..b6df538
--- /dev/null
+++ b/arch/mips/cavium-octeon/cpu.c
@@ -0,0 +1,52 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2009 Wind River Systems,
+ *   written by Ralf Baechle <ralf@linux-mips.org>
+ */
+#include <linux/init.h>
+#include <linux/irqflags.h>
+#include <linux/notifier.h>
+#include <linux/prefetch.h>
+#include <linux/sched.h>
+
+#include <asm/cop2.h>
+#include <asm/current.h>
+#include <asm/mipsregs.h>
+#include <asm/page.h>
+#include <asm/octeon/octeon.h>
+
+static int cnmips_cu2_call(struct notifier_block *nfb, unsigned long action,
+	void *data)
+{
+	unsigned long flags;
+	unsigned int status;
+
+	switch (action) {
+	case CU2_EXCEPTION:
+		prefetch(&current->thread.cp2);
+		local_irq_save(flags);
+		KSTK_STATUS(current) |= ST0_CU2;
+		status = read_c0_status();
+		write_c0_status(status | ST0_CU2);
+		octeon_cop2_restore(&(current->thread.cp2));
+		write_c0_status(status & ~ST0_CU2);
+		local_irq_restore(flags);
+
+		return NOTIFY_BAD;	/* Don't call default notifier */
+	}
+
+	return NOTIFY_OK;		/* Let default notifier send signals */
+}
+
+static struct notifier_block cnmips_cu2_notifier = {
+	.notifier_call = cnmips_cu2_call,
+};
+
+static int cnmips_cu2_setup(void)
+{
+	return register_cu2_notifier(&cnmips_cu2_notifier);
+}
+early_initcall(cnmips_cu2_setup);
diff --git a/arch/mips/include/asm/cop2.h b/arch/mips/include/asm/cop2.h
new file mode 100644
index 0000000..6b04c98
--- /dev/null
+++ b/arch/mips/include/asm/cop2.h
@@ -0,0 +1,23 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2009 Wind River Systems,
+ *   written by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_COP2_H
+#define __ASM_COP2_H
+
+enum cu2_ops {
+	CU2_EXCEPTION,
+	CU2_LWC2_OP,
+	CU2_LDC2_OP,
+	CU2_SWC2_OP,
+	CU2_SDC2_OP,
+};
+
+extern int register_cu2_notifier(struct notifier_block *nb);
+extern int cu2_notifier_call_chain(unsigned long val, void *v);
+
+#endif /* __ASM_COP2_H */
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index cac9b1a..4d0a8c6 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -47,6 +47,7 @@ struct octeon_cop2_state;
 extern unsigned long octeon_crypto_enable(struct octeon_cop2_state *state);
 extern void octeon_crypto_disable(struct octeon_cop2_state *state,
 				  unsigned long flags);
+extern asmlinkage void octeon_cop2_restore(struct octeon_cop2_state *task);
 
 extern void octeon_init_cvmcount(void);
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 0a18b4c..2c5c3a2 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -25,10 +25,12 @@
 #include <linux/ptrace.h>
 #include <linux/kgdb.h>
 #include <linux/kdebug.h>
+#include <linux/notifier.h>
 
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
 #include <asm/break.h>
+#include <asm/cop2.h>
 #include <asm/cpu.h>
 #include <asm/dsp.h>
 #include <asm/fpu.h>
@@ -79,10 +81,6 @@ extern asmlinkage void handle_reserved(void);
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 	struct mips_fpu_struct *ctx, int has_fpu);
 
-#ifdef CONFIG_CPU_CAVIUM_OCTEON
-extern asmlinkage void octeon_cop2_restore(struct octeon_cop2_state *task);
-#endif
-
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 void (*board_nmi_handler_setup)(void);
@@ -857,6 +855,44 @@ static void mt_ase_fp_affinity(void)
 #endif /* CONFIG_MIPS_MT_FPAFF */
 }
 
+/*
+ * No lock; only written during early bootup by CPU 0.
+ */
+static RAW_NOTIFIER_HEAD(cu2_chain);
+
+int __ref register_cu2_notifier(struct notifier_block *nb)
+{
+	return raw_notifier_chain_register(&cu2_chain, nb);
+}
+
+int cu2_notifier_call_chain(unsigned long val, void *v)
+{
+	return raw_notifier_call_chain(&cu2_chain, val, v);
+}
+
+static int default_cu2_call(struct notifier_block *nfb, unsigned long action,
+        void *data)
+{
+	struct pt_regs *regs = data;
+
+	switch (action) {
+	default: 
+		die_if_kernel("Unhandled kernel unaligned access or invalid "
+			      "instruction", regs);
+		/* Fall through  */
+
+	case CU2_EXCEPTION:
+		force_sig(SIGILL, current);
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block default_cu2_notifier = {
+	.notifier_call	= default_cu2_call,
+	.priority	= 0x80000000,		/* Run last  */
+};
+
 asmlinkage void do_cpu(struct pt_regs *regs)
 {
 	unsigned int __user *epc;
@@ -920,17 +956,9 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 		return;
 
 	case 2:
-#ifdef CONFIG_CPU_CAVIUM_OCTEON
-		prefetch(&current->thread.cp2);
-		local_irq_save(flags);
-		KSTK_STATUS(current) |= ST0_CU2;
-		status = read_c0_status();
-		write_c0_status(status | ST0_CU2);
-		octeon_cop2_restore(&(current->thread.cp2));
-		write_c0_status(status & ~ST0_CU2);
-		local_irq_restore(flags);
-		return;
-#endif
+		raw_notifier_call_chain(&cu2_chain, CU2_EXCEPTION, regs);
+		break;
+
 	case 3:
 		break;
 	}
@@ -1760,4 +1788,6 @@ void __init trap_init(void)
 	flush_tlb_handlers();
 
 	sort_extable(__start___dbe_table, __stop___dbe_table);
+
+	register_cu2_notifier(&default_cu2_notifier);
 }
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 67bd626..69b039c 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -81,6 +81,7 @@
 #include <asm/asm.h>
 #include <asm/branch.h>
 #include <asm/byteorder.h>
+#include <asm/cop2.h>
 #include <asm/inst.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -451,17 +452,27 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		 */
 		goto sigbus;
 
+	/*
+	 * COP2 is available to implementor for application specific use.
+	 * It's up to applications to register a notifier chain and do
+	 * whatever they have to do, including possible sending of signals.
+	 */
 	case lwc2_op:
+		cu2_notifier_call_chain(CU2_LWC2_OP, regs);
+		break;
+
 	case ldc2_op:
+		cu2_notifier_call_chain(CU2_LDC2_OP, regs);
+		break;
+
 	case swc2_op:
+		cu2_notifier_call_chain(CU2_SWC2_OP, regs);
+		break;
+
 	case sdc2_op:
-		/*
-		 * These are the coprocessor 2 load/stores.  The current
-		 * implementations don't use cp2 and cp2 should always be
-		 * disabled in c0_status.  So send SIGILL.
-                 * (No longer true: The Sony Praystation uses cp2 for
-                 * 3D matrix operations.  Dunno if that thingy has a MMU ...)
-		 */
+		cu2_notifier_call_chain(CU2_SDC2_OP, regs);
+		break;
+
 	default:
 		/*
 		 * Pheeee...  We encountered an yet unknown instruction or
