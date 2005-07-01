Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 16:22:37 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:45577 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226157AbVGAPWU>; Fri, 1 Jul 2005 16:22:20 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 24E09F598F; Fri,  1 Jul 2005 17:22:08 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02511-05; Fri,  1 Jul 2005 17:22:08 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D8C1EF598D; Fri,  1 Jul 2005 17:22:07 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j61FMAN2008141;
	Fri, 1 Jul 2005 17:22:11 +0200
Date:	Fri, 1 Jul 2005 16:22:19 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"Stephen P. Becker" <geoman@gentoo.org>
Cc:	Daniel Jacobowitz <dan@debian.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Bryan Althouse <bryan.althouse@3phoenix.com>,
	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
In-Reply-To: <42C55991.70109@gentoo.org>
Message-ID: <Pine.LNX.4.61L.0507011613510.30138@blysk.ds.pg.gda.pl>
References: <20050630173409Z8226102-3678+735@linux-mips.org>
 <20050630202111.GC3245@linux-mips.org> <20050630210357.GA23456@nevyn.them.org>
 <42C46D85.9050104@gentoo.org> <20050701035105.GA9601@nevyn.them.org>
 <42C55991.70109@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/963/Fri Jul  1 15:27:29 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 1 Jul 2005, Stephen P. Becker wrote:

> I'm sure it can be error prone, but that isn't the problem here at all.
>   My n32 glibc 2.3.5 compiled and seems to work just fine, and I was
> able to compile an entire userland around it that has no (other)
> problems so far as I can tell.  By this, I mean "emerge system" in
> Gentoo terms, which is a pretty good test of whether the toolchain works
> or not.  Furthermore, other programs that are linked against libpthread
> run without causing a segfault and oops.  I'm talking about glib, as in
> the glib that used to be part of GTK+ before it was split out some time
> ago.
> 
> The segfault with kernel oops that I can't get around occurs while
> glib's configure script is checking for libpthread.  Specifically, it
> links http://beerandrocks.net:8080/~spbecker/oops/conftest.c against
> libpthread and then runs it.

 And libpthread is part of glibc, not glib.  So if an autoconf test (which 
I'm assuming is AC_CHECK_LIB() rather than a hand-crafted hack) breaks on 
running a program linked against libpthread, then it's not a problem with 
glib, but probably with either glibc or the toolchain used.

> I've somewhat convinced myself this is either a kernel and/or a header
> problem.  It seems I'm only able to reproduce this problem when trying
> to compile and run that code while running 2.6.12 from cvs.  As I
> previously mentioned, I tested the offending code on a kernel I compiled
> from a 2.6.10 snapshot some time ago, and it ran with no segfault or oops.

 If you get an Oops when running software as non-root, then it's a kernel 
bug, no matter what.

  Maciej
