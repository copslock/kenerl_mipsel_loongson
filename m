Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA65636 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Mar 1999 15:33:12 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA75874
	for linux-list;
	Wed, 10 Mar 1999 15:32:15 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA81349
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 10 Mar 1999 15:32:13 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA04802
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Mar 1999 15:32:14 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10KsRC-0027TtC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 11 Mar 1999 00:30:54 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10KsRA-002OzyC; Thu, 11 Mar 99 00:30 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA00371;
	Thu, 11 Mar 1999 00:27:13 +0100
Message-ID: <19990311002713.A368@alpha.franken.de>
Date: Thu, 11 Mar 1999 00:27:13 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: eedthwo@eede.ericsson.se
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Illegal f_magic number while install-procedure
References: <199903081247.NAA02741@sun168.eu> <19990309000234.A2804@alpha.franken.de> <199903100920.KAA01213@sun168.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199903100920.KAA01213@sun168.eu>; from Tom Woelfel on Wed, Mar 10, 1999 at 10:20:19AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Mar 10, 1999 at 10:20:19AM +0100, Tom Woelfel wrote:
> Then nothing happens anymore. I think the next thing to come should be 
> the 'init' process (init doesn't need to be an ECOFF - exec ?).

no elf is perfect. Could you please send a hinv output ? I suspect this
another SC processor. 

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
