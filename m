Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA26297 for <linux-archive@neteng.engr.sgi.com>; Fri, 19 Feb 1999 17:33:08 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA52640
	for linux-list;
	Fri, 19 Feb 1999 17:32:21 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA06724
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 19 Feb 1999 17:32:18 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA04388
	for <linux@cthulhu.engr.sgi.com>; Fri, 19 Feb 1999 17:32:17 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10E1H6-0027SkC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sat, 20 Feb 1999 02:32:08 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10E1H1-002PXJC; Sat, 20 Feb 99 02:32 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id BAA03882;
	Sat, 20 Feb 1999 01:52:51 +0100
Message-ID: <19990220015251.A3878@alpha.franken.de>
Date: Sat, 20 Feb 1999 01:52:51 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Eric Melville <m_thrope@rigelfore.com>,
        Joan Eslinger <wombat@kilimanjaro.engr.sgi.com>
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: able to bootp/NFS-install/reboot R4400SC Indy
References: <199902170714.XAA09589@kilimanjaro.engr.sgi.com> <36CBB931.D552C44@rigelfore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <36CBB931.D552C44@rigelfore.com>; from Eric Melville on Wed, Feb 17, 1999 at 10:54:41PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Feb 17, 1999 at 10:54:41PM -0800, Eric Melville wrote:
> wait a sec, this is almost identical to mine! R4400 revision 6.0 ... the
> only difference i see is that mine was 200 mhz. what's up with this?
> please, i'd love to get this thing booted so that i can start helping
> with the porting efforts!

I doubt, that your problem is clock rate related. What does your
NFS root look like. Are you using the HardHat root filesystem ?
What type of NFS box are you using ?

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
