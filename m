Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2004 15:22:10 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:25057 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225009AbUGSOWD>; Mon, 19 Jul 2004 15:22:03 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id D37B0477EF; Mon, 19 Jul 2004 16:21:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id A70CF475C1; Mon, 19 Jul 2004 16:21:56 +0200 (CEST)
Date: Mon, 19 Jul 2004 16:21:56 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: binutils@sources.redhat.com, cgd@broadcom.com
Cc: ddaney@avtrex.com, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rsandifo@redhat.com>
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
In-Reply-To: <200406281519.IAA29663@mail-sj1-2.sj.broadcom.com>
Message-ID: <Pine.LNX.4.55.0407191612160.3667@jurand.ds.pg.gda.pl>
References: <200406281519.IAA29663@mail-sj1-2.sj.broadcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 28 Jun 2004 cgd@broadcom.com wrote:

> personally, i'd make the comment on the 'break' testcase in mips32.s a bit
> clearer and more explicit.  e.g. "for a while, break for mips32 
> took a 20 bit code.  But that was incompatible and caused problems, so
> now it's back to the old 10 bit code, or two comma-separated 10 bit codes."

 Here is an update, including your suggested comment changes as well as an
additional test case to assure single-argument "break" instructions have
the code placed correctly (this has led to an address shift enlarging the
patch significantly, unfortunately).  The gas testsuite has been verified
to pass after the change.

opcodes/:
2004-07-19  Maciej W. Rozycki  <macro@linux-mips.org>

	* mips-opc.c (mips_builtin_opcodes): Remove the MIPS32
	ISA-specific "break" encoding.

gas/testsuite/:
2004-07-19  Maciej W. Rozycki  <macro@linux-mips.org>

	* gas/mips/mips32.s: Adjust for the unified "break" syntax.  Add 
	another "break" case.  Update the comment accordingly.
	* gas/mips/set-arch.s: Likewise.
	* gas/mips/mips32.d: Adjust for the new output.
	* gas/mips/set-arch.d: Likewise.

 OK to apply?

  Maciej

binutils-2.15.91-20040715-mips-break20.patch
diff -up --recursive --new-file binutils-2.15.91-20040715.macro/gas/testsuite/gas/mips/mips32.d binutils-2.15.91-20040715/gas/testsuite/gas/mips/mips32.d
--- binutils-2.15.91-20040715.macro/gas/testsuite/gas/mips/mips32.d	2003-05-08 03:25:35.000000000 +0000
+++ binutils-2.15.91-20040715/gas/testsuite/gas/mips/mips32.d	2004-07-18 19:10:00.000000000 +0000
@@ -48,8 +48,9 @@ Disassembly of section .text:
 0+0098 <[^>]*> 4359e260 	wait	0x56789
 0+009c <[^>]*> 0000000d 	break
 0+00a0 <[^>]*> 0000000d 	break
-0+00a4 <[^>]*> 0048d14d 	break	0x12345
-0+00a8 <[^>]*> 7000003f 	sdbbp
+0+00a4 <[^>]*> 0345000d 	break	0x345
+0+00a8 <[^>]*> 0048d14d 	break	0x48,0x345
 0+00ac <[^>]*> 7000003f 	sdbbp
-0+00b0 <[^>]*> 7159e27f 	sdbbp	0x56789
+0+00b0 <[^>]*> 7000003f 	sdbbp
+0+00b4 <[^>]*> 7159e27f 	sdbbp	0x56789
 	...
diff -up --recursive --new-file binutils-2.15.91-20040715.macro/gas/testsuite/gas/mips/mips32.s binutils-2.15.91-20040715/gas/testsuite/gas/mips/mips32.s
--- binutils-2.15.91-20040715.macro/gas/testsuite/gas/mips/mips32.s	2002-09-05 03:25:40.000000000 +0000
+++ binutils-2.15.91-20040715/gas/testsuite/gas/mips/mips32.s	2004-07-18 19:30:04.000000000 +0000
@@ -58,11 +58,17 @@ text_label:
       wait    0                       # disassembles without code
       wait    0x56789
 
-      # Instructions in previous ISAs or CPUs which are now slightly
-      # different.
+      # For a while break for the mips32 ISA interpreted a single argument
+      # as a 20-bit code, placing it in the opcode differently to
+      # traditional ISAs.  This turned out to cause problems, so it has
+      # been removed.  This test is to assure consistent interpretation.
       break
       break   0                       # disassembles without code
-      break   0x12345
+      break   0x345
+      break   0x48,0x345              # this still specifies a 20-bit code
+
+      # Instructions in previous ISAs or CPUs which are now slightly
+      # different.
       sdbbp
       sdbbp   0                       # disassembles without code
       sdbbp   0x56789
