Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jul 2004 12:56:55 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:30476 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224948AbUGZL4u>; Mon, 26 Jul 2004 12:56:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E60C3E1CA6; Mon, 26 Jul 2004 13:56:45 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16700-04; Mon, 26 Jul 2004 13:56:45 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 984F5E1CA4; Mon, 26 Jul 2004 13:56:45 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.11.4) with ESMTP id i6QBurjQ028588;
	Mon, 26 Jul 2004 13:56:53 +0200
Date: Mon, 26 Jul 2004 13:56:47 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Richard Henderson <rth@redhat.com>,
	Richard Sandiford <rsandifo@redhat.com>,
	gcc-patches@gcc.gnu.org, linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
In-Reply-To: <20040723211232.GB5138@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0407261325470.3873@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl>
 <87hds49bmo.fsf@redhat.com> <Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl>
 <20040719213801.GD14931@redhat.com> <Pine.LNX.4.55.0407201505330.14824@jurand.ds.pg.gda.pl>
 <20040723202703.GB30931@redhat.com> <20040723211232.GB5138@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 23 Jul 2004, Ralf Baechle wrote:

> With a bit of hand waiving because haven't done benchmarks I guess Richard
> might be right.  The subroutine calling overhead on modern processors is
> rather low and smaller code means better cache hit rates ...

 Well, I just worry the call may itself include at least the same number
of instructions as the callee if inlined.  There would be no way for it to
be faster.

 That may happen for a leaf function -- the call itself, plus $ra
saving/restoration is already four instructions.  Now it's sufficient for
two statics to be needed to preserve temporaries across such a call and
the size of the caller is already the same.  With three statics, you lose
even for a non-leaf function.  That's for a function containing a single
call to such a shift -- if there are more, then you may win (but is it
common?).

 So not only it may not be faster, but the resulting code may be bigger as
well.  That said, the current GCC's implementation of these operations is
not exactly optimal for current MIPS processors.  That's trivial to deal
with in Linux, but would it be possible to pick a different implementation
from libgcc based on the "-march=" setting, too?

  Maciej
