Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA47096 for <linux-archive@neteng.engr.sgi.com>; Fri, 12 Feb 1999 02:22:10 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA35056
	for linux-list;
	Fri, 12 Feb 1999 02:21:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA42590
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 12 Feb 1999 02:21:30 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA07163
	for <linux@cthulhu.engr.sgi.com>; Fri, 12 Feb 1999 02:21:12 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10BFic-0027SwC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Fri, 12 Feb 1999 11:21:06 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10BFiX-002OazC; Fri, 12 Feb 99 11:21 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id LAA01063;
	Fri, 12 Feb 1999 11:16:41 +0100
Message-ID: <19990212111641.A1060@alpha.franken.de>
Date: Fri, 12 Feb 1999 11:16:41 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: chad@sgi.com, ralf@uni-koblenz.de, Alexander Graefe <nachtfalke@usa.net>,
        adevries@engsoc.carleton.ca
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: What kernel to use to install RH on a R4400 ?
References: <19990202155147.A1565@ganymede> <19990203043951.D3920@uni-koblenz.de> <19990204154637.B5941@ganymede> <19990205034821.A620@uni-koblenz.de> <36C39A50.6EE8E619@dallas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <36C39A50.6EE8E619@dallas.sgi.com>; from Chad Carlin on Thu, Feb 11, 1999 at 09:04:58PM -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Feb 11, 1999 at 09:04:58PM -0600, Chad Carlin wrote:
> Any chance of fixing nfsroot in the .131 kernel? I think that might get me
> there.

looks like someone is eating my emails to this list.

Please try:

ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-990212.gz

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