diff -up --recursive --new-file binutils-2.15.91-20040715.macro/gas/testsuite/gas/mips/set-arch.d binutils-2.15.91-20040715/gas/testsuite/gas/mips/set-arch.d
--- binutils-2.15.91-20040715.macro/gas/testsuite/gas/mips/set-arch.d	2003-10-01 03:25:36.000000000 +0000
+++ binutils-2.15.91-20040715/gas/testsuite/gas/mips/set-arch.d	2004-07-18 21:41:02.000000000 +0000
@@ -160,207 +160,208 @@ Disassembly of section \.text:
 00000260 <[^>]*> 4359e260 	wait	0x56789
 00000264 <[^>]*> 0000000d 	break
 00000268 <[^>]*> 0000000d 	break
-0000026c <[^>]*> 0048d14d 	break	0x12345
-00000270 <[^>]*> 7000003f 	sdbbp
+0000026c <[^>]*> 0345000d 	break	0x345
+00000270 <[^>]*> 0048d14d 	break	0x48,0x345
 00000274 <[^>]*> 7000003f 	sdbbp
-00000278 <[^>]*> 7159e27f 	sdbbp	0x56789
-0000027c <[^>]*> 000000c0 	sll	zero,zero,0x3
-00000280 <[^>]*> 7ca43980 	0x7ca43980
-00000284 <[^>]*> 7ca46984 	0x7ca46984
-00000288 <[^>]*> 0100fc09 	0x100fc09
-0000028c <[^>]*> 0120a409 	0x120a409
-00000290 <[^>]*> 01000408 	0x1000408
-00000294 <[^>]*> 7c0a003b 	0x7c0a003b
-00000298 <[^>]*> 7c0b083b 	0x7c0b083b
-0000029c <[^>]*> 7c0c103b 	0x7c0c103b
-000002a0 <[^>]*> 7c0d183b 	0x7c0d183b
-000002a4 <[^>]*> 7c0e203b 	0x7c0e203b
-000002a8 <[^>]*> 7c0f283b 	0x7c0f283b
-000002ac <[^>]*> 002acf02 	0x2acf02
-000002b0 <[^>]*> 002ac902 	0x2ac902
-000002b4 <[^>]*> 0004c823 	negu	t9,a0
-000002b8 <[^>]*> 032ac846 	0x32ac846
-000002bc <[^>]*> 008ac846 	0x8ac846
+00000278 <[^>]*> 7000003f 	sdbbp
+0000027c <[^>]*> 7159e27f 	sdbbp	0x56789
+00000280 <[^>]*> 000000c0 	sll	zero,zero,0x3
+00000284 <[^>]*> 7ca43980 	0x7ca43980
+00000288 <[^>]*> 7ca46984 	0x7ca46984
+0000028c <[^>]*> 0100fc09 	0x100fc09
+00000290 <[^>]*> 0120a409 	0x120a409
+00000294 <[^>]*> 01000408 	0x1000408
+00000298 <[^>]*> 7c0a003b 	0x7c0a003b
+0000029c <[^>]*> 7c0b083b 	0x7c0b083b
+000002a0 <[^>]*> 7c0c103b 	0x7c0c103b
+000002a4 <[^>]*> 7c0d183b 	0x7c0d183b
+000002a8 <[^>]*> 7c0e203b 	0x7c0e203b
+000002ac <[^>]*> 7c0f283b 	0x7c0f283b
+000002b0 <[^>]*> 002acf02 	0x2acf02
+000002b4 <[^>]*> 002ac902 	0x2ac902
+000002b8 <[^>]*> 0004c823 	negu	t9,a0
+000002bc <[^>]*> 032ac846 	0x32ac846
 000002c0 <[^>]*> 008ac846 	0x8ac846
-000002c4 <[^>]*> 7c073c20 	0x7c073c20
-000002c8 <[^>]*> 7c0a4420 	0x7c0a4420
-000002cc <[^>]*> 7c073e20 	0x7c073e20
-000002d0 <[^>]*> 7c0a4620 	0x7c0a4620
-000002d4 <[^>]*> 055f5555 	0x55f5555
-000002d8 <[^>]*> 7c0738a0 	0x7c0738a0
-000002dc <[^>]*> 7c0a40a0 	0x7c0a40a0
-000002e0 <[^>]*> 41606000 	0x41606000
+000002c4 <[^>]*> 008ac846 	0x8ac846
+000002c8 <[^>]*> 7c073c20 	0x7c073c20
+000002cc <[^>]*> 7c0a4420 	0x7c0a4420
+000002d0 <[^>]*> 7c073e20 	0x7c073e20
+000002d4 <[^>]*> 7c0a4620 	0x7c0a4620
+000002d8 <[^>]*> 055f5555 	0x55f5555
+000002dc <[^>]*> 7c0738a0 	0x7c0738a0
+000002e0 <[^>]*> 7c0a40a0 	0x7c0a40a0
 000002e4 <[^>]*> 41606000 	0x41606000
