Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2002 07:00:21 +0200 (CEST)
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:17318 "EHLO
	lacrosse.corp.redhat.com") by linux-mips.org with ESMTP
	id <S1123944AbSJOFAU>; Tue, 15 Oct 2002 07:00:20 +0200
Received: from free.redhat.lsd.ic.unicamp.br (aoliva2.cipe.redhat.com [10.0.1.156])
	by lacrosse.corp.redhat.com (8.11.6/8.9.3) with ESMTP id g9F506P32511;
	Tue, 15 Oct 2002 01:00:06 -0400
Received: from free.redhat.lsd.ic.unicamp.br (localhost.localdomain [127.0.0.1])
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5) with ESMTP id g9F505xB011056;
	Tue, 15 Oct 2002 03:00:05 -0200
Received: (from aoliva@localhost)
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5/Submit) id g9F503xn011052;
	Tue, 15 Oct 2002 02:00:03 -0300
To: "H. J. Lu" <hjl@lucon.org>
Cc: "David S. Miller" <davem@redhat.com>, rsandifo@redhat.com,
	linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
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
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 15 Oct 2002 02:00:03 -0300
In-Reply-To: <20021014141442.A1158@lucon.org>
Message-ID: <orbs5wz48c.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <aoliva@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aoliva@redhat.com
Precedence: bulk
X-list: linux-mips

On Oct 14, 2002, "H. J. Lu" <hjl@lucon.org> wrote:

> Have you ever tried g++.dg/opt/longbranch1.C in gcc 3.2 for ELF/mips?

Yes, I have, and it has failed in the past.  I don't know about the
current status and, frankly, I don't understand what point you're
trying to make waving your hands in the general direction of
longbranch1.C while discussing whether gas would have any chance of
filling a delay slot that gcc has failed to fill.

> If you want, I can tell you where you can find a complete cross
> toolchain for Linux/mips hosted on Linux/x86.

Thanks, I've built such toolchains more than once a day lately :-)

I know the problem that branch relaxation is intended to solve: it's a
work around for a long-standing bug in the compiler.  In that it
apparently assumes that the expansion of certain macros is shorter
than they actually are, so it ends up not doing branch shortening in
some necessary situations.  This gets even worse with mips16, in which
we don't do branch shortening, and the assembler doesn't do branch
relaxation.

But while you're trying to paper over the problem, others are
rewriting the mips back end so as to not make use of macros, such that
instruction lengths will be more accurate and then branch shortening
will (hopefully) work correctly.

The compiler is the right place in which to fix out-of-range jumps,
because the compiler has better information on how to reduce the
performance impact of such transformation.  It can be fixed in the
assembler, but it can't be done as efficiently.

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist                Professional serial bug killer
