Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA2444134 for <linux-archive@neteng.engr.sgi.com>; Tue, 31 Mar 1998 06:58:32 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id GAA5695230
	for linux-list;
	Tue, 31 Mar 1998 06:58:22 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA5992517
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 31 Mar 1998 06:58:21 -0800 (PST)
Received: from aec.at (web.aec.at [193.170.192.5]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id GAA10484
	for <linux@cthulhu.engr.sgi.com>; Tue, 31 Mar 1998 06:57:57 -0800 (PST)
	mail_from (oliver@web.aec.at)
Received: from localhost (oliver@localhost) by aec.at (8.8.3/8.7) with SMTP id QAA17780 for <linux@cthulhu.engr.sgi.com>; Tue, 31 Mar 1998 16:57:52 +0200
Date: Tue, 31 Mar 1998 16:57:52 +0200 (MET DST)
From: Oliver Frommel <oliver@aec.at>
To: linux@cthulhu.engr.sgi.com
Subject: Re: compile problem with kernel
In-Reply-To: <19980331165502.28021@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980331165553.17524C-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > 
> > ./configure --prefix=/tmp/binutils-xcompile-root/usr/local --program-prefix=mips
> > -linux- --enable-shared --target=mips-linux
> 
> You loose.  You install software in /tmp???
>

yeah. i lose - i use RPM :-)
seriuosly, i've installed it in /tmp/binutils-xcompile-root and packaged the RPM
from there, then installed the RPM whose -qpl looks like this:

/usr/local/bin/mips-linux-c++filt
/usr/local/bin/mips-linux-gasp
/usr/local/bin/mips-linux-ld
/usr/local/bin/mips-linux-nm
/usr/local/bin/mips-linux-objcopy
/usr/local/bin/mips-linux-objdump
/usr/local/bin/mips-linux-ranlib
/usr/local/bin/mips-linux-size
/usr/local/bin/mips-linux-strings
/usr/local/bin/mips-linux-strip
/usr/local/bin/mips-linux-as
/usr/local/bin/mips-linux-ar
/usr/local/mips-linux/bin/ar
/usr/local/mips-linux/bin/as
/usr/local/mips-linux/bin/ld
/usr/local/mips-linux/bin/nm
/usr/local/mips-linux/bin/ranlib
/usr/local/mips-linux/bin/strip
/usr/local/lib/libmips-linux-bfd.so
/usr/local/lib/libmips-linux-bfd.so.2.8.1
/usr/local/lib/libmips-linux-opcodes.a
/usr/local/lib/libmips-linux-opcodes.so
/usr/local/lib/libmips-linux-opcodes.so.2.8.1
...


-oliver 
