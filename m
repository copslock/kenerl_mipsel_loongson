Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA44141 for <linux-archive@neteng.engr.sgi.com>; Mon, 1 Mar 1999 15:24:04 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA35330
	for linux-list;
	Mon, 1 Mar 1999 15:22:53 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA52047
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 1 Mar 1999 15:22:49 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA09236
	for <linux@cthulhu.engr.sgi.com>; Mon, 1 Mar 1999 15:22:48 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10Hc1G-0027TFC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 2 Mar 1999 00:22:38 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10Hc19-002PKIC; Tue, 2 Mar 99 00:22 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA02910;
	Tue, 2 Mar 1999 00:16:15 +0100
Message-ID: <19990302001614.B2811@alpha.franken.de>
Date: Tue, 2 Mar 1999 00:16:14 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: mdhill@genxl.com, linux@cthulhu.engr.sgi.com
Subject: Re: 2.2.1 MIPS kernel sources plus Indy kernel binaries uploaded
References: <19990227001617.A4022@alpha.franken.de> <199902270430.XAA21725@wacky.total.net> <19990227120144.A601@alpha.franken.de> <tsbogend@alpha.franken.de> <9902281716.ZM1239@mdhill.genxl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <9902281716.ZM1239@mdhill.genxl.com>; from Michael Hill on Sun, Feb 28, 1999 at 05:16:59PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Feb 28, 1999 at 05:16:59PM -0500, Michael Hill wrote:
> Still have the aforementioned video quirks.  Any further developments 
> regarding Newport revisions?

so far nobody could tell me, how I can read the newport revision. Without
this information it's impossible to implement a runtime workaround for
the cursor problem (and mabye others).

So once again:

Is there anybody on this list, who knows and is willing to tell me, how I
get the newport revision ?

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
