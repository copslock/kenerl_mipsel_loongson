Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2002 16:29:59 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:55019 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122118AbSKYP36>; Mon, 25 Nov 2002 16:29:58 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA13570;
	Mon, 25 Nov 2002 16:30:13 +0100 (MET)
Date: Mon, 25 Nov 2002 16:30:13 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: Ralf Baechle <ralf@linux-mips.org>,
	atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
In-Reply-To: <20021125144059.GA23310@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1021125162225.8769H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 25 Nov 2002, Daniel Jacobowitz wrote:

> >  I think the best use of the watch exception would be making it available
> > to userland via PTRACE_PEEKUSR and PTRACE_POKEUSR for hardware watchpoint
> > support (e.g. for gdb).  Hardware support is absolutely necessary for
> > watching read accesses and much beneficial for write ones (otherwise gdb
> > single-steps code which sucks performace-wise).
> 
> (Although that isn't necessary; page-protection watchpoints are on my
> TODO for next year.  They aren't quite as efficient as hardware
> watchpoints but they don't require hardware support either, just an
> MMU.)

 As a fallback the approach is just fine, but doesn't is suck
performance-wise for watchpoints at the stack?  It certainly sucks for
instruction fetches.  While gdb doesn't seem to use hardware breakpoints
as they are only really necessary for ROMs, other software may want to
(well, gdb too, one day). 

> In any case, yes, the thing to do is choose an API for these and expose
> them via ptrace; not necessarily in PEEKUSER though.  There's no cost
> to adding new PTRACE_* ops.

 Sure, as long as common sense is applied.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
