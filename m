Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2008 00:50:19 +0100 (BST)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:54148 "EHLO
	sj-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20021484AbYEGXuM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 May 2008 00:50:12 +0100
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-2.cisco.com with ESMTP; 07 May 2008 16:49:54 -0700
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m47NnsSG003249
	for <linux-mips@linux-mips.org>; Wed, 7 May 2008 16:49:54 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m47NnsSC004582
	for <linux-mips@linux-mips.org>; Wed, 7 May 2008 23:49:54 GMT
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id XAA05289 for <linux-mips@linux-mips.org>; Wed, 7 May 2008 23:49:53 GMT
Message-ID: <48224021.7050306@cisco.com>
Date:	Wed, 07 May 2008 16:49:53 -0700
From:	David VomLehn <dvomlehn@cisco.com>
Reply-To: dvomlehn@cisco.com
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [RFC] [PATCH 1/1] [MIPS] Advanced Kernel Stack Backtrace
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=136334; t=1210204194; x=1211068194;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20[RFC]=20[PATCH=201/1]=20[MIPS]=20Advanced=20Ker
	nel=20Stack=20Backtrace
	|Sender:=20;
	bh=yHozLPhZjtVuLhbdyLNAuQlyehi66tUOyO5WCA6glr4=;
	b=BfYw76kjmYlIKwyBNgZcExIeinX6mBozPu/BOGdutRRWnONOE+ozEFrrx1
	ZHckZHgH+E1YACfBYCldgpVunQ62o/tGhXyi8HfYv7tqRpWfQ3/VS2eGGkGv
	uVtCDVEf2t/6N3AEpTVTeSfwws/QWxMT0JZ0mNc3LZU+Fu2fxj8f8=;
Authentication-Results:	sj-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

This patch contains the kernel stack backtrace code we've been running 
for about a year on our MIPS-based settop box. It is considerably larger 
than the existing backtrace implementation and so is configurable in the 
Kernel Hacking section.  It also requires that KALLSYMS be enabled. In 
return, I think it offers some advantages over the existing backtrace code:

o It will backtrace over nested interrupts and exceptions, allowing 
detailed analysis of was going on when it was invoked.
o It handles a number of corner cases involving instructions in branch 
delay slots.
o It is very careful to use __get_user when fetching stack data and 
instructions, meaning that it will fail gracefully even in the presence 
of stack corruption.
o It identifies whether the $sp register or another register is being 
used as the frame pointer. Assuming people are happy with this 
submission, there is a small subsequent patch I'll submit that dumps the 
frame pointer value as part of the backtrace.
o It segregates the backtrace code into a subdirectory of 
arch/mips/kernel rather than cluttering up traps.c or the kernel directory.

The main reason I am submitting this as a request for comments rather 
than as a normal patch is that, though I wrote it with 64-bit systems in 
mind, I don't have access to a 64-bit system on which to test it. I am 
happy to merge any 64-bit-specific changes. For 32-bit systems, I'll 
claim it's ready to go.

The other reason is that this is an RFC is that it is such a large, 
single chunk of code that there are certainly lots of comments that 
people will have. I'm not naive enough to think it's really ready 
without more review.

[Note: for anyone who was at the MIPS backtrace session at the CELF 
Conference, this is the code I was talking about.]

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
--
diff -urN linux-2.6.25.1/arch/mips/Kconfig.debug 
linux-t/arch/mips/Kconfig.debug
--- linux-2.6.25.1/arch/mips/Kconfig.debug	2008-05-01 14:45:25.000000000 
-0700
+++ linux-t/arch/mips/Kconfig.debug	2008-05-06 18:21:45.000000000 -0700
@@ -73,6 +73,17 @@
  	  include/asm-mips/debug.h for debuging macros.
  	  If unsure, say N.

+config MIPS_ADVANCED_BACKTRACE
+	bool "More sophisticated backtrace code"
+	default n
+	depends on KALLSYMS
+	help
+	  Use backtrace code that more completely handles the various
+	  complexities of the MIPS processors, including branch delay
+	  slots. This is substantially larger than the standard backtrace
+	  code. Using this also prints the frame pointer for each function
+	  in the call stack.
+
  config MIPS_UNCACHED
  	bool "Run uncached"
  	depends on DEBUG_KERNEL && !SMP && !SGI_IP27
