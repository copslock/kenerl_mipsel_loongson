Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Feb 2004 01:45:32 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:45029 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225485AbUBOBp1>;
	Sun, 15 Feb 2004 01:45:27 +0000
Received: from drow by nevyn.them.org with local (Exim 4.30 #1 (Debian))
	id 1AsBKq-00052v-Ur; Sat, 14 Feb 2004 20:44:40 -0500
Date: Sat, 14 Feb 2004 20:44:40 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@linux-mips.org>,
	David Daney <ddaney@avtrex.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: [patch] Prevent dead code/data removal with gcc 3.4
Message-ID: <20040215014440.GA19373@nevyn.them.org>
References: <20040213145316.GA23810@linux-mips.org> <20040213222253.GA20118@rembrandt.csv.ica.uni-stuttgart.de> <402D513F.8080205@avtrex.com> <20040213224959.GB20118@rembrandt.csv.ica.uni-stuttgart.de> <20040214011539.GB31847@linux-mips.org> <20040214012801.GC20118@rembrandt.csv.ica.uni-stuttgart.de> <20040214014520.GA4588@linux-mips.org> <20040214021740.GE20118@rembrandt.csv.ica.uni-stuttgart.de> <20040214061353.GA21449@mvista.com> <20040214062849.GA20171@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040214062849.GA20171@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 14, 2004 at 07:28:49AM +0100, Thiemo Seufer wrote:
> Jun Sun wrote:
> > On Sat, Feb 14, 2004 at 03:17:40AM +0100, Thiemo Seufer wrote:
> > > Ralf Baechle wrote:
> > > [snip]
> > > > Anyway, gcc could load next weeks lucky lottery numbers into the
> > > > s-registers after saving them.  That'd break save_static but not the
> > > > ABI which only promises to restore the old values in s-registers on
> > > > return.
> > > 
> > > Ok, it could, but adding such insns to the prologue wouldn't make
> > > sense at all, so this is unlikely to happen.
> > > 
> > 
> > OS people who have been around long enough know "unlikely" things
> > always end up happening. :)
> [snip]
> > sys_sigsuspend(struct pt_regs regs)
> > {
> >     8008e280:   27bdffc0        addiu   $sp,$sp,-64
> >     8008e284:   afb00030        sw      $s0,48($sp)
> >         sigset_t *uset, saveset, newset;
> > 
> >         save_static(&regs);
> 
> Which is a compiler bug, because it schedules around __asm__ __volatile__,
> but not a breakage caused by the prologue.
> 
> There's no way to be safe from broken compilers.

Not at all.  It's not code being scheduled around the asm - it's _part
of the prologue_ to save $s0 to the stack.  Register saves are
considered part of the prologue.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
