Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2003 14:45:09 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:62098 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225317AbTK0MpD>; Thu, 27 Nov 2003 12:45:03 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 8797A4BFF3; Thu, 27 Nov 2003 13:45:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 7340847B6B; Thu, 27 Nov 2003 13:45:00 +0100 (CET)
Date: Thu, 27 Nov 2003 13:45:00 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] 2.4, head: PAGE_SHIFT changes break glibc
In-Reply-To: <20031126170228.GA13116@nevyn.them.org>
Message-ID: <Pine.LNX.4.55.0311271319470.22529@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0311211550270.32551@jurand.ds.pg.gda.pl>
 <20031121185035.GC8318@linux-mips.org> <Pine.LNX.4.55.0311212021420.32551@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.55.0311251623180.6716@jurand.ds.pg.gda.pl>
 <20031125232439.GE11047@linux-mips.org> <Pine.LNX.4.55.0311260103320.6716@jurand.ds.pg.gda.pl>
 <20031126170228.GA13116@nevyn.them.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 26 Nov 2003, Daniel Jacobowitz wrote:

> >  I suppose so, although being not that fond of insane numbers of syscalls
> > I wonder how sysdeps/unix/sysv/linux/ia64/getpagesize.c gets away with
> > static binaries...  Perhaps we should ask glibc hackers?
> 
> Look at elf/dl-support.c:_dl_aux_init? dl_pagesize should end up
> initialized for static binaries too.

 Thanks for the hint.  I can see _dl_aux_init() gets indeed called from
__libc_start_main() in my i386/Linux libc-start.o binary (in libc.a), but
it does not in my MIPSel/Linux one.  So there must be a bug somewhere in
2.2.5, perhaps fixed later.  I'll have a look at it.  Once fixed, I
guess we should choose the IA64 way.

 After a brief look at the sources I suspect sysdeps/mips/elf/ldsodefs.h
overrides sysdeps/unix/sysv/linux/ldsodefs.h -- if that's the case, the
bug still exists in the trunk.  I'll work on a fix later, probably
tonight.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
