Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2003 14:46:27 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:34713 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225425AbTK0RhW>;
	Thu, 27 Nov 2003 17:37:22 +0000
Received: from drow by nevyn.them.org with local (Exim 4.24 #1 (Debian))
	id 1APQ4o-0006oJ-8V; Thu, 27 Nov 2003 12:37:14 -0500
Date: Thu, 27 Nov 2003 12:37:14 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] 2.4, head: PAGE_SHIFT changes break glibc
Message-ID: <20031127173714.GA26143@nevyn.them.org>
References: <Pine.LNX.4.55.0311211550270.32551@jurand.ds.pg.gda.pl> <20031121185035.GC8318@linux-mips.org> <Pine.LNX.4.55.0311212021420.32551@jurand.ds.pg.gda.pl> <Pine.LNX.4.55.0311251623180.6716@jurand.ds.pg.gda.pl> <20031125232439.GE11047@linux-mips.org> <Pine.LNX.4.55.0311260103320.6716@jurand.ds.pg.gda.pl> <20031126170228.GA13116@nevyn.them.org> <Pine.LNX.4.55.0311271319470.22529@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0311271319470.22529@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 27, 2003 at 01:45:00PM +0100, Maciej W. Rozycki wrote:
> On Wed, 26 Nov 2003, Daniel Jacobowitz wrote:
> 
> > >  I suppose so, although being not that fond of insane numbers of syscalls
> > > I wonder how sysdeps/unix/sysv/linux/ia64/getpagesize.c gets away with
> > > static binaries...  Perhaps we should ask glibc hackers?
> > 
> > Look at elf/dl-support.c:_dl_aux_init? dl_pagesize should end up
> > initialized for static binaries too.
> 
>  Thanks for the hint.  I can see _dl_aux_init() gets indeed called from
> __libc_start_main() in my i386/Linux libc-start.o binary (in libc.a), but
> it does not in my MIPSel/Linux one.  So there must be a bug somewhere in
> 2.2.5, perhaps fixed later.  I'll have a look at it.  Once fixed, I
> guess we should choose the IA64 way.
> 
>  After a brief look at the sources I suspect sysdeps/mips/elf/ldsodefs.h
> overrides sysdeps/unix/sysv/linux/ldsodefs.h -- if that's the case, the
> bug still exists in the trunk.  I'll work on a fix later, probably
> tonight.

_dl_aux_init ought to be called from __libc_start_main in
sysdeps/generic/libc-start.c.  In current sources I can't see any way
for that to go wrong on MIPS (but my MIPS board is off right now so I
haven't tried it)...

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
