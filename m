Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 09:14:08 +0100 (BST)
Received: from p508B74B7.dip.t-dialin.net ([IPv6:::ffff:80.139.116.183]:856
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225758AbUDXIOH>; Sat, 24 Apr 2004 09:14:07 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3O8E5xT007432;
	Sat, 24 Apr 2004 10:14:05 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3O8E5Nq007431;
	Sat, 24 Apr 2004 10:14:05 +0200
Date: Sat, 24 Apr 2004 10:14:05 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
Message-ID: <20040424081405.GA26165@linux-mips.org>
References: <20040424073802.GA25515@linux-mips.org> <Pine.GSO.4.10.10404240945500.14182-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10404240945500.14182-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 24, 2004 at 09:46:46AM +0200, Stanislaw Skowronek wrote:

> > > Ah, so it's like that. Great. Is the ELF64 support still not correct?
> > No, it's supposed to be working now.
> 
> OK. File it away under 'compatibility cruft' then ;)

The size difference this makes is still very significant.  In case of an
IP27 kernel default config:

   text    data     bss     dec     hex filename
2626662  747232  165760 3539654  3602c6 vmlinux
2907645 1283808  165760 4357213  427c5d vmlinux

The first kernel was built with the stock Makefile; the second was modified
to use 64-bit ELF using gcc 2.95.4 / binutils 2.13.2.1.  So I'd call those
817559 bytes kernel obesity ;)

> > > Well, as far as I know, and I'm probably right, it _does_ have some memory
> > > there. A whopping 16 kilobytes of memory mirrored by the HEART to allow
> > > placing exception vectors there (what a weird idea).
> > That's what the processor expects.
> 
> Yeah. The weirdness is not in that part; what's weird is placing the rest
> of memory somewhere else.

Not uncommon on SGI systems.  The Indy's memory also starts at 128MB; only
a few kB for exeption vectors are mirrored to physical address 0.

  Ralf
