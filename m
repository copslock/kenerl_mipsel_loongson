Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 16:58:34 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:41222
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224929AbUHRP6W>; Wed, 18 Aug 2004 16:58:22 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1BxSpS-00069q-00; Wed, 18 Aug 2004 17:58:22 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1BxSpP-0005w6-00; Wed, 18 Aug 2004 17:58:19 +0200
Date: Wed, 18 Aug 2004 17:58:19 +0200
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, binutils@sources.redhat.com,
	Daniel Jacobowitz <drow@false.org>
Subject: Re: Branch bug in gas on MIPS
Message-ID: <20040818155819.GJ23756@rembrandt.csv.ica.uni-stuttgart.de>
References: <20040817160110.GA32594@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817160110.GA32594@linux-mips.org>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> Below little test case demonstrates a gas bug that results in swapping
> of the two branch instructions and use of bogus destination addresses
> for the first of the two branches.
> 
> [ralf@lappi tmp]$ cat s.s
> 1:      beqzl   $2, 1b
>         beq     $4, $5, 1b
> [ralf@lappi tmp]$ mips-linux-as -mips2 -o s.o s.s
> [ralf@lappi tmp]$ mips-linux-objdump -d s.o
>  
> s.o:     file format elf32-tradbigmips
>  
> Disassembly of section .text:
>  
> 00000000 <.text>:
>    0:   1085ffff        beq     a0,a1,0x0
>    4:   00000000        nop
>    8:   50400000        beqzl   v0,0xc
>    c:   00000000        nop

I applied the appended patch. Daniel, I think this should also go
in the branch.


Thiemo


/gas/ChangeLog
2004-08-18  Thiemo Seufer  <seufer@csv.ica.uni-stuttgart.de>
	* config/tc-mips.c (append_insn): Handle delay slots in branch likely
	correctly.

/gas/testsuite/ChangeLog
2004-08-18  Thiemo Seufer  <seufer@csv.ica.uni-stuttgart.de>
	* gas/mips/branch-swap.s: New testcase.
	* gas/mips/branch-swap.d: New testcase.
	* gas/mips/mips.exp: Run the testcase.


--- gas/config/tc-mips.c.old	2004-05-17 21:36:10.000000000 +0200
+++ gas/config/tc-mips.c	2004-08-17 20:00:43.000000000 +0200
@@ -2708,6 +2708,7 @@ append_insn (struct mips_cl_insn *ip, ex
 	  prev_insn_reloc_type[1] = BFD_RELOC_UNUSED;
 	  prev_insn_reloc_type[2] = BFD_RELOC_UNUSED;
 	  prev_insn_extended = 0;
+	  prev_insn_is_delay_slot = 1;
 	}
       else
 	{
--- gas/testsuite/gas/mips/mips.exp.old	2004-08-17 22:50:38.000000000 +0200
+++ gas/testsuite/gas/mips/mips.exp	2004-08-18 14:53:43.000000000 +0200
@@ -429,6 +429,7 @@ if { [istarget mips*-*-*] } then {
     run_dump_test_arches "branch-misc-1" [mips_arch_list_matching mips1]
     run_list_test_arches "branch-misc-2" "-32 -non_shared" [mips_arch_list_matching mips1]
     run_list_test_arches "branch-misc-2pic" "-32 -call_shared" [mips_arch_list_matching mips1]
+    run_dump_test "branch-swap"
 
     if $ilocks {
 	run_dump_test "div-ilocks"
--- gas/testsuite/gas/mips/branch-swap.s.old	1970-01-01 01:00:00.000000000 +0100
+++ gas/testsuite/gas/mips/branch-swap.s	2004-08-17 22:52:50.000000000 +0200
@@ -0,0 +1,9 @@
+	.set push
+	.set mips2
+1:	beqzl	$2, 1b
+	b	1b
+foo:	beqzl	$2, foo
+	b	foo
+
+	.set pop
+	.space 8
--- gas/testsuite/gas/mips/branch-swap.d.old	1970-01-01 01:00:00.000000000 +0100
+++ gas/testsuite/gas/mips/branch-swap.d	2004-08-17 22:57:36.000000000 +0200
@@ -0,0 +1,20 @@
+#as: -march=mips2
+#objdump: -dr
+#name: MIPS branch-swap
+
+.*:     file format .*mips.*
+
+Disassembly of section \.text:
+
+00000000 <foo-0x10>:
+   0:	5040ffff 	beqzl	v0,0 <foo-0x10>
+   4:	00000000 	nop
+   8:	1000fffd 	b	0 <foo-0x10>
+   c:	00000000 	nop
+
+00000010 <foo>:
+  10:	5040ffff 	beqzl	v0,10 <foo>
+  14:	00000000 	nop
+  18:	1000fffd 	b	10 <foo>
+  1c:	00000000 	nop
+	\.\.\.
