Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2004 20:13:29 +0100 (BST)
Received: from p508B66F0.dip.t-dialin.net ([IPv6:::ffff:80.139.102.240]:48186
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225211AbUHWTNY>; Mon, 23 Aug 2004 20:13:24 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7NJDJnM029930;
	Mon, 23 Aug 2004 21:13:19 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7NJDJHo029929;
	Mon, 23 Aug 2004 21:13:19 +0200
Date: Mon, 23 Aug 2004 21:13:19 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Dominic Sweetman <dom@mips.com>, Jun Sun <jsun@mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: anybody tried NPTL?
Message-ID: <20040823191319.GA29165@linux-mips.org>
References: <20040804152936.D6269@mvista.com> <16676.46694.564448.344602@arsenal.mips.com> <20040819221646.GC8737@mvista.com> <16678.163.774841.111369@arsenal.mips.com> <20040823132853.GA31354@nevyn.them.org> <20040823171256.GC21884@linux-mips.org> <20040823174446.GA8197@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823174446.GA8197@nevyn.them.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 23, 2004 at 01:44:47PM -0400, Daniel Jacobowitz wrote:

> Personally, I favor doing the low-overhead syscall for o32 and then
> moving to the new ABI that MIPS is talking about with a thread
> register.

I was always wondering how far gcc could optimize code to minimize this
special system call.  After all on Alpha something similar PAL-code based
was the method of choice.

> I'm not sure what to do about n32/n64.

I believe N32 / N64 are not widespead enough yet to be a big roadblock
for moving to new ABIs.  Whoever disagress should better speak up soon :-)

If we deciede to move to something entirely different than the existing
ABIs in the future will be able to support compatibility the same way
we're already doing.

> > Other crazy ideas did include a per-thread mapping containing the thread
> > pointer - and possibly more information in the future.
> 
> Does MIPS have an efficient way to do this for SMP?

It can be done making the TLB fault for that page about as expensive as
a null syscall.

> > On the positive side if we had multiple register sets on a MIPSxx V2
> > processor we could exploit that to get rid of this overheade and do
> > other nice optimizations for TLB reload also.  Unfortunately these
> > register sets are optional feature of the architecture only.
> 
> That's more or less what was talked about for ARM v6.

I'm unARMed here ;-)

  Ralf