diff -urN linux-2.6.25.1/arch/mips/kernel/backtrace/kernel-backtrace.c 
linux-t/arch/mips/kernel/backtrace/kernel-backtrace.c
--- linux-2.6.25.1/arch/mips/kernel/backtrace/kernel-backtrace.c 
1969-12-31 16:00:00.000000000 -0800
+++ linux-t/arch/mips/kernel/backtrace/kernel-backtrace.c	2008-05-06 
18:38:48.000000000 -0700
@@ -0,0 +1,978 @@
+/*
+ *				kernel-backtrace.c
+ *
+ * Perform backtrace in the kernel. This means that, besides handling 
signals
+ * (which can happen to kernel threads, too), it must handle 
backtracing over
+ * exceptions and interrupts.
+ *
+ * Copyright (C) 2007  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 
02110-1301  USA
+ *
+ * Author: David VomLehn
+ */
+
+#include <linux/irq.h>
+#include <linux/kallsyms.h>
+#include <linux/module.h>
+#include <asm/system.h>
+#include <asm/mipsregs.h>
+#include <asm/uaccess.h>
+#include <asm/asm-offsets.h>
+#include <asm/kernel-backtrace.h>
+#include <asm/kernel-backtrace-symbols.h>
+
+#ifndef	numberof
+#define	numberof(a)	(sizeof(a) / sizeof((a) [0]))
+#endif
+
+/* Offsets and sizes in the exception vector */
+#define	TLB_REFILL_OFFSET	0
+#define	TLB_REFILL_SIZE		0x80
+#define	GEN_EX_OFFSET		0x180
+#define	GEN_EX_SIZE		0x80
+#define	INTERRUPT_OFFSET	0x200
+#define	INTERRUPT_SIZE		(NR_IRQS * vectorspacing())
+#define	UNEXPECTED_OFFSET	0x80
+#define	UNEXPECTED_SIZE		0x100
+
+static int in_exception_vector(reg_t pc, unsigned start, unsigned size);
+static const struct kern_special_sym *special_symbol(reg_t pc, reg_t 
*start,
+	reg_t *size);
+static int pop_k0_k1_only_frame(struct kernel_bt *bt);
+static int pop_save_some_frame(struct kernel_bt *bt);
+static int pop_save_all_frame(struct kernel_bt *bt);
+static int pop_save_some_or_all_frame(struct kernel_bt *bt);
+static int pop_save_static_frame(struct kernel_bt *bt);
+static int pop_glue_frame(struct kernel_bt *bt);
+static int pop_restore_some_frame(struct kernel_bt *bt);
+static int pop_exception(struct kernel_bt *bt);
+static int do_kernel_backtrace(struct kernel_bt *bt,
+	process_kernel_frame_t process, void *arg);
+static int update_saved_registers(struct kernel_bt *bt, reg_t ip,
+	reg_t ptr);
+static int update_saved_register(struct kernel_bt *bt, reg_t ptr,
+	reg_offset_t offset);
+static int read_pt_regs(struct kernel_bt *bt);
+static int get_op(reg_t ip, opcode_t *op);
+static int get_reg(reg_t rp, reg_t *reg);
+static int symbol_lookup(reg_t ip, reg_t *start, reg_t *size);
+static int get_sc_reg(reg_t rp, reg_t *reg);
+
+static const struct thread_bt_config tb_config = {
+	{SIMPLE_BACKTRACE_LOOKUP_FUNC, get_op, get_reg, symbol_lookup},
+	get_sc_reg
+};
+
+/*
+ * Returns the number of bytes in each entry of the interrupt vector.
+ */
+static unsigned vectorspacing(void)
+{
+	const unsigned	M_VS = 0x000003e0;
+	const unsigned	S_VS = 0;
+
+	return(read_c0_intctl() & M_VS) >> S_VS;
+}
+
+/*
+ * Perform a stack backtrace from the values in a struct pt_regs object.
+ * Params:	regs	Pointer to a struct pt_regs object with the initial
+ *			register values to be used for the backtrace
+ *		process	Function that processes a stack frame
+ *		arg	Argument passed to the function that processes a
+ *			stack frame
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+int kernel_backtrace_pt_regs(const struct pt_regs *regs,
+	process_kernel_frame_t process, void *arg)
+{
+	struct kernel_bt	bt;
+	enum reg_num		i;
+
+	thread_backtrace_init(&bt.tbt, &tb_config);
+
+	for (i = REG_AT; i < REG_ALL; i ++) {
+		bt.tbt.sbt.gprs [i] = regs->regs [i];
+		bt.tbt.sbt.gpr_saved [i] = 1;
+	}
+
+	bt.tbt.sbt.pc = regs->cp0_epc;
+
+	bt.cp0_epc = regs->cp0_epc;
+	bt.cp0_status = regs->cp0_status;
+	bt.type = KERNEL_FRAME_SIMPLE;
+
+	return do_kernel_backtrace(&bt, process, arg);
+}
+EXPORT_SYMBOL(kernel_backtrace_pt_regs);
+
+/*
+ * Backtrace for a process the current function, including handling of
+ * signal frames.
+ * Params:	process	Function that will process each stack frame.
+ *		arg	Argument to passed to the processing function.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+int kernel_backtrace(process_kernel_frame_t process, void *arg)
+{
+	struct kernel_bt	bt;
+
+	thread_backtrace_init_here(&bt.tbt, &tb_config);
+
+	bt.cp0_epc = read_c0_epc();
+	bt.cp0_status = read_c0_status();
+	bt.type = KERNEL_FRAME_SIMPLE;
+
+	return do_kernel_backtrace(&bt, process, arg);
+}
+EXPORT_SYMBOL(kernel_backtrace);
+
+/*
+ * This performs a kernel backtrace.
+ * Params:	bt	Pointer to initialized kernel backtrace information
+ * 		process	Function that will process each stack frame.
+ *		arg	Argument to passed to the processing function.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+static int do_kernel_backtrace(struct kernel_bt *bt,
+	process_kernel_frame_t process, void *arg)
+{
+	int	result;
+
+	for (result = kernel_backtrace_first(bt);
+		result == 0;
+		result = kernel_backtrace_next(bt)) {
+
+		/* If $pc is a return address, i.e. an address stored in $ra
+		 * by a jalr instruction, adjust it to point to the jalr
+		 * because, in some sense, that instruction is not yet
+		 * complete. */
+		if (bt->tbt.pc_is_return_address) {
+			bt->tbt.sbt.pc -= 2 * OPCODE_SIZE;
+			bt_dbg(2, "$pc is return address, adjusted to 0x%lx\n",
+				bt->tbt.sbt.pc);
+		}
+
+		result = process(arg, bt);
+
+		/* If we adjusted the pc to point to a jalr instruction,
+		 * restore it */
+		if (bt->tbt.pc_is_return_address)
+			bt->tbt.sbt.pc += 2 * OPCODE_SIZE;
+
+		if (result != 0)
+			break;
+	}
+
+	/* If we got a return value of -ENOSYS, the $pc and $sp values are
+	 * good, but we can't continue the backtrace. Call the function to
+	 * process the last frame. */
+
+	if (result == -ENOSYS) {
+		(void) process(arg, bt);
+		result = 0;
+	}
+
+	/* The result could be zero because we internally determined that
+	 * the stack backtrace is done, or because the process function
+	 * passed back KERNEL_BACKTRACE_END to indicate that the backtrace
+	 * is done. Either case is normal, so adjust the result to indicate
+	 * a normal termination. */
+	if (result > 0) {
+		bt_dbg(2, "Adjusting positive return code %d to zero", result);
+		result = 0;
+	}
+
+	return result;
+}
+
+/*
+ * Gets the first stack frame.
+ * Params:	bt	Pointer struct kernel_bt object
+ * Returns:	KERNEL_BACKTRACE_DONE	The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ *
+ */
+int kernel_backtrace_first(struct kernel_bt *bt)
+{
+	int	result;
+
+	result = kernel_backtrace_analyze_frame(bt);
+
+	return result;
+}
+
+/*
+ * This handles getting the next kernel stackframe. It checks to see if 
we are
+ * in an exception or interrupt frame. If not, we just pass it along to the
+ * process backtracing.
+ * Params:	bt	Pointer to the struct kernel_bt object
+ * Returns:	KERNEL_BACKTRACE_DONE	The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+int kernel_backtrace_next(struct kernel_bt *bt)
+{
+	int	result;
+
+	result = kernel_backtrace_pop_frame(bt);
+
+	if (result == 0)
+		result = kernel_backtrace_analyze_frame(bt);
+
+	return result;
+}
+
+/*
+ * This determines the type of the current frame. This is done by 
looking at
+ * the $pc register and seeing whether it is in some sort of interrupt or
+ * exception frame. If not, it passes the analysis on to the 
thread_backtrace
+ * code.
+ * Params:	bt	Pointer to a struct kernel_bt object.
+ * Returns:	Zero if it was able to determine the frame type, or a negative
+ *		errno value if an error occurred during processing.
+ */
+int kernel_backtrace_analyze_frame(struct kernel_bt *bt)
+{
+	int			result = 0;	/* Assume success */
+	reg_t			pc;
+	const struct kern_special_sym	*symbol;
+
+	bt->tbt.sbt.frame_size = 0;
+	pc = bt->tbt.sbt.pc;
+
+	/* The kernel is kind enough to arrange things so that the return
+	 * address is NULL if we have reached the end of a kernel stack, so
+	 * if we see that case, we are done. */
+	if (pc == NULL_REG)
+		result = KERNEL_BACKTRACE_DONE;
+
+	else {
+		symbol = special_symbol(pc, &bt->start, &bt->size);
+
+		if (symbol != NULL) {
+			bt->tbt.pc_is_return_address = 0;
+			bt->type = symbol->type;
+		}
+
+		else if (in_exception_vector(pc, TLB_REFILL_OFFSET,
+			TLB_REFILL_SIZE)) {
+			bt->tbt.pc_is_return_address = 0;
+			bt->type = KERNEL_FRAME_TLB_REFILL;
+			bt->start = ebase + TLB_REFILL_OFFSET;
+			bt->size = TLB_REFILL_SIZE;
+		}
+
+		else if (in_exception_vector(pc, GEN_EX_OFFSET, GEN_EX_SIZE)) {
+			bt->tbt.pc_is_return_address = 0;
+			bt->type = KERNEL_FRAME_GENERAL_EXCEPTION;
+			bt->start = ebase + GEN_EX_OFFSET;
+			bt->size = GEN_EX_SIZE;
+		}
+
+		else if (in_exception_vector(pc, INTERRUPT_OFFSET,
+			INTERRUPT_SIZE)) {
+			unsigned	offset, irq, spacing;
+			bt->tbt.pc_is_return_address = 0;
+			bt->type = KERNEL_FRAME_INTERRUPT;
+
+			/* Since we are using the exception vector for handling
+			 * interrupts, i.e. the CP0 Config3 register has VEIC
+			 * or VI set and the CP0 Cause register has the IV bit
+			 * set, we subtract ebase + INTERRUPT_OFFSET from $pc
+			 * to get the offset into the interrupt vector portion.
+			 * We divide this by the space of the interrupt vector
+			 * entries to get the interrupt number. Then the start
+			 * of the entry for this interrupt is computed by
+			 * multiplying the interrupt number by the spacing and
+			 * adding ebase and INTERRUPT_OFFSET back in. The size
+			 * of the entry is given by the spacing of the
+			 * interrupt vector entries. */
+			spacing = vectorspacing();
+			offset = pc - (ebase + INTERRUPT_OFFSET);
+			irq = offset / spacing;
+			bt->start = ebase + INTERRUPT_OFFSET + irq * spacing;
+			bt->size = spacing;
+		}
+
+		else if (in_exception_vector(pc, UNEXPECTED_OFFSET,
+			UNEXPECTED_SIZE)) {
+			bt->tbt.pc_is_return_address = 0;
+			bt->type = KERNEL_FRAME_UNEXPECTED;
+			bt->start = ebase + UNEXPECTED_OFFSET;
+			bt->size = UNEXPECTED_SIZE;
+		}
+
+		else {
+			result = thread_backtrace_analyze_frame(&bt->tbt);
+			bt->type = bt->tbt.type;
+		}
+	}
+
+	return result;
+}
+
+/*
+ * Advances to the next frame based on the analysis of the current frame
+ * done by kernel_backtrace_analyze_frame().
+ * Params:	bt	Pointer to struct struct kernel_bt object.
+ * Returns:	KERNEL_BACKTRACE_DONE	The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+int kernel_backtrace_pop_frame(struct kernel_bt *bt)
+{
+	int	result;
+
+	switch (bt->type) {
+	case KERNEL_FRAME_SIMPLE:
+	case KERNEL_FRAME_SIGNAL:
+	case KERNEL_FRAME_RT_SIGNAL: result =
+			thread_backtrace_pop_frame(&bt->tbt);
+		break;
+
+	case KERNEL_FRAME_TLB_REFILL:
+	case KERNEL_FRAME_GENERAL_EXCEPTION:
+	case KERNEL_FRAME_K0_K1_ONLY: result = pop_k0_k1_only_frame(bt);
+		break;
+
+	case KERNEL_FRAME_INTERRUPT:
+	case KERNEL_FRAME_SAVE_SOME: result = pop_save_some_frame(bt);
+		break;
+
+	case KERNEL_FRAME_SAVE_STATIC: result = pop_save_static_frame(bt);
+		break;
+
+	case KERNEL_FRAME_SAVE_ALL: result = pop_save_all_frame(bt);
+		break;
+
+	case KERNEL_FRAME_GLUE: result = pop_glue_frame(bt);
+		break;
+
+	case KERNEL_FRAME_RESTORE_SOME: result = pop_restore_some_frame(bt);
+		break;
+
+	case KERNEL_FRAME_UNEXPECTED: result = KERNEL_BACKTRACE_DONE;
+		break;
+
+	default: result = -EINVAL;	/* Internal failure: Shouldn't happen */
+		bt_dbg(1, "Unexpected frame type: %d\n", bt->type);
+		break;
+	}
+
+	return result;
+}
+
+/*
+ * Function that determines whether we are in some section of the exception
+ * vector. If no exception vector has been set up, which we determine
+ * by seeing whether ebase has yet been set, we can't be in the exception
+ * vector code.
+ * Params:	pc	Current program counter
+ *		start	Offset of the start of the section from ebase
+ *		size	Size of the section.
+ * Returns:	Non-zero if we are in the given section, zero otherwise.
+ */
+static int in_exception_vector(reg_t pc, unsigned start, unsigned size)
+{
+	int			result;
+
+	if (ebase == 0)
+		result = 0;
+
+	else {
+		reg_t	offset;
+
+		offset = pc - ebase;
+		result = (offset >= start && offset < size);
+	}
+
+	return result;
+}
+
+/*
+ * This looks for the given pc value in the list of pieces of code that 
must
+ * be handled specially for backtrace purposes. If found, it will store the
+ * symbol start and size.
+ * Params:	pc	Value of pc to look for
+ *		start	Address of the start of the code section.
+ *		size	Number of bytes in the code section.
+ * Returns:	A pointer to the entry in the table of special symbols
+ *		corresponding to pc if it could be found, NULL if not.
+ */
+static const struct kern_special_sym *special_symbol(reg_t pc, reg_t 
*start,
+	reg_t *size)
+{
+	const struct kern_special_sym	*result;
+	unsigned long		symbolsize;
+	unsigned long		offset;
+
+	/* We could look up each symbol and then see whether it contained the
+	 * pc, but a faster way is to look up the symbol corresponding to the
+	 * pc, then just quickly go through the table looking for it. This
+	 * could be even faster if the table were sorted by address because
+	 * we would be able to do a binary search of the table, but this is
+	 * simpler and only rarely done. */
+
+	/* Find the symbol corresponding to the pc */
+	if (!kallsyms_lookup_size_offset((unsigned long) pc, &symbolsize,
+		&offset))
+		result = NULL;
+
+	else {
+		size_t		i;
+		opcode_t	*symbol_start;
+
+		/* Search for the address within our table of special symbols.
+		 * We do a simple linear search, now, but if the table were
+		 * sorted we could use a faster binary search. Ah, someday when
+		 * we have time... */
+		symbol_start = (opcode_t *) (pc - offset);
+
+		for (i = 0;
+			i < kernel_backtrace_symbols_size &&
+				symbol_start !=
+					kernel_backtrace_symbols [i].start;
+			i ++)
+			;
+
+		if (i == kernel_backtrace_symbols_size)
+			result = NULL;
+
+		else {
+			result = &kernel_backtrace_symbols [i];
+			*start = (reg_t) symbol_start;
+			*size = symbolsize;
+		}
+	}
+
+	return result;
+}
+
+/*
+ * Loads the next register values for code that uses the $k0 and $k1
+ * registers only. In this case, the $pc value is in the CP0 EPC register
+ * and all other registers still have their original values.
+ * Params:	bt	Pointer to the current struct kernel_bt object.
+ * Returns:	KERNEL_BACKTRACE_DONE	The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+static int pop_k0_k1_only_frame(struct kernel_bt *bt)
+{
+	int	result = 0;		/* Assume success */
+
+	bt->tbt.sbt.pc = bt->cp0_epc;
+	result = pop_exception(bt);
+
+	return result;
+}
+
+/*
+ * Loads the next register values for code that uses the SAVE_SOME macro.
+ * Params:	bt	Pointer to the current struct kernel_bt object.
+ * Returns:	KERNEL_BACKTRACE_DONE	The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+static int pop_save_some_frame(struct kernel_bt *bt)
+{
+	return pop_save_some_or_all_frame(bt);
+}
+
+/*
+ * Loads the next register values for code that uses the SAVE_ALL 
macro. The
+ * SAVE_ALL macro starts by using the SAVE_SOME macro, then saves 
additional
+ * registers. We could simply have used pop_save_some_or_all_frame 
directly,
+ * but this extra, tiny, function allows a more directly mapping from what
+ * appears in the kernel code to the way we break things down here.
+ * Params:	bt	Pointer to the current struct kernel_bt object.
+ * Returns:	KERNEL_BACKTRACE_DONE	The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+static int pop_save_all_frame(struct kernel_bt *bt)
+{
+	return pop_save_some_or_all_frame(bt);
+}
+
+/*
+ * This handles a code section that starts with use of a SAVE_SOME 
macro and
+ * which *may* then save additional registers using macros like 
SAVE_STATIC,
+ * etc.
+ * Params:	bt	Pointer to the current struct kernel_bt object.
+ * Returns:	KERNEL_BACKTRACE_DONE	The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+static int pop_save_some_or_all_frame(struct kernel_bt *bt)
+{
+	int		result = 0;	/* Assume success */
+	enum		{OLD_SP_IN_SP, OLD_SP_IN_K0, OLD_SP_ON_STACK} sp_loc;
+	reg_t		ip;
+	opcode_t	op;
+
+	/* First, loop until the old stack pointer gets stored on the
+	 * stack. No other registers get stored in the struct pt_regs
+	 * object on the stack until after the stack pointer gets
+	 * stored. */
+
+	for (ip = bt->start, sp_loc = OLD_SP_IN_SP; ;
+		ip = ip_next(ip)) {
+		/* If we reach the current execution point or we have stored
+		 * the old SP on the stack, we are done. */
+		if (ip == bt->tbt.sbt.pc ||
+			sp_loc == OLD_SP_ON_STACK)
+			break;
+		result = get_op(ip, &op);
+		if (result != 0)
+			break;
+
+		if (is_move(op, REG_K0, REG_SP))
+			sp_loc = OLD_SP_IN_K0;
+
+		else if (sp_loc == OLD_SP_IN_K0 &&
+			is_sw(op, REG_K0, REG_SP))
+			sp_loc = OLD_SP_ON_STACK;
+	}
+
+	switch (sp_loc) {
+	case OLD_SP_IN_SP:		/* Nothing to do */
+		break;
+	case OLD_SP_IN_K0: bt->tbt.sbt.gprs [REG_SP] =
+			bt->tbt.sbt.gprs [REG_K0];
+		bt->tbt.sbt.gpr_saved [REG_SP] = 1;
+		break;
+	case OLD_SP_ON_STACK: result = update_saved_registers(bt, ip,
+			bt->tbt.sbt.gprs [REG_SP]);
+		break;
+	default: result = -EINVAL;	/* Internal failure: shouldn't happen */
+		bt_dbg(1, "Unexpected sp_loc value: %d\n", sp_loc);
+		break;
+	}
+
+	if (result == 0)
+		result = pop_exception(bt);
+
+	return result;
+}
+
+/*
+ * Loads the next register values for code that uses the SAVE_STATIC macro.
+ * Params:	bt	Pointer to the current struct kernel_bt object.
+ * Returns:	KERNEL_BACKTRACE_DONE	The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+static int pop_save_static_frame(struct kernel_bt *bt)
+{
+	int	result;
+	reg_t	pt_regs_ptr;
+
+	pt_regs_ptr = bt->tbt.sbt.gprs [REG_SP];
+
+	/* We must have already completed a SAVE_SOME macro in some previous
+	 * section of code, which has saved general purpose registers zero,
+	 * v0-v1, a0-a3, t9, gp, sp, and ra(r0, r2-r7, r25, r28, r29, r31),
+	 * and CP0 registers Cause, EPC, and Status. We can read these values
+	 * from their place on the stack. */
+	update_saved_register(bt, pt_regs_ptr, PT_R0);		/* zero */
+	update_saved_register(bt, pt_regs_ptr, PT_R2);		/* v0 */
+	update_saved_register(bt, pt_regs_ptr, PT_R3);		/* v1 */
+	update_saved_register(bt, pt_regs_ptr, PT_R4);		/* a0 */
+	update_saved_register(bt, pt_regs_ptr, PT_R5);		/* a1 */
+	update_saved_register(bt, pt_regs_ptr, PT_R6);		/* a2 */
+	update_saved_register(bt, pt_regs_ptr, PT_R7);		/* a3 */
+	update_saved_register(bt, pt_regs_ptr, PT_R25);		/* a4 */
+	update_saved_register(bt, pt_regs_ptr, PT_R28);		/* gp */
+	update_saved_register(bt, pt_regs_ptr, PT_R29);		/* sp */
+	update_saved_register(bt, pt_regs_ptr, PT_R31);		/* ra */
+	update_saved_register(bt, pt_regs_ptr, PT_EPC);		/* CP0 EPC */
+	update_saved_register(bt, pt_regs_ptr, PT_STATUS);	/* CP0 Status */
+	update_saved_register(bt, pt_regs_ptr, PT_CAUSE);	/* CP0 Cause */
+
+	/* Now read the registers which have been saved so far in this
+	 * section of code */
+	result = update_saved_registers(bt, bt->start, pt_regs_ptr);
+
+	if (result == 0)
+		result = pop_exception(bt);
+
+	return result;
+}
+
+/*
+ * At this point the SAVE_SOME or SAVE_STATIC macro has started to save
+ * register values into a struct pt_regs object. We run through the current
+ * code looking for stores relative to the $sp register and restore values
+ * from there.
+ * Params:	bt	Pointer to the struct kernel_bt object
+ *		ip	Pointer to the first instruction to examine to see if
+ *			it is a store.
+ *		ptr	Pointer to the struct pt_regs object in which values
+ *			are stored.
+ * Returns:	Zero on success, a negative errno value otherwise.
+ */
+static int update_saved_registers(struct kernel_bt *bt, reg_t ip,
+	reg_t ptr)
+{
+	int		result = 0;	/* Assume success */
+	opcode_t	op;
+
+
+	for (;
+		ip != bt->tbt.sbt.pc &&
+		(result = get_op(ip, &op)) == 0 &&
+			!is_basic_block_end(op);
+		ip = ip_next(ip)) {
+
+		/* If this is a save, we use the offset to determine which
+		 * register is being saved. Since all we want to do is to
+		 * restore the register value, the offset is all we need to
+		 * determine which register is to be restored. */
+		if (is_frame_save(op, REG_SP))
+			result = update_saved_register(bt, ptr,
+				frame_save_offset(op));
+	}
+
+	return result;
+}
+
+/*
+ * Gets a given general purpose register from the given memory location.
+ * Params:	bt	Pointer to the struct kernel_bt object in which
+ *			to store the value.
+ *		reg_num	The particular register to store.
+ *		ptr	Location of the value
+ * Returns:	Zero on success, a negative errno value otherwise.
+ */
+static inline int get_pt_gpr(struct kernel_bt *bt, enum reg_num reg_num,
+	reg_t ptr)
+{
+	return get_reg(ptr, &bt->tbt.sbt.gprs [reg_num]);
+}
+
+/*
+ * The current instruction is a save through the frame pointer. Retrieve
+ * the value that was saved. The offset tells us which register to 
retrieve,
+ * as well as being the offset in the struct pt_regs from which to 
retrieve it.
+ * Params:	bt	Pointer to the struct kernel_bt object
+ *		ptr	Pointer to the memory location where the struct
+ *			pt_regs object is stored.
+ *		offset	Offset from the pointer to the value for the
+ *			register we want to read
+ * Returns:	Zero on success, a negative errno value otherwise.
+ */
+static int update_saved_register(struct kernel_bt *bt, reg_t ptr,
+	reg_offset_t offset)
+{
+	int	result = 0;		/* Assume success */
+	reg_t	cp0_status;
+	reg_t	where;
+
+	where = ptr + offset;
+
+	/* The comment by each line indicates whether the register is saved
+	 * by the SAVE_SOME or SAVE_STATIC macro */
+	switch (offset) {
+	case PT_R0: result = get_pt_gpr(bt, REG_ZERO, where); /* SAVE_SOME*/
+		break;
+	case PT_R2: result = get_pt_gpr(bt, REG_V0, where);	/* SAVE_SOME*/
+		break;
+	case PT_R3: result = get_pt_gpr(bt, REG_V1, where);	/* SAVE_SOME*/
+		break;
+	case PT_R4: result = get_pt_gpr(bt, REG_A0, where);	/* SAVE_SOME*/
+		break;
+	case PT_R5: result = get_pt_gpr(bt, REG_A1, where);	/* SAVE_SOME*/
+		break;
+	case PT_R6: result = get_pt_gpr(bt, REG_A2, where);	/* SAVE_SOME*/
+		break;
+	case PT_R7: result = get_pt_gpr(bt, REG_A3, where);	/* SAVE_SOME*/
+		break;
+	case PT_R16: result = get_pt_gpr(bt, REG_S0, where);	/* SAVE_STATIC*/
+		break;
+	case PT_R17: result = get_pt_gpr(bt, REG_S1, where);	/* SAVE_STATIC*/
+		break;
+	case PT_R18: result = get_pt_gpr(bt, REG_S2, where);	/* SAVE_STATIC*/
+		break;
+	case PT_R19: result = get_pt_gpr(bt, REG_S3, where);	/* SAVE_STATIC*/
+		break;
+	case PT_R20: result = get_pt_gpr(bt, REG_S4, where);	/* SAVE_STATIC*/
+		break;
+	case PT_R21: result = get_pt_gpr(bt, REG_S5, where);	/* SAVE_STATIC*/
+		break;
+	case PT_R22: result = get_pt_gpr(bt, REG_S6, where);	/* SAVE_STATIC*/
+		break;
+	case PT_R23: result = get_pt_gpr(bt, REG_S7, where);	/* SAVE_STATIC*/
+		break;
+	case PT_R25: result = get_pt_gpr(bt, REG_T9, where);	/* SAVE_SOME */
+		break;
+	case PT_R28: result = get_pt_gpr(bt, REG_GP, where);	/* SAVE_SOME */
+		break;
+	case PT_R29: result = get_pt_gpr(bt, REG_SP, where);	/* SAVE_SOME */
+		break;
+	case PT_R30: result = get_pt_gpr(bt, REG_S8, where);	/* SAVE_STATIC*/
+		break;
+	case PT_R31: result = get_pt_gpr(bt, REG_RA, where);	/* SAVE_SOME */
+		break;
+	case PT_EPC: result = get_reg(where, &bt->cp0_epc);	/* SAVE_SOME */
+		break;
+	case PT_STATUS: result = get_reg(where, &cp0_status);	/* SAVE_SOME */
+		if (result == 0)
+			bt->cp0_status = cp0_status;
+		break;
+	}
+
+	return result;
+}
+/*
+ * Loads the next register values for glue code that is used after 
SAVE_SOME
+ * and SAVE_STATIC have been called and before RESTORE_SOME is called. This
+ * means that the values for the previous frame are all in a struct pt_regs
+ * object pointed to by $sp.
+ * Params:	bt	Pointer to the current struct kernel_bt object.
+ * Returns:	KERNEL_BACKTRACE_DONE	The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+static int pop_glue_frame(struct kernel_bt *bt)
+{
+	int		result;
+
+	result = read_pt_regs(bt);
+
+	if (result == 0)
+		result = pop_exception(bt);
+
+	return result;
+}
+
+/*
+ * Loads the next register values for code that uses the RESTORE_SOME 
macro.
+ * Until we reach the eret instruction, the $sp register points to a struct
+ * pt_regs object from which the values can be fetched. When we get to the
+ * eret, all registers except $pc have been loaded and we get the next $pc
+ * value from the CP0_EPC register.
+ * Params:	bt	Pointer to the current struct kernel_bt object.
+ * Returns:	KERNEL_BACKTRACE_DONE	The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+static int pop_restore_some_frame(struct kernel_bt *bt)
+{
+	int		result;
+	opcode_t	op;
+
+	/* Check to see whether we got to the eret instruction. If
+	 * not, use the stack pointer to get to the save values.
+	 * Otherwise, use the ones we have. */
+	result = get_op(bt->start, &op);
+
+	if (result == 0) {
+		if (!is_eret(op))
+			result = read_pt_regs(bt);
+	}
+
+	if (result == 0)
+		result = pop_exception(bt);
+
+	return result;
+}
+
+/* This is called when all of the registers, except for the $pc register,
+ * have been restored to their state prior to the exception. The 
pre-exception
+ * value of the $pc register is stored in the CP0 EPC register. This 
function
+ * checks the CP0 Status register's CU0 bit to find out whether we were
+ * executing kernel or user mode code before the exception. CU0 is set 
if we
+ * were previously executing in user mode, clear if in user mode. If we 
were
+ * executing user code, we are done. Otherwise, we need to restore the $pc
+ * value from the CP0 EPC register, and keep backtracing.
+ * Params:	bt	Pointer to struct kernel_bt object
+ * Return:	KERNEL_BACKTRACE_DONE if we would have returned to user mode,
+ *		otherwise zero.
+ */
+static int pop_exception(struct kernel_bt *bt)
+{
+	int	result;
+
+	if ((bt->cp0_status & ST0_CU0) == 0)
+		result = KERNEL_BACKTRACE_DONE;
+
+	else {
+		/* The next address executed would be that stored in
+		 * the CP0 EPC register. All other registers are
+		 * restored */
+		bt->tbt.sbt.pc = bt->cp0_epc;
+		result = 0;
+	}
+
+	return result;
+}
+
+/*
+ * Read new values of the register from the struct pt_regs object to 
which the
+ * current stack pointer points.
+ * Params:	bt	Points to the struct kernel_bt object to update.
+ * Returns:	Zero on success, a negative errno value otherwise.
+ */
+static int read_pt_regs(struct kernel_bt *bt)
+{
+	int		result;
+	reg_t		pt_regs;
+	enum reg_num	i;
+	reg_t		cp0_status;
+
+	pt_regs = bt->tbt.sbt.gprs [REG_SP];
+
+	result = get_reg(pt_regs + offsetof(struct pt_regs, cp0_status),
+			&cp0_status);
+	if (result == 0) {
+		bt->cp0_status = cp0_status;
+		result = get_reg(pt_regs + offsetof(struct pt_regs, cp0_epc),
+				&bt->cp0_epc);
+	}
+
+	for (i = REG_AT; result == 0 && i < REG_ALL; i ++) {
+		result = get_reg(pt_regs + offsetof(struct pt_regs,
+			regs [i]), &bt->tbt.sbt.gprs [i]);
+		if (result == 0)
+			bt->tbt.sbt.gpr_saved [i] = 1;
+	}
+
+	return result;
+}
+
+/*
+ * Functions that are required by the simple-backtrace.c code but which 
must
+ * be supplied by users of that code.
+ * ip_lookup - Look up the symbol start and size, given an address
+ * get_op - Get an opcode-sized element.
+ * get-reg - Get a register-sized element.
+ */
+
+/*
+ * Use kallsyms_lookup to find the symbol corresponding to a given address.
+ * All we care about for backtracing is where the section of code starts
+ * and the number of bytes in it.
+ * Params:	ip	Address for which to find the symbol
+ *		start	Pointer to location in which to store the starting
+ *			address for the symbol.
+ *		size	Pointer to location in which to store the size of the
+ *			symbol.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+static int symbol_lookup(reg_t ip, reg_t *start, reg_t *size)
+{
+	int		result;
+	const char	*symname;
+	unsigned long	symbolsize;
+	unsigned long	offset;
+	char		*modname;
+	char		namebuf [KSYM_NAME_LEN + 1];
+
+	symname = kallsyms_lookup((unsigned long) ip, &symbolsize,
+		&offset, &modname, namebuf);
+
+	/* Perhaps, if we couldn't find the symbol, it is a two-instruction
+	 * signal trampoline. It won't hurt to pretend because everything
+	 * validates that the address from which it fetches instructions. */
+	if (symname == NULL) {
+		result = 0;
+		*start = ip;
+		*size = 2 * OPCODE_SIZE;
+	}
+
+	else {
+		result = 0;
+		*start = ip - offset;
+		*size = symbolsize;
+	}
+
+	return result;
+}
+
+/*
+ * Read an opcode-sized piece of data.
+ * Params:	ip	Address from which to read the opcode
+ *		op	Location in which to store the opcode once it has
+ *			been read.
+ * Returns:	Zero on success, a negative errno value otherwise.
+ */
+static int get_op(reg_t ip, opcode_t *op)
+{
+	int		result;
+
+	result = __get_user(*op, (opcode_t *) ip);
+
+	return result;
+}
+
+/*
+ * Read an general purpose register-sized piece of data.
+ * Params:	rp	Address from which to read the data
+ *		reg	Location in which to store the value once it has
+ *			been read.
+ * Returns:	Zero on success, a negative errno value otherwise.
+ */
+static int get_reg(reg_t rp, reg_t *reg)
+{
+	int		result;
+
+	result = __get_user(*reg, (reg_t *) rp);
+
+	return result;
+}
+
+/*
+ * Read an piece of data as big as is used in the struct sigcontext 
registers.
+ * Params:	rp	Address from which to read the data
+ *		reg	Location in which to store the value once it has
+ *			been read.
+ * Returns:	Zero on success, a negative errno value otherwise.
+ */
+static int get_sc_reg(reg_t rp, reg_t *reg)
+{
+	int			result;
+	unsigned long long	sc_reg;
+
+	result = __get_user(sc_reg, (unsigned long long *) rp);
+
+	if (result == 0)
+		*reg = sc_reg;
+
+	return result;
+}
diff -urN 
linux-2.6.25.1/arch/mips/kernel/backtrace/kernel-backtrace-symbols.c 
linux-t/arch/mips/kernel/backtrace/kernel-backtrace-symbols.c
--- 
linux-2.6.25.1/arch/mips/kernel/backtrace/kernel-backtrace-symbols.c 
1969-12-31 16:00:00.000000000 -0800
+++ linux-t/arch/mips/kernel/backtrace/kernel-backtrace-symbols.c 
2008-05-06 17:30:09.000000000 -0700
@@ -0,0 +1,44 @@
+/*
+ *			kernel-backtrace-symbols.c
+ *
+ * Array with backtrace symbols for the kernel;
+ *
+ * Copyright (C) 2007  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 
02110-1301  USA
+ *
+ * Author: David VomLehn
+ */
+
+#ifndef	numberof
+#define	numberof(a)	(sizeof (a) / sizeof ((a) [0]))
+#endif
+
+/* Generate external references for the symbols that correspond to pieces
+ * of code that should be handled specially in order to do a proper kernel
+ * backtrace. */
+#define	SPECIAL_SYMBOL(name, type) extern opcode_t	name [];
+#include <asm/kernel-backtrace-symbols.h>
+#undef SPECIAL_SYMBOL
+
+/* Now generate the table for the symbols that we handle specially */
+#define	SPECIAL_SYMBOL(name, type) 	{name, type},
+
+const struct kern_special_sym kernel_backtrace_symbols [] = {
+#include <asm/kernel-backtrace-symbols.h>
+};
+#undef SPECIAL_SYMBOL
+
+unsigned kernel_backtrace_symbols_size = 
numberof(kernel_backtrace_symbols);
diff -urN linux-2.6.25.1/arch/mips/kernel/backtrace/Makefile 
linux-t/arch/mips/kernel/backtrace/Makefile
--- linux-2.6.25.1/arch/mips/kernel/backtrace/Makefile	1969-12-31 
16:00:00.000000000 -0800
+++ linux-t/arch/mips/kernel/backtrace/Makefile	2008-05-06 
17:30:09.000000000 -0700
@@ -0,0 +1,4 @@
+# Makefile for Linux/MIPS advanced backtrace code
+
+obj-y	+= kernel-backtrace.o kernel-backtrace-symbols.o \
+	   simple-backtrace.o thread-backtrace.o
diff -urN linux-2.6.25.1/arch/mips/kernel/backtrace/simple-backtrace.c 
linux-t/arch/mips/kernel/backtrace/simple-backtrace.c
--- linux-2.6.25.1/arch/mips/kernel/backtrace/simple-backtrace.c 
1969-12-31 16:00:00.000000000 -0800
+++ linux-t/arch/mips/kernel/backtrace/simple-backtrace.c	2008-05-06 
17:30:09.000000000 -0700
@@ -0,0 +1,1236 @@
+/*
+ *				simple-backtrace.c
+ *
+ * Implement an analysis and backtrace of stackframes. It only supports
+ * processing a single frame as multiple frame backtracing requires 
operating
+ * system-depending things like signal frames and/or exception handling.
+ * It knows how to handle "o32" ABI-conformant backtraces and backtraces
+ * where a function start and size may be determined.
+ *
+ * Though this has been designed with some thought towards working in a 
64-bit
+ * environment, only the 32-bit implementation is complete.
+ *
+ * Since this completely implements the ABI rules for processing a stack
+ * backtrace, without any OS dependencies, keeping this file a separate 
entity
+ * will allow reuse in other situations.
+ *
+ * Copyright(C) 2007  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 
02110-1301  USA
+ *
+ * Author: David VomLehn
+ */
+
+#include <asm/simple-backtrace.h>
+
+#ifndef	numberof
+#define	numberof(a)	(sizeof(a) / sizeof((a) [0]))
+#endif
+
+/* Pointers to functions to analyze the current function. This depends on
+ * the value of the struct simple_btype_t passed to the stack frame
+ * analysis functions */
+struct bt_ops {
+	int(*start_frame) (struct simple_bt *bt, reg_t ip);
+	int(*find_return) (struct simple_bt *bt);
+};
+
+static int read_reg_if_saved(struct simple_bt *bt, opcode_t op, reg_t fp);
+static int read_saved_reg(struct simple_bt *bt, opcode_t op, reg_t fp);
+static int read_saved_registers(struct simple_bt *bt, reg_t fp);
+static int start_frame(struct simple_bt *bt);
+static int find_sf_allocation(struct simple_bt *bt);
+static int analyze_procedure_prelude(struct simple_bt *bt);
+static void analyze_procedure_prelude_op(struct simple_bt *bt, opcode_t 
op);
+static int analyze_return_block(struct simple_bt *bt);
+static void analyze_return_block_op(struct simple_bt *bt, reg_t ip,
+	opcode_t op);
+static void complete_analysis(struct simple_bt *bt);
+
+static int start_frame_abi(struct simple_bt *bt, reg_t ip);
+static int back_up_from_sp_decrement(struct simple_bt *bt, reg_t ip);
+static int find_return_abi(struct simple_bt *bt);
+
+static int start_frame_lookup(struct simple_bt *bt, reg_t ip);
+static int find_return_lookup(struct simple_bt *bt);
+static int find_return_lookup_bounded(struct simple_bt *bt, reg_t start,
+	reg_t end);
+
+/* Array, indexed by a struct simple_btype_t value, that holds the
+ * function analysis function pointers. */
+static struct bt_ops ops [] = {
+	{start_frame_abi, find_return_abi},
+	{start_frame_lookup, find_return_lookup},
+};
+
+#if	BACKTRACE_DEBUG
+static const char *backtrace_type [] = {
+	"o32 ABI", "lookup"
+};
+#endif
+
+/*
+ * Look for a return from the current function. The search starts with the
+ * current location so that, later on, we can determine whether we are
+ * executing in a basic block that ends with a return. If there isn't
+ * a return in the current function that follows the current location, the
+ * search should look for a return before the current location.
+ *
+ * If successful, bt->fn_return will be set to the address of the
+ * "jr ra" instruction used to do the return.
+ * Params:	bt	Pointer to a struct simple_bt object.
+ * Returns: Zero on success, otherwise a negative errno value.
+ */
+static inline int find_return(struct simple_bt *bt)
+{
+	return ops [bt->config->type].find_return(bt);
+}
+
+/*
+ * Get an opcode_t-sized object from memory.
+ * Params:	bt	Pointer to the struct simple_bt object
+ *		ip	Address of the opcode.
+ *		op	Location in which to store the opcode
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+static inline int get_op(struct simple_bt *bt, reg_t ip, opcode_t *op)
+{
+	return bt->config->get_op(ip, op);
+}
+
+/*
+ * Get a register-sized(reg_t-sized) object from memory.
+ * Params:	bt	Pointer to the struct simple_bt object
+ *		rp		Address of the value.
+ *		reg		Location in which to store the value.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+static inline int get_reg(struct simple_bt *bt, reg_t rp, reg_t *reg)
+{
+	return bt->config->get_reg(rp, reg);
+}
+
+/*
+ * Lookup a symbol's starting address and the size of the object, given an
+ * address within the symbol.
+ * Params:	bt	Pointer to the struct simple_bt object
+ *		addr		Address to look up
+ *		symbolstart	Starting address of the symbol
+ *		symbolsize	Number of bytes in the memory represented by
+ *				the symbol.
+ * Returns:	Zero on success, otherwise a negative errno value. If the 
symbol
+ *		couldn't be found, the value returned should be -ESRCH.
+ */
+static inline int symbol_lookup(struct simple_bt *bt, reg_t addr,
+	reg_t *symbolstart, reg_t *symbolsize)
+{
+	return bt->config->symbol_lookup(addr, symbolstart, symbolsize);
+}
+
+/*
+ * Functions that determine whether the opcode falls into a class of
+ * instructions.
+ */
+/* Is this a move to a register from the stack pointer? This could be
+ * initializing a frame pointer. */
+static inline int is_move_to_framepointer(opcode_t inst)
+{
+	struct r_format	*op_p = (struct r_format *) &inst;
+	return is_addu_noreg(inst) &&
+		op_p->rs == REG_SP && op_p->rt == REG_ZERO;
+}
+
+/* Is this a move from a register to the stack pointer? If so, it's a 
restore
+ * of the stack pointer from a frame pointer. */
+static inline int is_move_from_framepointer(opcode_t inst)
+{
+	struct r_format	*op_p = (struct r_format *) &inst;
+	return is_addu_noreg(inst) &&
+		op_p->rt == REG_ZERO && op_p->rd == REG_SP;
+}
+
+/* Is this a decrement of the stack pointer register? */
+static inline int is_sp_decrement(opcode_t op)
+{
+	struct i_format *op_p = (struct i_format *) &op;
+	return is_addiu(op, REG_SP, REG_SP) &&
+		op_p->simmediate < 0;
+}
+
+/* Is this an increment of the stack pointer register? */
+static inline int is_sp_increment(opcode_t op)
+{
+	struct i_format *op_p = (struct i_format *) &op;
+	return is_addiu(op, REG_SP, REG_SP) &&
+		op_p->simmediate > 0;
+}
+
+/* Is this a jump through the return register $ra? */
+static inline int is_return(opcode_t op)
+{
+	return is_jr(op, REG_RA);
+}
+
+/* Is this a branch or jump instruction? This would mark the end of a basic
+ * block. Note that no coprocessor branch instructions are decoded. */
+int is_basic_block_end(opcode_t op)
+{
+	int			result;
+	struct any_format	*op_p = (struct any_format *) &op;
+	struct r_format		*op_p_r;
+	struct i_format		*op_p_i;
+	struct eret_format	*op_p_eret;
+
+	switch (op_p->opcode) {
+	case j_op:
+	case beq_op:
+	case bne_op:
+	case blez_op:
+	case bgtz_op:
+	case beql_op:
+	case bnel_op:
+	case blezl_op:
+	case bgtzl_op:
+		result = 1;
+		break;
+
+	case spec_op:
+		op_p_r = (struct r_format *) &op;
+		result = (op_p_r->func == jr_op &&
+			op_p_r->rt == 0 && op_p_r->rd == 0);
+		break;
+
+	case bcond_op:
+		op_p_i = (struct i_format *) &op;
+		switch (op_p_i->rt) {
+		case bltz_op:
+		case bgez_op:
+		case bltzl_op:
+		case bgezl_op:
+			result = 1;
+			break;
+
+		default:
+			result = 0;
+			break;
+		}
+		break;
+
+	case cop0_op:
+		op_p_eret = (struct eret_format *) &op;
+		result = (op_p_eret->func == eret_op &&
+			op_p_eret->co == 1 && op_p_eret->zero == 0);
+		break;
+
+
+	default: result = 0;
+		break;
+	}
+
+	return result;
+}
+
+/*
+ * Given an instruction that ends a basic block, as determined by the
+ * is_basic_block_end function, indicates whether the instruction has a
+ * branch delay slot or not.
+ * Params:	op	Instruction that ended the basic block
+ * Returns:	Non-zero if the instruction has a branch delay slot and
+ *		zero if it does.
+ */
+int basic_block_end_uses_BDS(opcode_t op)
+{
+	return !is_eret(op);
+}
+
+/*
+ * Initialize the given struct simple_bt object for going down the
+ * stack frames.
+ * Params:	bt	Pointer to the struct simple_bt object to initialize
+ *		config	Pointer to the configuration to use for the backtrace
+ */
+void simple_backtrace_init(struct simple_bt *bt,
+	const struct simple_bt_config *config)
+{
+	simple_backtrace_clear_saved(bt);
+	bt->config = config;
+}
+EXPORT_SYMBOL(simple_backtrace_init);
+
+/*
+ * Clear the saved bits for all general purpose registers.
+ * Params:	bt	Pointer to the struct simple_bt object.
+ */
+void simple_backtrace_clear_saved(struct simple_bt *bt)
+{
+	enum reg_num	i;
+
+	for (i = 0; i < numberof(bt->gpr_saved); i ++)
+		bt->gpr_saved [i] = 0;
+}
+EXPORT_SYMBOL(simple_backtrace_clear_saved);
+
+/*
+ * Process the first stack frame. The register values must be set by this
+ * call.
+ * Params:	bt	Pointer to struct simple_bt object.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ *		A value of -ENOSYS indicates that the $pc and $sp are valid
+ *		but we can't continue the backtrace.
+ */
+int simple_backtrace_first(struct simple_bt *bt)
+{
+	int	result;
+
+	result = simple_backtrace_analyze_frame(bt);
+
+	return result;
+}
+EXPORT_SYMBOL(simple_backtrace_first);
+
+/*
+ * Process one stack frame. The given register values will be updated
+ * based on the processing of the stack frame.
+ * Params:	bt	Pointer to copies of the register values that
+ *			apply for this frame.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ *		A value of -ENOSYS indicates that the $pc and $sp are valid
+ *		but we can't continue the backtrace.
+ */
+
+int simple_backtrace_next(struct simple_bt *bt)
+{
+	int	result;
+
+	result = simple_backtrace_pop_frame(bt);
+
+	if (result == 0)
+		result = simple_backtrace_analyze_frame(bt);
+
+	return result;
+}
+EXPORT_SYMBOL(simple_backtrace_next);
+
+/*
+ * Gather information about the current stack frame.
+ * Params:	bt	Pointer to the struct simple_bt object.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+int simple_backtrace_analyze_frame(struct simple_bt *bt)
+{
+	int	result = 0;	/* Assume good backtrace */
+
+	bt_dbg(1, "type \"%s\" $pc 0x%lx $sp 0x%lx\n",
+		backtrace_type [bt->config->type], bt->pc,
+		bt->gprs [REG_SP]);
+	/* Initialize for the analysis of the current stack frame */
+	start_frame(bt);
+	simple_backtrace_clear_saved(bt);
+	bt->framepointer = REG_SP; /* Default frame pointer is $sp */
+
+	/* Find the place where we allocate the stack fame, if any */
+	result = find_sf_allocation(bt);
+
+	/* If we have not allocated a stack frame, the current stack pointer
+	 * is for the caller's stack frame and the return address is still
+	 * in $ra. In that case, we are done with the analysis. Otherwise,
+	 * let's see whether we are using a stack frame pointer */
+	if (result == 0 && bt->frame_size != 0) {
+		result = find_return(bt);
+
+		switch (result) {
+		case 0: result = analyze_return_block(bt);
+			if (result == 0) {
+				result = analyze_procedure_prelude(bt);
+				if (result == 0)
+					complete_analysis(bt);
+			}
+			break;
+
+		case -ENOSYS: bt_dbg(1,
+				"No return found, applying heuristic\n");
+			bt->possible_framepointer = REG_S8;
+			result = analyze_procedure_prelude(bt);
+			break;
+
+		default:			/* Leave the result unchanged */
+			break;
+		}
+	}
+
+	return result;
+}
+EXPORT_SYMBOL(simple_backtrace_analyze_frame);
+
+/*
+ * Locates the first instruction in the current function. We start by
+ * finding the function containing the instruction to which $pc points. 
Recall
+ * that $pc is actually the return address from a call. It will normally
+ * point to the same function that contains the call, except in the case
+ * where the call is the last thing in the current function. In that 
special
+ * case, $pc will actually point to the first instruction in the function
+ * after the current function. This arises when the last thing the current
+ * function did was to call a function defined with __attribute__ 
((noreturn)).
+ *
+ * To detect this special case, note that there are two ways that we can
+ * be doing a stack backtrace with $pc pointing to the first instruction of
+ * a function:
+ * 1.	We got a signal, exception, or interrupt just before executing the
+ *	first instruction of a function.
+ * 2.	We called a function, with a jal or jalr instruction, that, with the
+ *	instruction in its branch delay slot, immediately preceeds the
+ *	function.
+ * In the first case, we called the function from somewhere else and the
+ * value in the the ra register will be something other than the value of
+ * the $pc register. In the second case, however, the ra and $pc register
+ * values will be the same. In that case, the current function is the
+ * function in which the jal or jalr instruction is located, which is two
+ * instructions before the current value of the $pc register.
+ * Params:	bt	Points to the struct simple_bt object. The start
+ *			field will be set to the result.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+static int start_frame(struct simple_bt *bt)
+{
+	int	result;
+
+	result = ops [bt->config->type].start_frame(bt, bt->pc);
+
+	if (result == 0) {
+		bt_dbg(2, "Comparing $pc 0x%lx with function start 0x%lx and "
+			"ra 0x%lx\n", bt->pc, bt->func_start,
+			bt->gprs [REG_RA]);
+		if (bt->pc == bt->func_start &&
+			bt->pc == bt->gprs [REG_RA]) {
+			bt_dbg(2, "Detected call in previous function with "
+				"pc 0x%lx\n", bt->pc);
+			result = ops [bt->config->type].start_frame(bt,
+				ip_add(bt->pc, -2 * OPCODE_SIZE));
+		}
+	}
+
+	bt_dbg(1, "Function start detected at 0x%lx\n", bt->func_start);
+
+	return result;
+}
+
+/*
+ * Sets the state to indicate that no stack frame has been allocated.
+ * Params:	bt	Points to the struct simple_bt object to set
+ */
+static inline void set_no_sf_allocation(struct simple_bt *bt)
+{
+	bt->sf_allocation = NULL_REG;
+	bt->frame_size = 0;
+}
+
+/*
+ * Sets the state that records where the stack frame is allocated and
+ * the frame size.
+ * Params:	bt	Points to the struct simple_bt object to set
+ *		ip	Location where the stack frame is allocated
+ *		op	Opcode used to allocate the stack frame, from which
+ *			the size will be taken.
+ */
+static inline void set_sf_allocation(struct simple_bt *bt, reg_t ip,
+	opcode_t op)
+{
+	struct i_format *op_p;
+
+	bt->sf_allocation = ip;
+	op_p = (struct i_format *) &op;
+	bt->frame_size = -op_p->simmediate;
+	bt_dbg(2, "Found frame allocation for %d bytes at 0x%lx\n",
+		bt->frame_size, ip);
+}
+
+
+/*
+ * Finds the location where the stack frame is allocated. If one was found,
+ * the location is stored in sf_allocation, otherwise sf_allocation is set
+ * to NULL_REG.
+ * Params:	bt	Points to the struct simple_bt object. The start
+ *			field will be set to the result.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+static int find_sf_allocation(struct simple_bt *bt)
+{
+	int		result = 0;
+	reg_t		ip;
+	opcode_t	op;
+
+	/* Scan forwards from the start of the function until one of the
+	 * following:
+	 * 1.	We reach the current execution location, in which case
+	 *	no stack frame has been allocated,
+	 * 2.	We fail to read an opcode, which is an error,
+	 * 3.	We see a stack frame decrement instruction, which is how
+	 *	the stack frame is allocated, or
+	 * 4.	We reach an instruction marking the end of a basic block,
+	 *	in which the function does not allocate a stack frame at all.
+	 */
+	for (ip = bt->func_start; ; ip = ip_next(ip)) {
+		if (ip == bt->pc)
+			break;
+
+		result = get_op(bt, ip, &op);
+
+		if (result != 0 ||
+			is_sp_decrement(op) ||
+			is_basic_block_end(op))
+			break;
+
+		bt_dbg(3, "Looked at 0x%lx, opcode 0x%x\n", ip, op);
+	}
+
+	if (ip == bt->pc)
+		set_no_sf_allocation(bt);
+
+	else if (result == 0) {
+		if (is_sp_decrement(op))
+			set_sf_allocation(bt, ip, op);
+
+		else {
+			/* We exited the loop because we found the end of
+			 * the basic block. If the instruction that marked
+			 * the end of the basic block uses a branch delay
+			 * slot, we need to examine that instruction to see
+			 * if it allocated a stack frame. */
+
+			ip = ip_next(ip);	/* Adv. to branch delay slot */
+			result = get_op(bt, ip, &op);
+
+			if (result == 0) {
+				if (is_sp_decrement(op))
+					set_sf_allocation(bt, ip, op);
+
+				else
+					set_no_sf_allocation(bt);
+			}
+		}
+	}
+
+	return result;
+}
+
+/*
+ * This function analyzes a basic block ending with the function return
+ * at fn_return. We do a backwards scan, starting with the "jr ra" 
instruction
+ * until we reach the end of the previous basic block, or the stack frame
+ * allocation, whichever comes first.
+ * Params:	bt	Pointer to the struct simple_bt object.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+static int analyze_return_block(struct simple_bt *bt)
+{
+	int		result;
+	reg_t		ip;
+	opcode_t	op;
+
+	bt->possible_framepointer = REG_SP;
+	bt->fp_restore = NULL_REG;
+	bt->sf_deallocation = NULL_REG;
+
+	/* Doing this analysis is a bit complicated because of branch delay
+	 * slots. The first complication is that the first instruction in
+	 * our backwards scan is the one after the "jr ra" instruction. The
+	 * next complication is that the $pc value associated with instruction
+	 * in the branch delay slot is actually that of the "jr ra"
+	 * instruction. Either they are both executed or neither are
+	 * executed. */
+	ip = bt->fn_return;
+	result = get_op(bt, ip_next(ip), &op);
+
+	if (result == 0) {
+		opcode_t	prev_op;
+		reg_t		prev_ip;
+
+		analyze_return_block_op(bt, ip, op);
+
+		/* The next complication in the backwards scan is that we
+		 * don't want to evaluate the instruction after the one that
+		 * marks the end of the previous block if it is in a branch
+		 * delay slot. So, we start by getting an opcode, which we
+		 * refer to as the current op code. Then, until:
+		 * 1.	We have reached the instruction where the stack
+		 *	frame was allocated,
+		 * 2.	We failed to read the next opcode, and
+		 * 3.	The opcode we got marks the end of a basic block,
+		 * we analyze the current opcode. After analyzing the current
+		 * opcode, the next opcode becomes the current opcode and
+		 * we loop again. */
+		result = get_op(bt, bt->fn_return, &op);
+
+		if (result == 0) {
+			for (prev_ip = ip_prev(ip); ; prev_ip = ip_prev(ip)) {
+				if (prev_ip == bt->sf_allocation)
+					break;
+
+				result = get_op(bt, prev_ip, &prev_op);
+
+				if (result != 0 ||
+					is_basic_block_end(prev_op))
+					break;
+
+				analyze_return_block_op(bt, ip, op);
+				ip = prev_ip;
+				op = prev_op;
+			}
+
+			/* If we stopped because prev_op was the instruction
+			 * that marked the end of the previous block, and that
+			 * instruction does not have a branch delay slot, we
+			 * still have to analyze the current instruction */
+			if (prev_ip == bt->sf_allocation ||
+				(result == 0 && is_basic_block_end(prev_op) &&
+					!basic_block_end_uses_BDS(prev_op)))
+				analyze_return_block_op(bt, ip, op);
+		}
+	}
+
+	if (result == 0 && bt->sf_deallocation == NULL_REG) {
+		bt_dbg(1, "Stack frame not deallocated\n");
+		result = -ENOSYS;
+	}
+
+	return result;
+}
+
+/*
+ * This looks at the given opcode, which comes from the given address, 
to see
+ * if it is a move to the stack pointer or a stack pointer increment. 
If so,
+ * it records that information.
+ *
+ * We assume that the basic block that includes the function return 
instruction
+ * can have only one move to the $sp register, but don't check for that
+ * fact. We also don't check that the frame pointer restore preceeds the
+ * stack frame deallocation.
+ *
+ * This may set the following struct simple_bt fields:
+ *	possible_framepointer	Register number used in "move sp, rx"
+ *				instruction.
+ *	fp_restore		Address of the "move sp, rx" instruction
+ *	sf_deallocation		Address of "addiu sp, sp, framesize" instruction
+ *
+ * Params:	bt	Pointer to the struct simple_bt object.
+ *		ip	Address of the instruction being analyzed
+ *		op	Instruction to analyze
+ */
+static void analyze_return_block_op(struct simple_bt *bt, reg_t ip,
+	opcode_t op)
+{
+	bt_dbg(3, "analyze opcode 0x%08x at 0x%lx\n", op, ip);
+
+	if (is_move_from_framepointer(op)) {
+		struct r_format	*op_p = (struct r_format *) &op;
+		bt->possible_framepointer = op_p->rs;
+		bt->fp_restore = ip;
+		bt_dbg(3, "possible frame pointer $r%d at 0x%lx\n",
+			bt->possible_framepointer, ip);
+	}
+
+	else if (is_sp_increment(op)) {
+		bt->sf_deallocation = ip;
+		bt_dbg(2, "frame deallocation at 0x%lx\n", ip);
+	}
+}
+
+/*
+ * This function analyzes the procedure prelude, which is the first basic
+ * in the function, to see if a frame pointer has been established. It 
stops
+ * when it sees a frame pointer established, it reaches the end of the 
basic
+ * block, or when when it reaches $pc. This function assumes that the
+ * framepointer element of the struct simple_bt has already been set to
+ * REG_SP.
+ * Params:	bt	Pointer to the struct simple_bt object.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+static int analyze_procedure_prelude(struct simple_bt *bt)
+{
+	int		result = 0;	/* Assume good result */
+	reg_t		ip;
+	opcode_t	op;
+
+	/* Starting at the instruction after the allocation of the stack
+	 * frame, look at each opcode to see if a frame pointer has been
+	 * established. Continue looking until:
+	 * 1.	We have reached the instruction about to be executed,
+	 * 2.	We have established a frame pointer,
+	 * 3.	We aren't able to read the next opcode, and
+	 * 4.	The opcode we read marks the end of a basic block. */
+	for (ip = ip_next(bt->sf_allocation); ; ip = ip_next(ip)) {
+		if (ip == bt->pc ||
+			bt->framepointer != REG_SP)
+			break;
+		result = get_op(bt, ip, &op);
+		if (result != 0 ||
+			is_basic_block_end(op))
+			break;
+		bt_dbg(3, "analyze opcode 0x%08x at 0x%lx\n", op, ip);
+		analyze_procedure_prelude_op(bt, op);
+	}
+
+	/* If we did not reach the current executation address, have not
+	 * yet found a frame pointer established, are at the end of the
+	 * basic block and the instruction that ended the basic block has
+	 * a branch delay slot, then we need to look at the instruction in
+	 * the branch delay slot to see whether it establishes a frame
+	 * pointer. */
+	if (ip != bt->pc && bt->framepointer == REG_SP &&
+		is_basic_block_end(op) && basic_block_end_uses_BDS(op)) {
+		ip = ip_next(ip);
+		result = get_op(bt, ip, &op);
+
+		if (result == 0) {
+			bt_dbg(3, "analyze opcode 0x%08x at 0x%lx\n", op, ip);
+			analyze_procedure_prelude_op(bt, op);
+		}
+	}
+
+
+	return result;
+}
+
+/*
+ * This looks at the given opcode, which comes from the given address, 
to see
+ * if it is a move from the stack pointer to another register. If this 
matches
+ * a move from the same register to the stack pointer in the return block,
+ * this must be initialization of a frame pointer.
+ *
+ * This might set the following struct simple_bt fields:
+ *	framepointer	Register being used as a frame pointer.
+ *
+ * Params:	bt	Pointer to struct simple_bt object
+ *		op	Instruction to examine.
+ */
+static void analyze_procedure_prelude_op(struct simple_bt *bt, opcode_t op)
+{
+	if (is_move_to_framepointer(op)) {
+		enum reg_num	rd;
+		struct r_format	*op_p = (struct r_format *) &op;
+		rd = op_p->rd;
+		bt_dbg(3, "Checking $r%d to see if is a frame pointer\n", rd);
+		if (rd == bt->possible_framepointer) {
+			bt_dbg(2, "Confirmed frame pointer $r%d\n", rd);
+			bt->framepointer = rd;
+		}
+	}
+}
+
+/*
+ * This finishes the analysis of this stack frame, based on the analysis
+ * that has already been done. It assumes that:
+ * o	The stack frame size is correct, if one has been allocated, or zero
+ *	if one has not been allocated.
+ * o	A basic block ending with a function return instruction, "jr ra", has
+ *	been found, the stack frame deallocation has been located, and, if
+ *	a stack frame pointer is in use, the location where it is transferred
+ *	to $sp has been found.
+ * Params:	bt	Pointer to the struct simple_bt object used to keep
+ *			track of the analysis.
+ */
+static void complete_analysis(struct simple_bt *bt)
+{
+	if (bt->frame_size != 0) {
+		/* If a stack frame pointer has been allocated, have we
+		 * executed the instruction where it is moved back to $sp
+		 * on the way to executing a return? */
+		if (bt->framepointer != REG_SP &&
+			bt->pc > bt->fp_restore &&
+			bt->pc <= bt->fn_return) {
+			bt_dbg(2, "After stack frame restored to $sp\n");
+			bt->framepointer = REG_SP;
+		}
+
+		/* If we have passed the point where the stack frame is
+		 * deallocated on our way to a return from the function,
+		 * the frame size is now effectively zero. */
+		if (bt->pc > bt->sf_deallocation &&
+			bt->pc <= bt->fn_return) {
+			bt_dbg(2, "After stack frame deallocated\n");
+			bt->frame_size = 0;
+		}
+	}
+}
+
+/*
+ * Updates the $pc and $sp registers, given the current values of the
+ * $ra register and the size of the stack frame.
+ * Params:	bt	Pointer to the struct simple_bt object.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+int simple_backtrace_pop_frame(struct simple_bt *bt)
+{
+	int	result = 0;	/* Assume success */
+	reg_t	new_sp;
+	reg_t	fp;
+
+	bt_dbg(2, "Popping %d-byte frame\n", bt->frame_size);
+	/* Assuming we successfully retrieved the saved register
+	 * values, the new stack pointer value is the frame pointer
+	 * plus the size of the stack frame. */
+	bt_dbg(3, "framepointer in $r%d = 0x%lx\n", bt->framepointer,
+		bt->gprs [bt->framepointer]);
+	fp = bt->gprs [bt->framepointer];
+	new_sp = fp + bt->frame_size;
+
+	/* If we allocated a stack frame, read the saved registers */
+	if (bt->frame_size != 0)
+		result = read_saved_registers(bt, fp);
+
+	if (result == 0) {
+		bt->gprs [REG_SP] = new_sp;
+
+		/* Set the pc to the address of the next instruction to
+		 * execute. Note that this is two instructions beyond the
+		 * 'jalr' instruction used to call the function for this
+		 * frame. */
+		bt->pc = bt->gprs [REG_RA];
+	}
+
+	return result;
+}
+EXPORT_SYMBOL(simple_backtrace_pop_frame);
+
+/*
+ * Update all of the registers saved within the current basic block. We
+ * go from the starting location up to the last instruction executed.
+ * Params:	bt	Pointer to the object in which values will be held.
+ *		fp	Location of the stack frame
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+static int read_saved_registers(struct simple_bt *bt, reg_t fp)
+{
+	int		result = 0;	/* No errors so far */
+	opcode_t	op;
+	reg_t		ip;
+
+	/* Loop through the code, starting with the first instruction after
+	 * the stack frame allocation, and each time a register is saved
+	 * in the stack frame, read its value into the array with the
+	 * general purpose register values. We keep doing this until:
+	 * 1.	We have reached the instruction we are about to execute,
+	 * 2.	We can't read the next opcode, and
+	 * 3.	The opcode we read marks the end of a basic block. */
+	for (ip = ip_next(bt->sf_allocation); ; ip = ip_next(ip)) {
+		if (result != 0 ||
+			ip == bt->pc)
+			break;
+		result = get_op(bt, ip, &op);
+		if (result != 0 ||
+			is_basic_block_end(op))
+			break;
+		bt_dbg(3, "Check 0x%lx for register save\n", ip);
+		result = read_reg_if_saved(bt, op, fp);
+	}
+
+	/* If we reached the end of the basic block without error, and
+	 * the instruction that marked the end of the basic block uses
+	 * a branch delay slot, check the instruction in the branch delay
+	 * slot. */
+	if (result == 0 &&
+		ip != bt->pc &&
+		basic_block_end_uses_BDS(op)) {
+		ip = ip_next(ip);
+		result = get_op(bt, ip, &op);
+
+		if (result == 0) {
+			bt_dbg(3, "Check 0x%lx for register save\n", ip);
+			result = read_reg_if_saved(bt, op, fp);
+		}
+	}
+
+	return result;
+}
+
+/*
+ * Look at the given op code and, if it is a save of a register through
+ * the frame pointer, get the value. This is only done the first time
+ * the save occurs. Subsequent stores can't be a save of the value with
+ * which we were called.
+ * Params:	bt	Pointer to struct simple_bt object
+ *		op	Opcode to analyze.
+ *		fp	Value of frame pointer to use.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ *
+ */
+static int read_reg_if_saved(struct simple_bt *bt, opcode_t op, reg_t fp)
+{
+	int			result = 0;	/* No errors so far */
+
+	/* If the given instruction is a save through the
+	 * frame pointer, retrieve the value from the stack.
+	 *
+	 * Note: the o32 ABI says that the registers will be
+	 * saved through the frame pointer, but the reality is
+	 * that they are saved through the stack pointer.
+	 * Accomodate both. */
+
+	if (is_frame_save(op, bt->framepointer))
+		result = read_saved_reg(bt, op, fp);
+
+	else if (is_frame_save(op, REG_SP))
+		result = read_saved_reg(bt, op, fp);
+
+	return result;
+}
+
+/*
+ * If the register is a saved register, read the value from the stack 
frame.
+ * Params:	bt	Pointer to struct simple_bt object.
+ *		op	Opcode used to save the register through the given
+ *			frame pointer
+ *		fp	Value of frame pointer
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+static int read_saved_reg(struct simple_bt *bt, opcode_t op, reg_t fp)
+{
+	int			result = 0;		/* Assume success */
+	enum reg_num		rt;
+	reg_offset_t		offset;
+
+	rt = frame_save_rt(op);
+	offset = frame_save_offset(op);
+
+	/* Only worry about the first save. Subsequent saves in this
+	 * function would not be saves of the caller's values for this
+	 * register. */
+	switch (rt) {
+	case REG_S0:
+	case REG_S1:
+	case REG_S2:
+	case REG_S3:
+	case REG_S4:
+	case REG_S5:
+	case REG_S6:
+	case REG_S7:
+	case REG_GP:
+	case REG_S8:
+	case REG_RA: if (!bt->gpr_saved [rt]) {
+			reg_t	rp;
+			rp = fp + offset;
+			result = get_reg(bt, rp, &bt->gprs [rt]);
+			bt_dbg(3, "Read $r%d from 0x%lx+%d(0x%lx)=0x%lx\n",
+				rt, fp, offset, rp, bt->gprs [rt]);
+			bt->gpr_saved [rt] = 1;
+		}
+
+		else
+			bt_dbg(3, "$r%d already read\n", rt);
+	break;
+
+	default:		/* Ignore other registers */
+		break;
+	}
+
+	return result;
+}
+
+/*
+ * Find the beginning of the function in which the given address is found.
+ * Params:	bt	Points to the struct simple_bt object
+ *		addr	Address for which to locate the function start
+ * Returns:	Zero on success, otherwise:
+ *		-ESRCH	The given address is not in known code(inherited from
+ *			symbol_lookup)
+ */
+static int start_frame_abi(struct simple_bt *bt, reg_t addr)
+{
+	int		result;
+	reg_t		ip;
+	opcode_t	op;
+
+	/* Scan backwards until:
+	 * 1.	We can't read an instruction, which we take to indicate we
+	 *	went one instruction past the beginning of the function,
+	 * 2.	We found a "jr ra", which marks the end of the previous
+	 *	function, or
+	 * 3.	We found a decrement of the sp register, which is the stack
+	 *	frame allocation for this function.
+	 */
+	for (ip = ip_prev(addr); ; ip = ip_prev(ip)) {
+		result = get_op(bt, ip, &op);
+		if (result != 0 ||
+			is_return(op) ||
+			is_sp_decrement(op))
+			break;
+	}
+
+	switch (result) {
+	case -EFAULT: bt->func_start = ip_next(ip);
+		bt_dbg(2, "Found function start at 0x%lx by running out of "
+			"code\n", bt->func_start);
+		break;
+	case 0: if (is_return(op)) {
+			bt->func_start = ip_add(ip, 2 * OPCODE_SIZE);
+			bt_dbg(2, "Found function start at 0x%lx by "
+				"finding previous function end at 0x%lx\n",
+				bt->func_start, ip);
+		}
+
+		else
+			result = back_up_from_sp_decrement(bt, ip);
+		break;
+	default: 				/* Got some other error */
+		bt->func_start = NULL_REG;
+		break;
+	}
+
+	return result;
+}
+
+/*
+ * Matches the code fragment:
+ *	li	gp,<value>
+ *	addu	gp, gp, t9
+ * which is a short version of the code used to recover the GOT (global 
offset
+ * table) pointer from the address of the current function.
+ * Params:	op1	Possible match to: addu		gp, gp, t9
+ *		op2	Possible match to: li		gp,<value>
+ * Returns:	Non-zero if it matches, zero if it does not.
+ */
+static inline int match_short_get_got(opcode_t op1, opcode_t op2)
+{
+	return is_addu(op1, REG_GP, REG_GP, REG_T9) &&
+		is_li(op2, REG_GP);
+}
+
+/*
+ * Matches the code fragment:
+ *	lui	gp,%hi(<value>)
+ *	addiu	gp,gp,%lo(<value>)
+ *	addu	gp, gp, t9
+ * which is a long version of the code used to recover the GOT (global 
offset
+ * table) pointer from the address of the current function.
+ * Params:	op1	Possible match to: addu		gp, gp, t9
+ *		op2	Possible match to: addiu	gp,gp,%lo(<value>)
+ *		op3	Possible match to: lui		gp,%hi(<value>)
+ * Returns:	Non-zero if it matches, zero if it does not.
+ */
+static inline int match_long_get_got(opcode_t op1, opcode_t op2, 
opcode_t op3)
+{
+	return is_addu(op1, REG_GP, REG_GP, REG_T9) &&
+		is_addiu(op2, REG_GP, REG_GP) &&
+		is_lui(op2, REG_GP);
+}
+
+/*
+ * We are trying to find the beginning of a MIPS o32 ABI conformant 
function
+ * and found a stack pointer decrement at the given address. The means we
+ * must be in the first basic block of the current function. We want to
+ * keep backing up until we reach the beginning of the current function.
+ *
+ * The stack pointer decrement may be the first instruction of this
+ * function, but there is the possibility that we have code that
+ * is used to get the address of the GOT (global offset table) into
+ * the gp register. We look to see if we have such code and, if so,
+ * assume that the beginning of that code is the beginning of this
+ * function. This code will look like:
+ *	la	gp,<value>
+ *	addu	gp,gp,t9
+ * where la might expand into either:
+ *	lui	gp,%hi(<value>)
+ *	addiu	gp,gp,%lo(<value>)
+ * or, if <value> fits, as a signed value, in 16 bits:
+ *	li	gp,<value>	(implement as addiu gp,zero,<value>)
+ *
+ * Params:	bt	Pointer to struct simple_bt object.
+ *		sp_dec	Location of stack pointer decrement instruction
+ * Returns:	Zero if we found the start of the function and a negative
+ *		errno value if not.
+ */
+static int back_up_from_sp_decrement(struct simple_bt *bt, reg_t sp_dec)
+{
+	int		result = 0;
+	reg_t		ip;
+	unsigned	i;
+	opcode_t	op [3];
+
+	/* Start by trying to read the three previous instructions. */
+	for (i = 0, ip = ip_prev(sp_dec);
+		i < numberof(op);
+		i ++, ip = ip_prev(ip)) {
+		result = get_op(bt, ip, &op [i]);
+		if (result != 0)
+			break;
+	}
+
+	/* If we got an error other than -EFAULT, we have a problem we should
+	 * propagate. Otherwise, let's look at what we got. */
+	if (result == 0 || result == -EFAULT) {
+		switch (i) {
+		case 0:			/* Only read none or one instruction */
+		case 1: bt->func_start = sp_dec;
+			result = 0;
+			break;
+
+		case 2: if (match_short_get_got(op [0], op [1])) {
+				bt_dbg(3, "Matched short get GOT code\n");
+				bt->func_start = ip_add(sp_dec,
+					 -2 * OPCODE_SIZE);
+			} else
+				bt->func_start = sp_dec;
+
+			result = 0;
+			break;
+		case 3: if (match_short_get_got(op [0], op [1])) {
+				bt_dbg(3, "Matched short get GOT code\n");
+				bt->func_start = ip_add(sp_dec,
+					 -2 * OPCODE_SIZE);
+			} else if (match_long_get_got(op [0], op [1], op [2])) {
+				bt_dbg(3, "Matched long get GOT code\n");
+				bt->func_start = ip_add(sp_dec,
+					 -3 * OPCODE_SIZE);
+			} else
+				bt->func_start = sp_dec;
+
+			result = 0;
+			break;
+		default: result = -EINVAL;	/* Internal error */
+			break;
+		}
+	}
+
+	return result;
+}
+
+/*
+ * Find the end of the function by o32 ABI rules. If the function was 
not found,
+ * bt->fn_return must be set to NULL_REG.
+ * Params:	bt	Pointer to struct simple_bt object.
+ * Returns:	Zero if we found the end of the function, a negative errno 
value
+ *		if we could not.
+ */
+static int find_return_abi(struct simple_bt *bt)
+{
+	int		result;
+	reg_t		ip;
+	opcode_t	op;
+
+	/* Scan forward to find the "jr ra" that marks the end
+	 * of the current function */
+	for (ip = bt->pc; ; ip = ip_next(ip)) {
+		result = get_op(bt, ip, &op);
+		if (result != 0 || is_return(op))
+			break;
+	}
+
+	if (result == 0) {
+		bt_dbg(2, "Function return at 0x%lx\n", ip);
+		bt->fn_return = ip;
+	}
+
+	return result;
+}
+
+/*
+ * Find the beginning of the function in which the given address is found.
+ * Params:	bt	Points to the struct simple_bt object
+ *		addr	Address for which to locate the function start
+ * Returns:	Zero on success, otherwise:
+ *		-ESRCH	The given address is not in known code(inherited from
+ *			symbol_lookup)
+ */
+static int start_frame_lookup(struct simple_bt *bt, reg_t addr)
+{
+	int	result;
+
+	result = symbol_lookup(bt, addr, &bt->func_start,
+		&bt->data.lookup.func_size);
+
+	return result;
+}
+
+/*
+ * Find the return instruction starting at the current instruction, but if
+ * we don't find one by the end of the function, try again at the top.
+ * Params:	bt	Pointer to a struct simple_bt object
+ * Returns:	Zero if successful, otherwise a negative errno value.
+ */
+static int find_return_lookup(struct simple_bt *bt)
+{
+	int		result;
+	reg_t		end;
+
+	/* Start the search at the next instruction to be excuted and search to
+	 * the end */
+	end = bt->func_start + bt->data.lookup.func_size;
+	result = find_return_lookup_bounded(bt, bt->pc, end);
+
+	/* Start by scanning forward to find the "jr ra" that marks the end
+	 * of the current function. If we didn't get an error, but didn't
+	 * find the instruction, try again from the beginning. */
+
+	if (result == 0 && bt->fn_return == NULL_REG) {
+		/* We couldn't find a "jr ra" after the current
+		 * location, let's try for one before it. We know that
+		 * it can't be before the stack allocation and the
+		 * stack allocation isn't a return, so start right
+		 *  after that.*/
+		result = find_return_lookup_bounded(bt,
+			ip_next(bt->sf_allocation), bt->pc);
+
+		/* If we failed, return an error code */
+		if (result == 0 && bt->fn_return == NULL_REG) {
+			bt_dbg(1, "No function return found\n");
+			bt_dbg(2, "1st search: 0x%lx to 0x%lx, "
+				"2nd: 0x%lx to 0x%lx\n", bt->pc, end,
+				ip_next(bt->sf_allocation), bt->pc);
+
+			result = -ENOSYS;
+		}
+	}
+
+	return result;
+}
+
+/*
+ * This starts at the given address and looks for a function return. If
+ * it finds one, it sets the fn_return field to its address, otherwise it
+ * sets it to NULL_REG.
+ * Params:	bt	Points to the current struct simple_bt object
+ *		start	Starting address.
+ *		end	One instruction past the last instruction to check.
+ *			The address here should not be checked.
+ * Returns:	Zero if no error occurred during the scan, otherwise a
+ *		negative errno value.
+ */
+static int find_return_lookup_bounded(struct simple_bt *bt, reg_t start,
+	reg_t end)
+{
+	int		result = 0;	/* Assume success */
+	reg_t		ip;
+	opcode_t	op;
+
+	for (ip = start; ; ip = ip_next(ip)) {
+		if (ip == end)
+			break;
+		result = get_op(bt, ip, &op);
+		if (result != 0 || is_return(op))
+			break;
+	}
+
+	if (result == 0) {
+		if (ip == end)
+			bt->fn_return = NULL_REG;
+
+		else {
+			bt_dbg(2, "Function return at 0x%lx\n", ip);
+			bt->fn_return = ip;
+		}
+	}
+
+	return result;
+}
diff -urN linux-2.6.25.1/arch/mips/kernel/backtrace/thread-backtrace.c 
linux-t/arch/mips/kernel/backtrace/thread-backtrace.c
--- linux-2.6.25.1/arch/mips/kernel/backtrace/thread-backtrace.c 
1969-12-31 16:00:00.000000000 -0800
+++ linux-t/arch/mips/kernel/backtrace/thread-backtrace.c	2008-05-06 
17:30:09.000000000 -0700
@@ -0,0 +1,388 @@
+/*
+ *			thread-backtrace.c
+ *
+ * Performs Linux-dependent MIPS processor stack backtracing for 
processes. It
+ * builds on the MIPS processor ABI-conformant stack backtracing code, but
+ * does the OS-dependent portions that handle signal frames, too. This 
allows
+ * it to do multi-frame backtracing.
+ *
+ * Copyright(C) 2007  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 
02110-1301  USA
+ *
+ * Author: David VomLehn
+ */
+
+#ifdef	__KERNEL__
+#include <linux/errno.h>
+#include <linux/module.h>
+#else
+#define	FAKE_KERNEL
+#endif
+
+#ifdef	FAKE_KERNEL
+#define	__KERNEL__
+#endif
+#include <asm/sigframe.h>
+#ifdef	FAKE_KERNEL
+#undef	__KERNEL__
+#endif
+
+#include <asm/thread-backtrace.h>
+
+#ifndef	numberof
+#define	numberof(a)	(sizeof(a) / sizeof ((a) [0]))
+#endif
+
+static int restore_sigcontext_regs(struct thread_bt *bt, reg_t ctx);
+static int set_sigargs(struct thread_bt *bt, reg_t sigframe_args,
+	reg_t sigargs [NUM_SIGARGS]);
+static int thread_backtrace_analyze_simple(struct thread_bt *bt);
+static int do_thread_backtrace (struct thread_bt *tbt,
+	process_thread_frame_t process, void *arg);
+
+void thread_backtrace_init(struct thread_bt *bt,
+	const struct thread_bt_config *config)
+{
+	bt->config = config;
+	simple_backtrace_init(&bt->sbt, &config->simple_config);
+	bt->pc_is_return_address = 0;
+}
+EXPORT_SYMBOL(thread_backtrace_init);
+
+/*
+ * Determine the program counter value of the caller.
+ * Returns:	Return address, which is the location at which the call
+ *		instruction is located.
+ */
+reg_t thread_backtrace_here(void)
+{
+	unsigned long ra;
+	__asm__ __volatile__(
+		"	.set	noat\n"
+		"	la	$at,%[ra]\n"
+		"	sw	$ra,0($at)\n"
+		:	[ra] "=m" (ra)
+		:
+		: "at"
+	);
+	return ra;
+}
+EXPORT_SYMBOL(thread_backtrace_here);
+
+/*
+ * thread_backtrace_pt_regs - Backtrace the current thread.
+ */
+int thread_backtrace_pt_regs (const struct pt_regs *regs,
+	process_thread_frame_t process, void *arg,
+	const struct thread_bt_config *config)
+{
+	panic ("TODO: thread_backtrace_pt_regs not implemented\n");
+	return -ENOSYS;
+}
+
+/*
+ * Backtrace for a process the current function, including handling of
+ * signal frames.
+ * Params:	process	Function that will process each stack frame.
+ *		arg	Argument to passed to the processing function.
+ * Returns:	Zero if successful, otherwise a negative number.
+ *		value if not.
+ */
+int thread_backtrace(process_thread_frame_t process, void *arg,
+	const struct thread_bt_config *config)
+{
+	struct thread_bt	bt;
+
+	thread_backtrace_init_here(&bt, config);
+	return do_thread_backtrace (&bt, process, arg);
+}
+
+/*
+ * do_thread_backtrace - Loop through the thread's stack
+ */
+static int do_thread_backtrace (struct thread_bt *bt,
+	process_thread_frame_t process, void *arg)
+{
+	int			result;
+
+	for (result = thread_backtrace_first(bt);
+		result == 0;
+		result = thread_backtrace_next(bt)) {
+
+		/* If $pc is a return address, i.e. an address stored in $ra
+		 * by a jalr instruction, adjust it to point to the jalr
+		 * because, in some sense, that instruction is not yet
+		 * complete. */
+		if (bt->pc_is_return_address) {
+			bt->sbt.pc -= 2 * OPCODE_SIZE;
+			bt_dbg(2, "$pc is return address, adjusted to 0x%lx\n",
+				bt->sbt.pc);
+		}
+
+		bt_dbg(1, "---\n");
+		result = process(arg, bt);
+
+		/* If we adjusted the pc to point to a jalr instruction,
+		 * restore it */
+		if (bt->pc_is_return_address)
+			bt->sbt.pc += 2 * OPCODE_SIZE;
+
+		if (result != 0)
+			break;
+	}
+
+	/* If we got a return value of -ENOSYS, the $pc and $sp values are
+	 * good, but we can't continue the backtrace. Call the function to
+	 * process the last frame. */
+
+	if (result == -ENOSYS) {
+		(void) process(arg, bt);
+		result = 0;
+	}
+
+	/* The result could be zero because we internally determined that
+	 * the stack backtrace is done, or because the process function
+	 * passed back THREAD_BACKTRACE_END to indicate that the backtrace
+	 * is done. Either case is normal, so adjust the result to indicate
+	 * a normal termination. */
+	if (result > 0) {
+		bt_dbg(2, "Adjusting positive return code %d to zero", result);
+		result = 0;
+	}
+
+	return result;
+}
+EXPORT_SYMBOL(thread_backtrace);
+
+/*
+ * Get information for the first stack frame in a backtrace.
+ * Params:	bt	Pointer to trace_backtrace_t object initialized with
+ *			thread_backtrace_init.
+ * Returns:	Zero on success, a negative errno otherwise.
+ */
+int thread_backtrace_first(struct thread_bt *bt)
+{
+	int	result;
+
+	result = thread_backtrace_analyze_frame(bt);
+
+	return result;
+}
+EXPORT_SYMBOL(thread_backtrace_first);
+
+/*
+ * Handle one stack backtrace frame, updating the register according to 
what
+ * is found.
+ * Params:	bt	Pointer to register and backtrace information.
+ * Returns:	Zero on success, a negative errno otherwise.
+ */
+int thread_backtrace_next(struct thread_bt *bt)
+{
+	int		result;
+
+	result = thread_backtrace_pop_frame(bt);
+
+	if (result == 0)
+		result = thread_backtrace_analyze_frame(bt);
+
+	return result;
+}
+EXPORT_SYMBOL(thread_backtrace_next);
+
+/*
+ * Analyzes the current stack frame to see whether we are executing in a
+ * signal trampoline. To do this, we look at the instructions at the
+ * return address. If we have a load of $v0 with one of a few special 
values,
+ * followed by a syscall, this frame is actually for a signal trampoline.
+ * If it is a signal trampoline, it will set the sigargs.
+ * Params:	bt		Pointer to backtrace register and other
+ *				information.
+ * Returns:	Zero if we were able to determine whether we were in a
+ *		signal trampoline and a negative errno value if not.
+ */
+int thread_backtrace_analyze_frame(struct thread_bt *bt)
+{
+	int			result;
+	opcode_t		op1, op2;
+	reg_t			ip;
+	reg_t			sigframe_args;
+
+	bt_dbg(1, "$pc 0x%lx $sp 0x%lx\n", bt->sbt.pc,
+		bt->sbt.gprs [REG_SP]);
+	/* Start by trying to read two instructions since that's how long the
+	 * signal trampoline is. */
+	ip = bt->sbt.pc;
+	result = bt->config->simple_config.get_op(ip, &op1);
+
+	if (result == 0)
+		result = bt->config->simple_config.get_op(ip_next(ip),
+			&op2);
+
+	if (result == 0) {
+		bt_dbg(3, "Possible signal trampoline ops: 0x%08x 0x%08x\n",
+			op1, op2);
+		/* If we could read the instructions, check to see whether
+		 * they are the right ones for the signal trampoline. */
+		if (!is_li(op1, REG_V0) || !is_syscall(op2))
+			result = thread_backtrace_analyze_simple(bt);
+
+		else {
+			struct u_format	*op_p;
+			/* Yes, we have an 'li v0,<value>' followed by a
+			 * syscall. Is the system call we are doing the right
+			 * kind? */
+			op_p = (struct u_format *) &op1;
+
+			switch (op_p->uimmediate) {
+			case __NR_O32_sigreturn: bt_dbg(2,
+					"Analyzing signal frame\n");
+				bt->type = THREAD_FRAME_SIGNAL;
+				bt->pc_is_return_address = 0;
+				sigframe_args = bt->sbt.gprs [REG_SP] +
+					offsetof(struct sigframe, sf_ass);
+				result = set_sigargs(bt, sigframe_args,
+					bt->sigargs);
+				break;
+			case __NR_O32_rt_sigreturn: bt_dbg(2,
+					"Analyzing realtime signal frame\n");
+				bt->type = THREAD_FRAME_RT_SIGNAL;
+				bt->pc_is_return_address = 0;
+				sigframe_args = bt->sbt.gprs [REG_SP] +
+					offsetof(struct rt_sigframe, rs_ass);
+				result = set_sigargs(bt, sigframe_args,
+					bt->sigargs);
+				break;
+			default: result = thread_backtrace_analyze_simple(bt);
+				break;
+			}
+		}
+	}
+
+	return result;
+}
+EXPORT_SYMBOL(thread_backtrace_analyze_frame);
+
+/*
+ * This is not a signal frame, so use the analyzer for simple stack frames.
+ * Params:	bt	Pointer to struct thread_bt object
+ * Returns:	Zero on success and a negative errno on failure.
+ */
+static int thread_backtrace_analyze_simple(struct thread_bt *bt)
+{
+	bt->type = THREAD_FRAME_SIMPLE;
+	bt->pc_is_return_address = 1;
+	return simple_backtrace_analyze_frame(&bt->sbt);
+}
+
+/*
+ * Advances to the next stack frame.
+ * Params:	bt	Pointer to a struct thread_bt object.
+ * Returns:	Zero on success and a negative errno on failure.
+ */
+int thread_backtrace_pop_frame(struct thread_bt *bt)
+{
+	int	result;
+	reg_t	sc;
+
+	switch (bt->type) {
+	case THREAD_FRAME_SIMPLE: result =
+			simple_backtrace_pop_frame(&bt->sbt);
+		break;
+
+	case THREAD_FRAME_SIGNAL: sc = bt->sbt.gprs [REG_SP] +
+			offsetof(struct sigframe, sf_sc);
+		result = restore_sigcontext_regs(bt, sc);
+		break;
+
+	case THREAD_FRAME_RT_SIGNAL: sc = bt->sbt.gprs [REG_SP] +
+			offsetof(struct rt_sigframe, rs_uc.uc_mcontext);
+		result = restore_sigcontext_regs(bt, sc);
+		break;
+
+	default: result = -EINVAL;	/* Internal failure: shouldn't happen */
+		bt_dbg(1, "Unexpected frame type: %d\n", bt->type);
+		break;
+	}
+
+	return result;
+}
+EXPORT_SYMBOL(thread_backtrace_pop_frame);
+
+/*
+ * Sets the backtrace information from the sigcontext object.
+ * Params:	ctx	Pointer to a sigcontext structure from which to take
+ *			the register values.
+ *		bt	Pointer to the struct thread_bt object into which to
+ *			place the register values.
+ * Returns:	Zero if able to successfully read the information, a negative
+ *		errno value otherwise.
+ */
+static int restore_sigcontext_regs(struct thread_bt *bt, reg_t ctx)
+{
+	int		result = 0;		/* Assume success */
+	reg_t		sc_reg;
+	enum reg_num	i;
+
+	bt_dbg(3, "sigcontext is at 0x%lx\n", ctx);
+
+	/* Restore all of the general purpose registers. */
+	simple_backtrace_clear_saved(&bt->sbt);
+
+	for (i = REG_AT; result == 0 && i < REG_ALL; i ++) {
+		sc_reg = ctx + offsetof(struct sigcontext, sc_regs [i]);
+		result = bt->config->get_sc_reg(sc_reg,
+			&bt->sbt.gprs [i]);
+		if (result == 0) {
+			bt_dbg(3, "Restored $r%d = 0x%lx\n", i,
+				bt->sbt.gprs [i]);
+			bt->sbt.gpr_saved [i] = 1;
+		}
+	}
+
+	/* We also have to get the $pc register because it is not a general
+	 * purpose register. */
+	if (result == 0) {
+		result = bt->config->get_sc_reg(ctx +
+				offsetof(struct sigcontext, sc_pc),
+			&bt->sbt.pc);
+		if (result == 0)
+			bt_dbg(1, "Restored $pc = 0x%lx\n", bt->sbt.pc);
+	}
+
+	return result;
+}
+
+/*
+ * Copy the signal arguments into the struct thread_bt object.
+ * Params:	args		Pointer to the four argument values
+ *		sigargs		Pointer to array in which to store the
+ *				argument values.
+ * Returns:	Zero on success, a negative errno value on failure.
+ */
+static int set_sigargs(struct thread_bt *bt, reg_t sigframe_args,
+	reg_t sigargs [NUM_SIGARGS])
+{
+	int		result = 0;	/* Assume success */
+	unsigned	i;
+
+	for (i = 0; result == 0 && i < NUM_SIGARGS; i ++) {
+		reg_t	p;
+		p = sigframe_args + i * sizeof(reg_t);
+		result = bt->config->simple_config.get_reg(p, &sigargs [i]);
+	}
+
+	return result;
+}
diff -urN linux-2.6.25.1/arch/mips/kernel/entry.S 
linux-t/arch/mips/kernel/entry.S
--- linux-2.6.25.1/arch/mips/kernel/entry.S	2008-05-01 
14:45:25.000000000 -0700
+++ linux-t/arch/mips/kernel/entry.S	2008-05-06 17:30:09.000000000 -0700
@@ -40,6 +40,7 @@
  	andi	t0, t0, KU_USER
  	beqz	t0, resume_kernel

