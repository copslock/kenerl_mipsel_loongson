Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA07030 for <linux-archive@neteng.engr.sgi.com>; Wed, 24 Feb 1999 15:18:11 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA92790
	for linux-list;
	Wed, 24 Feb 1999 15:17:18 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA81489
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 Feb 1999 15:17:16 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA09721
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 Feb 1999 15:17:15 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10FnYG-0027U4C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 25 Feb 1999 00:17:12 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10FnXy-002PAQC; Thu, 25 Feb 99 00:16 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA01981;
	Wed, 24 Feb 1999 22:59:29 +0100
Message-ID: <19990224225929.B1972@alpha.franken.de>
Date: Wed, 24 Feb 1999 22:59:29 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: gkm@total.net, linux@cthulhu.engr.sgi.com
Subject: Re: A few(bunch? :) of questions.
References: <199902241011.FAA26317@bretweir.total.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199902241011.FAA26317@bretweir.total.net>; from gkm@total.net on Wed, Feb 24, 1999 at 05:12:04AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Feb 24, 1999 at 05:12:04AM -0500, gkm@total.net wrote:
> My console doesn't work, the log shows lots of getty HANGUP signals and then 
> init stopping the process.

add a a getty for /dev/ttyS0 to your /etc/inittab and remove the other 
gettys for tty0-5.

> around waiting for Bootp to time out and such) Where can I get the latest 
> kernel source? (base 2.2.1 blows up impressivly when trying to compile :)

You can get it from the CVS on ftp.linux.sgi.com. But there are some
minor patches missing, which I've used for the test kernels. I'll check the
stuff in next weekend and create a source tarball.

> Related to the above:  How do I get support for the second ethernet and all 
> the other SCSI adapters?

If the second ethernet is the same as the first one, it should just be a
matter of adding the necessary probing stuff. For the other SCSI adapter
your out of luck. I do have a datasheet for the wd33c95, but I doubt it's
possible to write a driver with just this information. The wd33c95 is a scsi 
script processor (for me it looks a little bit like the NCR53C7xx/8xx
chips). So we would need a script first, but I don't have any idea how
write one, because this information is missing in the datasheet.

> Is there anyway I can dump the Irix drive?  As it is now, the 1 Gig drive is 
> used to hold vmlinux, that's it. Is milo something that works?

milo doesn't work for the Indy. Ralf told me about another boot stuff, which
would allow us to get the kernel from an ext2 partition. Ralf any news ?

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
