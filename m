Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jan 2005 15:16:14 +0000 (GMT)
Received: from p508B7153.dip.t-dialin.net ([IPv6:::ffff:80.139.113.83]:37731
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225073AbVAMPQJ>; Thu, 13 Jan 2005 15:16:09 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0DFG7uw024921;
	Thu, 13 Jan 2005 16:16:07 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j0DFG794024914;
	Thu, 13 Jan 2005 16:16:07 +0100
Date: Thu, 13 Jan 2005 16:16:07 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Philippe De Swert <philippedeswert@scarlet.be>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: unresolved (soft)float symbols
Message-ID: <20050113151607.GA23657@linux-mips.org>
References: <IA9DY0$DCC07516FD959EE0729448D36856A324@scarlet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA9DY0$DCC07516FD959EE0729448D36856A324@scarlet.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 13, 2005 at 03:08:24PM +0100, Philippe De Swert wrote:

> The module builds fine also, but when insmodding I get the following error.
> 
> insmod: unresolved symbol __fixdfsi
> insmod: unresolved symbol __floatsidf
> insmod: unresolved symbol __muldf3
> insmod: unresolved symbol __adddf3
> 
> As these are all float operations I am wondering about the following things:
> 
> 1.why they are in there? I have a soft-float toolchain....

That's why they are there.

> 2.Is there float support in the kernel? While googling for it I found a few

Nothing whatsoever.

> things talking about FP point in the kernel. Does it have something to do with
> the Algorithmics/MIPS FPU emulator. (Although it does not work emulator or
> not. Which I expected because it should only be used by apps which emit FPU
> calls, and this should not happen because I use a softfloat toolchain). So I
> expect it does not really have something to do with this.
> 3.I took care of using the same compiler options as the kernel compilation
> uses. I guess this is the correct way, and the problems are thus not related
> to this.

The simple answer is no FP in the kernel.

  Ralf
