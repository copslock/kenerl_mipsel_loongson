Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA00310
	for <pstadt@stud.fh-heilbronn.de>; Tue, 13 Jul 1999 00:37:32 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA5506095; Mon, 12 Jul 1999 15:33:40 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA96990
	for linux-list;
	Mon, 12 Jul 1999 15:29:31 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA49236
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 12 Jul 1999 15:29:25 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07677
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jul 1999 15:29:22 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-11.uni-koblenz.de [141.26.131.11])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA23700
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Jul 1999 00:29:18 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id AAA04607;
	Tue, 13 Jul 1999 00:27:41 +0200
Date: Tue, 13 Jul 1999 00:27:40 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Edwin Hakkennes <E.Hakkennes@et.tudelft.nl>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Small problems on Indy
Message-ID: <19990713002740.B3015@uni-koblenz.de>
References: <199907121239.OAA16846@zaphod.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <199907121239.OAA16846@zaphod.et.tudelft.nl>; from Edwin Hakkennes on Mon, Jul 12, 1999 at 02:39:26PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jul 12, 1999 at 02:39:26PM +0200, Edwin Hakkennes wrote:

> After lurking on the sgi-list for more than a year, I installed one of
> our indy's with hardhat. I couldn't get bootp working, so I copied the
> install kernel to the efs-root of the Irix (5.2?) disk, which proved a
> workable solution.
> 
> I have a few questions:
> 
> 1) The console uses 62 lines, but I can see only 47 of them using an
> Iiyama monitor. I also tried a genuine SGI monitor, which gives me all
> 62 lines. How can I set the number of lines?

You seem to be running the kernel shipping with Hard Hat which had problems
like this due different positioning of the gfx.  Current kernels are
more like IRIX in that aspect.

> 2) How can I specify kernel options in the ARC firmware?  
> 
> I tried
> setenv -p OSLoadOptions "root=/dev/sdb1"
> init
> printenv OSLoadOptions 
> which gives
> OSLoadOptions=root=/dev/sd

Run it like /vmlinux root=/dev/sdc1 or so.

> so this doesn't seem to work.
> Can I use rdev on i386 machine for this?

Yes, but it will not work ;-)

> 3) What is the prefered partitioning scheme.  I would like to go back
> to one disk, with no IRIX installed. So the question is what partition 
> types is the arc-firmware able to boot from? (iso,fat)

The volume header, EFS and BOOTP/TFTP.

If you're using IRIX's sash then you can also boot a kernel from XFS
or whatever else sash supports.

> Can we alternatively store the kernel in the disk-label? From within Linux??

I'm working on a tool to do this.  Even better, on a bootloader which
will be able to read the kernel to launch from a ext2 filesystem.

For the time being you can use dvhtool under IRIX to do this.

> Is the following possible?  
> 
> sda1    20 MB      /boot    type=efs (or iso9660, or fat)
> sda2   100 MB      /        type=ext2
> sda3   whole disk? 				Is this necessary?

That whole disk partition thing is actually an IRIX-ism which wasn't
supposed to make it into Linux ...

> sda4   800 MB      /usr     type=ext2
> sda5   128 MB      SWAP
> sda6   REST        /data    type=ext2
> 
> Is linux capable of writing to an efs partition?

No, only reading and that only in current kernel versions.

  Ralf
