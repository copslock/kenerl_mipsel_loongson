Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA51184 for <linux-archive@neteng.engr.sgi.com>; Sat, 13 Mar 1999 02:44:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA87451
	for linux-list;
	Sat, 13 Mar 1999 02:43:24 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA05196;
	Sat, 13 Mar 1999 02:43:20 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA07854; Sat, 13 Mar 1999 02:43:17 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10Lls7-0027T4C@rachael.franken.de>
	for cthulhu.engr.sgi.com!ariel; Sat, 13 Mar 1999 11:42:23 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10LeLS-002OiZC; Sat, 13 Mar 99 03:40 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id DAA04162;
	Sat, 13 Mar 1999 03:35:34 +0100
Message-ID: <19990313033534.C4129@alpha.franken.de>
Date: Sat, 13 Mar 1999 03:35:34 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>, adelton@informatics.muni.cz
Cc: ariel@cthulhu.engr.sgi.com, darkaeon@cubicsky.com,
        linux@cthulhu.engr.sgi.com
Subject: Re: Indigo2 & Linux
References: <36E85AC2.25F7C9B0@kotetsu.cubicsky.com> <199903112224.OAA54631@oz.engr.sgi.com> <19990312111717.A3024@aisa.fi.muni.cz> <199903121814.MAA30851@metropolis.nuclecu.unam.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199903121814.MAA30851@metropolis.nuclecu.unam.mx>; from Miguel de Icaza on Fri, Mar 12, 1999 at 12:14:51PM -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Mar 12, 1999 at 12:14:51PM -0600, Miguel de Icaza wrote:
> The kernel support is integrated.  You just need to setup an IRIX
> emulation environment (/usr/emul/irix perhaps?  I forget) and the
> proper devices used by the X server in /dev and you should be able to
> launch the X server.

I don't think this still works with a current kernel. I'm pretty sure, that
I broke at least the graphics device, when I did the new newport console.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
