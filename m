Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 18:17:36 +0100 (BST)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:8924 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8226168AbVGARRU>; Fri, 1 Jul 2005 18:17:20 +0100
Received: from vivi.cc.vt.edu (IDENT:mirapoint@[10.1.1.12])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id j61HG0Qx017070;
	Fri, 1 Jul 2005 13:16:10 -0400
Received: from [128.173.184.73] (gs4073.geos.vt.edu [128.173.184.73])
	by vivi.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id DNQ77670;
	Fri, 1 Jul 2005 13:15:45 -0400 (EDT)
Message-ID: <42C57A2E.4070702@gentoo.org>
Date:	Fri, 01 Jul 2005 13:15:26 -0400
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050624)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Daniel Jacobowitz <dan@debian.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Bryan Althouse <bryan.althouse@3phoenix.com>,
	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
References: <20050630173409Z8226102-3678+735@linux-mips.org> <20050630202111.GC3245@linux-mips.org> <20050630210357.GA23456@nevyn.them.org> <42C46D85.9050104@gentoo.org> <20050701035105.GA9601@nevyn.them.org> <42C55991.70109@gentoo.org> <20050701170258.GA22405@nevyn.them.org>
In-Reply-To: <20050701170258.GA22405@nevyn.them.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:
> On Fri, Jul 01, 2005 at 10:56:17AM -0400, Stephen P. Becker wrote:
> 
>>The segfault with kernel oops that I can't get around occurs while
>>glib's configure script is checking for libpthread.  Specifically, it
>>links http://beerandrocks.net:8080/~spbecker/oops/conftest.c against
>>libpthread and then runs it.
> 
> 
> If that oopses, your famed emerge testing hasn't run any threaded
> programs, my friend :-)

What do you mean by "famed" emerge testing?  In any case, that is what I
am in the process of doing (testing).  This userland I am working with
is in no way an official Gentoo install. :)  At some point in the
future, we will probably make official n32 install stages available to
the general users, after we work all the bugs out...this just happens to
be one of those bugs.

> Could be kernel, could be library, could be both.

Well, since you say that glibc 2.3.5 probably isn't up to par for
mips64, I'll see if I can get cvs HEAD going in a chroot and see if that
fixes the problem.

> Must be at least kernel because the kernel should never oops.

Agreed.

-Steve
