Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jan 2004 16:34:01 +0000 (GMT)
Received: from p508B6259.dip.t-dialin.net ([IPv6:::ffff:80.139.98.89]:43348
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225225AbUAQQd7>; Sat, 17 Jan 2004 16:33:59 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0HGXv4P027198;
	Sat, 17 Jan 2004 17:33:57 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0HGXtGR027197;
	Sat, 17 Jan 2004 17:33:55 +0100
Date: Sat, 17 Jan 2004 17:33:55 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Adam Nielsen <a.nielsen@optushome.com.au>
Cc: linux-mips@linux-mips.org
Subject: Re: Trouble compiling MIPS cross-compiler
Message-ID: <20040117163355.GE5288@linux-mips.org>
References: <200401171711.34964@korath> <200401171736.49803@korath>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401171736.49803@korath>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 17, 2004 at 05:36:49PM +1000, Adam Nielsen wrote:

> 	./configure --prefix=/usr [...]
> 
> then it appears to work perfectly...!
> 
> No idea what's going on, but at least it works and hopefully it won't 
> overwrite my existing compiler when I install it ;-)

gcc and binutils must be installed with the same prefix or gcc will not
find the target as and fallback to the native tools which of course
won't work at all as you saw.

In your other mail you mentioned you were using gcc 1.1.2; I recommend
gcc 2.95.4 instead.  gcc 1.1.2 needs a few workarounds in the kernel
source in particular for 64-bit kernels and I've removed all of them
around 2003-05-16 (in the Linux 2.4.20 age) so I'm not sure if egcs 1.1.2
will still work.  Sympthom are compiler core dumps.  Newer doesn't harm ...

  Ralf
