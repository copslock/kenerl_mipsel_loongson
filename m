Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Feb 2003 16:55:12 +0000 (GMT)
Received: from p508B66FD.dip.t-dialin.net ([IPv6:::ffff:80.139.102.253]:52202
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225201AbTBFQzL>; Thu, 6 Feb 2003 16:55:11 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h16GrX923933;
	Thu, 6 Feb 2003 17:53:33 +0100
Date: Thu, 6 Feb 2003 17:53:33 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Guido Guenther <agx@sigxcpu.org>, linux-mips@linux-mips.org
Subject: Re: [patch] cmdline.c rewrite
Message-ID: <20030206175333.A22327@linux-mips.org>
References: <20030204061323.GA27302@pureza.melbourne.sgi.com> <20030204092417.GR16674@bogon.ms20.nix> <20030204223930.GD27302@pureza.melbourne.sgi.com> <20030204231203.GY16674@bogon.ms20.nix> <20030204231909.GE27302@pureza.melbourne.sgi.com> <20030204234529.GZ16674@bogon.ms20.nix> <20030204235543.GG27302@pureza.melbourne.sgi.com> <20030205000734.GA16674@bogon.ms20.nix> <20030205001911.GH27302@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030205001911.GH27302@pureza.melbourne.sgi.com>; from clausen@melbourne.sgi.com on Wed, Feb 05, 2003 at 11:19:11AM +1100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 05, 2003 at 11:19:11AM +1100, Andrew Clausen wrote:

> On Wed, Feb 05, 2003 at 01:07:35AM +0100, Guido Guenther wrote:
> > On IP22 the PROM uses SystemPartition to find the kernel/bootloader.
> > We set it to something like scsi(0)disk(1)rdisk(0)partition(8) to grab
> > it from the vh. Is SystemPartition used differently on IP27?
> 
> I think SystemPartition is ignored (haven't been able to see any
> evidence to the contrary... I should look in the source...)

SystemPartition is to be used by the bootloader, that is sash in SGI's case.
So when booting a kernel directly from the volume header from the firmware's
point of view SystemPartition's value is irrelevant.  Afair it's used for
all non-absolute filenames where absolute ARC filenames are starting with
a device specificer like scsi(0)disk(1)partition(1), not just a slash to
indicate search from the fs root.

> > [..snip..]
> > > So, we should obviously support OSLoadPartition=/dev/sda1 (=> root=/dev/sda1),
> > > but it would also be nice to support OSLoadPartition=dksc(0,1,3).

> > Well we could either check if OSLoadPartition matches the linux device
> > naming scheme or the other way around and see if it looks like a valid
> > device identifier used by the PROM (I'd prefer the later, though) - or
> > simply make the OSLoadPartition <-> root= mapping '#ifdef CONFIG_SGI_IP22'.
> 
> I think the middle option (the one you prefer) of matching dksc(0,1,3)
> and converting it /dev/sda2 is best.  Just, it has to happen after the
> hard disks are probed - /dev/sdXY are allocated dynamically (in
> a predictable-for-end-user way), so you need to find out what it was
> allocated to.  Is this doable in a nice way?

Checkout ROOT_DEV and it's use in init/main.c.  Options such as root=...
are parsed very early during bootup.  After that is done you could check
if the value of ROOT_DEV is still 0 that is no root=... was passed and
fallback to a value derived from SystemPartition at some later stage.

Feel free to read the devfs code for additional transpiration ;)

> BTW, I think file system labels are a much better way of identifying FSs.

ARC dates back more than 10 years back.  It was written with PC partitions
and NT as OS in mind.  So don't expect fancy concepts or sanity ;-)

> Perhaps this discussion is irrelevant... people who are using
> OSLoadPartition to control their bootloader should just add a root=
> option.

The ARC code is also used by non-SGI systems and on some of those using a
non-standard variables is a bit of a pita.

  SystemPartition	The default path for the system partition.
  OSLoader		The default path for an operating-system loader program.
  OSLoadPartition	The default pathname of the partition containing the
			program to be loaded by the operating-system loader.
  OSLoadFilename	The default filename of the program the operating
			 system loader is to load.

Btw, device names like dksc(0,1,2) came from SGI's / MIPS's pre-ARC firmware
so are deprecated since 10 years.  Some things just don't want to die.

  Ralf