-000002e8 <[^>]*> 416a6000 	0x416a6000
-000002ec <[^>]*> 41606020 	0x41606020
+000002e8 <[^>]*> 41606000 	0x41606000
+000002ec <[^>]*> 416a6000 	0x416a6000
 000002f0 <[^>]*> 41606020 	0x41606020
-000002f4 <[^>]*> 416a6020 	0x416a6020
-000002f8 <[^>]*> 41595000 	0x41595000
-000002fc <[^>]*> 41d95000 	0x41d95000
-00000300 <[^>]*> 44710000 	0x44710000
-00000304 <[^>]*> 44f10000 	0x44f10000
-00000308 <[^>]*> 48715555 	0x48715555
-0000030c <[^>]*> 48f15555 	0x48f15555
-00000310 <[^>]*> 70410825 	dclo	at,v0
-00000314 <[^>]*> 70831824 	dclz	v1,a0
-00000318 <[^>]*> 48232000 	dmfc2	v1,\$4
-0000031c <[^>]*> 48242800 	dmfc2	a0,\$5
-00000320 <[^>]*> 48253007 	dmfc2	a1,\$6,7
-00000324 <[^>]*> 48a63800 	dmtc2	a2,\$7
-00000328 <[^>]*> 48a74000 	dmtc2	a3,\$8
-0000032c <[^>]*> 48a84807 	dmtc2	t0,\$9,7
-00000330 <[^>]*> 00850029 	0x850029
-00000334 <[^>]*> 00a60028 	0xa60028
-00000338 <[^>]*> 00002012 	mflo	a0
-0000033c <[^>]*> 00a62029 	0xa62029
-00000340 <[^>]*> 00a62229 	0xa62229
-00000344 <[^>]*> 00a62629 	0xa62629
-00000348 <[^>]*> 00a62269 	0xa62269
-0000034c <[^>]*> 00a62669 	0xa62669
-00000350 <[^>]*> 00a62429 	0xa62429
-00000354 <[^>]*> 00a62069 	0xa62069
-00000358 <[^>]*> 00a62469 	0xa62469
-0000035c <[^>]*> 00002012 	mflo	a0
-00000360 <[^>]*> 00a62028 	0xa62028
-00000364 <[^>]*> 00a62228 	0xa62228
-00000368 <[^>]*> 00a62628 	0xa62628
-0000036c <[^>]*> 00a62268 	0xa62268
-00000370 <[^>]*> 00a62668 	0xa62668
-00000374 <[^>]*> 00a62428 	0xa62428
-00000378 <[^>]*> 00a62068 	0xa62068
-0000037c <[^>]*> 00a62468 	0xa62468
-00000380 <[^>]*> 00a62059 	0xa62059
-00000384 <[^>]*> 00a62258 	0xa62258
-00000388 <[^>]*> 00a62259 	0xa62259
-0000038c <[^>]*> 00a620d8 	0xa620d8
-00000390 <[^>]*> 00a620d9 	0xa620d9
-00000394 <[^>]*> 00a622d8 	0xa622d8
-00000398 <[^>]*> 00a622d9 	0xa622d9
-0000039c <[^>]*> 00a62158 	0xa62158
-000003a0 <[^>]*> 00a62159 	0xa62159
-000003a4 <[^>]*> 00a62358 	0xa62358
-000003a8 <[^>]*> 00a62359 	0xa62359
-000003ac <[^>]*> 00a621d8 	0xa621d8
-000003b0 <[^>]*> 00a621d9 	0xa621d9
-000003b4 <[^>]*> 00a623d8 	0xa623d8
-000003b8 <[^>]*> 00a623d9 	0xa623d9
-000003bc <[^>]*> 00252642 	0x252642
-000003c0 <[^>]*> 00c52046 	0xc52046
-000003c4 <[^>]*> 0025267a 	0x25267a
-000003c8 <[^>]*> 0025267e 	0x25267e
+000002f4 <[^>]*> 41606020 	0x41606020
+000002f8 <[^>]*> 416a6020 	0x416a6020
+000002fc <[^>]*> 41595000 	0x41595000
+00000300 <[^>]*> 41d95000 	0x41d95000
+00000304 <[^>]*> 44710000 	0x44710000
+00000308 <[^>]*> 44f10000 	0x44f10000
+0000030c <[^>]*> 48715555 	0x48715555
+00000310 <[^>]*> 48f15555 	0x48f15555
+00000314 <[^>]*> 70410825 	dclo	at,v0
+00000318 <[^>]*> 70831824 	dclz	v1,a0
+0000031c <[^>]*> 48232000 	dmfc2	v1,\$4
+00000320 <[^>]*> 48242800 	dmfc2	a0,\$5
+00000324 <[^>]*> 48253007 	dmfc2	a1,\$6,7
+00000328 <[^>]*> 48a63800 	dmtc2	a2,\$7
+0000032c <[^>]*> 48a74000 	dmtc2	a3,\$8
+00000330 <[^>]*> 48a84807 	dmtc2	t0,\$9,7
+00000334 <[^>]*> 00850029 	0x850029
+00000338 <[^>]*> 00a60028 	0xa60028
+0000033c <[^>]*> 00002012 	mflo	a0
+00000340 <[^>]*> 00a62029 	0xa62029
+00000344 <[^>]*> 00a62229 	0xa62229
+00000348 <[^>]*> 00a62629 	0xa62629
+0000034c <[^>]*> 00a62269 	0xa62269
+00000350 <[^>]*> 00a62669 	0xa62669
+00000354 <[^>]*> 00a62429 	0xa62429
+00000358 <[^>]*> 00a62069 	0xa62069
+0000035c <[^>]*> 00a62469 	0xa62469
+00000360 <[^>]*> 00002012 	mflo	a0
+00000364 <[^>]*> 00a62028 	0xa62028
+00000368 <[^>]*> 00a62228 	0xa62228
+0000036c <[^>]*> 00a62628 	0xa62628
+00000370 <[^>]*> 00a62268 	0xa62268
+00000374 <[^>]*> 00a62668 	0xa62668
+00000378 <[^>]*> 00a62428 	0xa62428
+0000037c <[^>]*> 00a62068 	0xa62068
+00000380 <[^>]*> 00a62468 	0xa62468
+00000384 <[^>]*> 00a62059 	0xa62059
+00000388 <[^>]*> 00a62258 	0xa62258
+0000038c <[^>]*> 00a62259 	0xa62259
+00000390 <[^>]*> 00a620d8 	0xa620d8
+00000394 <[^>]*> 00a620d9 	0xa620d9
+00000398 <[^>]*> 00a622d8 	0xa622d8
+0000039c <[^>]*> 00a622d9 	0xa622d9
+000003a0 <[^>]*> 00a62158 	0xa62158
+000003a4 <[^>]*> 00a62159 	0xa62159
+000003a8 <[^>]*> 00a62358 	0xa62358
+000003ac <[^>]*> 00a62359 	0xa62359
+000003b0 <[^>]*> 00a621d8 	0xa621d8
+000003b4 <[^>]*> 00a621d9 	0xa621d9
+000003b8 <[^>]*> 00a623d8 	0xa623d8
+000003bc <[^>]*> 00a623d9 	0xa623d9
+000003c0 <[^>]*> 00252642 	0x252642
+000003c4 <[^>]*> 00c52046 	0xc52046
+000003c8 <[^>]*> 0025267a 	0x25267a
 000003cc <[^>]*> 0025267e 	0x25267e