+	.globl	resume_userspace
  resume_userspace:
  	local_irq_disable		# make sure we dont miss an
  					# interrupt setting need_resched
@@ -50,10 +51,12 @@
  	j	restore_all

  #ifdef CONFIG_PREEMPT
+	.globl	resume_kernel
  resume_kernel:
  	local_irq_disable
  	lw	t0, TI_PRE_COUNT($28)
  	bnez	t0, restore_all
+	.globl	need_resched
  need_resched:
  	LONG_L	t0, TI_FLAGS($28)
  	andi	t1, t0, _TIF_NEED_RESCHED
@@ -141,9 +144,11 @@
  	RESTORE_SP_AND_RET
  	.set	at

+	.globl	work_pending
  work_pending:
  	andi	t0, a2, _TIF_NEED_RESCHED # a2 is preloaded with TI_FLAGS
  	beqz	t0, work_notifysig
+	.globl	work_resched
  work_resched:
  	jal	schedule

@@ -157,6 +162,7 @@
  	andi	t0, a2, _TIF_NEED_RESCHED
  	bnez	t0, work_resched

+	.globl	work_notifysig
  work_notifysig:				# deal with pending signals and
  					# notify-resume requests
  	move	a0, sp
@@ -166,6 +172,7 @@

  FEXPORT(syscall_exit_work_partial)
  	SAVE_STATIC
