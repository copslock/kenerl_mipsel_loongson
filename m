Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 15:19:00 +0100 (BST)
Received: from real.realitydiluted.com ([IPv6:::ffff:208.242.241.164]:15781
	"EHLO real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225552AbTJIOS4>; Thu, 9 Oct 2003 15:18:56 +0100
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1A7bcT-0004b1-00; Thu, 09 Oct 2003 09:18:21 -0500
Message-ID: <3F856E29.9040007@realitydiluted.com>
Date: Thu, 09 Oct 2003 10:18:17 -0400
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@linux-mips.org
Subject: Re: [PATCH] Toshiba RBTX4927 NMI handling code....
References: <3F846FA3.6090208@realitydiluted.com> <20031008141808.H3887@mvista.com>
In-Reply-To: <20031008141808.H3887@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------090202090506040008030206"
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090202090506040008030206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hey Jun.

Thanks for your input on this. Updated code has been applied
to CVS. The new patch is also attached just for record.

-Steve

--------------090202090506040008030206
Content-Type: text/plain;
 name="rbtx4927-nmi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rbtx4927-nmi.patch"

? big.diff
? rbtx4927-nmi.patch
Index: arch/mips/kernel/traps.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/traps.c,v
retrieving revision 1.99.2.57
diff -u -r1.99.2.57 traps.c
--- arch/mips/kernel/traps.c	10 Sep 2003 10:09:47 -0000	1.99.2.57
+++ arch/mips/kernel/traps.c	9 Oct 2003 14:12:23 -0000
@@ -63,6 +63,7 @@
 
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
+void (*board_nmi_handler_setup)(void) = NULL;
 
 int kstack_depth_to_print = 24;
 
@@ -1008,6 +1009,9 @@
 		save_fp_context = fpu_emulator_save_context;
 		restore_fp_context = fpu_emulator_restore_context;
 	}
+
+	if (board_nmi_handler_setup)
+		board_nmi_handler_setup();
 
 	flush_icache_range(KSEG0, KSEG0 + 0x400);
 
Index: arch/mips/tx4927/toshiba_rbtx4927/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/tx4927/toshiba_rbtx4927/Makefile,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 Makefile
--- arch/mips/tx4927/toshiba_rbtx4927/Makefile	11 Apr 2003 17:26:20 -0000	1.1.2.1
+++ arch/mips/tx4927/toshiba_rbtx4927/Makefile	9 Oct 2003 14:12:23 -0000
@@ -13,6 +13,7 @@
 obj-y	+= toshiba_rbtx4927_prom.o 
 obj-y	+= toshiba_rbtx4927_setup.o 
 obj-y	+= toshiba_rbtx4927_irq.o 
+obj-y	+= toshiba_rbtx4927_nmi.o 
 
 obj-$(CONFIG_PCI)	+= toshiba_rbtx4927_pci_fixup.o 
 obj-$(CONFIG_PCI)	+= toshiba_rbtx4927_pci_ops.o 
Index: arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_nmi.S
===================================================================
RCS file: arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_nmi.S
diff -N arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_nmi.S
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_nmi.S	9 Oct 2003 14:12:23 -0000
@@ -0,0 +1,46 @@
+/*
+ * linux/arch/mips/tx4927/toshiba_rbtx4927/tx4927_irq_handler.S
+ *
+ * NMI handler for Toshiba RBTX4927 board
+ *
+ * Copyright (C) 2003 TimeSys Corp.
+ *                    S. James Hill (James.Hill@timesys.com)
+ *                                  (sjhill@realitydiluted.com)
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+
+		.align	5
+		.set noat
+		NESTED(tx4927_nmi_handler, PT_SIZE, sp)
+		SAVE_ALL
+		CLI
+		.set at
+		mfc0	k0, CP0_STATUS
+		lui	k1, 0x50		/* Clear BEV and NMI */
+		nor	k1, zero, k1
+		and	k0, k1
+		mtc0	k0, CP0_STATUS
+		move	a0, sp
+		jal	toshiba_rbtx4927_nmi
+		END(tx4927_nmi_handler)
Index: arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c,v
retrieving revision 1.1.2.5
diff -u -r1.1.2.5 toshiba_rbtx4927_setup.c
--- arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c	25 Aug 2003 16:14:53 -0000	1.1.2.5
+++ arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c	9 Oct 2003 14:12:23 -0000
@@ -907,8 +907,47 @@
 	/* no return */
 }
 
+void toshiba_rbtx4927_nmi (struct pt_regs *regs)
+{
+	extern void show_code(unsigned int *pc);
+	extern void show_runqueue(void);
+	extern void show_stack(unsigned int *sp);
+	extern void show_state_nolock(void);
+	extern void show_trace(unsigned long *sp, unsigned int *ra,
+			       unsigned int *pc);
+
+	bust_spinlocks(1);
+	printk("\ncurrent = %d:%s\n",current->pid,current->comm);
+	show_regs(regs);
+	printk("Process %s (pid: %d, stackpage=%08lx)\n",
+		current->comm, current->pid, (unsigned long) current);
+	show_stack((unsigned int *)regs->regs[29]);
+	show_trace((unsigned long *)regs->regs[29], 
+	           (unsigned int *)regs->regs[31],
+	           (unsigned int *)regs->cp0_epc);
+	show_code((unsigned int *)regs->cp0_epc);
+	bust_spinlocks(0);
+}
+
+void toshiba_rbtx4927_nmi_handler_setup (void)
+{
+	extern void tx4927_nmi_handler (void);
+	unsigned long vec[2];
+
+	vec[0] = 0x08000000 |
+			(0x03ffffff & ((unsigned long)tx4927_nmi_handler >> 2));
+	vec[1] = 0;
+
+	/*
+	 * Our firmware (PMON in this case) has a NMI hook that
+	 * jumps to 0x80000220. We locate our NMI handler there.
+	 */
+	memcpy((void *)(KSEG0 + 0x220), &vec, 0x8);
+}
+
 void __init toshiba_rbtx4927_setup(void)
 {
+	extern void (*board_nmi_handler_setup)(void);
 	vu32 cp0_config;
 
 	printk("CPU is %s\n", toshiba_name);
@@ -927,6 +966,9 @@
 	cp0_config = read_c0_config();
 	cp0_config = cp0_config & ~(TX49_CONF_IC | TX49_CONF_DC);
 	write_c0_config(cp0_config);
+
+	/* set up the NMI handler */
+	board_nmi_handler_setup = toshiba_rbtx4927_nmi_handler_setup;
 
 #ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
 	{

--------------090202090506040008030206--
