Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jun 2004 22:31:00 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:13731 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225720AbUFVVaz>; Tue, 22 Jun 2004 22:30:55 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 7C4E647831; Tue, 22 Jun 2004 23:30:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 631AB4762E; Tue, 22 Jun 2004 23:30:48 +0200 (CEST)
Date: Tue, 22 Jun 2004 23:30:48 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: cgd@broadcom.com
Cc: David Daney <ddaney@avtrex.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
In-Reply-To: <yov57juduc7q.fsf@ldt-sj3-010.sj.broadcom.com>
Message-ID: <Pine.LNX.4.55.0406222304340.23178@jurand.ds.pg.gda.pl>
References: <40C9F5A4.2050606@avtrex.com> <40C9F5FE.8030607@avtrex.com>
 <40C9F7F0.50501@avtrex.com> <Pine.LNX.4.55.0406112039040.13062@jurand.ds.pg.gda.pl>
 <mailpost.1086981251.16853@news-sj1-1> <yov57juduc7q.fsf@ldt-sj3-010.sj.broadcom.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 11 Jun 2004 cgd@broadcom.com wrote:

> in retrospect, the 'B' variation probably wasn't the greatest idea.
> 
> If it were removed (leaving 'c' and 'c','q' variations), I don't know
> that any real harm would occur.
> 
> It may be very confusing to people who expect that the break code will
> translate into the instruction in an obvious way, and obviously it
> would mess up use of 20-bit codes, but i don't know how prevalent that
> is.
> 
> Unfortunately, at this point, Linux should probably accept the
> divide-by-zero code in both locations.
> 
> 
> (Really, from day one, assemblers probably should have accepted a
> 20-bit code.  I just checked my copy of the Kane r2000/r3000 book, and
> it was 20-bit all the way back then.  If i had to guess, i'd guess
> that gas was copying a non-gnu assembler's behaviour.  In any case,
> water under the bridge.)

 As it's at least annoying to have different break codes for divisions 
expanded by gcc explicitly and ones created implicitly by gas, here's the 
most reasonable (IMO) approach to fix that.  I think it should have been 
implemented this way originally (if at all).

gas/testsuite/:
2004-06-22  Maciej W. Rozycki  <macro@ds2.pg.gda.pl>

	* gas/mips/break20.s: Test the "break20" alias.
	* gas/mips/break20.d: Results for the test.
	* gas/mips/mips32.s: Replace "break" with "break20".
	* gas/mips/set-arch.s: Likewise.
	* gas/mips/mips32.d: Adjust for the new output.
	* gas/mips/set-arch.d: Likewise.

opcodes/:
2004-06-22  Maciej W. Rozycki  <macro@ds2.pg.gda.pl>

	* mips-opc.c (mips_builtin_opcodes): Replace the MIPS32 ISA 
	specific "break" encoding with a "break20" alias accepted for any 
	ISA.

 I decided to give a precedence to "break x,y" over "break20 z" to avoid 