+	.global	syscall_exit_work
  syscall_exit_work:
  	li	t0, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
  	and	t0, a2			# a2 is preloaded with TI_FLAGS
diff -urN linux-2.6.25.1/arch/mips/kernel/Makefile 
linux-t/arch/mips/kernel/Makefile
--- linux-2.6.25.1/arch/mips/kernel/Makefile	2008-05-01 
14:45:25.000000000 -0700
+++ linux-t/arch/mips/kernel/Makefile	2008-05-06 17:30:09.000000000 -0700
@@ -79,6 +79,7 @@

  obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
  obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_MIPS_ADVANCED_BACKTRACE) += backtrace/

  CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c 
-o /dev/null -xc /dev/null >/dev/null 2>&1; then echo 
"-DHAVE_AS_SET_DADDI"; fi)

diff -urN linux-2.6.25.1/arch/mips/kernel/scall32-o32.S 
linux-t/arch/mips/kernel/scall32-o32.S
--- linux-2.6.25.1/arch/mips/kernel/scall32-o32.S	2008-05-01 
14:45:25.000000000 -0700
+++ linux-t/arch/mips/kernel/scall32-o32.S	2008-05-06 17:30:09.000000000 
-0700
@@ -54,6 +54,7 @@
  	sw	a3, PT_R26(sp)		# save a3 for syscall restarting
  	bgez	t3, stackargs

