Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id PAA01306
	for <pstadt@stud.fh-heilbronn.de>; Mon, 19 Jul 1999 15:41:54 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA03545; Mon, 19 Jul 1999 06:35:05 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA12564
	for linux-list;
	Mon, 19 Jul 1999 06:31:06 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA33838
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 19 Jul 1999 06:31:01 -0700 (PDT)
	mail_from (ednes@zaphod.et.tudelft.nl)
Received: from zaphod.et.tudelft.nl (zaphod.et.tudelft.nl [130.161.38.84]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA08950
	for <linux@cthulhu.engr.sgi.com>; Mon, 19 Jul 1999 06:30:59 -0700 (PDT)
	mail_from (ednes@zaphod.et.tudelft.nl)
Received: (from ednes@localhost)
	by zaphod.et.tudelft.nl (8.8.7/8.8.7) id PAA06009;
	Mon, 19 Jul 1999 15:30:53 +0200
Message-Id: <199907191330.PAA06009@zaphod.et.tudelft.nl>
Subject: Re: 200mhz indy
To: m_thrope@rigelfore.com (Eric Melville)
Date: Mon, 19 Jul 1999 15:30:53 +0200 (CEST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <37922879.C3136AE3@rigelfore.com> from "Eric Melville" at Jul 18, 99 12:18:17 pm
From: Edwin Hakkennes <E.Hakkennes@et.tudelft.nl>
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi Eric,

> 
> ok, this morning i successfully booted my r4400 rev. 6.0 indy! thanks
> for the help... but now i've got a problem installing it. i'm a little
> low on disk space for the whole hardhat archive. i was thinking i could
> dump the rpms to a cd and then hook me external scsi cdrom to the indy,
> however the root fs for hardhat setup seems to be missing mount, plus i
> don't know if the redhat installer can be "tricked" like that (i have NO
> redhat experience).
> 

I didn't try this, but it should work. At least it works with
redhat-alpha.

If you can get the kernel loaded and recognising the CD, it should be
do-able. Just boot the kernel with vmlinux root=/dev/scd0 

You can't just dump the RPMS to the CD. The whole install image should
be on the CD, it should be mountable as a rootfs.

Beware that there are quite some absolute symlinks. They could pose
problems. Make sure that mkisofs picks the right contents in this case.
(e.g. sbin/init instead of /sbin/init)


BTW: I'm trying to come up with recompiled rpm for the updates relative to
HardHat. Is anyone interested in these?

Greetings and good luck,

Edwin Hakkennes
