Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2002 00:32:44 +0200 (CEST)
Received: from mx2.redhat.com ([12.150.115.133]:49668 "EHLO mx2.redhat.com")
	by linux-mips.org with ESMTP id <S1124020AbSJOWcn>;
	Wed, 16 Oct 2002 00:32:43 +0200
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id g9FMVqs15664;
	Tue, 15 Oct 2002 18:31:52 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id g9FMWQl10964;
	Tue, 15 Oct 2002 18:32:26 -0400
Received: from tonopah.toronto.redhat.com (tonopah.toronto.redhat.com [172.16.14.91])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id g9FMWND14971;
	Tue, 15 Oct 2002 15:32:23 -0700
Received: (from wilson@localhost)
	by tonopah.toronto.redhat.com (8.11.6/8.11.6) id g9FMWNU07028;
	Tue, 15 Oct 2002 18:32:23 -0400
X-Authentication-Warning: tonopah.toronto.redhat.com: wilson set sender to wilson@redhat.com using -f
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Alexandre Oliva <aoliva@redhat.com>, "H. J. Lu" <hjl@lucon.org>,
	"David S. Miller" <davem@redhat.com>, rsandifo@redhat.com,
	linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
References: <Pine.GSO.3.96.1021015203905.20626A-100000@delta.ds2.pg.gda.pl>
From: Jim Wilson <wilson@redhat.com>
Date: 15 Oct 2002 18:32:22 -0400
In-Reply-To: <Pine.GSO.3.96.1021015203905.20626A-100000@delta.ds2.pg.gda.pl>
Message-ID: <xwun0pfwcy1.fsf@tonopah.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wilson@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@redhat.com
Precedence: bulk
X-list: linux-mips

> Except that the compiler does not always have the knowledge, particularly
>when inline assembly bits (insolvable) or macros such as "la" (unless gcc
>gets a full-blown ABI-dependent machinery implemented) are involved.

There is a natural conflict between compiler optimization and assembler
optimization/assembler macro expansion.  If you want the best possible
compiler optimization, then you need to be willing to give up use of
assembler optimizations and assembler macros.  That includes uses in extended
asms.  We can make that work if we have to, but it is better if we don't have
to.

> For the latter, gas could be able to move parts of macro expansions into
>delay slots and it sometimes succeeds, though it isn't particularly good
>at it.

This is ISA confusion.  When you ask gas to generate o32/PIC code, it assumes
the least common denominator, which is the R2000.  The R2000 does not have
hardware interlocks on loads.  It requires a nop in between a load and the
instruction that uses the result of the load.  Therefore, we can not put a
load in a delay slot unless we know that the instruction at the branch target
does not use the result of the load.  Since gas doesn't bother to construct
a control flow graph, we have no idea what is at the branch target, and
therefore we can't put a load in the branch delay slot.

When you ask gas to generate n32/PIC code, the least common denominator is
the R4000, which does have hardware interlocks on loads, and thus we can put
a load into a delay slot.

If you ask gas to generate R4000 o32/PIC code, it will fill the delay slot
exactly like you wanted, but the code may fail at run time on some mips
processors.

> It can't be optimized by gcc, if to be emitted,

It can be optimized if we use direct cpu instructions instead of relying
on assembler macros.  Then gcc would know about the load instructions, and
would be able to place one in the branch delay slot (assuming a R4000 or
better target).

The MIPS gcc target is the only one that has this problem, because it is the
only one that relies on assembler macros for PIC support.

>So there is still a small gain from letting gas try to fill slots usefully
>when gcc can't. ...
> This isn't ever going to hurt, whether gcc gets smarter
>or not,

Yes it can hurt.  If gcc decides the optimal code for a loop requires putting
a nop in a branch delay slot, then the assembler would hurt performance if
it put another instruction there.

If your main concern is only extended asm code writting using assembler macros,
then that can be fixed by turning on assembler optimization within the
extended asm code.  In the long run though, you are better off if you stop
using assembler macros.

Jim
