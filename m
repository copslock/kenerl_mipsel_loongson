Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2002 17:06:34 +0200 (CEST)
Received: from web10404.mail.yahoo.com ([216.136.130.96]:19811 "HELO
	web10404.mail.yahoo.com") by linux-mips.org with SMTP
	id <S1123907AbSJAPGe>; Tue, 1 Oct 2002 17:06:34 +0200
Message-ID: <20021001150625.51995.qmail@web10404.mail.yahoo.com>
Received: from [159.134.216.102] by web10404.mail.yahoo.com via HTTP; Tue, 01 Oct 2002 08:06:25 PDT
Date: Tue, 1 Oct 2002 08:06:25 -0700 (PDT)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Subject: Fwd: mips unaligned.c bugfix
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1906408386-1033484785=:51138"
Return-Path: <barrow_dj@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: barrow_dj@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-1906408386-1033484785=:51138
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I was advised by Jon Burgess to forward the fix to this mailing
list as well Ralf Baechle said he would look at the fix.

--- "D.J. Barrow" <barrow_dj@yahoo.com> wrote:
> Date: Fri, 27 Sep 2002 09:26:01 -0700 (PDT)
> From: "D.J. Barrow" <barrow_dj@yahoo.com>
> Subject: mips unaligned.c bugfix
> To: Kernel Mailing List <linux-kernel@vger.kernel.org>, 
>     Ralf Baechle <ralf@uni-koblenz.de>
> 
> Hi Ralf & others,
> 
> I found & fixed kernel bug in unaligned.c which was affecting the iptables code 
> in little mips32 endian.
> 
> The patch is against 2.4.17 on oss.sgi.com & should hopefully apply to the latest
> kernel.
> 
> The fixes code for I did mips 64 is untested, I had no way to test them unfortunately.
> 
> An example of the bug is the bug following sequence of mips instructions
> beqz        v0,<destaddr>
> lw          v0,(t3) 
> 
> say reg t3 points to an unaligned address
> 
> In the emulation the v0 register was being loaded & modified before
> the computation of the destination address ( which depended on v0 ) 
> this was incorrect so I had to save the updating of the v0 register
> until the computation of the destination address was done.
> 
> =====
> D.J. Barrow Linux kernel developer
> eMail: dj_barrow@ariasoft.ie 
> Home: +353-22-47196.
> Work: +353-91-758353
> 
> __________________________________________________
> Do you Yahoo!?
> New DSL Internet Access from SBC & Yahoo!
> http://sbc.yahoo.com

> ATTACHMENT part 2 application/x-unknown name=unaligned.diff




=====
D.J. Barrow Linux kernel developer
eMail: dj_barrow@ariasoft.ie 
Home: +353-22-47196.
Apt till end Oct 2002: +353-91-533628

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
--0-1906408386-1033484785=:51138
Content-Type: text/plain; name="unaligned.diff"
Content-Description: unaligned.diff
Content-Disposition: inline; filename="unaligned.diff"

--- kernel.orig/arch/mips/kernel/unaligned.c	Tue Jan 15 04:08:09 2002
+++ kernel/arch/mips/kernel/unaligned.c	Fri Sep 27 16:58:22 2002
@@ -8,6 +8,11 @@
  * Copyright (C) 1996, 1998 by Ralf Baechle
  * Copyright (C) 1999 Silicon Graphics, Inc.
  *
+ * Fixes: 
+ *          2002 Denis Joseph Barrow <dj_barrow@ariasoft.ie>
+ *          Fix to do_ade to compute destination addresses correctly 
+ *          after fixing delay slot instructions.
+ * 
  * This file contains exception handler for address error exception with the
  * special capability to execute faulting instructions in software.  The
  * handler does not try to handle the case when the program counter points
@@ -97,13 +102,15 @@
 		goto sigbus;
 
 static inline int emulate_load_store_insn(struct pt_regs *regs,
-	unsigned long addr, unsigned long pc)
+	unsigned long addr, unsigned long pc,
+	unsigned long **regptr,unsigned long *newvalue)
 {
 	union mips_instruction insn;
 	unsigned long value, fixup;
 	unsigned int res;
 
 	regs->regs[0] = 0;
+	*regptr=NULL;
 	/*
 	 * This load never faults.
 	 */
@@ -169,7 +176,8 @@
 			: "r" (addr), "i" (-EFAULT));
 		if (res)
 			goto fault;
-		regs->regs[insn.i_format.rt] = value;
+		*newvalue=value;
+		*regptr=&regs->regs[insn.i_format.rt];
 		return 0;
 
 	case lw_op:
@@ -196,7 +204,8 @@
 			: "r" (addr), "i" (-EFAULT));
 		if (res)
 			goto fault;
-		regs->regs[insn.i_format.rt] = value;
+		*newvalue=value;
+		*regptr=&regs->regs[insn.i_format.rt];
 		return 0;
 
 	case lhu_op:
@@ -227,7 +236,8 @@
 			: "r" (addr), "i" (-EFAULT));
 		if (res)
 			goto fault;
