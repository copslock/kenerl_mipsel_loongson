Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78JZPj02675
	for linux-mips-outgoing; Wed, 8 Aug 2001 12:35:25 -0700
Received: from smtp.WPI.EDU (root@smtp.WPI.EDU [130.215.24.62])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78JZOV02670
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 12:35:24 -0700
Received: from grover.wpi.edu (ian@grover.WPI.EDU [130.215.25.67])
	by smtp.WPI.EDU (8.12.0.Beta17/8.12.0.Beta17) with ESMTP id f78JZNFd003073;
	Wed, 8 Aug 2001 15:35:23 -0400 (EDT)
Date: Wed, 8 Aug 2001 15:35:22 -0400 (EDT)
From: Ian <ian@WPI.EDU>
To: Florian Lohoff <flo@rfc822.org>
cc: Guido Guenther <guido.guenther@gmx.net>,
   Soeren Laursen <soeren.laursen@scrooge.dk>,
   linux-mips <linux-mips@oss.sgi.com>
Subject: Re: HELP can't boot
In-Reply-To: <20010808174351.C17694@paradigm.rfc822.org>
Message-ID: <Pine.OSF.4.33.0108081532180.2274-100000@grover.WPI.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> tftp/nfs-root boot ? The prom is enough.

When I type "boot bootp():/tftpboot/kernel-hardhat" at the PROM command
monitor, I get an error that it can't find Sash (the Irix [6.2]
bootloader).  Sash appears to be necessary to do a netboot.

> Hardhat is VERY old and you will get really in trouble to get any
> current software integrated into the distribution.

HardHat will a sufficient base to build a new system on (i.e. LFS) from
scratch.  LFS is a program where you simply build a complete Linux system
from source (current sources, including libraries and *everything*).
However you need some kind of basic system to start with, and HardHat will
do the trick (if I can get it to boot).

--
Ian Cooper
ian@wpi.edu
