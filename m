Received:  by oss.sgi.com id <S42190AbQGGORl>;
	Fri, 7 Jul 2000 07:17:41 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:53542 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42185AbQGGOR1>;
	Fri, 7 Jul 2000 07:17:27 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id HAA26110
	for <linux-mips@oss.sgi.com>; Fri, 7 Jul 2000 07:12:35 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id KAA06711 for <linux-mips@oss.sgi.com>; Fri, 7 Jul 2000 10:10:59 -0300
Date:   Fri, 7 Jul 2000 10:10:59 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     linux-mips@oss.sgi.com
Subject: Kernel boot tips.
Message-ID: <Pine.SGI.4.10.10007070952190.6663-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I learned 3 slick booting tips for booting an Indy from disk without a
regular Linux boot loader that might be useful to some of the newbies.

First off, there are two ways to trick the prom into booting the kernel
image like the normal Irix kerenel from disk.  If you have an EFS or XFS
bootable file system on the drive, and have Irix up at some point, you can
put the linux kernel in the file system as /unix in place of an Irix
kernel.  When booting, sash will look for that particular file and
bootstrap it.  Another way to accomplish this trick if you don't want any
Irix partitions on your drive at all is to use the volume header itself.
Sash is located there, and the boot prom will load and execute sash as
part of the boot process.  Under Irix, you can use dvhtool to replace sash
with the linux kernel itself.  Then when the system tries to boot, the
prom will load "sash" like normal, but will end up boot straping the linux
kernel for you.  (I think this will require a coff image though.)

The third trick I learned will help those that cannot afford the spare
change to keep around extra SCSI drives so that they have a bootable Irix
image to use for accomplishing these feats.  If you use fx to initially
prepare your linux disk, use the expert option and resize the volume
header partition.  Make it big, like 25 Meg or so.  Shrink the efs/xfs
root partition down very small, but don't delete it.  Keep the swap
partition as well, but again, rather small.  On the Irix CD, you'll find
the directory /dist/miniroot, and inside there, the Irix kernel miniroot
images.  Pick the one named for your machine arch, such as unix.IP22.
When I set up my volume header, I put sash in there like normal, but also
put the miniroot image in there as well, and put the linux kernel as /unix
in the vestigal efs/xfs root partition.  Now from the prom, I can enter
the command "miniroot" and get the Irix kernel up with a handful of
utilities to manage the disk.  It has fx, dvhtool, and others.  On top of
that, you can ifconfig your ethernet device and use rcp to pull over your
linux kernel from the network to install it on the efx/xfs root or in the
volume header as you choose.  You can even mount cdroms and so forth.
Basicly, this is the next best thing to having a full blown Irix install
somewhere.

Hope these tips are usefull for someone!


--

J. Scott Kasten
Email: jsk AT tetracon-eng DOT net

"The only future you have is the one
 you choose to make for yourself..."
