Received:  by oss.sgi.com id <S42227AbQGIU5l>;
	Sun, 9 Jul 2000 13:57:41 -0700
Received: from u-73.karlsruhe.ipdial.viaginterkom.de ([62.180.21.73]:63492
        "EHLO u-73.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42185AbQGIU5S>; Sun, 9 Jul 2000 13:57:18 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S639098AbQGIE32>;
        Sun, 9 Jul 2000 06:29:28 +0200
Date:   Sun, 9 Jul 2000 06:29:28 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Kernel boot tips.
Message-ID: <20000709062927.A5609@bacchus.dhis.org>
References: <Pine.SGI.4.10.10007070952190.6663-100000@thor.tetracon-eng.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.SGI.4.10.10007070952190.6663-100000@thor.tetracon-eng.net>; from jsk@tetracon-eng.net on Fri, Jul 07, 2000 at 10:10:59AM -0300
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jul 07, 2000 at 10:10:59AM -0300, J. Scott Kasten wrote:

> I learned 3 slick booting tips for booting an Indy from disk without a
> regular Linux boot loader that might be useful to some of the newbies.
> 
> First off, there are two ways to trick the prom into booting the kernel
> image like the normal Irix kerenel from disk.  If you have an EFS or XFS
> bootable file system on the drive, and have Irix up at some point, you can
> put the linux kernel in the file system as /unix in place of an Irix
> kernel.  When booting, sash will look for that particular file and
> bootstrap it.  Another way to accomplish this trick if you don't want any
> Irix partitions on your drive at all is to use the volume header itself.
> Sash is located there, and the boot prom will load and execute sash as
> part of the boot process.  Under Irix, you can use dvhtool to replace sash
> with the linux kernel itself.  Then when the system tries to boot, the
> prom will load "sash" like normal, but will end up boot straping the linux
> kernel for you.  (I think this will require a coff image though.)
> 
> The third trick I learned will help those that cannot afford the spare
> change to keep around extra SCSI drives so that they have a bootable Irix
> image to use for accomplishing these feats.  If you use fx to initially
> prepare your linux disk, use the expert option and resize the volume
> header partition.  Make it big, like 25 Meg or so.  Shrink the efs/xfs
> root partition down very small, but don't delete it.  Keep the swap
> partition as well, but again, rather small.  On the Irix CD, you'll find
> the directory /dist/miniroot, and inside there, the Irix kernel miniroot
> images.  Pick the one named for your machine arch, such as unix.IP22.
> When I set up my volume header, I put sash in there like normal, but also
> put the miniroot image in there as well, and put the linux kernel as /unix
> in the vestigal efs/xfs root partition.  Now from the prom, I can enter
> the command "miniroot" and get the Irix kernel up with a handful of
> utilities to manage the disk.  It has fx, dvhtool, and others.  On top of
> that, you can ifconfig your ethernet device and use rcp to pull over your
> linux kernel from the network to install it on the efx/xfs root or in the
> volume header as you choose.  You can even mount cdroms and so forth.
> Basicly, this is the next best thing to having a full blown Irix install
> somewhere.

I've finally commited my rewrite of dvhtool into the CVS archive on
oss.  It's not yet complete but hackers may be interested in taking a
look at it.

One of my next projects will be a standalone libc which can be used to
write reasonably portable standalone tools like a sash equivalent.

  Ralf
