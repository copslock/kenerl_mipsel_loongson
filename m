Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2002 21:37:40 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:21430 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122978AbSJOThk>; Tue, 15 Oct 2002 21:37:40 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA23561;
	Tue, 15 Oct 2002 21:37:54 +0200 (MET DST)
Date: Tue, 15 Oct 2002 21:37:53 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alexandre Oliva <aoliva@redhat.com>
cc: "H. J. Lu" <hjl@lucon.org>, "David S. Miller" <davem@redhat.com>,
	rsandifo@redhat.com, linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
In-Reply-To: <orbs5wz48c.fsf@free.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.GSO.3.96.1021015203905.20626A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 15 Oct 2002, Alexandre Oliva wrote:

> The compiler is the right place in which to fix out-of-range jumps,
> because the compiler has better information on how to reduce the
> performance impact of such transformation.  It can be fixed in the
> assembler, but it can't be done as efficiently.

 Except that the compiler does not always have the knowledge, particularly
when inline assembly bits (insolvable) or macros such as "la" (unless gcc
gets a full-blown ABI-dependent machinery implemented) are involved.

 I think at least for the former case gas should be let relax jumps and
branches freely, so the ".set nomacro" statement should be moved to affect
instructions in delay slots only, as you suggested.

 For the latter, gas could be able to move parts of macro expansions into
delay slots and it sometimes succeeds, though it isn't particularly good
at it.  Try to assemble e.g.: "bar: lw $2,foo; b bar" for o32/PIC and for
n32/PIC.  It can't be optimized by gcc, if to be emitted, any further
currently and gas (2.13) fails that miserably for the former: 

lw.o:     file format elf32-tradlittlemips

Disassembly of section .text:

00000000 <bar>:
   0:	8f820000 	lw	v0,0(gp)
			0: R_MIPS_GOT16	foo
   4:	00000000 	nop
   8:	8c420000 	lw	v0,0(v0)
   c:	1000fffc 	b	0 <bar>
  10:	00000000 	nop
	...

but it succeeds for the latter!:

lw64.o:     file format elf64-tradlittlemips

Disassembly of section .text:

0000000000000000 <bar>:
   0:	df820000 	ld	v0,0(gp)
			0: R_MIPS_GOT_PAGE	foo
   4:	64420000 	daddiu	v0,v0,0
			4: R_MIPS_GOT_OFST	foo
   8:	1000fffd 	b	0 <bar>
   c:	8c420000 	lw	v0,0(v0)

So there is still a small gain from letting gas try to fill slots usefully
when gcc can't.  Therefore, I agree with H. J. here -- if gcc is about to
put a "nop" into a branch delay, it'd better give it up together with the
".set noreorder" directive, letting gas try again if it can come with
something better.  This isn't ever going to hurt, whether gcc gets smarter
or not, unless gas stops filling delay slots one day, which is unlikely, I
hope.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
