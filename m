Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Feb 2005 01:54:34 +0000 (GMT)
Received: from p3EE2BC3E.dip.t-dialin.net ([IPv6:::ffff:62.226.188.62]:13632
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225352AbVBLByL>; Sat, 12 Feb 2005 01:54:11 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j1C1s62u012433;
	Sat, 12 Feb 2005 02:54:06 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j1C1s0Jp012432;
	Sat, 12 Feb 2005 02:54:00 +0100
Date:	Sat, 12 Feb 2005 02:54:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Stephen P. Becker" <geoman@gentoo.org>
Cc:	Frederic TEMPORELLI - astek <ftemporelli@astek.fr>,
	linux-mips@linux-mips.org
Subject: Re: IP32 - issues with last CVS snapshoot
Message-ID: <20050212015400.GA26873@linux-mips.org>
References: <420CEE7F.3080201@astek.fr> <420CF611.5030705@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420CF611.5030705@gentoo.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 11, 2005 at 01:14:41PM -0500, Stephen P. Becker wrote:

> >First, there's something wrong with "make ip32_defconfig" which generate 
> >config file with "Kernel code model = 64-bit kernel" (MIPS64=y) but 
> >doesn't preselect  "Use 64-bit ELF format for building" (BUILD_ELF64=n)
> >doing so, "make" quickly generates an error:
> 
> O2 doesn't use 64-bit ELF format.  You have to use o64.  See the 
> arch/mips/Makefile portion of http://dev.gentoo.org/~geoman/cvs.diff for 
> the proper changes.  I'm willing to bet a lot of your problems will go 
> away if you stop using ELF64.  Such a kernel will boot, but it never 
> quite works right.  Not only that, but 64-bit kernels have had some 
> major problems in 2.6.11 so far that I'm not sure Ralf has completely 
> fixed just yet.  Last I knew swap still didn't work, so I bet that is 
> where your swap problem is coming from.

I fixed that also but it's still not stable.  As a test I did rebuild
e2fsutils and it did panic after a while.  So midnight oil to the rescue ...

  Ralf
