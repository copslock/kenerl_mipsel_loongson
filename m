Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78DgpM32376
	for linux-mips-outgoing; Wed, 8 Aug 2001 06:42:51 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78DgnV32369
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 06:42:49 -0700
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 15UTbi-0006a6-00; Wed, 08 Aug 2001 15:42:46 +0200
Date: Wed, 8 Aug 2001 15:42:46 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: Ian <ian@WPI.EDU>
Cc: Soeren Laursen <soeren.laursen@scrooge.dk>,
   linux-mips <linux-mips@oss.sgi.com>
Subject: Re: HELP can't boot
Message-ID: <20010808154246.A25205@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Ian <ian@WPI.EDU>,
	Soeren Laursen <soeren.laursen@scrooge.dk>,
	linux-mips <linux-mips@oss.sgi.com>
References: <20010808104536.A21775@gandalf.physik.uni-konstanz.de> <Pine.OSF.4.33.0108080857440.32160-100000@grover.WPI.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.OSF.4.33.0108080857440.32160-100000@grover.WPI.EDU>; from ian@WPI.EDU on Wed, Aug 08, 2001 at 08:59:15AM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 08:59:15AM -0400, Ian wrote:
> I was in the middle of a HardHat install, and fdisk was able to partition
> the disks.  The problem is that I deleted all of the partitions on the
> original disk, including sda9 and sda11, which store the SGI sash
> bootloader and associated files.  Without the bootloader, the system is
> inoperable.  I did not realize that those partitions contained it at that
> time.
You simply need to recreate a sgi partition table which is no problem
with a current fdisk. That's all you need  to make linux bootable from
harddisk.
This is kind of off-topic but I'd recommend switching to s.th. more
recent than hardhat like debian or the rpms by H.J Lu on oss. Hardhat is
way out of date.
 -- Guido
