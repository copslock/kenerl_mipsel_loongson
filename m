Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2002 22:19:32 +0200 (CEST)
Received: from mx2.redhat.com ([12.150.115.133]:33042 "EHLO mx2.redhat.com")
	by linux-mips.org with ESMTP id <S1122978AbSJOUTb>;
	Tue, 15 Oct 2002 22:19:31 +0200
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id g9FKIhs15013;
	Tue, 15 Oct 2002 16:18:43 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id g9FKJHl10229;
	Tue, 15 Oct 2002 16:19:17 -0400
Received: from tonopah.toronto.redhat.com (tonopah.toronto.redhat.com [172.16.14.91])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id g9FKJDD10189;
	Tue, 15 Oct 2002 13:19:14 -0700
Received: (from wilson@localhost)
	by tonopah.toronto.redhat.com (8.11.6/8.11.6) id g9FKJCs24087;
	Tue, 15 Oct 2002 16:19:12 -0400
X-Authentication-Warning: tonopah.toronto.redhat.com: wilson set sender to wilson@redhat.com using -f
To: Dominic Sweetman <dom@algor.co.uk>
Cc: Alexandre Oliva <aoliva@redhat.com>, "H. J. Lu" <hjl@lucon.org>,
	"David S. Miller" <davem@redhat.com>, rsandifo@redhat.com,
	linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com, nigel@algor.co.uk
Subject: Re: MIPS gas relaxation still doesn't work
References: <20021014123940.A32333@lucon.org>
	<20021014.123510.00003943.davem@redhat.com>
	<20021014125549.A32575@lucon.org>
	<20021014.125134.98070597.davem@redhat.com>
	<20021014130932.A32693@lucon.org>
	<orwuokzs9k.fsf@free.redhat.lsd.ic.unicamp.br>
	<20021014132352.A489@lucon.org>
	<orof9wzq5r.fsf@free.redhat.lsd.ic.unicamp.br>
	<20021014141442.A1158@lucon.org>
	<orbs5wz48c.fsf@free.redhat.lsd.ic.unicamp.br>
	<15787.52889.454591.611223@gladsmuir.algor.co.uk>
From: Jim Wilson <wilson@redhat.com>
Date: 15 Oct 2002 16:19:12 -0400
In-Reply-To: <15787.52889.454591.611223@gladsmuir.algor.co.uk>
Message-ID: <xwuof9vxxof.fsf@tonopah.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wilson@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@redhat.com
Precedence: bulk
X-list: linux-mips

Your historical info is only partly accurate.

You are right about the beginning part.  In the beginning there was MIPS,
and MIPS wrote a toolchain that tried to be friendly to assembly language
programmers.  Because of this, some optimizations, mainly instruction
scheduling and delay-slot filling, were implemented in the assembler instead
of the compiler, so that they would be usuable to assembly language
programmers.  Since gcc/binutils usually follows conventions set by the
vendor, gcc/binutils did things the same way.

Later, gcc started using its own instruction scheduler and delay-slot filling
optimization passes, but we never fully moved away from relying on assembler
optimizations.

>The first GCC ports for MIPS were quick hacks using the MIPS
>assembler. They made liberal use of what were effectively macro
>instructions. 

I think this is inaccurate in a number of ways.  It is a gcc convention
to use the native assembler whenever possible, and be compatible with the
native assembler language.  We write our own assembler only when the native
one isn't good enough to bootstrap gcc, or when there is no other native
assembler, e.g. embedded and linux targets.  Similarly, we create our own
assembler language only when there isn't an existing one we can use.  So there
was nothing wrong with using the MIPS/SGI assembler for the original gcc ports.
Also, gcc followed the conventions set by the MIPS/SGI compilers, which used
macro instructions very heavily.  Thus gcc used macro instructions heavily
also.  In hindsight this was a mistake, but at the time it wasn't so obvious.

>Which got a whole lot worse when gcc/gas was hacked again for position
>independent code and the bulk of that work was done in the assembler.

I agree everything got a lot uglier when PIC support was added.  However,
it was SGI that did it first in the assembler, and gcc/gas just followed
exactly the conventions that were defined and implemented by SGI, in order
to maintain compatibility with SGI systems.

When we added PIC support for embedded systems, it was just more of the same.

>But getting the assembler macros out of the compiler is a long-overdue
>reform.

Definitely.

SGI eventually realized their original toolchain design was limiting their
performance, and when SGI introduced their 64-bit Irix6 workstations, they
used this as an excuse to write a new compiler from scratch in which all
optimizations were performed in the compiler, and no assembler optimizations
were used at all.  Gcc has unfortunately not made the switch over yet, but
people are working on it.  Once again, we are following conventions defined
by SGI.

Jim