-000003d0 <[^>]*> 00c52056 	0xc52056
-000003d4 <[^>]*> 7000003f 	sdbbp
-000003d8 <[^>]*> 7000003e 	0x7000003e
-000003dc <[^>]*> 7003183d 	0x7003183d
-000003e0 <[^>]*> 7083183d 	0x7083183d
-000003e4 <[^>]*> 4004c803 	mfc0	a0,c0_perfcnt,3
-000003e8 <[^>]*> 4004c802 	mfc0	a0,c0_perfcnt,2
-000003ec <[^>]*> 4084c803 	mtc0	a0,c0_perfcnt,3
-000003f0 <[^>]*> 4084c802 	mtc0	a0,c0_perfcnt,2
-000003f4 <[^>]*> 4ac4100b 	c2	0xc4100b
-000003f8 <[^>]*> 4886208b 	0x4886208b
-000003fc <[^>]*> 4bcf218b 	c2	0x1cf218b
-00000400 <[^>]*> 4bdf310b 	c2	0x1df310b
-00000404 <[^>]*> 4ac4100c 	c2	0xc4100c
-00000408 <[^>]*> 4886208c 	0x4886208c
-0000040c <[^>]*> 4bcf218c 	c2	0x1cf218c
-00000410 <[^>]*> 4bdf310c 	c2	0x1df310c
-00000414 <[^>]*> 4ac20001 	c2	0xc20001
-00000418 <[^>]*> 48862001 	mtc2	a2,\$4,1
-0000041c <[^>]*> 4bcf3001 	c2	0x1cf3001
-00000420 <[^>]*> 4bdf2001 	c2	0x1df2001
-00000424 <[^>]*> 4ac20005 	c2	0xc20005
-00000428 <[^>]*> 48862005 	mtc2	a2,\$4,5
-0000042c <[^>]*> 4bcf3005 	c2	0x1cf3005
-00000430 <[^>]*> 4bdf2005 	c2	0x1df2005
-00000434 <[^>]*> 4ac20004 	c2	0xc20004
-00000438 <[^>]*> 48862004 	mtc2	a2,\$4,4
-0000043c <[^>]*> 4bcf3004 	c2	0x1cf3004
-00000440 <[^>]*> 4bdf2004 	c2	0x1df2004
-00000444 <[^>]*> 4ac41007 	c2	0xc41007
-00000448 <[^>]*> 48862087 	0x48862087
-0000044c <[^>]*> 4bcf2187 	c2	0x1cf2187
-00000450 <[^>]*> 4bdf3107 	c2	0x1df3107
-00000454 <[^>]*> 4ac41006 	c2	0xc41006
-00000458 <[^>]*> 48862086 	0x48862086
-0000045c <[^>]*> 4bcf2186 	c2	0x1cf2186
-00000460 <[^>]*> 4bdf3106 	c2	0x1df3106
-00000464 <[^>]*> 4ac41030 	c2	0xc41030
-00000468 <[^>]*> 488620b0 	0x488620b0
-0000046c <[^>]*> 4bcf21b0 	c2	0x1cf21b0
-00000470 <[^>]*> 4bdf3130 	c2	0x1df3130
-00000474 <[^>]*> 4ac20033 	c2	0xc20033
-00000478 <[^>]*> 48862033 	0x48862033
-0000047c <[^>]*> 4bcf3033 	c2	0x1cf3033
-00000480 <[^>]*> 4bdf2033 	c2	0x1df2033
-00000484 <[^>]*> 4ac20433 	c2	0xc20433
-00000488 <[^>]*> 48862433 	0x48862433
-0000048c <[^>]*> 4bcf3433 	c2	0x1cf3433
-00000490 <[^>]*> 4bdf2433 	c2	0x1df2433
-00000494 <[^>]*> 4ac20032 	c2	0xc20032
-00000498 <[^>]*> 48862032 	0x48862032
-0000049c <[^>]*> 4bcf3032 	c2	0x1cf3032
-000004a0 <[^>]*> 4bdf2032 	c2	0x1df2032
-000004a4 <[^>]*> 4ac20432 	c2	0xc20432
-000004a8 <[^>]*> 48862432 	0x48862432
-000004ac <[^>]*> 4bcf3432 	c2	0x1cf3432
-000004b0 <[^>]*> 4bdf2432 	c2	0x1df2432
-000004b4 <[^>]*> 4ac4100f 	c2	0xc4100f
-000004b8 <[^>]*> 4886208f 	0x4886208f
-000004bc <[^>]*> 4bcf218f 	c2	0x1cf218f
-000004c0 <[^>]*> 4bdf310f 	c2	0x1df310f
-000004c4 <[^>]*> 4ac4100e 	c2	0xc4100e
-000004c8 <[^>]*> 4886208e 	0x4886208e
-000004cc <[^>]*> 4bcf218e 	c2	0x1cf218e
-000004d0 <[^>]*> 4bdf310e 	c2	0x1df310e
-000004d4 <[^>]*> 4ac41002 	c2	0xc41002
-000004d8 <[^>]*> 48862082 	0x48862082
-000004dc <[^>]*> 4bcf2182 	c2	0x1cf2182
-000004e0 <[^>]*> 4bdf3102 	c2	0x1df3102
-000004e4 <[^>]*> 4ac41003 	c2	0xc41003
-000004e8 <[^>]*> 48862083 	0x48862083
-000004ec <[^>]*> 4bcf2183 	c2	0x1cf2183
-000004f0 <[^>]*> 4bdf3103 	c2	0x1df3103
-000004f4 <[^>]*> 4ac4100a 	c2	0xc4100a
-000004f8 <[^>]*> 4886208a 	0x4886208a
-000004fc <[^>]*> 4bcf218a 	c2	0x1cf218a
-00000500 <[^>]*> 4bdf310a 	c2	0x1df310a
-00000504 <[^>]*> 4ac4100d 	c2	0xc4100d
-00000508 <[^>]*> 4886208d 	0x4886208d
-0000050c <[^>]*> 4bcf218d 	c2	0x1cf218d
-00000510 <[^>]*> 4bdf310d 	c2	0x1df310d
-00000514 <[^>]*> 48a41018 	0x48a41018
-00000518 <[^>]*> 4984101f 	0x4984101f
-0000051c <[^>]*> 49c4101f 	0x49c4101f
-00000520 <[^>]*> 4904101f 	0x4904101f
-00000524 <[^>]*> 4944101f 	0x4944101f
-00000528 <[^>]*> 48c62090 	0x48c62090
-0000052c <[^>]*> 4bce3110 	c2	0x1ce3110
-00000530 <[^>]*> 48c62092 	0x48c62092
-00000534 <[^>]*> 4bce3112 	c2	0x1ce3112
-00000538 <[^>]*> 4bcd00a0 	c2	0x1cd00a0
-0000053c <[^>]*> 4a0000bf 	c2	0xbf
-00000540 <[^>]*> 480000bf 	0x480000bf
-00000544 <[^>]*> 490000bf 	bc2f	00000844 <[^>]*>
-00000548 <[^>]*> 4a00103e 	c2	0x103e
-0000054c <[^>]*> 4804103e 	0x4804103e
-00000550 <[^>]*> 00c52046 	0xc52046
-00000554 <[^>]*> 00252442 	0x252442
-00000558 <[^>]*> 00c52056 	0xc52056
-0000055c <[^>]*> 0025207e 	0x25207e
-00000560 <[^>]*> 002520ba 	0x2520ba
-00000564 <[^>]*> 4ca4200f 	prefx	0x4,a0\(a1\)
-00000568 <[^>]*> 42000020 	wait
+000003d0 <[^>]*> 0025267e 	0x25267e
+000003d4 <[^>]*> 00c52056 	0xc52056
+000003d8 <[^>]*> 7000003f 	sdbbp
+000003dc <[^>]*> 7000003e 	0x7000003e
+000003e0 <[^>]*> 7003183d 	0x7003183d
+000003e4 <[^>]*> 7083183d 	0x7083183d
+000003e8 <[^>]*> 4004c803 	mfc0	a0,c0_perfcnt,3
+000003ec <[^>]*> 4004c802 	mfc0	a0,c0_perfcnt,2
+000003f0 <[^>]*> 4084c803 	mtc0	a0,c0_perfcnt,3
+000003f4 <[^>]*> 4084c802 	mtc0	a0,c0_perfcnt,2
+000003f8 <[^>]*> 4ac4100b 	c2	0xc4100b
+000003fc <[^>]*> 4886208b 	0x4886208b
+00000400 <[^>]*> 4bcf218b 	c2	0x1cf218b
+00000404 <[^>]*> 4bdf310b 	c2	0x1df310b
+00000408 <[^>]*> 4ac4100c 	c2	0xc4100c
+0000040c <[^>]*> 4886208c 	0x4886208c
+00000410 <[^>]*> 4bcf218c 	c2	0x1cf218c
+00000414 <[^>]*> 4bdf310c 	c2	0x1df310c
+00000418 <[^>]*> 4ac20001 	c2	0xc20001
+0000041c <[^>]*> 48862001 	mtc2	a2,\$4,1
+00000420 <[^>]*> 4bcf3001 	c2	0x1cf3001
+00000424 <[^>]*> 4bdf2001 	c2	0x1df2001
+00000428 <[^>]*> 4ac20005 	c2	0xc20005
+0000042c <[^>]*> 48862005 	mtc2	a2,\$4,5
+00000430 <[^>]*> 4bcf3005 	c2	0x1cf3005
+00000434 <[^>]*> 4bdf2005 	c2	0x1df2005
+00000438 <[^>]*> 4ac20004 	c2	0xc20004
+0000043c <[^>]*> 48862004 	mtc2	a2,\$4,4
+00000440 <[^>]*> 4bcf3004 	c2	0x1cf3004
+00000444 <[^>]*> 4bdf2004 	c2	0x1df2004
+00000448 <[^>]*> 4ac41007 	c2	0xc41007
+0000044c <[^>]*> 48862087 	0x48862087
+00000450 <[^>]*> 4bcf2187 	c2	0x1cf2187
+00000454 <[^>]*> 4bdf3107 	c2	0x1df3107
+00000458 <[^>]*> 4ac41006 	c2	0xc41006
+0000045c <[^>]*> 48862086 	0x48862086
+00000460 <[^>]*> 4bcf2186 	c2	0x1cf2186
+00000464 <[^>]*> 4bdf3106 	c2	0x1df3106
+00000468 <[^>]*> 4ac41030 	c2	0xc41030
+0000046c <[^>]*> 488620b0 	0x488620b0
+00000470 <[^>]*> 4bcf21b0 	c2	0x1cf21b0
+00000474 <[^>]*> 4bdf3130 	c2	0x1df3130
+00000478 <[^>]*> 4ac20033 	c2	0xc20033
+0000047c <[^>]*> 48862033 	0x48862033
+00000480 <[^>]*> 4bcf3033 	c2	0x1cf3033
+00000484 <[^>]*> 4bdf2033 	c2	0x1df2033
+00000488 <[^>]*> 4ac20433 	c2	0xc20433
+0000048c <[^>]*> 48862433 	0x48862433
+00000490 <[^>]*> 4bcf3433 	c2	0x1cf3433
+00000494 <[^>]*> 4bdf2433 	c2	0x1df2433
+00000498 <[^>]*> 4ac20032 	c2	0xc20032
+0000049c <[^>]*> 48862032 	0x48862032
+000004a0 <[^>]*> 4bcf3032 	c2	0x1cf3032
+000004a4 <[^>]*> 4bdf2032 	c2	0x1df2032
+000004a8 <[^>]*> 4ac20432 	c2	0xc20432
+000004ac <[^>]*> 48862432 	0x48862432
+000004b0 <[^>]*> 4bcf3432 	c2	0x1cf3432
+000004b4 <[^>]*> 4bdf2432 	c2	0x1df2432
+000004b8 <[^>]*> 4ac4100f 	c2	0xc4100f
+000004bc <[^>]*> 4886208f 	0x4886208f
+000004c0 <[^>]*> 4bcf218f 	c2	0x1cf218f
+000004c4 <[^>]*> 4bdf310f 	c2	0x1df310f
+000004c8 <[^>]*> 4ac4100e 	c2	0xc4100e
+000004cc <[^>]*> 4886208e 	0x4886208e
+000004d0 <[^>]*> 4bcf218e 	c2	0x1cf218e
+000004d4 <[^>]*> 4bdf310e 	c2	0x1df310e
+000004d8 <[^>]*> 4ac41002 	c2	0xc41002
+000004dc <[^>]*> 48862082 	0x48862082
+000004e0 <[^>]*> 4bcf2182 	c2	0x1cf2182
+000004e4 <[^>]*> 4bdf3102 	c2	0x1df3102
+000004e8 <[^>]*> 4ac41003 	c2	0xc41003
+000004ec <[^>]*> 48862083 	0x48862083
+000004f0 <[^>]*> 4bcf2183 	c2	0x1cf2183
+000004f4 <[^>]*> 4bdf3103 	c2	0x1df3103
+000004f8 <[^>]*> 4ac4100a 	c2	0xc4100a
+000004fc <[^>]*> 4886208a 	0x4886208a
+00000500 <[^>]*> 4bcf218a 	c2	0x1cf218a
+00000504 <[^>]*> 4bdf310a 	c2	0x1df310a
+00000508 <[^>]*> 4ac4100d 	c2	0xc4100d
+0000050c <[^>]*> 4886208d 	0x4886208d
+00000510 <[^>]*> 4bcf218d 	c2	0x1cf218d
+00000514 <[^>]*> 4bdf310d 	c2	0x1df310d
+00000518 <[^>]*> 48a41018 	0x48a41018
+0000051c <[^>]*> 4984101f 	0x4984101f
+00000520 <[^>]*> 49c4101f 	0x49c4101f
+00000524 <[^>]*> 4904101f 	0x4904101f
+00000528 <[^>]*> 4944101f 	0x4944101f
+0000052c <[^>]*> 48c62090 	0x48c62090
+00000530 <[^>]*> 4bce3110 	c2	0x1ce3110
+00000534 <[^>]*> 48c62092 	0x48c62092
+00000538 <[^>]*> 4bce3112 	c2	0x1ce3112
+0000053c <[^>]*> 4bcd00a0 	c2	0x1cd00a0
+00000540 <[^>]*> 4a0000bf 	c2	0xbf
+00000544 <[^>]*> 480000bf 	0x480000bf
+00000548 <[^>]*> 490000bf 	bc2f	00000848 <[^>]*>
+0000054c <[^>]*> 4a00103e 	c2	0x103e
+00000550 <[^>]*> 4804103e 	0x4804103e
+00000554 <[^>]*> 00c52046 	0xc52046
+00000558 <[^>]*> 00252442 	0x252442
+0000055c <[^>]*> 00c52056 	0xc52056
+00000560 <[^>]*> 0025207e 	0x25207e
+00000564 <[^>]*> 002520ba 	0x2520ba
+00000568 <[^>]*> 4ca4200f 	prefx	0x4,a0\(a1\)
 0000056c <[^>]*> 42000020 	wait