+	.globl	stack_done
  stack_done:
  	lw	t0, TI_FLAGS($28)	# syscall tracing enabled?
  	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
@@ -72,6 +73,7 @@
  					# restarting
  1:	sw	v0, PT_R2(sp)		# result

+	.globl	o32_syscall_exit
  o32_syscall_exit:
  	local_irq_disable		# make sure need_resched and
  					# signals dont change between
@@ -83,11 +85,13 @@

  	j	restore_partial

+	.globl	o32_syscall_exit_work
  o32_syscall_exit_work:
  	j	syscall_exit_work_partial

  /* 
------------------------------------------------------------------------ */

+	.globl	syscall_trace_entry
  syscall_trace_entry:
  	SAVE_STATIC
  	move	s0, t2
@@ -122,6 +126,7 @@
  	 * stack arguments from the user stack to the kernel stack.
  	 * This Sucks (TM).
  	 */
+	.globl	stackargs
  stackargs:
  	lw	t0, PT_R29(sp)		# get old user stack pointer

@@ -132,7 +137,7 @@
  	lw	t5, TI_ADDR_LIMIT($28)
  	addu	t4, t0, 32
  	and	t5, t4
-	bltz	t5, bad_stack		# -> sp is bad
+	bltz	t5, _bad_stack		# -> sp is bad

  	/* Ok, copy the args from the luser stack to the kernel stack.
  	 * t3 is the precomputed number of instruction bytes needed to
@@ -162,17 +167,18 @@
  	.set	pop

  	.section __ex_table,"a"
-	PTR	1b,bad_stack
-	PTR	2b,bad_stack
-	PTR	3b,bad_stack
-	PTR	4b,bad_stack
+	PTR	1b,_bad_stack
+	PTR	2b,_bad_stack
+	PTR	3b,_bad_stack
+	PTR	4b,_bad_stack
  	.previous

  	/*
  	 * The stackpointer for a call with more than 4 arguments is bad.
  	 * We probably should handle this case a bit more drastic.
  	 */
