Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 08:18:04 +0100 (BST)
Received: from p508B74B7.dip.t-dialin.net ([IPv6:::ffff:80.139.116.183]:23383
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225388AbUDXHRz>; Sat, 24 Apr 2004 08:17:55 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3O7HrxT025188;
	Sat, 24 Apr 2004 09:17:53 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3O7HqLs025187;
	Sat, 24 Apr 2004 09:17:52 +0200
Date: Sat, 24 Apr 2004 09:17:52 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
Message-ID: <20040424071751.GA561@linux-mips.org>
References: <Pine.LNX.4.55.0404231849480.14494@jurand.ds.pg.gda.pl> <Pine.GSO.4.10.10404240825540.10762-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10404240825540.10762-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 24, 2004 at 08:28:09AM +0200, Stanislaw Skowronek wrote:

> why do we attempt to compile the kernel with 32-bit GAS abi and 64-bit GCC
> abi? Is it because the module loader is broken and supports only 32-bit
> ELFs? Then what about machines which load their kernels at weird 64-bit
> addresses, like 0xa800000020004000 (Octane)?

The whole thing was born as a dirty hack back in '99 or so to avoid the
totally broken and imcomplete implementation of 64-bit MIPS ELF in binutils.
By using these options we run the kernel in CKSEG0 which means 32-bit ELF
will suffice.  A nice side effect if a reduction of kernel size - this in
the end made the code model which was born as a hack the way of choice.

So there is no relation at all to modules.  You btw. can load 64-bit ELF
modules into a kernel which was built using above trick as 32-bit ELF.
That's necessary because modules are currently allocated through vmalloc
which allocates space in XKSEG.

A code model which I'm considering as alternative is -G optimization but
that will require a good bit of work; we would have to free up $28 which
right now we're already using for the current pointer.  A bunch of
declaration would simply need to be fixed.  Module loaders would need
support for R_MIPS_GPREL16 and we'd need a solution for the problem of
the kernel being too large, therefore overflowing the small data section.
Th latter is probably going to require binutils hacking, so non-trivial.

> I have changed it to 64-bit abi in my Octane kernel, because it won't even
> compile otherwise. I've got gcc 3.3.2, gas 2.14.

Octane has no memory at all in CKSEG0?

>   Paranoid: one who is truly in touch with reality.

The fact that you're paranoid doesn't meant they're not out to get you.

  Ralf
