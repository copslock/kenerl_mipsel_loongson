Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78EkTu08747
	for linux-mips-outgoing; Wed, 8 Aug 2001 07:46:29 -0700
Received: from smtp.WPI.EDU (root@smtp.WPI.EDU [130.215.24.62])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78EkRV08742
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 07:46:27 -0700
Received: from grover.wpi.edu (ian@grover.WPI.EDU [130.215.25.67])
	by smtp.WPI.EDU (8.12.0.Beta17/8.12.0.Beta17) with ESMTP id f78EkOFd005564;
	Wed, 8 Aug 2001 10:46:24 -0400 (EDT)
Date: Wed, 8 Aug 2001 10:46:24 -0400 (EDT)
From: Ian <ian@WPI.EDU>
To: Guido Guenther <guido.guenther@gmx.net>
cc: Soeren Laursen <soeren.laursen@scrooge.dk>,
   linux-mips <linux-mips@oss.sgi.com>
Subject: Re: HELP can't boot
In-Reply-To: <20010808154246.A25205@gandalf.physik.uni-konstanz.de>
Message-ID: <Pine.OSF.4.33.0108081039480.6638-100000@grover.WPI.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> You simply need to recreate a sgi partition table which is no problem
> with a current fdisk. That's all you need  to make linux bootable from
> harddisk.

Right.  But how to I get to that point?  There is NO bootloader?  I have
no Irix 6.x media available to restore those partitions.

> This is kind of off-topic but I'd recommend switching to s.th. more
> recent than hardhat like debian or the rpms by H.J Lu on oss. Hardhat is
> way out of date.

I was planning to use HardHat as a basis to build a custom LFS
(http://www.linuxfromscrtach.org) system from.  It would be sufficient.

--
Ian Cooper
ian@wpi.edu