-bad_stack:
+	.globl	_bad_stack
+_bad_stack:
  	negu	v0				# error
  	sw	v0, PT_R0(sp)
  	sw	v0, PT_R2(sp)
@@ -183,6 +189,7 @@
  	/*
  	 * The system call does not exist in this kernel
  	 */
+	.globl	illegal_syscall
  illegal_syscall:
  	li	v0, -ENOSYS			# error
  	sw	v0, PT_R2(sp)
@@ -213,8 +220,8 @@
  #endif

  	.section __ex_table,"a"
-	PTR	1b, bad_stack
-	PTR	2b, bad_stack
+	PTR	1b, _bad_stack
+	PTR	2b, _bad_stack
  	.previous
  #else
  	sw	a1, 16(sp)
@@ -246,13 +253,16 @@

  	j	o32_syscall_exit	# continue like a normal syscall

+	.globl	no_mem
  no_mem:	li	v0, -ENOMEM
  	jr	ra

+	.globl	bad_address
  bad_address:
  	li	v0, -EFAULT
  	jr	ra

+	.globl	bad_alignment
  bad_alignment:
  	li	v0, -EINVAL
  	jr	ra
@@ -305,6 +315,7 @@
  	jr	t2
  	/* Unreached */

+	.globl	einval
  einval:	li	v0, -EINVAL
  	jr	ra
  	END(sys_syscall)
diff -urN linux-2.6.25.1/arch/mips/kernel/signal32.c 
linux-t/arch/mips/kernel/signal32.c
--- linux-2.6.25.1/arch/mips/kernel/signal32.c	2008-05-01 
14:45:25.000000000 -0700
+++ linux-t/arch/mips/kernel/signal32.c	2008-05-06 17:30:09.000000000 -0700
@@ -32,16 +32,10 @@
  #include <asm/system.h>
  #include <asm/fpu.h>
  #include <asm/war.h>
+#include <asm/sigframe.h>

  #include "signal-common.h"

-/*
- * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
- */
-#define __NR_O32_sigreturn		4119
-#define __NR_O32_rt_sigreturn		4193
-#define __NR_O32_restart_syscall        4253
-
  /* 32-bit compatibility types */

  typedef unsigned int __sighandler32_t;
diff -urN linux-2.6.25.1/arch/mips/kernel/signal.c 
linux-t/arch/mips/kernel/signal.c
--- linux-2.6.25.1/arch/mips/kernel/signal.c	2008-05-01 
14:45:25.000000000 -0700
+++ linux-t/arch/mips/kernel/signal.c	2008-05-06 17:30:09.000000000 -0700
@@ -30,51 +30,11 @@
  #include <asm/ucontext.h>
  #include <asm/cpu-features.h>
  #include <asm/war.h>
+#include <asm/sigframe.h>

  #include "signal-common.h"

  /*
- * Horribly complicated - with the bloody RM9000 workarounds enabled
- * the signal trampolines is moving to the end of the structure so we can
- * increase the alignment without breaking software compatibility.
- */
-#if ICACHE_REFILLS_WORKAROUND_WAR == 0
-
-struct sigframe {
-	u32 sf_ass[4];		/* argument save space for o32 */
-	u32 sf_code[2];		/* signal trampoline */
-	struct sigcontext sf_sc;
-	sigset_t sf_mask;
-};
-
-struct rt_sigframe {
-	u32 rs_ass[4];		/* argument save space for o32 */
-	u32 rs_code[2];		/* signal trampoline */
-	struct siginfo rs_info;
-	struct ucontext rs_uc;
-};
-
-#else
-
-struct sigframe {
-	u32 sf_ass[4];			/* argument save space for o32 */
-	u32 sf_pad[2];
-	struct sigcontext sf_sc;	/* hw context */
-	sigset_t sf_mask;
-	u32 sf_code[8] ____cacheline_aligned;	/* signal trampoline */
-};
-
-struct rt_sigframe {
-	u32 rs_ass[4];			/* argument save space for o32 */
-	u32 rs_pad[2];
-	struct siginfo rs_info;
-	struct ucontext rs_uc;
-	u32 rs_code[8] ____cacheline_aligned;	/* signal trampoline */
-};
-
-#endif
-
-/*
   * Helper routines
   */
  static int protected_save_fp_context(struct sigcontext __user *sc)
diff -urN linux-2.6.25.1/arch/mips/kernel/traps.c 
linux-t/arch/mips/kernel/traps.c
--- linux-2.6.25.1/arch/mips/kernel/traps.c	2008-05-01 
14:45:25.000000000 -0700
+++ linux-t/arch/mips/kernel/traps.c	2008-05-06 17:33:13.000000000 -0700
@@ -42,6 +42,7 @@
  #include <asm/mmu_context.h>
  #include <asm/types.h>
  #include <asm/stacktrace.h>
+#include <asm/kernel-backtrace.h>

  extern asmlinkage void handle_int(void);
  extern asmlinkage void handle_tlbm(void);
@@ -105,21 +106,83 @@
  __setup("raw_show_trace", set_raw_show_trace);
  #endif

-static void show_backtrace(struct task_struct *task, const struct 
pt_regs *regs)
+#ifdef	CONFIG_MIPS_ADVANCED_BACKTRACE
+/*
+ * print_bt_frame - Print one backtrace frame
+ * @arg:	Pointer to the frame count
+ * @bt:		Pointer to the kernel backtrace structure &kernel_bt.
+ * Returns: Zero if the backtrace is to continue, otherwise
+ *	KERNEL_BACKTRACE_END to indicate backtrace termination.
+ */
+static int print_bt_frame(void *arg, struct kernel_bt *bt)
+{
+	int		result = 0;	/* Assume a good outcome */
+	unsigned	*count = (unsigned *) arg;
+	unsigned long	pc, fp;
+	static const int max_stack_frames = 50;
+
+	pc = bt->tbt.sbt.pc;
+	fp = bt->tbt.sbt.gprs [bt->tbt.sbt.framepointer];
+	print_ip_sym(pc);
+
+	/* Don't print more than the maximum number of stack frames. */
+	*count = *count + 1;
+
+	if (*count >= max_stack_frames) {
+		printk(KERN_WARNING "Exceeded maximum number of frames (%u)\n",
+			max_stack_frames);
+		result = KERNEL_BACKTRACE_END;
+	}
+
+	return result;
+}
+
+/**
+ * show_unwinding_backtrace - Print the backtrace by unwinding stack frames
+ *	one at a time.
+ * @task:	Pointer to the task structure for the task to be unwound
+ * @regs:	Pointer to &pt_regs structure with the initial registers
+ */
+static void show_unwinding_backtrace(struct task_struct *task,
+	const struct pt_regs *regs)
+{
+	int	frame_count = 0;
+	int	rc;
+
+	rc = kernel_backtrace_pt_regs(regs, print_bt_frame, &frame_count);
+
+	if (rc != 0)
+		printk(KERN_WARNING "Backtrace terminated with error %d\n",
+			rc);
+}
+#else
+static void show_unwinding_backtrace(struct task_struct *task,
+	const struct pt_regs *regs)
  {
  	unsigned long sp = regs->regs[29];
  	unsigned long ra = regs->regs[31];
  	unsigned long pc = regs->cp0_epc;

-	if (raw_show_trace || !__kernel_text_address(pc)) {
-		show_raw_backtrace(sp);
-		return;
-	}
-	printk("Call Trace:\n");
  	do {
  		print_ip_sym(pc);
  		pc = unwind_stack(task, &sp, pc, &ra);
  	} while (pc);
+}
+#endif
+
+static void show_backtrace(struct task_struct *task, const struct 
pt_regs *regs)
+{
+	unsigned long sp = regs->regs[29];
+	unsigned long pc = regs->cp0_epc;
+
+	if (raw_show_trace
+		|| !__kernel_text_address(pc)
+		) {
+		show_raw_backtrace(sp);
+		return;
+	}
+	printk("Symbolic Call Trace:\n");
+	show_unwinding_backtrace(task, regs);
  	printk("\n");
  }

