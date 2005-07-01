Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 18:03:28 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:24267 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8226168AbVGARDJ>;
	Fri, 1 Jul 2005 18:03:09 +0100
Received: from drow by nevyn.them.org with local (Exim 4.51)
	id 1DoOuo-0005r2-Kn; Fri, 01 Jul 2005 13:02:58 -0400
Date:	Fri, 1 Jul 2005 13:02:58 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	"Stephen P. Becker" <geoman@gentoo.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Bryan Althouse <bryan.althouse@3phoenix.com>,
	'Linux/MIPS Development' <linux-mips@linux-mips.org>
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
Message-ID: <20050701170258.GA22405@nevyn.them.org>
References: <20050630173409Z8226102-3678+735@linux-mips.org> <20050630202111.GC3245@linux-mips.org> <20050630210357.GA23456@nevyn.them.org> <42C46D85.9050104@gentoo.org> <20050701035105.GA9601@nevyn.them.org> <42C55991.70109@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C55991.70109@gentoo.org>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 01, 2005 at 10:56:17AM -0400, Stephen P. Becker wrote:
> The segfault with kernel oops that I can't get around occurs while
> glib's configure script is checking for libpthread.  Specifically, it
> links http://beerandrocks.net:8080/~spbecker/oops/conftest.c against
> libpthread and then runs it.

If that oopses, your famed emerge testing hasn't run any threaded
programs, my friend :-)

Could be kernel, could be library, could be both.  Must be at least
kernel because the kernel should never oops.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