-00000570 <[^>]*> 4359e260 	wait	0x56789
-00000574 <[^>]*> 00000040 	ssnop
-00000578 <[^>]*> 70831821 	clo	v1,a0
-0000057c <[^>]*> 70831825 	dclo	v1,a0
-00000580 <[^>]*> 70831820 	clz	v1,a0
-00000584 <[^>]*> 70831824 	dclz	v1,a0
-00000588 <[^>]*> 4c440005 	luxc1	\$f0,a0\(v0\)
-0000058c <[^>]*> 4c44100d 	suxc1	\$f2,a0\(v0\)
-00000590 <[^>]*> 42000008 	tlbp
-00000594 <[^>]*> 42000001 	tlbr
+00000570 <[^>]*> 42000020 	wait
+00000574 <[^>]*> 4359e260 	wait	0x56789
+00000578 <[^>]*> 00000040 	ssnop
+0000057c <[^>]*> 70831821 	clo	v1,a0
+00000580 <[^>]*> 70831825 	dclo	v1,a0
+00000584 <[^>]*> 70831820 	clz	v1,a0
+00000588 <[^>]*> 70831824 	dclz	v1,a0
+0000058c <[^>]*> 4c440005 	luxc1	\$f0,a0\(v0\)
+00000590 <[^>]*> 4c44100d 	suxc1	\$f2,a0\(v0\)
+00000594 <[^>]*> 42000008 	tlbp
+00000598 <[^>]*> 42000001 	tlbr
 	\.\.\.
