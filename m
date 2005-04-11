Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 17:33:48 +0100 (BST)
Received: from bay101-f10.bay101.hotmail.com ([IPv6:::ffff:64.4.56.20]:59732
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8226124AbVDKQdd>; Mon, 11 Apr 2005 17:33:33 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 11 Apr 2005 09:33:25 -0700
Message-ID: <BAY101-F104C615D4EA1DBF2A3064DDC320@phx.gbl>
Received: from 64.4.56.208 by by101fd.bay101.hotmail.msn.com with HTTP;
	Mon, 11 Apr 2005 16:33:25 GMT
X-Originating-IP: [64.4.56.208]
X-Originating-Email: [danieljlaird@hotmail.com]
X-Sender: danieljlaird@hotmail.com
In-Reply-To: <Pine.LNX.4.61L.0504111659410.31547@blysk.ds.pg.gda.pl>
From:	"Daniel Laird" <danieljlaird@hotmail.com>
To:	macro@linux-mips.org
Cc:	libc-alpha@sources.redhat.com, linux-mips@linux-mips.org
Subject: Re: Building GLIBC 2.3.4 on MIPS
Date:	Mon, 11 Apr 2005 16:33:25 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 11 Apr 2005 16:33:25.0434 (UTC) FILETIME=[2F0CF1A0:01C53EB4]
Return-Path: <danieljlaird@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips

I am using crosstool to help me build!

I have a problem when i compile that it seems to include a file 
sysdeps/mips/mips32/Makefile.  This has the option -mabi=32.  When it does 
the install-headers target in crosstool it passes this flag to the host 
compiler.  This causes an error.

I get around this my removing this flag for the install header target and 
then putting it back for the rest of the crosstool script.

this results in a complete toolchain and a 2.6.11.6 kernel which is running 
on my target.

I then try to build busybox1.00 and i get the error
In file included from 
/home/laird/ccm_wa/ipstb/ipstb_laird/ipstb/build/packages/busybox-1.00/libbb/module_syscalls.c:26:
/opt/nxlinux/gcc/gcc-3.4.3-glibc-2.3.4/lib/gcc/mipsel-linux-gnu/3.4.3/../../../../mipsel-linux-gnu/sys-include/sys/syscall.h:39:27: 
bits/syscall.h: No such file or directory
make[1]: *** 
[/home/laird/ccm_wa/ipstb/ipstb_laird/ipstb/build/packages/busybox-1.00/libbb/module_syscalls.o] 
Error 1
make[1]: Leaving directory 
`/home/laird/ccm_wa/ipstb/ipstb_laird/ipstb/build/packages/busybox-1.00'

When i check it is missing.

I am presuming my hack to get the install-headers target may be breaking 
things but how else do i get round this.

Are you guys using crosstool?

Thanks for the help
