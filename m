Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA96056 for <linux-archive@neteng.engr.sgi.com>; Sun, 17 Jan 1999 23:50:18 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA48969
	for linux-list;
	Sun, 17 Jan 1999 23:49:31 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA65705
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 17 Jan 1999 23:49:24 -0800 (PST)
	mail_from (deliverator.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA07151
	for <linux@cthulhu.engr.sgi.com>; Mon, 18 Jan 1999 14:02:03 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m102Msf-0027r8C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Mon, 18 Jan 1999 23:10:45 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m102MsT-002OzmC; Mon, 18 Jan 99 23:10 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA03631;
	Mon, 18 Jan 1999 22:40:58 +0100
Message-ID: <19990118224057.A3501@alpha.franken.de>
Date: Mon, 18 Jan 1999 22:40:57 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Problems getting 2.1.131 to build.
References: <Pine.LNX.3.96.990118011528.30635A-100000@lager.engsoc.carleton.ca> <Pine.LNX.3.96.990118015635.30635G-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.96.990118015635.30635G-100000@lager.engsoc.carleton.ca>; from Alex deVries on Mon, Jan 18, 1999 at 01:57:31AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jan 18, 1999 at 01:57:31AM -0500, Alex deVries wrote:
> Ah, I see.  Just disabled SGI RTC support, and it builds. Binaries
> tomorrow.

wrong solution, disable "Enhanced Real Time Clock Support" and let
SGI RTC enabled. It's possible, that this is the cause for your
boot problem.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
