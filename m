Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2003 14:54:01 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:4997 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224861AbTEWNx7>;
	Fri, 23 May 2003 14:53:59 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h4NDrjLT006185;
	Fri, 23 May 2003 15:53:45 +0200 (MEST)
Date: Fri, 23 May 2003 15:53:50 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: [PATCH] Vr41xx unaligned access update
Message-ID: <Pine.GSO.4.21.0305231553070.26586-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

	Hi Ralf,

Update fix for some (Vr41xx?) CPUs, where if an unaligned access happens in a
branch delay slot and the branch is not taken, EPC may point at the branch
instruction while the BD bit in the cause register is not set:
  - Remove tests for unconditional jumps, since they are always taken
  - Add test for a branch in a branch delay slot

--- linux-mips-2.4.x/arch/mips/kernel/unaligned.c	Mon May  5 16:23:43 2003
+++ linux/arch/mips/kernel/unaligned.c	Tue May  6 14:24:56 2003
@@ -99,6 +99,7 @@
 	union mips_instruction insn;
 	unsigned long value, fixup;
 	unsigned int res;
+	int branch = 0;
 
 	regs->regs[0] = 0;
 	*regptr=NULL;
@@ -145,8 +146,6 @@
 	 * but the BD bit in the cause register is not set.
 	 */
 	case bcond_op:
-	case j_op:
-	case jal_op:
 	case beq_op:
 	case bne_op:
 	case blez_op:
@@ -155,7 +154,11 @@
 	case bnel_op:
 	case blezl_op:
 	case bgtzl_op:
-	case jalx_op:
+		if (branch) {
+		    /* branch in a branch delay slot */
+		    goto sigill;
+		}
+		branch = 1;
 		pc += 4;
 		goto retry;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
