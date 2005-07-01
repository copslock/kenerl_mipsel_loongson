Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 15:58:16 +0100 (BST)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:11213 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8226150AbVGAO54>; Fri, 1 Jul 2005 15:57:56 +0100
Received: from dagger.cc.vt.edu (IDENT:mirapoint@[10.1.1.11])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id j61EuVpO006465;
	Fri, 1 Jul 2005 10:56:41 -0400
Received: from [128.173.184.73] (gs4073.geos.vt.edu [128.173.184.73])
	by dagger.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id DOU46020;
	Fri, 1 Jul 2005 10:56:24 -0400 (EDT)
Message-ID: <42C55991.70109@gentoo.org>
Date:	Fri, 01 Jul 2005 10:56:17 -0400
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050624)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Daniel Jacobowitz <dan@debian.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Bryan Althouse <bryan.althouse@3phoenix.com>,
	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
References: <20050630173409Z8226102-3678+735@linux-mips.org> <20050630202111.GC3245@linux-mips.org> <20050630210357.GA23456@nevyn.them.org> <42C46D85.9050104@gentoo.org> <20050701035105.GA9601@nevyn.them.org>
In-Reply-To: <20050701035105.GA9601@nevyn.them.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

>>Hmm, well with respect to my problem, I'm using a pretty recent
>>toolchain, with gcc 3.4.4, binutils-2.16.1, glibc-2.3.5, and headers
>>from a linux-mips 2.6.11 snapshot.  Interestingly, I tried to reproduce
>>Bryan's segfault, but could not.  That code ran without error when I
>>linked with libpthread.  Any thoughts?
> 
> 
> I don't think glibc 2.3.5 worked for mips64.  But I haven't checked it
> in a long time.  Try CVS HEAD of glibc instead.
> 
> Other than that, you're on your own - building glibc is extremely error
> prone.
> 

I'm sure it can be error prone, but that isn't the problem here at all.
  My n32 glibc 2.3.5 compiled and seems to work just fine, and I was
able to compile an entire userland around it that has no (other)
problems so far as I can tell.  By this, I mean "emerge system" in
Gentoo terms, which is a pretty good test of whether the toolchain works
or not.  Furthermore, other programs that are linked against libpthread
run without causing a segfault and oops.  I'm talking about glib, as in
the glib that used to be part of GTK+ before it was split out some time
ago.

The segfault with kernel oops that I can't get around occurs while
glib's configure script is checking for libpthread.  Specifically, it
links http://beerandrocks.net:8080/~spbecker/oops/conftest.c against
libpthread and then runs it.

I've somewhat convinced myself this is either a kernel and/or a header
problem.  It seems I'm only able to reproduce this problem when trying
to compile and run that code while running 2.6.12 from cvs.  As I
previously mentioned, I tested the offending code on a kernel I compiled
from a 2.6.10 snapshot some time ago, and it ran with no segfault or oops.

-Steve
