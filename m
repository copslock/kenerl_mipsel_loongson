Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78CxJ925563
	for linux-mips-outgoing; Wed, 8 Aug 2001 05:59:19 -0700
Received: from smtp.WPI.EDU (root@smtp.WPI.EDU [130.215.24.62])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78CxIV25559
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 05:59:18 -0700
Received: from grover.wpi.edu (ian@grover.WPI.EDU [130.215.25.67])
	by smtp.WPI.EDU (8.12.0.Beta17/8.12.0.Beta17) with ESMTP id f78CxFFd001878;
	Wed, 8 Aug 2001 08:59:15 -0400 (EDT)
Date: Wed, 8 Aug 2001 08:59:15 -0400 (EDT)
From: Ian <ian@WPI.EDU>
To: Guido Guenther <guido.guenther@gmx.net>
cc: Soeren Laursen <soeren.laursen@scrooge.dk>, <linux-mips@oss.sgi.com>
Subject: Re: HELP can't boot
In-Reply-To: <20010808104536.A21775@gandalf.physik.uni-konstanz.de>
Message-ID: <Pine.OSF.4.33.0108080857440.32160-100000@grover.WPI.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I was in the middle of a HardHat install, and fdisk was able to partition
the disks.  The problem is that I deleted all of the partitions on the
original disk, including sda9 and sda11, which store the SGI sash
bootloader and associated files.  Without the bootloader, the system is
inoperable.  I did not realize that those partitions contained it at that
time.

On Wed, 8 Aug 2001, Guido Guenther wrote:

> On Wed, Aug 08, 2001 at 10:25:44AM +0200, Soeren Laursen wrote:
> > You need (as I know) to use irix to prepare the disk.
> No need for Irix. Linux fdisk can handle sgi disklkabels since quiet
> some time now.
>  -- Guido
>

--
Ian Cooper
ian@wpi.edu