diff -up --recursive --new-file binutils-2.15.91-20040715.macro/gas/testsuite/gas/mips/set-arch.s binutils-2.15.91-20040715/gas/testsuite/gas/mips/set-arch.s
--- binutils-2.15.91-20040715.macro/gas/testsuite/gas/mips/set-arch.s	2003-06-29 19:41:33.000000000 +0000
+++ binutils-2.15.91-20040715/gas/testsuite/gas/mips/set-arch.s	2004-07-18 19:21:55.000000000 +0000
@@ -200,11 +200,17 @@ text_label:	
 	wait    0                       # disassembles without code
 	wait    0x56789
 
-	# Instructions in previous ISAs or CPUs which are now slightly
-	# different.
+	# For a while break for the mips32 ISA interpreted a single argument
+	# as a 20-bit code, placing it in the opcode differently to
+	# traditional ISAs.  This turned out to cause problems, so it has
+	# been removed.  This test is to assure consistent interpretation.
 	break
 	break   0                       # disassembles without code
-	break   0x12345
+	break	0x345
+	break	0x48,0x345		# this still specifies a 20-bit code
+
+	# Instructions in previous ISAs or CPUs which are now slightly
+	# different.
 	sdbbp
 	sdbbp   0                       # disassembles without code
 	sdbbp   0x56789
