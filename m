Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 08:38:05 +0100 (BST)
Received: from p508B74B7.dip.t-dialin.net ([IPv6:::ffff:80.139.116.183]:37463
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225397AbUDXHiF>; Sat, 24 Apr 2004 08:38:05 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3O7c2xT025636;
	Sat, 24 Apr 2004 09:38:02 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3O7c25m025635;
	Sat, 24 Apr 2004 09:38:02 +0200
Date: Sat, 24 Apr 2004 09:38:02 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
Message-ID: <20040424073802.GA25515@linux-mips.org>
References: <20040424071751.GA561@linux-mips.org> <Pine.GSO.4.10.10404240927450.13336-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10404240927450.13336-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 24, 2004 at 09:31:14AM +0200, Stanislaw Skowronek wrote:

> > So there is no relation at all to modules.  You btw. can load 64-bit ELF
> > modules into a kernel which was built using above trick as 32-bit ELF.
> > That's necessary because modules are currently allocated through vmalloc
> > which allocates space in XKSEG.
> 
> Ah, so it's like that. Great. Is the ELF64 support still not correct?

No, it's supposed to be working now.

> > > I have changed it to 64-bit abi in my Octane kernel, because it won't even
> > > compile otherwise. I've got gcc 3.3.2, gas 2.14.
> > Octane has no memory at all in CKSEG0?
> 
> Well, as far as I know, and I'm probably right, it _does_ have some memory
> there. A whopping 16 kilobytes of memory mirrored by the HEART to allow
> placing exception vectors there (what a weird idea).

That's what the processor expects.

  Ralf
