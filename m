Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA05968 for <linux-archive@neteng.engr.sgi.com>; Fri, 9 Apr 1999 12:22:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA88416
	for linux-list;
	Fri, 9 Apr 1999 12:21:32 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA87064
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 9 Apr 1999 12:21:31 -0700 (PDT)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA06103
	for <linux@cthulhu.engr.sgi.com>; Fri, 9 Apr 1999 12:21:29 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10Vh0D-0027TeC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Fri, 9 Apr 1999 21:31:45 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10VgqB-002P2dC; Fri, 9 Apr 99 21:21 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id VAA02018
	for linux@cthulhu.engr.sgi.com; Fri, 9 Apr 1999 21:17:20 +0200
Message-ID: <19990409211720.A2015@alpha.franken.de>
Date: Fri, 9 Apr 1999 21:17:20 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Subject: Re: Indy ISDN questions
References: <19990408223436.A2491@alpha.franken.de> <19990408215230.A4951@fmc-container.mach.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19990408215230.A4951@fmc-container.mach.uni-karlsruhe.de>; from Matthias Kleinschmidt on Thu, Apr 08, 1999 at 09:52:30PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Apr 08, 1999 at 09:52:30PM -0400, Matthias Kleinschmidt wrote:
> On Thu, Apr 08, 1999 at 10:34:36PM +0200, Thomas Bogendoerfer wrote:
> > Ok, after Ulf got the sound working the remaining not supported hardware 
> > is VINO and ISDN.
> 
> What about parallel port support? Or am I just unable to find it?

who needs it ? These days every sane printer has a ethernet built in or
is attached to a 386sx Linux box as print server:-) And scanners
shouldn't be connected to printer ports. But a parallel port driver
isn't a major deal (as long as it is a _printer_ port) and could be
done by nearly everbody during a evening hacking session:-)

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
