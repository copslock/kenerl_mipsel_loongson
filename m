Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA50665 for <linux-archive@neteng.engr.sgi.com>; Tue, 9 Feb 1999 13:41:23 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA01777
	for linux-list;
	Tue, 9 Feb 1999 13:40:34 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA99362
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 9 Feb 1999 13:40:33 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA04267
	for <linux@cthulhu.engr.sgi.com>; Tue, 9 Feb 1999 13:40:32 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10AKrT-0027UUC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 9 Feb 1999 22:38:27 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10AKrL-002OikC; Tue, 9 Feb 99 22:38 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA01546;
	Tue, 9 Feb 1999 22:31:55 +0100
Message-ID: <19990209223155.B1509@alpha.franken.de>
Date: Tue, 9 Feb 1999 22:31:55 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Moving drivers/sgi around
References: <Pine.LNX.3.96.990208190349.11444F-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.3.96.990208190349.11444F-100000@lager.engsoc.carleton.ca>; from Alex deVries on Mon, Feb 08, 1999 at 07:06:22PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Feb 08, 1999 at 07:06:22PM -0500, Alex deVries wrote:
> Are there any objections to me moving drivers/sgi and merging them into
> the 'correct' places?  The places in question are:
[...]
> Any objections?

not really, but I don't like it either. As long as the drivers in drivers/sgi
aren't usefull for other architectures, I would leave them, where they are.
There is enough different stuff sitting in drivers/char, which should
be sorted out and stuffed into better subdirectories.

I'm even not sure, whether my decision to put newport_con into drivers/video
was the right one. But at least drivers/video contains only driver dedicated 
to the same thing,which is to provide a console.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