diff -up --recursive --new-file binutils-2.15.91-20040715.macro/opcodes/mips-opc.c binutils-2.15.91-20040715/opcodes/mips-opc.c
--- binutils-2.15.91-20040715.macro/opcodes/mips-opc.c	2003-11-19 04:25:23.000000000 +0000
+++ binutils-2.15.91-20040715/opcodes/mips-opc.c	2004-06-26 12:42:46.000000000 +0000
@@ -274,7 +274,6 @@ const struct mips_opcode mips_builtin_op
 {"bnel",    "s,t,p",	0x54000000, 0xfc000000,	CBL|RD_s|RD_t, 		I2|T3	},
 {"bnel",    "s,I,p",	0,    (int) M_BNEL_I,	INSN_MACRO,		I2|T3	},
 {"break",   "",		0x0000000d, 0xffffffff,	TRAP,			I1	},
-{"break",   "B",        0x0000000d, 0xfc00003f, TRAP,           	I32     },
 {"break",   "c",	0x0000000d, 0xfc00ffff,	TRAP,			I1	},
 {"break",   "c,q",	0x0000000d, 0xfc00003f,	TRAP,			I1	},
 {"c.f.d",   "S,T",	0x46200030, 0xffe007ff,	RD_S|RD_T|WR_CC|FP_D,	I1	},
