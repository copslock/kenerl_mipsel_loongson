Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Oct 2002 10:06:04 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:3791 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123398AbSJUIGE>;
	Mon, 21 Oct 2002 10:06:04 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g9L85rNf022881;
	Mon, 21 Oct 2002 01:05:53 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA26210;
	Mon, 21 Oct 2002 01:06:42 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g9L85sb04966;
	Mon, 21 Oct 2002 10:05:55 +0200 (MEST)
Message-ID: <3DB3B562.2083ADE9@mips.com>
Date: Mon, 21 Oct 2002 10:05:54 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: get_insn_opcode broken in the 64-bit kernel
Content-Type: multipart/mixed;
 boundary="------------29DB5335C8E5A533037676ED"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------29DB5335C8E5A533037676ED
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

The get_insn_opcode is broken in the 64-bit kernel, the patch below fix
the problem.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------29DB5335C8E5A533037676ED
Content-Type: text/plain; charset=iso-8859-15;
 name="get_insn_opcode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="get_insn_opcode.patch"

Index: arch/mips64/kernel/traps.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/traps.c,v
retrieving revision 1.30.2.33
diff -u -r1.30.2.33 traps.c
--- arch/mips64/kernel/traps.c	2 Oct 2002 14:45:46 -0000	1.30.2.33
+++ arch/mips64/kernel/traps.c	21 Oct 2002 08:03:45 -0000
@@ -463,11 +463,11 @@
 
 static inline int get_insn_opcode(struct pt_regs *regs, unsigned int *opcode)
 {
-	unsigned long *epc;
+	unsigned int *epc;
 
-	epc = (unsigned long *) regs->cp0_epc +
+	epc = (unsigned int *) regs->cp0_epc +
 	      ((regs->cp0_cause & CAUSEF_BD) != 0);
-	if (!get_user(opcode, epc))
+	if (!get_user(*opcode, epc))
 		return 0;
 
 	force_sig(SIGSEGV, current);

--------------29DB5335C8E5A533037676ED--
