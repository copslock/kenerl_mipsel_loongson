Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2003 23:14:28 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:63225 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225203AbTCDXO1>;
	Tue, 4 Mar 2003 23:14:27 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h24NEOZ19096;
	Tue, 4 Mar 2003 15:14:24 -0800
Date: Tue, 4 Mar 2003 15:14:24 -0800
From: Jun Sun <jsun@mvista.com>
To: Kip Walker <kwalker@broadcom.com>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	jsun@mvista.com
Subject: Re: [PATCH] kernelsp on 64-bit kernel
Message-ID: <20030304151424.B18978@mvista.com>
References: <3E651FB7.A38AFD3B@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E651FB7.A38AFD3B@broadcom.com>; from kwalker@broadcom.com on Tue, Mar 04, 2003 at 01:50:47PM -0800
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Mar 04, 2003 at 01:50:47PM -0800, Kip Walker wrote:
> 
> Is anyone else interested in having the 64-bit kernel *not* use the CP0
> watchpoint registers for storing the kernel stack pointer for the CPU's
> current process?
> 
> I have a couple problems with this:
>  - there are read-only bits in watchhi (according to the MIPS64 spec) so
> hoping to save and restore all high 32 bits (as currently coded) seems
> unjustified.
>  - somebody might want to actually *use* watchpoints (a JTAG debugger,
> in my case)
>

I agree.  This is a good thing to do.
 
> I put together something that works, based on the 32-bit kernel which
> has an array of kernelsp's instead of keeping it in CP0.  Some notes
> about this solution are:
>  - processor id isn't as easy to get in the 64-bit kernel since
> CP0_CONTEXT has (&pgd_current[cpu] << 23) instead of (cpu << 23) so in
> this patch I use ((&pgd_current[cpu] - &pgd_current[0]) + &kernelsp)
> which seems expensive.

I can't think of any better way than this.  Anybody knows how IRIX
does this? 

Jun
