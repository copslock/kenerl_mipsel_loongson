Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 10:34:36 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:14572 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225404AbSLSKef>;
	Thu, 19 Dec 2002 10:34:35 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id B9A12D657; Thu, 19 Dec 2002 11:40:38 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: unaligned
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 19 Dec 2002 11:40:38 +0100
Message-ID: <m27ke6mgux.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        - asm wants a unsigned long
        - verify_area wants a void *
one of the two places need a cast.

Once there, ralf? forgot that emulate_load_store returns void, then
nuke the return 1 part.

Later, Juan.


Index: arch/mips/kernel/unaligned.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/unaligned.c,v
retrieving revision 1.15.2.11
diff -u -r1.15.2.11 unaligned.c
--- arch/mips/kernel/unaligned.c	17 Dec 2002 23:20:08 -0000	1.15.2.11
+++ arch/mips/kernel/unaligned.c	19 Dec 2002 10:17:48 -0000
@@ -139,7 +139,7 @@
 	 * The remaining opcodes are the ones that are really of interest.
 	 */
 	case lh_op:
-		if (verify_area(VERIFY_READ, addr, 2))
+		if (verify_area(VERIFY_READ, (void *)addr, 2))
 			goto sigbus;
 
 		__asm__(".set\tnoat\n"
@@ -171,7 +171,7 @@
 		break;
 
 	case lw_op:
-		if (verify_area(VERIFY_READ, addr, 4))
+		if (verify_area(VERIFY_READ, (void *)addr, 4))
 			goto sigbus;
 
 		__asm__(
@@ -200,7 +200,7 @@
 		break;
 
 	case lhu_op:
-		if (verify_area(VERIFY_READ, addr, 2))
+		if (verify_area(VERIFY_READ, (void *)addr, 2))
 			goto sigbus;
 
 		__asm__(
@@ -241,7 +241,7 @@
 		 * would blow up, so for now we don't handle unaligned 64-bit
 		 * instructions on 32-bit kernels.
 		 */
-		if (verify_area(VERIFY_READ, addr, 4))
+		if (verify_area(VERIFY_READ, (void *)addr, 4))
 			goto sigbus;
 
 		__asm__(
@@ -284,7 +284,7 @@
 		 * would blow up, so for now we don't handle unaligned 64-bit
 		 * instructions on 32-bit kernels.
 		 */
-		if (verify_area(VERIFY_READ, addr, 8))
+		if (verify_area(VERIFY_READ, (void *)addr, 8))
 			goto sigbus;
 
 		__asm__(
@@ -317,7 +317,7 @@
 		goto sigill;
 
 	case sh_op:
-		if (verify_area(VERIFY_WRITE, addr, 2))
+		if (verify_area(VERIFY_WRITE, (void *)addr, 2))
 			goto sigbus;
 
 		value = regs->regs[insn.i_format.rt];
@@ -353,7 +353,7 @@
 		break;
 
 	case sw_op:
-		if (verify_area(VERIFY_WRITE, addr, 4))
+		if (verify_area(VERIFY_WRITE, (void *)addr, 4))
 			goto sigbus;
 
 		value = regs->regs[insn.i_format.rt];
@@ -391,7 +391,7 @@
 		 * would blow up, so for now we don't handle unaligned 64-bit
 		 * instructions on 32-bit kernels.
 		 */
-		if (verify_area(VERIFY_WRITE, addr, 8))
+		if (verify_area(VERIFY_WRITE, (void *)addr, 8))
 			goto sigbus;
 
 		value = regs->regs[insn.i_format.rt];
@@ -469,7 +469,7 @@
 		printk(KERN_DEBUG "%s: Forwarding exception at [<%lx>] (%lx)\n",
 		       current->comm, regs->cp0_epc, new_epc);
 		regs->cp0_epc = new_epc;
-		return 1;
+		return;
 	}
 
 	die_if_kernel ("Unhandled kernel unaligned access", regs);


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