perhaps a bit surprising output in `objdump'.

 The question is: does anyone know of possible troubles with this change?  
Chances are someone depends on the current semantics for
-march=mips32/mips64, but that's fragile anyway as building with a
different setting results in different code.

 Or should we get rid of the 20-bit "break" completely?  The two-argument
version provides the same functionality, although the 10-bit codes to be
used do not map to the 20-bit equivalent "optically" very well.  
Especially if decimal notation is used.

 Note the same problem appears to be the case with "sdbbp".  It could be
handled similarly, but given the limited use of "sdbbp" for
non-MIPS32/MIPS64 ISAs it may not be worth the hassle.  I see no problem
writing a similar fix if desired, though.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

binutils-2.15.91-20040615-mips-break20.patch
diff -up --recursive --new-file binutils-2.15.91-20040615.macro/gas/testsuite/gas/mips/break20.d binutils-2.15.91-20040615/gas/testsuite/gas/mips/break20.d
--- binutils-2.15.91-20040615.macro/gas/testsuite/gas/mips/break20.d	2003-05-08 03:25:31.000000000 +0000
+++ binutils-2.15.91-20040615/gas/testsuite/gas/mips/break20.d	2004-06-17 21:03:30.000000000 +0000
@@ -10,9 +10,13 @@ Disassembly of section .text:
 0+0008 <[^>]*> break	0x14
 0+000c <[^>]*> break	0x14,0x28
 0+0010 <[^>]*> break	0x3ff,0x3ff
-0+0014 <[^>]*> sdbbp
-0+0018 <[^>]*> sdbbp
-0+001c <[^>]*> sdbbp	0x14
-0+0020 <[^>]*> sdbbp	0x14,0x28
-0+0024 <[^>]*> sdbbp	0x3ff,0x3ff
+0+0014 <[^>]*> break
+0+0018 <[^>]*> break	0x0,0x14
+0+001c <[^>]*> break	0x14,0x28
+0+0020 <[^>]*> break	0x3ff,0x3ff
+0+0024 <[^>]*> sdbbp
+0+0028 <[^>]*> sdbbp
+0+002c <[^>]*> sdbbp	0x14
+0+0030 <[^>]*> sdbbp	0x14,0x28
+0+0034 <[^>]*> sdbbp	0x3ff,0x3ff
 	...
diff -up --recursive --new-file binutils-2.15.91-20040615.macro/gas/testsuite/gas/mips/break20.s binutils-2.15.91-20040615/gas/testsuite/gas/mips/break20.s
--- binutils-2.15.91-20040615.macro/gas/testsuite/gas/mips/break20.s	1999-08-10 14:24:45.000000000 +0000
+++ binutils-2.15.91-20040615/gas/testsuite/gas/mips/break20.s	2004-06-17 19:57:51.000000000 +0000
@@ -6,6 +6,11 @@ foo:	
 	break	20,40
 	break	1023,1023
 	
+	break20	0
+	break20	20
+	break20	20520
+	break20	1048575
+
 	sdbbp
 	sdbbp	0
 	sdbbp	20
diff -up --recursive --new-file binutils-2.15.91-20040615.macro/gas/testsuite/gas/mips/mips32.d binutils-2.15.91-20040615/gas/testsuite/gas/mips/mips32.d
--- binutils-2.15.91-20040615.macro/gas/testsuite/gas/mips/mips32.d	2003-05-08 03:25:35.000000000 +0000
+++ binutils-2.15.91-20040615/gas/testsuite/gas/mips/mips32.d	2004-06-17 21:15:04.000000000 +0000
@@ -48,7 +48,7 @@ Disassembly of section .text:
 0+0098 <[^>]*> 4359e260 	wait	0x56789
 0+009c <[^>]*> 0000000d 	break
 0+00a0 <[^>]*> 0000000d 	break
-0+00a4 <[^>]*> 0048d14d 	break	0x12345
+0+00a4 <[^>]*> 0048d14d 	break	0x48,0x345
 0+00a8 <[^>]*> 7000003f 	sdbbp
 0+00ac <[^>]*> 7000003f 	sdbbp
 0+00b0 <[^>]*> 7159e27f 	sdbbp	0x56789
diff -up --recursive --new-file binutils-2.15.91-20040615.macro/gas/testsuite/gas/mips/mips32.s binutils-2.15.91-20040615/gas/testsuite/gas/mips/mips32.s
--- binutils-2.15.91-20040615.macro/gas/testsuite/gas/mips/mips32.s	2002-09-05 03:25:40.000000000 +0000
+++ binutils-2.15.91-20040615/gas/testsuite/gas/mips/mips32.s	2004-06-17 21:13:22.000000000 +0000
@@ -62,7 +62,7 @@ text_label:
       # different.
       break
       break   0                       # disassembles without code
-      break   0x12345
+      break20 0x12345
       sdbbp
       sdbbp   0                       # disassembles without code
       sdbbp   0x56789
diff -up --recursive --new-file binutils-2.15.91-20040615.macro/gas/testsuite/gas/mips/set-arch.d binutils-2.15.91-20040615/gas/testsuite/gas/mips/set-arch.d
--- binutils-2.15.91-20040615.macro/gas/testsuite/gas/mips/set-arch.d	2003-10-01 03:25:36.000000000 +0000
+++ binutils-2.15.91-20040615/gas/testsuite/gas/mips/set-arch.d	2004-06-17 21:17:46.000000000 +0000
@@ -160,7 +160,7 @@ Disassembly of section \.text:
 00000260 <[^>]*> 4359e260 	wait	0x56789
 00000264 <[^>]*> 0000000d 	break
 00000268 <[^>]*> 0000000d 	break
-0000026c <[^>]*> 0048d14d 	break	0x12345
+0000026c <[^>]*> 0048d14d 	break	0x48,0x345
 00000270 <[^>]*> 7000003f 	sdbbp
 00000274 <[^>]*> 7000003f 	sdbbp
 00000278 <[^>]*> 7159e27f 	sdbbp	0x56789
diff -up --recursive --new-file binutils-2.15.91-20040615.macro/gas/testsuite/gas/mips/set-arch.s binutils-2.15.91-20040615/gas/testsuite/gas/mips/set-arch.s
--- binutils-2.15.91-20040615.macro/gas/testsuite/gas/mips/set-arch.s	2003-06-29 19:41:33.000000000 +0000
+++ binutils-2.15.91-20040615/gas/testsuite/gas/mips/set-arch.s	2004-06-17 21:18:01.000000000 +0000
@@ -204,7 +204,7 @@ text_label:	
 	# different.
 	break
 	break   0                       # disassembles without code
-	break   0x12345
+	break20 0x12345
 	sdbbp
 	sdbbp   0                       # disassembles without code
 	sdbbp   0x56789
diff -up --recursive --new-file binutils-2.15.91-20040615.macro/opcodes/mips-opc.c binutils-2.15.91-20040615/opcodes/mips-opc.c
--- binutils-2.15.91-20040615.macro/opcodes/mips-opc.c	2003-11-19 04:25:23.000000000 +0000
+++ binutils-2.15.91-20040615/opcodes/mips-opc.c	2004-06-17 19:46:23.000000000 +0000
@@ -274,9 +274,9 @@ const struct mips_opcode mips_builtin_op
 {"bnel",    "s,t,p",	0x54000000, 0xfc000000,	CBL|RD_s|RD_t, 		I2|T3	},
 {"bnel",    "s,I,p",	0,    (int) M_BNEL_I,	INSN_MACRO,		I2|T3	},
 {"break",   "",		0x0000000d, 0xffffffff,	TRAP,			I1	},
-{"break",   "B",        0x0000000d, 0xfc00003f, TRAP,           	I32     },
 {"break",   "c",	0x0000000d, 0xfc00ffff,	TRAP,			I1	},
 {"break",   "c,q",	0x0000000d, 0xfc00003f,	TRAP,			I1	},
+{"break20", "B",        0x0000000d, 0xfc00003f, TRAP,           	I1      },
 {"c.f.d",   "S,T",	0x46200030, 0xffe007ff,	RD_S|RD_T|WR_CC|FP_D,	I1	},
 {"c.f.d",   "M,S,T",    0x46200030, 0xffe000ff, RD_S|RD_T|WR_CC|FP_D,   I4|I32	},
 {"c.f.s",   "S,T",      0x46000030, 0xffe007ff, RD_S|RD_T|WR_CC|FP_S,   I1      },
