Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA54226 for <linux-archive@neteng.engr.sgi.com>; Mon, 5 Apr 1999 17:10:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA00948
	for linux-list;
	Mon, 5 Apr 1999 16:47:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA66942
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 5 Apr 1999 16:43:45 -0700 (PDT)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03480
	for <linux@cthulhu.engr.sgi.com>; Mon, 5 Apr 1999 16:43:44 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10UJA3-0027TUC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 6 Apr 1999 01:52:11 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10UJ1e-002PcGC; Tue, 6 Apr 99 01:43 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA03401;
	Tue, 6 Apr 1999 00:43:19 +0200
Message-ID: <19990406004319.C2370@alpha.franken.de>
Date: Tue, 6 Apr 1999 00:43:19 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Miles Lott <milos@kprc.com>,
        "'Alex deVries'" <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: New Indy kernel uploaded
References: <8F94EAC86EE3D011BBCB08003667410229A436@aries.kprc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <8F94EAC86EE3D011BBCB08003667410229A436@aries.kprc.net>; from Miles Lott on Mon, Apr 05, 1999 at 01:18:03PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Apr 05, 1999 at 01:18:03PM -0500, Miles Lott wrote:
> Should I leave the detected partitions as is during the redhat install,
> and not repartition ext2 using diskdruid or fdisk?

don't touch the partitions (if they don't fit, use Irix to change them), but
make sure, that the installer creates a new filesystem.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