-		regs->regs[insn.i_format.rt] = value;
+		*newvalue=value;
+		*regptr=&regs->regs[insn.i_format.rt];
 		return 0;
 
 	case lwu_op:
@@ -365,7 +375,7 @@
 
 asmlinkage void do_ade(struct pt_regs *regs)
 {
-	unsigned long pc;
+	unsigned long pc,*regptr,newval;
 	extern int do_dsemulret(struct pt_regs *);
 
 	/* 
@@ -395,9 +405,18 @@
 	 * Do branch emulation only if we didn't forward the exception.
 	 * This is all so but ugly ...
 	 */
-	if (!emulate_load_store_insn(regs, regs->cp0_badvaddr, pc))
+	if (!emulate_load_store_insn(regs, regs->cp0_badvaddr, pc,&regptr,&newval))
+	{
 		compute_return_epc(regs);
-
+                /* We need use the regptr complication for delay slot instructions 
+                 * which can miscompute destination addresses
+                 * e.g. consider the sequence 
+                 * beqz        v0,<destaddr>
+                 * lw          v0,(t3) 
+                 */ 
+		if(regptr)
+			*regptr=newval;
+	}
 #ifdef CONFIG_PROC_FS
 	unaligned_instructions++;
 #endif
--- kernel.orig/arch/mips64/kernel/unaligned.c	Sat Jan 26 07:28:35 2002
+++ kernel/arch/mips64/kernel/unaligned.c	Fri Sep 27 17:09:28 2002
@@ -8,6 +8,11 @@
  * Copyright (C) 1996, 1998, 1999 by Ralf Baechle
  * Copyright (C) 1999 Silicon Graphics, Inc.
  *
+ * Fixes: 
+ *          2002 Denis Joseph Barrow <dj_barrow@ariasoft.ie>
+ *          Fix to do_ade to compute destination addresses correctly 
+ *          after fixing delay slot instructions.
+ * 
  * This file contains exception handler for address error exception with the
  * special capability to execute faulting instructions in software.  The
  * handler does not try to handle the case when the program counter points
@@ -97,12 +102,14 @@
 		goto sigbus;
 
 static inline int emulate_load_store_insn(struct pt_regs *regs,
-	unsigned long addr, unsigned long pc)
+	unsigned long addr, unsigned long pc,
+ 	unsigned long **regptr,unsigned long *newvalue)
 {
 	union mips_instruction insn;
 	unsigned long value, fixup;
 
 	regs->regs[0] = 0;
+	*regptr=NULL;
 	/*
 	 * This load never faults.
 	 */
@@ -162,7 +169,8 @@
 			".previous"
 			:"=&r" (value)
 			:"r" (addr), "i" (&&fault));
-		regs->regs[insn.i_format.rt] = value;
+ 		*newvalue=value;
+ 		*regptr=&regs->regs[insn.i_format.rt];
 		return 0;
 
 	case lw_op:
@@ -182,8 +190,9 @@
 			".previous"
 			:"=&r" (value)
 			:"r" (addr), "i" (&&fault));
-			regs->regs[insn.i_format.rt] = value;
-			return 0;
+ 		*newvalue=value;
+ 		*regptr=&regs->regs[insn.i_format.rt];
+		return 0;
 
 	case lhu_op:
 		check_axs(pc, addr, 2);
@@ -206,7 +215,8 @@
 			".previous"
 			:"=&r" (value)
 			:"r" (addr), "i" (&&fault));
-		regs->regs[insn.i_format.rt] = value;
+ 		*newvalue=value;
+ 		*regptr=&regs->regs[insn.i_format.rt];
 		return 0;
 
 	case lwu_op:
@@ -227,7 +237,8 @@
 			:"=&r" (value)
 			:"r" (addr), "i" (&&fault));
 		value &= 0xffffffff;
-		regs->regs[insn.i_format.rt] = value;
+		*newvalue=value;
+ 		*regptr=&regs->regs[insn.i_format.rt];
 		return 0;
 
 	case ld_op:
@@ -249,7 +260,8 @@
 			".previous"
 			:"=&r" (value)
 			:"r" (addr), "i" (&&fault));
-		regs->regs[insn.i_format.rt] = value;
+ 		*newvalue=value;
+ 		*regptr=&regs->regs[insn.i_format.rt];
 		return 0;
 
 	case sh_op:
@@ -398,9 +410,18 @@
 	 * Do branch emulation only if we didn't forward the exception.
 	 * This is all so but ugly ...
 	 */
-	if (!emulate_load_store_insn(regs, regs->cp0_badvaddr, pc))
+	if (!emulate_load_store_insn(regs, regs->cp0_badvaddr, pc,&regptr,&newval))
+	{
 		compute_return_epc(regs);
-
+                /* We need use the regptr complication for delay slot instructions 
+                 * which can miscompute destination addresses
+                 * e.g. consider the sequence 
+                 * beqz        v0,<destaddr>
+                 * lw          v0,(t3) 
+                 */ 
+		if(regptr)
+			*regptr=newval;
+	}
 #ifdef CONFIG_PROC_FS
 	unaligned_instructions++;
 #endif










--0-1906408386-1033484785=:51138--