diff -urN linux-2.6.25.1/include/asm-mips/kernel-backtrace.h 
linux-t/include/asm-mips/kernel-backtrace.h
--- linux-2.6.25.1/include/asm-mips/kernel-backtrace.h	1969-12-31 
16:00:00.000000000 -0800
+++ linux-t/include/asm-mips/kernel-backtrace.h	2008-05-06 
17:30:09.000000000 -0700
@@ -0,0 +1,81 @@
+/*
+ *				kernel-backtrace.h
+ *
+ * Definitions for stack backtracing in the kernel. In addition to handle
+ * process backtraces, because kernel threads can get signals, too, 
this has
+ * to handle interrupts and exceptions.
+ *
+ * Copyright (C) 2007  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 
02110-1301  USA
+ */
+
+#ifndef	_KERNEL_BACKTRACE_H_
+#define	_KERNEL_BACKTRACE_H_
+#include <asm/types.h>
+#include <asm/thread-backtrace.h>
+
+/* Value to be returned by the function that processes each frame to 
indicate
+ * a non-error termination of the backtrace. */
+#define	KERNEL_BACKTRACE_END	1
+
+/* Value returned internally by functions called from 
do_kernel_backtrace to
+ * indicate that the backtrace should terminate. */
+#define KERNEL_BACKTRACE_DONE	2
+
+enum kernel_frame_type {
+	KERNEL_FRAME_SIMPLE = THREAD_FRAME_SIMPLE, /* Ordinary frame */
+	KERNEL_FRAME_SIGNAL = THREAD_FRAME_SIGNAL, /* Signal frame */
+	KERNEL_FRAME_RT_SIGNAL = THREAD_FRAME_RT_SIGNAL, /* Realtime signal */
+	KERNEL_FRAME_TLB_REFILL,	/* In the general exception vector */
+	KERNEL_FRAME_GENERAL_EXCEPTION,	/* In the general exception vector */
+	KERNEL_FRAME_INTERRUPT,		/* In the general exception vector */
+	KERNEL_FRAME_K0_K1_ONLY,	/* Code uses only $k0 & $k1 registers */
+	KERNEL_FRAME_SAVE_SOME,		/* Code uses SAVE_SOME macro */
+	KERNEL_FRAME_SAVE_STATIC,	/* Code uses SAVE_STATIC macro */
+	KERNEL_FRAME_SAVE_ALL,		/* Code uses SAVE_ALL macro */
+	KERNEL_FRAME_GLUE,		/* Registers saved in struct pt_regs */
+	KERNEL_FRAME_RESTORE_SOME,	/* Code uses RESTORE_SOME macro */
+	KERNEL_FRAME_UNEXPECTED		/* Never expect to be in this code */
+};
+
+struct kernel_bt {
+	struct thread_bt	tbt;
+	enum kernel_frame_type	type;
+	u32			cp0_status; /* CP0 Status register */
+	reg_t			cp0_epc; /* CP0 EPC register */
+	reg_t			start;	/* Start of current section of code */
+	reg_t			size;	/* Size of current section of code */
+};
+
+/**
+ * process_kernel_frame_t - Type of function called to do processing 
for each
+ *	frame of the stack backtrace.
+ * @arg:	Argument passed to kernel_backtrace/kernel_backtrace_pt_regs
+ * @bt:		Pointer to &kernel_bt structure
+ * Returns zero if the backtrace is to continue, non-zero otherwise. A 
negative
+ *	errno is used to signal an error, KERNEL_BACKTRACE_END is available for
+ *	a normal termination.
+ */
+typedef	int (*process_kernel_frame_t) (void *arg, struct kernel_bt *bt);
+
+extern int kernel_backtrace_pt_regs(const struct pt_regs *regs,
+	process_kernel_frame_t process, void *arg);
+extern int kernel_backtrace(process_kernel_frame_t process, void *arg);
+extern int kernel_backtrace_first(struct kernel_bt *bt);
+extern int kernel_backtrace_next(struct kernel_bt *bt);
+extern int kernel_backtrace_analyze_frame(struct kernel_bt *bt);
+extern int kernel_backtrace_pop_frame(struct kernel_bt *bt);
+#endif	/* _KERNEL_BACKTRACE_H_ */
diff -urN linux-2.6.25.1/include/asm-mips/kernel-backtrace-symbols.h 
linux-t/include/asm-mips/kernel-backtrace-symbols.h
--- linux-2.6.25.1/include/asm-mips/kernel-backtrace-symbols.h 
1969-12-31 16:00:00.000000000 -0800
+++ linux-t/include/asm-mips/kernel-backtrace-symbols.h	2008-05-06 
17:30:09.000000000 -0700
@@ -0,0 +1,133 @@
+/*
+ *			kernel-backtrace-symbols.h
+ *
+ * This file contains symbols that need to be handled specially. The
+ * idea is that code will define a macro named SPECIAL_SYMBOL that
+ * appropriately generates code for an external reference, then redefines
+ * it to generate a table with the symbols.
+ *
+ * It should be mentioned that, though this is not especially pretty, 
having
+ * this list of symbols in only one place makes it impossible to define
+ * the external reference for the symbol and then forget to add it to the
+ * table of symbols, which is a big win on the maintenance front.
+ *
+ * To make this list easier to maintain, it is best to keep the symbols
+ * for a given file together and in the order in which they appear in that
+ * file.
+ *
+ * Copyright (C) 2007  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 
02110-1301  USA
+ */
+
+/* The first part is protected against multiple inclusions, but the
+ * rest isn't */
+#ifndef	_KERNEL_BACKTRACE_SYMBOLS_H_
+#define	_KERNEL_BACKTRACE_SYMBOLS_H_
+#include <asm/kernel-backtrace.h>
+
+struct kern_special_sym {
+	const opcode_t		*start;
+	enum kernel_frame_type	type;
+};
+
+extern const struct kern_special_sym kernel_backtrace_symbols [];
+extern unsigned kernel_backtrace_symbols_size;
+#endif	/* _KERNEL_BACKTRACE_SYMBOLS_H_ */
+
+/* Only define the symbol list if someone has defined the macro we use
+ * to construct it. This allows the above symbols to be included even by
+ * things which only reference the list. */
+
+#ifdef	SPECIAL_SYMBOL
+/* arch/mips/kernel/entry.S */
+SPECIAL_SYMBOL(ret_from_exception, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(ret_from_irq, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(resume_userspace, KERNEL_FRAME_GLUE)
+#ifdef CONFIG_PREEMPT
+SPECIAL_SYMBOL(resume_kernel, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(need_resched, KERNEL_FRAME_GLUE)
+#endif
+SPECIAL_SYMBOL(ret_from_fork, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(syscall_exit, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(restore_all, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(restore_partial, KERNEL_FRAME_RESTORE_SOME)
+SPECIAL_SYMBOL(work_pending, KERNEL_FRAME_RESTORE_SOME)
+SPECIAL_SYMBOL(work_resched, KERNEL_FRAME_RESTORE_SOME)
+SPECIAL_SYMBOL(work_notifysig, KERNEL_FRAME_RESTORE_SOME)
+SPECIAL_SYMBOL(syscall_exit_work_partial, KERNEL_FRAME_SAVE_STATIC)
+SPECIAL_SYMBOL(syscall_exit_work, KERNEL_FRAME_GLUE)
+
+/* arch/mips/kernel/genex.S */
+SPECIAL_SYMBOL(except_vec_vi_end, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(except_vec_vi_handler, KERNEL_FRAME_SAVE_STATIC)
+SPECIAL_SYMBOL(handle_adel, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_adel_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_ades, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_ades_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_ibe, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_ibe_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_dbe, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_dbe_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_bp, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_bp_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_ri, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_ri_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_cpu, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_cpu_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_ov, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_ov_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_tr, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_tr_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_fpe, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_fpe_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_mdmx, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_mdmx_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_watch, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_watch_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_mcheck, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_mcheck_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_mt, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_mt_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_dsp, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_dsp_int, KERNEL_FRAME_GLUE)
+
+/* arch/mips/kernel/scall32-o32.S */
+SPECIAL_SYMBOL(handle_sys, KERNEL_FRAME_SAVE_SOME)
+SPECIAL_SYMBOL(stack_done, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(o32_syscall_exit, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(o32_syscall_exit_work, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(syscall_trace_entry, KERNEL_FRAME_SAVE_STATIC)
+SPECIAL_SYMBOL(stackargs, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(_bad_stack, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(illegal_syscall, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(mips_atomic_set, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(mips_atomic_set, KERNEL_FRAME_SAVE_STATIC)
+SPECIAL_SYMBOL(no_mem, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(bad_address, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(bad_alignment, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(sys_sysmips, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(sys_syscall, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(einval, KERNEL_FRAME_GLUE)
+
+/* arch/mips/mm/tlbex-fault.S */
+SPECIAL_SYMBOL(tlb_do_page_fault_0, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(tlb_do_page_fault_1, KERNEL_FRAME_SAVE_ALL)
+
+/* arch/mips/mm/tlbex.c (Code generated dynamically) */
+SPECIAL_SYMBOL(handle_tlbl, KERNEL_FRAME_K0_K1_ONLY)
+SPECIAL_SYMBOL(handle_tlbm, KERNEL_FRAME_K0_K1_ONLY)
+SPECIAL_SYMBOL(handle_tlbs, KERNEL_FRAME_K0_K1_ONLY)
+#endif	/* SPECIAL_SYMBOL */
diff -urN linux-2.6.25.1/include/asm-mips/ptrace.h 
linux-t/include/asm-mips/ptrace.h
--- linux-2.6.25.1/include/asm-mips/ptrace.h	2008-05-01 
14:45:25.000000000 -0700
+++ linux-t/include/asm-mips/ptrace.h	2008-05-06 18:27:15.000000000 -0700
@@ -23,6 +23,18 @@
  #define DSP_CONTROL	77
  #define ACX		78

+/* Register numbers */
+enum reg_num {
+	REG_ZERO,	REG_AT,	REG_V0,	REG_V1,
+	REG_A0,	REG_A1,	REG_A2,	REG_A3,
+	REG_T0,	REG_T1,	REG_T2,	REG_T3,
+	REG_T4,	REG_T5,	REG_T6,	REG_T7,
+	REG_S0,	REG_S1,	REG_S2,	REG_S3,
+	REG_S4,	REG_S5,	REG_S6,	REG_S7,
+	REG_T8,	REG_T9,	REG_K0,	REG_K1,
+	REG_GP,	REG_SP,	REG_S8,	REG_RA,
+	REG_ALL		/* This last one is the number of GPRs */
+};
  /*
   * This struct defines the way the registers are stored on the stack 
during a
   * system call/exception. As usual the registers k0/k1 aren't being saved.
@@ -34,7 +46,7 @@
  #endif

  	/* Saved main processor registers. */
-	unsigned long regs[32];
+	unsigned long regs[REG_ALL];

  	/* Saved special registers. */
  	unsigned long cp0_status;
diff -urN linux-2.6.25.1/include/asm-mips/sigframe.h 
linux-t/include/asm-mips/sigframe.h
--- linux-2.6.25.1/include/asm-mips/sigframe.h	1969-12-31 
16:00:00.000000000 -0800
+++ linux-t/include/asm-mips/sigframe.h	2008-05-06 17:30:09.000000000 -0700
@@ -0,0 +1,73 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General 
Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 2007 Scientific-Atlanta, Inc.
+ * Copyright (C) 1991, 1992  Linus Torvalds
+ * Copyright (C) 1994 - 2000  Ralf Baechle
+ * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ */
+
+#ifndef	_SIGFRAME_H_
+#define	_SIGFRAME_H_
+#include <linux/signal.h>
+
+#include <asm/ucontext.h>
+#include <asm/war.h>
+
+/*
+ * Originally from arch/mips/kernel/signal.c...
+ */
+/*
+ * Horribly complicated - with the bloody RM9000 workarounds enabled
+ * the signal trampolines is moving to the end of the structure so we can
+ * increase the alignment without breaking software compatibility.
+ */
+#if ICACHE_REFILLS_WORKAROUND_WAR == 0
+
+struct sigframe {
+	u32 sf_ass[4];		/* argument save space for o32 */
+	u32 sf_code[2];		/* signal trampoline */
+	struct sigcontext sf_sc;
+	sigset_t sf_mask;
+};
+
+struct rt_sigframe {
+	u32 rs_ass[4];		/* argument save space for o32 */
+	u32 rs_code[2];		/* signal trampoline */
+	struct siginfo rs_info;
+	struct ucontext rs_uc;
+};
+
+#else
+
+struct sigframe {
+	u32 sf_ass[4];			/* argument save space for o32 */
+	u32 sf_pad[2];
+	struct sigcontext sf_sc;	/* hw context */
+	sigset_t sf_mask;
+	u32 sf_code[8] ____cacheline_aligned;	/* signal trampoline */
+};
+
+struct rt_sigframe {
+	u32 rs_ass[4];			/* argument save space for o32 */
+	u32 rs_pad[2];
+	struct siginfo rs_info;
+	struct ucontext rs_uc;
+	u32 rs_code[8] ____cacheline_aligned;	/* signal trampoline */
+};
+
+#endif
+
+/*
+ * Originally from arch/mips/kernel/signal32.c...
+ */
+
+/*
+ * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
+ */
+#define __NR_O32_sigreturn		4119
+#define __NR_O32_rt_sigreturn		4193
+#define __NR_O32_restart_syscall	4253
+#endif
diff -urN linux-2.6.25.1/include/asm-mips/simple-backtrace.h 
linux-t/include/asm-mips/simple-backtrace.h
--- linux-2.6.25.1/include/asm-mips/simple-backtrace.h	1969-12-31 
16:00:00.000000000 -0800
+++ linux-t/include/asm-mips/simple-backtrace.h	2008-05-06 
17:30:09.000000000 -0700
@@ -0,0 +1,344 @@
+/*
+ *			simple-backtrace.h
+ *
+ * Definitions handling one simple stack frame's worth of stack backtrace.
+ *
+ * Copyright(C) 2007  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 
02110-1301  USA
+ */
+
+#ifndef	_SIMPLE_BACKTRACE_H_
+#define	_SIMPLE_BACKTRACE_H_
+#include <linux/compiler.h>
+#include <asm/inst.h>
+#include <asm/ptrace.h>
+
+#ifdef	__KERNEL__
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#define	dbg_print	printk
+#define	PRIORITY	KERN_CRIT
+#else
+#include <errno.h>
+#include <stdio.h>
+#define	dbg_print	printf
+#define	EXPORT_SYMBOL(sym)
+#define	PRIORITY
+#endif
+
+#define	BACKTRACE_DEBUG	0
+
+#if	BACKTRACE_DEBUG != 0
+#define	bt_dbg(level, fmt, ...)	do {					\
+		if (level <= BACKTRACE_DEBUG)				\
+			dbg_print(PRIORITY "%s: " fmt, __FUNCTION__,	\
+			## __VA_ARGS__);				\
+	} while (0)
+#else
+#define	bt_dbg(level, fmt, ...)	do { } while (0)
+#endif
+
+#define	OPCODE_SIZE (sizeof(opcode_t))	/* MIPS processor has 4-byte 
opcodes */
+
+/* Additional instruction formats that really should have been defined in
+ * asm/inst.h */
+#ifdef	__MIPSEB__
+	struct	any_format {		/* Generic format */
+		unsigned int opcode : 6;
+		unsigned int remainder : 26;
+	};
+
+	struct	eret_format {
+		unsigned int opcode : 6;
+		unsigned int co : 1;
+		unsigned int zero: 19;
+		unsigned int func : 6;
+	};
+
+	struct syscall_format {
+		unsigned int opcode : 6;
+		unsigned int code : 20;
+		unsigned int func : 6;
+	};
+#else
+	struct	any_format {		/* Generic format */
+		unsigned int remainder : 26;
+		unsigned int opcode : 6;
+	};
+
+	struct	eret_format {
+		unsigned int func : 6;
+		unsigned int zero: 19;
+		unsigned int co : 1;
+		unsigned int opcode : 6;
+	};
+
+	struct syscall_format {
+		unsigned int func : 6;
+		unsigned int code : 20;
+		unsigned int opcode : 6;
+	};
+#endif
+
+/* NULL value, converted to a reg_t type */
+#define	NULL_REG	((reg_t) NULL)
+
+typedef	unsigned long reg_t;		/* Can hold a register value */
+typedef	mips_instruction opcode_t;	/* Holds a machine instruction */
+typedef	int reg_offset_t;		/* Offset from a register */
+typedef	reg_offset_t frame_size_t;	/* Stack frame size */
+typedef	long pc_offset_t;		/* Offset from $pc */
+
+/* Backtrace types */
+enum simple_bt_type {
+	SIMPLE_BACKTRACE_O32_ABI,	/* Backtrace using o32 ABI rules */
+	SIMPLE_BACKTRACE_LOOKUP_FUNC,	/* Look up function start and size */
+};
+
+/*
+ * Functions that are required by the simple-backtrace.c code but which 
must
+ * be supplied by users of that code.
+ */
+
+/*
+ * Get an opcode_t-sized object from memory.
+ * Params:	ip	Address of the opcode.
+ *		op	Location in which to store the opcode
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+typedef int(*get_op_t) (reg_t ip, opcode_t *op);
+
+/*
+ * Get a register-sized(reg_t-sized) object from memory.
+ * Params:	rp		Address of the value.
+ *		reg		Location in which to store the value.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+typedef int(*get_reg_t) (reg_t rp, reg_t *reg);
+
+/*
+ * Lookup a symbol's starting address and the size of the object, given an
+ * address within the symbol.
+ * Params:	addr		Address to look up
+ *		symbolstart	Starting address of the symbol
+ *		symbolsize	Number of bytes in the memory represented by
+ *				the symbol.
+ * Returns:	Zero on success, otherwise a negative errno value. If the 
symbol
+ *		couldn't be found, the value returned should be -ESRCH.
+ */
+typedef int(*symbol_lookup_t) (reg_t addr, reg_t *symbolstart,
+	reg_t *symbolsize);
+
+/*
+ * Configuration information for the backtrace.
+ */
+struct simple_bt_config {
+	enum simple_bt_type	type;
+	get_op_t		get_op;
+	get_reg_t		get_reg;
+	symbol_lookup_t		symbol_lookup;
+};
+
+/*
+ * Data type that holds the current values of the GPRS, along with other
+ * information required during the backtrace.
+ */
+struct simple_bt {
+	/* Public */
+	reg_t		gprs [REG_ALL];
+	int		gpr_saved [REG_ALL];
+	enum reg_num	framepointer;	/* Register number of frame pointer */
+	reg_t		pc;
+	frame_size_t	frame_size;	/* Stack frame size, in bytes */
+	/* Private */
+	const struct simple_bt_config *config;
+	reg_t		sf_allocation;	/* Address of stack frame allocation */
+	reg_t		fp_restore;	/* Addr frame ptr moved back to $sp*/
+	reg_t		sf_deallocation; /* Addr of stack frame deallocation */
+	reg_t		fn_return;	/* Address of return instruction */
+	enum reg_num	possible_framepointer;
+	reg_t		func_start;	/* Address of 1st opcode of function */
+	union {
+		struct {
+			reg_t	func_size;
+		} lookup;
+	} data;
+};
+
+/* Opcode: addiu rs, rt, imm */
+static inline int is_addiu(opcode_t inst, reg_t rs, reg_t rt)
+{
+	struct i_format *op_p = (struct i_format *) &inst;
+	return op_p->opcode == addiu_op &&
+		op_p->rs == rs &&  op_p->rt == rt;
+}
+
+/* Opcode: addu */
+static inline int is_addu_noreg(opcode_t inst)
+{
+	struct r_format	*op_p = (struct r_format *) &inst;
+	return op_p->opcode == spec_op && op_p->func == addu_op &&
+			op_p->re == 0;
+}
+
+/* Opcode: addu rd, rs, rt */
+static inline int is_addu(opcode_t inst, reg_t rd, reg_t rs, reg_t rt)
+{
+	struct r_format	*op_p = (struct r_format *) &inst;
+	return is_addu_noreg(inst) &&
+		op_p->rd == rd && op_p->rs == rs && op_p->rt == rt;
+}
+
+/* Opcode: eret */
+static inline int is_eret(opcode_t inst)
+{
+	struct eret_format	*op_p = (struct eret_format *) &inst;
+	return op_p->opcode == spec_op && op_p->func == eret_op &&
+		op_p->co == 1 && op_p->zero == 0;
+}
+
+/* Opcode: move rd, rs. Synonym for addu rd, rs, zero. */
+static inline int is_move(opcode_t inst, reg_t rd, reg_t rs)
+{
+	return is_addu(inst, rd, rs, REG_ZERO);
+}
+
+/* Opcode: jal addr */
+static inline int is_jal(opcode_t inst)
+{
+	struct j_format	*op_p = (struct j_format *) &inst;
+	return op_p->opcode == jal_op;
+}
+
+static inline int is_jalr(opcode_t inst)
+{
+	struct r_format	*op_p = (struct r_format *) &inst;
+	return op_p->opcode == spec_op && op_p->func == jalr_op &&
+		op_p->rt == 0;
+}
+
+static inline int is_jr(opcode_t inst, reg_t rs)
+{
+	struct r_format	*op_p = (struct r_format *) &inst;
+	return op_p->opcode == spec_op && op_p->func == jr_op &&
+		op_p->rs == rs && op_p->rt == 0 && op_p->rd == 0;
+}
+
+static inline int is_li(opcode_t inst, reg_t rt)
+{
+	return is_addiu(inst, REG_ZERO, rt);
+}
+
+static inline int is_lui(opcode_t inst, reg_t rt)
+{
+	struct u_format	*op_p = (struct u_format *) &inst;
+	return op_p->opcode == lui_op && op_p->rs == 0 &&
+		op_p->rt == rt;
+}
+
+static inline int is_sw(opcode_t inst, reg_t rt, reg_t base)
+{
+	struct i_format	*op_p = (struct i_format *) &inst;
+	return op_p->opcode == sw_op &&
+		op_p->rs == base && op_p->rt == rt;
+}
+
+static inline int is_syscall(opcode_t inst)
+{
+	struct syscall_format *op_p = (struct syscall_format *) &inst;
+	return op_p->opcode == spec_op &&
+		op_p->func == syscall_op;
+}
+
+/* Sign extension functions. */
+
+static inline reg_offset_t sign_extend_imm(opcode_t imm)
+{
+	struct i_format	*op_p = (struct i_format *) &imm;
+	return op_p->simmediate;
+}
+
+static inline reg_offset_t sign_extend_offset(opcode_t offset)
+{
+	struct i_format *op_p = (struct i_format *) &offset;
+	return op_p->simmediate;
+}
+
+/* Is this the save of a register with an offset from the given frame 
pointer
+ * register? */
+static inline int is_frame_save(opcode_t inst, enum reg_num framepointer)
+{
+	struct i_format	*op_p = (struct i_format *) &inst;
+	return op_p->opcode == sw_op &&
+		op_p->rs == framepointer;
+}
+
+/* Returns the number of the register being saved when the opcode is a 
frame
+ * save. */
+static inline enum reg_num frame_save_rt(opcode_t op)
+{
+	struct i_format	*op_p = (struct i_format *) &op;
+	return op_p->rt;
+}
+
+/* Returns the offset in the stack frame for a frame save */
+static inline reg_offset_t frame_save_offset(opcode_t op)
+{
+	struct i_format *op_p = (struct i_format *) &op;
+	return op_p->simmediate;
+}
+
+/*
+ * Add a number of bytes to the given instruction pointer
+ * Params:	ip	Instruction pointer
+ *		delta	Number of bytes to add
+ * Returns:	The sum of ip and delta, as an opcode_t *.
+ */
+static inline reg_t ip_add(reg_t ip, pc_offset_t delta)
+{
+	return ip + delta;
+}
+
+/*
+ * Compute the location of the next instruction.
+ * Params:	ip	Pointer to the current instruction
+ * Returns:	Pointer to the next instruction.
+ */
+static inline reg_t ip_next(reg_t ip)
+{
+	return ip_add(ip, OPCODE_SIZE);
+}
+
+/*
+ * Compute the location of the previous instruction.
+ * Params:	ip	Pointer to the current instruction
+ * Returns:	Pointer to the previous instruction.
+ */
+static inline reg_t ip_prev(reg_t ip)
+{
+	return ip_add(ip, -OPCODE_SIZE);
+}
+
+extern int is_basic_block_end(opcode_t op);
+extern void simple_backtrace_clear_saved(struct simple_bt *bt);
+extern void simple_backtrace_init(struct simple_bt *bt,
+	const struct simple_bt_config *config);
+extern int simple_backtrace_first(struct simple_bt *bt);
+extern int simple_backtrace_next(struct simple_bt *bt);
+extern int simple_backtrace_analyze_frame(struct simple_bt *bt);
+extern int simple_backtrace_pop_frame(struct simple_bt *bt);
+#endif	/* _SIMPLE_BACKTRACE_H_ */
diff -urN linux-2.6.25.1/include/asm-mips/stacktrace.h 
linux-t/include/asm-mips/stacktrace.h
--- linux-2.6.25.1/include/asm-mips/stacktrace.h	2008-05-01 
14:45:25.000000000 -0700
+++ linux-t/include/asm-mips/stacktrace.h	2008-05-06 17:30:09.000000000 
-0700
@@ -30,18 +30,49 @@
  		".set noat\n\t"
  #ifdef CONFIG_64BIT
  		"1: dla $1, 1b\n\t"
-		"sd $1, %0\n\t"
-		"sd $29, %1\n\t"
-		"sd $31, %2\n\t"
+		"sd $1, %[epc]\n\t"
+		"sd $16, %[s0]\n\t"
+		"sd $17, %[s1]\n\t"
+		"sd $18, %[s2]\n\t"
+		"sd $19, %[s3]\n\t"
+		"sd $20, %[s4]\n\t"
+		"sd $21, %[s5]\n\t"
+		"sd $22, %[s6]\n\t"
+		"sd $23, %[s7]\n\t"
+		"sd $28, %[gp]\n\t"
+		"sd $29, %[sp]\n\t"
+		"sd $30, %[fp]\n\t"
+		"sd $31, %[ra]\n\t"
  #else
  		"1: la $1, 1b\n\t"
-		"sw $1, %0\n\t"
-		"sw $29, %1\n\t"
-		"sw $31, %2\n\t"
+		"sw $1, %[epc]\n\t"
+		"sw $16, %[s0]\n\t"
+		"sw $17, %[s1]\n\t"
+		"sw $18, %[s2]\n\t"
+		"sw $19, %[s3]\n\t"
+		"sw $20, %[s4]\n\t"
+		"sw $21, %[s5]\n\t"
+		"sw $22, %[s6]\n\t"
+		"sw $23, %[s7]\n\t"
+		"sw $28, %[gp]\n\t"
+		"sw $29, %[sp]\n\t"
+		"sw $30, %[fp]\n\t"
+		"sw $31, %[ra]\n\t"
  #endif
  		".set pop\n\t"
-		: "=m" (regs->cp0_epc),
-		"=m" (regs->regs[29]), "=m" (regs->regs[31])
+		: [epc] "=m" (regs->cp0_epc),
+		  [s0] "=m" (regs->regs[16]),
+		  [s1] "=m" (regs->regs[17]),
+		  [s2] "=m" (regs->regs[18]),
+		  [s3] "=m" (regs->regs[19]),
+		  [s4] "=m" (regs->regs[20]),
+		  [s5] "=m" (regs->regs[21]),
+		  [s6] "=m" (regs->regs[22]),
+		  [s7] "=m" (regs->regs[23]),
+		  [gp] "=m" (regs->regs[28]),
+		  [sp] "=m" (regs->regs[29]),
+		  [fp] "=m" (regs->regs[30]),
+		  [ra] "=m" (regs->regs[31])
  		: : "memory");
  }

diff -urN linux-2.6.25.1/include/asm-mips/thread-backtrace.h 
linux-t/include/asm-mips/thread-backtrace.h
--- linux-2.6.25.1/include/asm-mips/thread-backtrace.h	1969-12-31 
16:00:00.000000000 -0800
+++ linux-t/include/asm-mips/thread-backtrace.h	2008-05-06 
17:30:09.000000000 -0700
@@ -0,0 +1,229 @@
+/*
+ *				thread-backtrace.h
+ *
+ * Backtrace code for Linux operating system processes. This means that, in
+ * addition to handling the normal ABI-conformant stack frames, it must 
also
+ * handle Linux-specific signal stack frames.
+ *
+ * Copyright (C) 2007  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 
02110-1301  USA
+ */
+
+#ifndef	_THREAD_BACKTRACE_H_
+#define	_THREAD_BACKTRACE_H_
+#include <asm/simple-backtrace.h>
+#include <asm/ptrace.h>
+
+/* Value to be returned by the function that processes each frame to 
indicate
+ * a non-error termination of the backtrace. */
+#define	THREAD_BACKTRACE_END	1
+
+/* Value returned internally by functions called from thread_backtrace to
+ * indicate that the backtrace should terminate. */
+#define THREAD_BACKTRACE_DONE	2
+
+#define	NUM_SIGARGS	4		/* # of signal function arguments */
+
+enum thread_frame_type {
+	THREAD_FRAME_SIMPLE, THREAD_FRAME_SIGNAL, THREAD_FRAME_RT_SIGNAL
+};
+
+/*
+ * This function must be supplied by the caller.
+ *
+ * Get a 64-bit object from memory. This is used by the register values
+ * in a sigframe structure.
+ * Params:	rp		Address of the value.
+ *		reg		Location in which to store the value.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+typedef int (*get_sc_reg_t) (reg_t rp, reg_t *sc_reg);
+
+/*
+ * Configuration information
+ */
+struct thread_bt_config {
+	struct simple_bt_config	simple_config;
+	get_sc_reg_t		get_sc_reg;
+};
+
+/*
+ * Contains register information (s0-s8, sp, pc), the stack frame type and,
+ * if the stack frame type is THREAD_FRAME_SIGNAL or 
THREAD_FRAME_RT_SIGNAL,
+ * the arguments to the signal handler.
+ */
+struct thread_bt {
+	struct simple_bt	sbt;
+	const struct thread_bt_config	*config;
+	enum thread_frame_type	type;
+	reg_t			sigargs [NUM_SIGARGS]; /* Arguments to */
+					/* the signal handler */
+	/* Protected */
+	int			pc_is_return_address; /* If non-zero, the */
+					/* $pc value is the address saved */
+					/* by a jalr instruction, and thus */
+					/* should be decremented by two times */
+					/* OPCODE_SIZE to point to the jalr */
+};
+
+/*
+ * This is the function that thread_backtrace will call for each frame that
+ * it finds. It can terminate the backtrace by returning 
THREAD_BACKTRACE_END,
+ * which be treated as a normal termination, or a negative errno value. 
Negative
+ * errno values will be, in turn, returned by thread_backtrace to its 
caller.
+ * then be returned by thread_backtrace.
+ * Params:	arg	Value passed to thread_backtrace.
+ *		bt	Pointer to the struct thread_bt object for the curent
+ *			stack frame.
+ * Returns:	Zero if the backtrace should continue, non-zero if the 
backtrace
+ *		should terminate. If the backtrace is terminating because an
+ *		error occurred, it should return a negative errno value. If the
+ *		backtrace is terminating because this function has reach the
+ *		end of the backtrace, it should return the positive value
+ *		THREAD_BACKTRACE_END.
+ */
+typedef	int (*process_thread_frame_t) (void *arg, struct thread_bt *bt);
+
+/* Store the given register. Assumes that $at points to the location
+ * for the store. This is the 32-bit version. */
+#define	STORE_REG(reg)	"sw	" #reg ",0($at)\n"
+
+/* Initialize the given struct thread_bt object that will be used in a call
+ * to thread_next_frame from the current function, or a function called 
by the
+ * current function. This should be the first thing in the function so that
+ * the values of the registers are not altered from their values on 
entry to
+ * the function. */
+#define	thread_backtrace_init_here(bt, config)	do {			\
+		/* First, store $sp. Note that we use $at to do this */	\
+		__asm__ __volatile__ (					\
+			"	.set	noat\n"				\
+			"	la	$at,%[sp]\n"	/* SP */	\
+				STORE_REG($sp)				\
+		:	[sp] "=m" ((bt)->sbt.gprs [REG_SP])		\
+		:							\
+		:	"at"						\
+		);							\
+		__asm__ __volatile__ (					\
+			"	la	$at,%[v0]\n"	/* V0 */	\
+				STORE_REG($2)				\
+			"	la	$at,%[v1]\n"	/* V1 */	\
+				STORE_REG($3)				\
+									\
+			"	la	$at,%[a0]\n"	/* A0 */	\
+				STORE_REG($4)				\
+			"	la	$at,%[a1]\n"	/* A1 */	\
+				STORE_REG($5)				\
+			"	la	$at,%[a2]\n"	/* A2 */	\
+				STORE_REG($6)				\
+			"	la	$at,%[a3]\n"	/* A3 */	\
+				STORE_REG($7)				\
+									\
+			"	la	$at,%[t0]\n"	/* T0 */	\
+				STORE_REG($8)				\
+			"	la	$at,%[t1]\n"	/* T1 */	\
+				STORE_REG($9)				\
+			"	la	$at,%[t2]\n"	/* T2 */	\
+				STORE_REG($10)				\
+			"	la	$at,%[t3]\n"	/* T3 */	\
+				STORE_REG($11)				\
+			"	la	$at,%[t4]\n"	/* T4 */	\
+				STORE_REG($12)				\
+			"	la	$at,%[t5]\n"	/* T5 */	\
+				STORE_REG($13)				\
+			"	la	$at,%[t6]\n"	/* T6 */	\
+				STORE_REG($14)				\
+			"	la	$at,%[t7]\n"	/* T7 */	\
+				STORE_REG($15)				\
+									\
+			"	la	$at,%[s0]\n"	/* S0 */	\
+				STORE_REG($16)				\
+			"	la	$at,%[s1]\n"	/* S1 */	\
+				STORE_REG($17)				\
+			"	la	$at,%[s2]\n"	/* S2 */	\
+				STORE_REG($18)				\
+			"	la	$at,%[s3]\n"	/* S3 */	\
+				STORE_REG($19)				\
+			"	la	$at,%[s4]\n"	/* S4 */	\
+				STORE_REG($20)				\
+			"	la	$at,%[s5]\n"	/* S5 */	\
+				STORE_REG($21)				\
+			"	la	$at,%[s6]\n"	/* S6 */	\
+				STORE_REG($22)				\
+			"	la	$at,%[s7]\n"	/* S7 */	\
+				STORE_REG($23)				\
+									\
+			"	la	$at,%[t8]\n"	/* T8 */	\
+				STORE_REG($24)				\
+			"	la	$at,%[t9]\n"	/* T9 */	\
+				STORE_REG($25)				\
+									\
+			"	la	$at,%[k0]\n"	/* K0 */	\
+				STORE_REG($26)				\
+			"	la	$at,%[k1]\n"	/* K1 */	\
+				STORE_REG($27)				\
+									\
+			"	la	$at,%[gp]\n"	/* GP */	\
+				STORE_REG($gp)				\
+			"	la	$at,%[s8]\n"	/* FP/S8 */	\
+				STORE_REG($fp)				\
+			"	la	$at,%[ra]\n"	/* RA */	\
+				STORE_REG($ra)				\
+		:	[v0] "=m" ((bt)->sbt.gprs [REG_V0]),		\
+			[v1] "=m" ((bt)->sbt.gprs [REG_V1]),		\
+			[a0] "=m" ((bt)->sbt.gprs [REG_A0]),		\
+			[a1] "=m" ((bt)->sbt.gprs [REG_A1]),		\
+			[a2] "=m" ((bt)->sbt.gprs [REG_A2]),		\
+			[a3] "=m" ((bt)->sbt.gprs [REG_A3]),		\
+			[t0] "=m" ((bt)->sbt.gprs [REG_T0]),		\
+			[t1] "=m" ((bt)->sbt.gprs [REG_T1]),		\
+			[t2] "=m" ((bt)->sbt.gprs [REG_T2]),		\
+			[t3] "=m" ((bt)->sbt.gprs [REG_T3]),		\
+			[t4] "=m" ((bt)->sbt.gprs [REG_T4]),		\
+			[t5] "=m" ((bt)->sbt.gprs [REG_T5]),		\
+			[t6] "=m" ((bt)->sbt.gprs [REG_T6]),		\
+			[t7] "=m" ((bt)->sbt.gprs [REG_T7]),		\
+			[s0] "=m" ((bt)->sbt.gprs [REG_S0]),		\
+			[s1] "=m" ((bt)->sbt.gprs [REG_S1]),		\
+			[s2] "=m" ((bt)->sbt.gprs [REG_S2]),		\
+			[s3] "=m" ((bt)->sbt.gprs [REG_S3]),		\
+			[s4] "=m" ((bt)->sbt.gprs [REG_S4]),		\
+			[s5] "=m" ((bt)->sbt.gprs [REG_S5]),		\
+			[s6] "=m" ((bt)->sbt.gprs [REG_S6]),		\
+			[s7] "=m" ((bt)->sbt.gprs [REG_S7]),		\
+			[t8] "=m" ((bt)->sbt.gprs [REG_T8]),		\
+			[t9] "=m" ((bt)->sbt.gprs [REG_T9]),		\
+			[k0] "=m" ((bt)->sbt.gprs [REG_K0]),		\
+			[k1] "=m" ((bt)->sbt.gprs [REG_K1]),		\
+			[gp] "=m" ((bt)->sbt.gprs [REG_GP]),		\
+			[s8] "=m" ((bt)->sbt.gprs [REG_S8]),		\
+			[ra] "=m" ((bt)->sbt.gprs [REG_RA])		\
+		:							\
+		: "at"							\
+		);							\
+		thread_backtrace_init(bt, config);			\
+		(bt)->sbt.pc = thread_backtrace_here();			\
+	} while (0)
+
+extern int thread_backtrace(process_thread_frame_t process, void *arg,
+	const struct thread_bt_config *config);
+extern void thread_backtrace_init(struct thread_bt *bt,
+	const struct thread_bt_config *config);
+extern reg_t thread_backtrace_here(void);
+extern int thread_backtrace_first(struct thread_bt *bt);
+extern int thread_backtrace_next(struct thread_bt *bt);
+extern int thread_backtrace_pop_frame(struct thread_bt *bt);
+extern int thread_backtrace_analyze_frame(struct thread_bt *bt);
+#endif	/* _THREAD_BACKTRACE_H_ */
