Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jul 2004 01:39:19 +0100 (BST)
Received: from p508B68D1.dip.t-dialin.net ([IPv6:::ffff:80.139.104.209]:35443
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225766AbUGOAjP>; Thu, 15 Jul 2004 01:39:15 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i6F0dEk0025682;
	Thu, 15 Jul 2004 02:39:14 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i6F0dEQI025681;
	Thu, 15 Jul 2004 02:39:14 +0200
Date: Thu, 15 Jul 2004 02:39:14 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: a.voropay@vmb-service.ru, linux-mips@linux-mips.org
Subject: Re: MS VC++ compiler / MIPS
Message-ID: <20040715003914.GB25279@linux-mips.org>
References: <07d301c469a9$e708f550$0200000a@ALEC> <003001c469b4$3b5ae960$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003001c469b4$3b5ae960$10eca8c0@grendel>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 14, 2004 at 05:07:06PM +0200, Kevin D. Kissell wrote:

> If I recall correctly, the MS compiler uses a subltly different
> calling convention/ABI than the "o32" gcc conventions assumed
> by MIPS Linux, and certainly the assembler directives will be
> different from those assumed by the Linux sources.  It *might*
> be possible to hack up a MIPS Linux kernel source tree to
> build with the MS tool kit, but it would be a lot of work, 
> some of it subtle.

A few years ago we got SGI's IA-64 kernel to compile with their Pro64
compiler.  Despite the usually rather dramatic superiority of Pro64's
code generation compared to the gcc of that time - half the time to
generate twice as fast application code was common - the huge effort
it took was essentially wasted time to achieve a hard to meassure amount
of extra performance.  Most of the kernel code is well optimized, was
written with being compiled by gcc in mind and performance is more
limited by the hardware and kernel algorithms than by the compiler's
code generation.  So I wouldn't invest any time into trying to get the
kernel working on yet another non-gcc compiler ...

  Ralf
