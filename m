Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2005 21:21:57 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:48288 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225395AbVAXVVm>;
	Mon, 24 Jan 2005 21:21:42 +0000
Received: from drow by nevyn.them.org with local (Exim 4.43 #1 (Debian))
	id 1CtBeH-0001Nf-KS; Mon, 24 Jan 2005 16:21:25 -0500
Date:	Mon, 24 Jan 2005 16:21:25 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fix some (maybe) missing syncs in bitops.h
Message-ID: <20050124212125.GA5071@nevyn.them.org>
References: <20050121010403.GA10371@nevyn.them.org> <20050124210535.GA2797@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124210535.GA2797@linux-mips.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 24, 2005 at 09:05:35PM +0000, Ralf Baechle wrote:
> On Thu, Jan 20, 2005 at 08:04:03PM -0500, Daniel Jacobowitz wrote:
> 
> > If I'm reading the broadcom documentation right, the semantics of set_bit
> > and test_and_set_bit require a sync at the end on this architecture.
> 
> Linux semantics of the bit functions are less than obvious.  The functions
> set_bit, change_bit and clear_bit may be atomic but they don't have memory
> barrier semantics, that is memory accesses before the function call may be
> reordered to be executed after the function has been completed or vice
> versa.  The test_and_{set,clear,change}_bit functions however have memory
> barrier semantics.  The intended use is something like:
> 
> 	if (!test_and_set_bit(bitnr, bitmap)) {
> 		/* we got the bit */
> 
> 		... do something ...
> 
> 		smp_mb__before_clear_bit();
> 		clear_bit(bitnr, bitmap);
> 		smp_mb__after_clear_bit();
> 	} else
> 		printk("Bit was already set by somebody else\n");

I know that clear_bit has these semantics.  But are you sure about
set_bit/change_bit?  The comments in clear_bit in every bitops.h
explicitly say it doesn't have a memory barrier, but those on set_bit
don't.  At least some platforms use acquire semantics.

I don't see where there might be a barrier on the signal_wake_up path
after the flag is set, but since the patch didn't fix my problems,
you're probably right that there is one somewhere :-)

-- 
Daniel Jacobowitz
