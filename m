Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2003 01:42:02 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:35056 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225251AbTCDBmB>;
	Tue, 4 Mar 2003 01:42:01 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h241fr419627;
	Mon, 3 Mar 2003 17:41:53 -0800
Date: Mon, 3 Mar 2003 17:41:53 -0800
From: Jun Sun <jsun@mvista.com>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Improper handling of unaligned user address access?
Message-ID: <20030303174153.B19572@mvista.com>
References: <3E63B17C.8000403@realitydiluted.com> <3E63EFDC.6090605@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E63EFDC.6090605@realitydiluted.com>; from sjhill@realitydiluted.com on Mon, Mar 03, 2003 at 06:14:20PM -0600
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, Mar 03, 2003 at 06:14:20PM -0600, Steven J. Hill wrote:
> The first thing I tried to fix this issue was to use the
> 'memcpy.S' file from 2.4.7 and that actually worked, but
> that was a step backwards. It was much simpler to just
> add a 'nop' after the offending branch instruction. It
> fixes all of my problems with 'copy_from_user'. 

Adding 'nop' seems to be right.

> I do have one further question. In 'arch/mips/mm/fault.c'
> when we need to do a fixup:
> 
>     fixup = search_exception_table(regs->cp0_epc);
>
> Why do we not check to see if the EPC is a branch insn
> before looking in the exception table?
>

You must be looking at a different tree.  We do check epc
for branch instruction:

	fixup = search_exception_table(exception_epc(regs));

Jun
