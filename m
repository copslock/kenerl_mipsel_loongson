Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2002 10:15:41 +0200 (CEST)
Received: from alg133.algor.co.uk ([62.254.210.133]:28613 "EHLO
	oval.algor.co.uk") by linux-mips.org with ESMTP id <S1122978AbSJOIPk>;
	Tue, 15 Oct 2002 10:15:40 +0200
Received: from gladsmuir.algor.co.uk (pubfw.algor.co.uk [62.254.210.129])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g9F8FLr20663;
	Tue, 15 Oct 2002 09:15:26 +0100 (BST)
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15787.52889.454591.611223@gladsmuir.algor.co.uk>
Date: Tue, 15 Oct 2002 09:15:21 +0100
To: Alexandre Oliva <aoliva@redhat.com>
Cc: "H. J. Lu" <hjl@lucon.org>, "David S. Miller" <davem@redhat.com>,
	rsandifo@redhat.com, linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com, nigel@algor.co.uk
Subject: Re: MIPS gas relaxation still doesn't work
In-Reply-To: <orbs5wz48c.fsf@free.redhat.lsd.ic.unicamp.br>
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
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Return-Path: <dom@algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


Alexandre,

> I know the problem that branch relaxation [aka delay-slot filling by
> the assembler] is intended to solve: it's a
> work around for a long-standing bug in the compiler.  In that it
> apparently assumes that the expansion of certain macros is shorter
> than they actually are, so it ends up not doing branch shortening in
> some necessary situations.  This gets even worse with mips16, in which
> we don't do branch shortening, and the assembler doesn't do branch
> relaxation.

This true - but it isn't why it's there.  Getting the assembler
involved goes back to the early 1980s roots of the MIPS project:

o It saved putting novel and interesting code into compilers.  A safe
  and quick hack to the assembler probably catches more than half the
  delay slots available; anything other than very clever compiler work
  might do little better.  Nobody should forget that most 
  'commercial' compilers are even more ghastly than gcc.

o It concealed the deeply unfamiliar and counter-intuitive "delay
  slot" from the assembler programmer.

o At the time, MIPS' assembler was related to a DoD initiative to
  write mission-critical software via a
  slightly-higher-than-machine-language assembly code - a kind of
  "what if Ada doesn't work?" project.  As such, there was good reason
  to get the *compiler* to target assembler language.

The first GCC ports for MIPS were quick hacks using the MIPS
assembler. They made liberal use of what were effectively macro
instructions.  RISC CPUs were kind of new, and back-end coders quailed
at a machine which had no register-to-register move and where even the
nop is an alias.  More pernicious, as you say, is the use of macros
such as "la" or even "lw" which expand different ways...

Which got a whole lot worse when gcc/gas was hacked again for position
independent code and the bulk of that work was done in the assembler.

> But while you're trying to paper over the problem, others are
> rewriting the mips back end so as to not make use of macros, such that
> instruction lengths will be more accurate and then branch shortening
> will (hopefully) work correctly.

Other pressures, unfortunately, operate the other way; you could
generate substantially better position-independent MIPS code if you
were prepared to avoid committing the final instruction sequence until
the link which produced the executable or shared object...

But getting the assembler macros out of the compiler is a long-overdue
reform.

Algorithmics (now part of MIPS) have been chiselling away at this for
a long while, but opportunistically rather than as a focussed problem.
Moreover, our limited resource + the poor state of standard gcc
releases (at least up to two years ago) meant that producing a decent
usable compiler always took us so long that by the time it worked our
codebase was too old to facilitate changes going back.  We do have a
lot of useful changes for MIPS, and aim to resynchronise to 3.x and 
make a substantial attempt to get those changes back into the main
source trees, perhaps in 6 months time.

Meanwhile, do you have some sense of a plausible team and a schedule
for this reform in the 3.1.x codebase?

-- 
Dominic Sweetman
MIPS Technologies (formerly Algorithmics Ltd)
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone +44 1223 706200/fax +44 1223 706250/direct +44 1223 706205
http://www.algor.co.uk
