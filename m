Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2003 04:52:51 +0100 (BST)
Received: from p508B5DEF.dip.t-dialin.net ([IPv6:::ffff:80.139.93.239]:43418
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225301AbTHSDwt>; Tue, 19 Aug 2003 04:52:49 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h7J3qk8R007516;
	Tue, 19 Aug 2003 05:52:46 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h7J3qhap007515;
	Tue, 19 Aug 2003 05:52:43 +0200
Date: Tue, 19 Aug 2003 05:52:43 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: kumba@gentoo.org, linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
Message-ID: <20030819035242.GB6223@linux-mips.org>
References: <20030812.152654.74756131.nemoto@toshiba-tops.co.jp> <3F388E0C.50802@gentoo.org> <20030812.182529.18309031.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812.182529.18309031.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 12, 2003 at 06:25:29PM +0900, Atsushi Nemoto wrote:

> Only affected code I found is __BUILD_clear_ade.  So the 32-bit kernel
> compiled with -mips3 will work fine normally, but once an address
> error occur the kernel will crash.
> 
> As Thiemo said, it seems include/asm-mips/asm.h should be fixed
> instead of Makefile.  Still investigating...

No.  We may argue if the compiler is defining the wrong symbols for given
options or the Makefile passes the wrong options but the __mips64 symbol
is a define that exists since 64-bit MIPS compilers exist.  It simply
should not be defined at this point.

  Ralf
