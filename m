Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2004 18:28:03 +0100 (BST)
Received: from p508B60B2.dip.t-dialin.net ([IPv6:::ffff:80.139.96.178]:7204
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225208AbUD1R2C>; Wed, 28 Apr 2004 18:28:02 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3SHRfxT031872
	for <linux-mips@linux-mips.org>; Wed, 28 Apr 2004 19:27:41 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3SHRLQE031854;
	Wed, 28 Apr 2004 19:27:21 +0200
Date: Wed, 28 Apr 2004 19:27:21 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org
Subject: Re: TLB on R10k
Message-ID: <20040428172721.GA28007@linux-mips.org>
References: <20040427192828.GA7739@linux-mips.org> <Pine.GSO.4.10.10404280734480.9183-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10404280734480.9183-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 28, 2004 at 07:37:06AM +0200, Stanislaw Skowronek wrote:

> > Have you verified that the UX bit is set correctly by your kernel?  BEV
> > also plays a role but since you survive BogoMIPS it should be right.
> 
> >From what I remember, the UX bit is fixed set. I have made the machine
> print a '*' (no, I didn't use printk, but since it's my own console
> driver I'm pretty sure it can work in interrupts - all it does is
> hardware writes) whenever it gets a TLB refill and flushed the TLB before
> entering usermode. Guess what, I didn't get a single '*' after ERET. To
> verify my method, I've made a single read from the usermode PC from the
> kernel, and the '*' appeared. I don't know what's up.

printk can be used in exceptions.

Be careful when changing the TLB exception handlers.  They occupy slots
of just 128 bytes or 32 instructions.  Maybe your debugging code just
extended it beyond that maximum?

  Ralf
