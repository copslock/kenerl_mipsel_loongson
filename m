Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jun 2004 14:46:41 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:55760 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225285AbUF1Nqf>; Mon, 28 Jun 2004 14:46:35 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 5E230474C5; Mon, 28 Jun 2004 15:46:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 47A4545837; Mon, 28 Jun 2004 15:46:29 +0200 (CEST)
Date: Mon, 28 Jun 2004 15:46:29 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: cgd@broadcom.com
Cc: Richard Sandiford <rsandifo@redhat.com>,
	David Daney <ddaney@avtrex.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
In-Reply-To: <yov5eko4okte.fsf@ldt-sj3-010.sj.broadcom.com>
Message-ID: <Pine.LNX.4.55.0406281532530.23162@jurand.ds.pg.gda.pl>
References: <40C9F5A4.2050606@avtrex.com> <40C9F5FE.8030607@avtrex.com>
 <40C9F7F0.50501@avtrex.com> <Pine.LNX.4.55.0406112039040.13062@jurand.ds.pg.gda.pl>
 <mailpost.1086981251.16853@news-sj1-1> <yov57juduc7q.fsf@ldt-sj3-010.sj.broadcom.com>
 <Pine.LNX.4.55.0406222304340.23178@jurand.ds.pg.gda.pl> <87y8mdgryp.fsf@redhat.com>
 <Pine.LNX.4.55.0406242031020.8569@jurand.ds.pg.gda.pl> <mailpost.1088102121.25381@news-sj1-1>
 <yov5eko4okte.fsf@ldt-sj3-010.sj.broadcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 24 Jun 2004 cgd@broadcom.com wrote:

