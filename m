Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2002 13:03:08 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:45524 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122978AbSJPLDH>; Wed, 16 Oct 2002 13:03:07 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA16398;
	Wed, 16 Oct 2002 13:03:27 +0200 (MET DST)
Date: Wed, 16 Oct 2002 13:03:27 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jim Wilson <wilson@redhat.com>
cc: Alexandre Oliva <aoliva@redhat.com>, "H. J. Lu" <hjl@lucon.org>,
	"David S. Miller" <davem@redhat.com>, rsandifo@redhat.com,
	linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
In-Reply-To: <xwun0pfwcy1.fsf@tonopah.toronto.redhat.com>
Message-ID: <Pine.GSO.3.96.1021016124113.14774D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 15 Oct 2002, Jim Wilson wrote:

> There is a natural conflict between compiler optimization and assembler
> optimization/assembler macro expansion.  If you want the best possible
> compiler optimization, then you need to be willing to give up use of
> assembler optimizations and assembler macros.  That includes uses in extended
> asms.  We can make that work if we have to, but it is better if we don't have
> to.

 If gcc can fully handle all possible cases that gas does, I see no
problem.  That may be beneficial if done well, but will require care to
track changes done to both code generation engines to make sure they are
in sync.  If gcc keeps the recent good habit of frequent releases, then
it's perfecty acceptable.

> This is ISA confusion.  When you ask gas to generate o32/PIC code, it assumes
> the least common denominator, which is the R2000.  The R2000 does not have
> hardware interlocks on loads.  It requires a nop in between a load and the
> instruction that uses the result of the load.  Therefore, we can not put a
> load in a delay slot unless we know that the instruction at the branch target
> does not use the result of the load.  Since gas doesn't bother to construct
> a control flow graph, we have no idea what is at the branch target, and
> therefore we can't put a load in the branch delay slot.

 I'm sorry, I missed the load delay slot property first and only some time
later I recalled it (shame on me -- I even own an R3k system ;-) ).  Still
for "-mips2" the code is not exactly perfect:

la2.o:     file format elf32-tradlittlemips

Disassembly of section .text:

00000000 <bar>:
   0:	8f820000 	lw	v0,0(gp)
			0: R_MIPS_GOT16	foo
   4:	00000000 	nop
   8:	1000fffd 	b	0 <bar>
   c:	8c420000 	lw	v0,0(v0)

The "nop" is unnecessary.

> It can be optimized if we use direct cpu instructions instead of relying
> on assembler macros.  Then gcc would know about the load instructions, and
> would be able to place one in the branch delay slot (assuming a R4000 or
> better target).

 To nitpick, actually an R6000 suffices. ;-)

> The MIPS gcc target is the only one that has this problem, because it is the
> only one that relies on assembler macros for PIC support.

 So it does for non-PIC.

> Yes it can hurt.  If gcc decides the optimal code for a loop requires putting
> a nop in a branch delay slot, then the assembler would hurt performance if
> it put another instruction there.

 Once it only emits machine instructions and it can really judge the "nop"
is a win -- I agree.  Still it may emit ".set reorder; .set macro" if it
cannot judge for some reason.

> If your main concern is only extended asm code writting using assembler macros,
> then that can be fixed by turning on assembler optimization within the
> extended asm code.  In the long run though, you are better off if you stop
> using assembler macros.

 As soon as gcc supports plain machine instructions well, as I wrote in
another mail, I see no showstopper problems.  Though putting a "nop" 
surrounded with an "ifdef" clause in all load delay slots you cannot
usefully fill is not nice -- maybe a "%" code could be added to gcc to let
an assembly programmer express these "nop" fillers in a way gcc would know
about them and be able to remove them if unneeded. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
