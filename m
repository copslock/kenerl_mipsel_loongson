Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2003 18:04:55 +0000 (GMT)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:37536 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8226369AbTAMSEy>;
	Mon, 13 Jan 2003 18:04:54 +0000
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id TAA00817;
	Mon, 13 Jan 2003 19:04:35 +0100 (MET)
Date: Mon, 13 Jan 2003 19:04:36 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Mike Uhler <uhler@mips.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: unaligned load in branch delay slot 
In-Reply-To: <200301131719.h0DHJkG29389@uhler-linux.mips.com>
Message-ID: <Pine.GSO.4.21.0301131901500.21279-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 13 Jan 2003, Mike Uhler wrote:
> > If I print the parameters at label `sigill' in emulate_load_store_insn(), I
> > get:
> > 
> >     pc 0x80346448 addr 0x83d9f81e ins 0x14600012
> > 
> > And emulate_load_store_insn() gets confused because 0x14600012 is not a
> > load/store. 0x14600012 is the branch instruction before the load, not the load
> > after the branch instruction! Note that bit 31 of cause (CAUSEF_BD) is not set.
> > Some more investigations showed that the branch is indeed not taken.
> > 
> > Apparently if an unaligned access happens right after a branch which is not
> > taking, epc points to the branch instruction, and CAUSEF_BD is not set
> > (technically speaking, this is not a branch delay, since the branch is not
> > taken :-). Is this expected behavior? The CPU is a VR4120A core.
> > 
> > As a workaround, I assume I can just test whether pc points to a branch
> > instruction, and increment pc if that's the case?
> 
> Prior to the MIPS32/MIPS64 architecture definition, which requires that EPC
> point at the branch and the Cause[BD] bit be set on any exception in the
> branch delay slot, there were a few CPUs which interpreted the rules in the
> manner that you describe.  I don't happen to have a VR4120A manual in front
> of me, but the behavior you describe could easily be the case of this differnt
> interpretation.

Thanks!

The following patch (against linux-mips-2.4.x CVS) cures my crash.

I don't know on which CPUs this may happen (need #ifdef CONFIG_CPU_VR41XX?),
nor whether all branch and jump instructions are affected (I included
everything that starts with a `b' or `j').

Index: arch/mips/kernel/unaligned.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/unaligned.c,v
retrieving revision 1.15.2.14
diff -u -r1.15.2.14 unaligned.c
--- arch/mips/kernel/unaligned.c	6 Jan 2003 22:05:25 -0000	1.15.2.14
+++ arch/mips/kernel/unaligned.c	13 Jan 2003 18:01:26 -0000
@@ -103,6 +103,7 @@
 	/*
 	 * This load never faults.
 	 */
+retry:
 	__get_user(insn.word, (unsigned int *)pc);
 
 	switch (insn.i_format.opcode) {
@@ -134,6 +135,26 @@
 	case lbu_op:
 	case sb_op:
 		goto sigbus;
+
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
+		pc += 4;
+		goto retry;
 
 	/*
 	 * The remaining opcodes are the ones that are really of interest.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
