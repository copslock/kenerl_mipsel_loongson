Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7G7X7C16280
	for linux-mips-outgoing; Thu, 16 Aug 2001 00:33:07 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7G7X6j16275
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 00:33:06 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA28873;
	Thu, 16 Aug 2001 00:32:58 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA14041;
	Thu, 16 Aug 2001 00:32:58 -0700 (PDT)
Received: from copsun17.mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f7G7VMa06401;
	Thu, 16 Aug 2001 09:31:22 +0200 (MEST)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun17.mips.com (8.9.1/8.9.0) id JAA00011;
	Thu, 16 Aug 2001 09:31:21 +0200 (MET DST)
Message-Id: <200108160731.JAA00011@copsun17.mips.com>
Subject: Re: About booting malta board.
To: swang@mmc.atmel.com
Date: Thu, 16 Aug 2001 09:31:21 +0200 (MET DST)
Cc: linux-mips@oss.sgi.com
In-Reply-To: <3B7B0437.ECE7019F@mmc.atmel.com> from "Shuanglin Wang" at Aug 15, 2001 06:22:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

So the key question is whether it is the precompiled bigendian kernel
from ftp.mips.com that doesn't work or the one you compiled yourself?

To verify, these are the precompiled 2.4.3 Malta kernels on ftp.mips.com:

-rw-r--r--   1 9618     40        1075193 Jul  6 04:35 vmlinux-2.4.3.malta.eb-01.00.srec.gz
-rw-r--r--   1 9618     40        1107586 Jul  6 04:35 vmlinux-2.4.3.malta.el-01.00.srec.gz

If the precompiled kernel works and the one you compiled doesn't there
could be something wrong in your compiler setup. We're currently
compiling on Linux/x86 using the precompiled version from:

	ftp://oss.sgi.com/pub/linux/mips/crossdev/i386-linux/

It reports itself as being:

/home/hartvige/tmp/linux-2.4.3> /usr/bin/mipsel-linux-gcc -v
Reading specs from /usr/lib/gcc-lib/mipsel-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)

/home/hartvige/tmp/linux-2.4.3> /usr/bin/mips-linux-gcc -v
Reading specs from /usr/lib/gcc-lib/mips-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)

/Hartvig


Shuanglin Wang writes:
> 
> I downloaded Linux pre-comipled kernel 2.4.3 from ftp.mips.com and built up
> kernel images (big endian and little endian) by myself.  AlsoI use NFS as the
> boot directory.  For the big-endian mode, everthing is fine. But, for little
> endian mode,  the system just display "LINUX started....",  then monitor
> terminal display nothing. But I'm sure the system continue booting,  and after a
> while, it hang.
> 
> I just download the kernel and input:
> go . nfsboot=hostIP:/linux/mipsel  ip=boardIP
> 
> Thanks