> >  Well, this is essentially what the patch does.  Or do you mean: "drop it
> > and if anyone screams, consider an alternative?"  I'd find it acceptable,
> > actually, but it's not my opinion that really matters here.
> 
> (it's fine w/ me.)

 Here's an updated patch I use currently in case this is the solution to
be agreed upon.

opcodes/:
2004-06-28  Maciej W. Rozycki  <macro@linux-mips.org>

	* mips-opc.c (mips_builtin_opcodes): Remove the MIPS32 
	ISA-specific "break" encoding.

gas/testsuite/:
2004-06-28  Maciej W. Rozycki  <macro@linux-mips.org>

	* gas/mips/mips32.s: Adjust for the unified "break" syntax.
	* gas/mips/set-arch.s: Likewise.
	* gas/mips/mips32.d: Adjust for the new output.
	* gas/mips/set-arch.d: Likewise.

  Maciej

binutils-2.15.91-20040625-mips-break20.patch
diff -up --recursive --new-file binutils-2.15.91-20040625.macro/gas/testsuite/gas/mips/mips32.d binutils-2.15.91-20040625/gas/testsuite/gas/mips/mips32.d
--- binutils-2.15.91-20040625.macro/gas/testsuite/gas/mips/mips32.d	2003-05-08 03:25:35.000000000 +0000
+++ binutils-2.15.91-20040625/gas/testsuite/gas/mips/mips32.d	2004-06-17 21:15:04.000000000 +0000
@@ -48,7 +48,7 @@ Disassembly of section .text:
 0+0098 <[^>]*> 4359e260 	wait	0x56789
 0+009c <[^>]*> 0000000d 	break
 0+00a0 <[^>]*> 0000000d 	break
-0+00a4 <[^>]*> 0048d14d 	break	0x12345
+0+00a4 <[^>]*> 0048d14d 	break	0x48,0x345
 0+00a8 <[^>]*> 7000003f 	sdbbp
 0+00ac <[^>]*> 7000003f 	sdbbp
 0+00b0 <[^>]*> 7159e27f 	sdbbp	0x56789
diff -up --recursive --new-file binutils-2.15.91-20040625.macro/gas/testsuite/gas/mips/mips32.s binutils-2.15.91-20040625/gas/testsuite/gas/mips/mips32.s
--- binutils-2.15.91-20040625.macro/gas/testsuite/gas/mips/mips32.s	2002-09-05 03:25:40.000000000 +0000
+++ binutils-2.15.91-20040625/gas/testsuite/gas/mips/mips32.s	2004-06-26 12:41:17.000000000 +0000
@@ -58,11 +58,13 @@ text_label:
       wait    0                       # disassembles without code
       wait    0x56789
 
-      # Instructions in previous ISAs or CPUs which are now slightly
-      # different.
+      # Instructions that used to have compatibility problems.
       break
       break   0                       # disassembles without code
-      break   0x12345
+      break   0x48,0x345
+
+      # Instructions in previous ISAs or CPUs which are now slightly
+      # different.
       sdbbp
       sdbbp   0                       # disassembles without code
       sdbbp   0x56789
diff -up --recursive --new-file binutils-2.15.91-20040625.macro/gas/testsuite/gas/mips/set-arch.d binutils-2.15.91-20040625/gas/testsuite/gas/mips/set-arch.d
--- binutils-2.15.91-20040625.macro/gas/testsuite/gas/mips/set-arch.d	2003-10-01 03:25:36.000000000 +0000
+++ binutils-2.15.91-20040625/gas/testsuite/gas/mips/set-arch.d	2004-06-17 21:17:46.000000000 +0000
@@ -160,7 +160,7 @@ Disassembly of section \.text:
 00000260 <[^>]*> 4359e260 	wait	0x56789
 00000264 <[^>]*> 0000000d 	break
 00000268 <[^>]*> 0000000d 	break
-0000026c <[^>]*> 0048d14d 	break	0x12345
+0000026c <[^>]*> 0048d14d 	break	0x48,0x345
 00000270 <[^>]*> 7000003f 	sdbbp
 00000274 <[^>]*> 7000003f 	sdbbp
 00000278 <[^>]*> 7159e27f 	sdbbp	0x56789
diff -up --recursive --new-file binutils-2.15.91-20040625.macro/gas/testsuite/gas/mips/set-arch.s binutils-2.15.91-20040625/gas/testsuite/gas/mips/set-arch.s
--- binutils-2.15.91-20040625.macro/gas/testsuite/gas/mips/set-arch.s	2003-06-29 19:41:33.000000000 +0000
+++ binutils-2.15.91-20040625/gas/testsuite/gas/mips/set-arch.s	2004-06-26 12:42:22.000000000 +0000
@@ -200,11 +200,13 @@ text_label:	
 	wait    0                       # disassembles without code
 	wait    0x56789
 
-	# Instructions in previous ISAs or CPUs which are now slightly
-	# different.
+	# Instructions that used to have compatibility problems.
 	break
 	break   0                       # disassembles without code
-	break   0x12345
+	break   0x48,0x345
+
+	# Instructions in previous ISAs or CPUs which are now slightly
+	# different.
 	sdbbp
 	sdbbp   0                       # disassembles without code
 	sdbbp   0x56789
diff -up --recursive --new-file binutils-2.15.91-20040625.macro/opcodes/mips-opc.c binutils-2.15.91-20040625/opcodes/mips-opc.c
--- binutils-2.15.91-20040625.macro/opcodes/mips-opc.c	2003-11-19 04:25:23.000000000 +0000
+++ binutils-2.15.91-20040625/opcodes/mips-opc.c	2004-06-26 12:42:46.000000000 +0000
@@ -274,7 +274,6 @@ const struct mips_opcode mips_builtin_op
 {"bnel",    "s,t,p",	0x54000000, 0xfc000000,	CBL|RD_s|RD_t, 		I2|T3	},
 {"bnel",    "s,I,p",	0,    (int) M_BNEL_I,	INSN_MACRO,		I2|T3	},
 {"break",   "",		0x0000000d, 0xffffffff,	TRAP,			I1	},
-{"break",   "B",        0x0000000d, 0xfc00003f, TRAP,           	I32     },
 {"break",   "c",	0x0000000d, 0xfc00ffff,	TRAP,			I1	},
 {"break",   "c,q",	0x0000000d, 0xfc00003f,	TRAP,			I1	},
 {"c.f.d",   "S,T",	0x46200030, 0xffe007ff,	RD_S|RD_T|WR_CC|FP_D,	I1	},
