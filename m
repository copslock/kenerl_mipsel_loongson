Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA07343; Tue, 8 Apr 1997 17:02:54 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA24880 for linux-list; Tue, 8 Apr 1997 17:02:19 -0700
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA24870 for <linux@engr.sgi.com>; Tue, 8 Apr 1997 17:02:18 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	for <@ares.esd.sgi.com:linux@engr.sgi.com> id RAA02548; Tue, 8 Apr 1997 17:02:17 -0700
Received: (from wje@localhost) by fir.esd.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id RAA14801; Tue, 8 Apr 1997 17:02:14 -0700
Date: Tue, 8 Apr 1997 17:02:14 -0700
Message-Id: <199704090002.RAA14801@fir.esd.sgi.com>
From: "William J. Earl" <wje@fir.esd.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: Re: It booooooooooots!
In-Reply-To: <9704091140.ZM8508@windy.wellington.sgi.com>
References: <199704082223.SAA03675@neon.ingenia.ca>
	<199704082337.QAA14690@fir.esd.sgi.com>
	<wje@fir.esd.sgi.com>
	<9704091140.ZM8508@windy.wellington.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alistair Lambie writes:
 > On Apr 9, 11:38am, William J. Earl wrote:
 > > Subject: Re: It booooooooooots!
 > > Mike Shaver writes:
...
 > >  > Checking for 'wait' instruction...  unavailable.
 > > ...
 > >
 > >      This appears to be a bug.  The R5000 does have the wait instruction.
 > 
 > I don't think David ever worked on an R5000.  The only platforms were R4600 &
 > R4400...soooo, there may be some issues to be resolved.
...

     On an Indy, the R5000 and R4600 are basically equivalent, except
for the MIPS IV extensions and larger caches (32 KB versus 16 KB) on the R5000.
The R5000 does have built-in secondary cache control, which is used on the O2,
but it is not used on the Indy.  On the Indy, the R5000 uses the same off-chip
secondary cache controller as the R4600.  The wait instruction operates the
same on both processors.  The wait instruction is not really essential in any
case, since its main purpose is to save power, and the R5000 and R4600 don't
use much power anyway.
