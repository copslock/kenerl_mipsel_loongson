Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA16696
	for <pstadt@stud.fh-heilbronn.de>; Mon, 12 Jul 1999 23:29:20 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA2026433; Mon, 12 Jul 1999 14:26:01 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA28442
	for linux-list;
	Mon, 12 Jul 1999 14:20:04 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA07006
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 12 Jul 1999 14:19:56 -0700 (PDT)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA02533
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jul 1999 14:19:53 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m113nUD-0027Y5C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Mon, 12 Jul 1999 23:19:41 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m113nU6-002OztC; Mon, 12 Jul 99 23:19 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA01993;
	Mon, 12 Jul 1999 22:56:59 +0200
Message-ID: <19990712225659.A1990@alpha.franken.de>
Date: Mon, 12 Jul 1999 22:56:59 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Edwin Hakkennes <E.Hakkennes@et.tudelft.nl>, linux@cthulhu.engr.sgi.com
Subject: Re: Small problems on Indy
References: <199907121239.OAA16846@zaphod.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199907121239.OAA16846@zaphod.et.tudelft.nl>; from Edwin Hakkennes on Mon, Jul 12, 1999 at 02:39:26PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jul 12, 1999 at 02:39:26PM +0200, Edwin Hakkennes wrote:
> 1) The console uses 62 lines, but I can see only 47 of them using an
> Iiyama monitor. I also tried a genuine SGI monitor, which gives me all
> 62 lines. How can I set the number of lines?

The screen size is compiled into the old kernels. Get a newer kernel, which
will autodetect the screen size setup by the ARC console. You can find a newer
kernel on ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy* (take
the newest one).

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
