Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Dec 2004 01:11:59 +0000 (GMT)
Received: from mail.alphastar.de ([IPv6:::ffff:194.59.236.179]:31492 "EHLO
	mail.alphastar.de") by linux-mips.org with ESMTP
	id <S8225230AbULaBLy>; Fri, 31 Dec 2004 01:11:54 +0000
Received: from SNaIlmail.Peter (217.249.217.132)
          by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==)
          for <linux-mips@linux-mips.org>; Fri, 31 Dec 2004 02:09:52 +0100
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id iBV18ZGQ000482
	for <linux-mips@linux-mips.org>; Fri, 31 Dec 2004 02:08:35 +0100
Received: from pf (helo=localhost)
	by Indigo2.Peter with local-esmtp (Exim 3.35 #1 (Debian))
	id 1CkBFq-00007R-00
	for <linux-mips@linux-mips.org>; Fri, 31 Dec 2004 02:06:58 +0100
Date: Fri, 31 Dec 2004 02:06:02 +0100 (CET)
From: Peter Fuerst <pf@Indigo2.Peter>
To: linux-mips@linux-mips.org
Subject: Confused assembler
In-Reply-To: <20041227124435.GC26100@linux-mips.org>
Message-ID: <Pine.LNX.4.58.0412310201350.455@Indigo2.Peter>
References: <20041225172449.1063A1F123@trashy.coderock.org>
 <20041227124435.GC26100@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: pf@net.alphadv.de
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@Indigo2.Peter
Precedence: bulk
X-list: linux-mips



Hello !


When building 2.6.10, the assembler (2.13.2.1) gets confused by a "b target2"
(compiler generated) immediately following a "beqzl target1" (inline assembly
macro), and reorders these instructions (with wrong address calculation too)
to an infinite loop.
(Well, not really infinite - after about ten minutes some timer interrupt
makes an end to it by a null-pointer dereference in __queue_work()  ;-)
This bug is rather unreliable though, going away with minimal, unintentional
code changes, unexpectedly reappearing after some later rebuild...

Was this behaviour already observed elsewhere ?  Is it fixed in some newer
assembler version ?  Or should i just be content with it and work around
with appropriate "nop"s in the concerned inline-assembly macros ? ... ?



as -EB -G 0 -mips4 -O2 -g0 -64 -mcpu=r8000 -v -64 -non_shared -64 -march=r8000 -mips4 --trap -o kernel/.tmp_fork.o
GNU assembler version 2.13.2.1 (mips64-ip28-linux-gnu) using BFD version 2.13.2.1
GNU assembler version 2.13.2.1 (mips64-linux) using BFD version 2.13.2.1

Here are examples of what the assembler receives from the compiler,
and what it produces:

a80000002003a6c0 <copy_process>:
...

	.set	macro
	.set	reorder
	cache 0x14,0($sp)	# Cache Barrier
 #APP
	1:	lld	$3, 256($4)	# atomic64_add
	addu	$3, $2
	scd	$3, 256($4)
	beqzl	$3, 1b
 #NO_APP
	b	$L5881
$L5887:
	 # Cache Barrier omitted.
	move	$5,$0
$L5881:
	...
a80000002003a944:	bfb40000 	cache	0x14,0(sp)
a80000002003a948:	d0830100 	lld	v1,256(a0)
a80000002003a94c:	00621821 	addu	v1,v1,v0
a80000002003a950:	f0830100 	scd	v1,256(a0)
a80000002003a954 <!>:	1000ffff 	b	a80000002003a954 <$L6939+0xe4>
a80000002003a958:	00000000 	nop
a80000002003a95c:	50600000 	beqzl	v1,a80000002003a960 <$L5887>
a80000002003a960 <$L5887>:
a80000002003a960:	0000282d 	move	a1,zero
a80000002003a964 <$L5881>:
...

 #APP
	1:	ll	$5, 0($2)	# atomic_add
	addu	$5, $3
	sc	$5, 0($2)
	beqzl	$5, 1b
 #NO_APP
	b	$L6092
$L6057:
	...
$L6092:
	...
a80000002003abe4:	c0450000 	ll	a1,0(v0)
a80000002003abe8 <!>:	00a32821 	addu	a1,a1,v1
a80000002003abec:	e0450000 	sc	a1,0(v0)
a80000002003abf0:	1000fffd 	b	a80000002003abe8 <$L6045+0x70>
a80000002003abf4:	00000000 	nop
a80000002003abf8:	50a00000 	beqzl	a1,a80000002003abfc <$L6057>
a80000002003abfc <$L6057>:
...

 #APP
	1:	ll	$5, 4($2)	# atomic_add
	addu	$5, $3
	sc	$5, 4($2)
	beqzl	$5, 1b
 #NO_APP
	b	$L6480
$L6411:
	...
$L6480:
	...
a80000002003aedc:	c0450004 	ll	a1,4(v0)
a80000002003aee0:	00a32821 	addu	a1,a1,v1
a80000002003aee4 <!>:	e0450004 	sc	a1,4(v0)
a80000002003aee8:	1000fffe 	b	a80000002003aee4 <$L6401+0x54>
a80000002003aeec:	00000000 	nop
a80000002003aef0:	50a00000 	beqzl	a1,a80000002003aef4 <$L6411>
a80000002003aef4 <$L6411>:
...


with kind regards

pf
