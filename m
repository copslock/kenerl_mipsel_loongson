Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 17:41:40 +0100 (BST)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:42939 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8226159AbVGAQlU>; Fri, 1 Jul 2005 17:41:20 +0100
Received: from zidane.cc.vt.edu (IDENT:mirapoint@[10.1.1.13])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id j61Gdqm7005445;
	Fri, 1 Jul 2005 12:40:02 -0400
Received: from [128.173.184.73] (gs4073.geos.vt.edu [128.173.184.73])
	by zidane.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id DMZ68355;
	Fri, 1 Jul 2005 12:39:38 -0400 (EDT)
Message-ID: <42C571C3.1060703@gentoo.org>
Date:	Fri, 01 Jul 2005 12:39:31 -0400
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050624)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Daniel Jacobowitz <dan@debian.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Bryan Althouse <bryan.althouse@3phoenix.com>,
	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
References: <20050630173409Z8226102-3678+735@linux-mips.org> <20050630202111.GC3245@linux-mips.org> <20050630210357.GA23456@nevyn.them.org> <42C46D85.9050104@gentoo.org> <20050701035105.GA9601@nevyn.them.org> <42C55991.70109@gentoo.org> <Pine.LNX.4.61L.0507011613510.30138@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0507011613510.30138@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

>>The segfault with kernel oops that I can't get around occurs while
>>glib's configure script is checking for libpthread.  Specifically, it
>>links http://beerandrocks.net:8080/~spbecker/oops/conftest.c against
>>libpthread and then runs it.
> 
> 
> And libpthread is part of glibc, not glib.  So if an autoconf test (which 
> I'm assuming is AC_CHECK_LIB() rather than a hand-crafted hack) breaks on 
> running a program linked against libpthread, then it's not a problem with 
> glib, but probably with either glibc or the toolchain used.

I'm aware of this. It just sounded like Daniel was questioning whether
or not my glibc was compiling/working in the first place.

>>I've somewhat convinced myself this is either a kernel and/or a header
>>problem.  It seems I'm only able to reproduce this problem when trying
>>to compile and run that code while running 2.6.12 from cvs.  As I
>>previously mentioned, I tested the offending code on a kernel I compiled
>>from a 2.6.10 snapshot some time ago, and it ran with no segfault or oops.
> 
> 
>  If you get an Oops when running software as non-root, then it's a kernel 
> bug, no matter what.
> 

Yes, it certainly happens when running as a non-privileged user.  If I
get a bit of time later today, I was going to try and track down which
cvs commit and/or kernel version broke things.

-Steve
