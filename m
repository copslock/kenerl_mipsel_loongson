Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 09:05:53 +0100 (BST)
Received: from jeeves.momenco.com ([IPv6:::ffff:64.169.228.99]:7945 "EHLO 
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S8225464AbTJIIFt>; Thu, 9 Oct 2003 09:05:49 +0100
Received: (from mdharm@localhost)
	by  host099.momenco.com (8.11.6/8.11.6) id h9985d203524;
	Thu, 9 Oct 2003 01:05:39 -0700
Date: Thu, 9 Oct 2003 01:05:39 -0700
From: Matthew Dharm <mdharm@momenco.com>
To: durai <durai@isofttech.com>
Cc: mips <linux-mips@linux-mips.org>
Subject: Re: how to include mips assembly in c code?
Message-ID: <20031009010539.B3375@momenco.com>
References: <007801c38e27$a1c81920$6b00a8c0@DURAI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <007801c38e27$a1c81920$6b00a8c0@DURAI>; from durai@isofttech.com on Thu, Oct 09, 2003 at 11:08:56AM +0530
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
Return-Path: <mdharm@host099.momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

I feel compelled to point out that the source file you are quoting looks
suspiciously like it came from VxWorks, which means it is likely copyright
Wind River Systems.  Using their code without permission would be illegal.

Matt

On Thu, Oct 09, 2003 at 11:08:56AM +0530, durai wrote:
> hello,
> I am having the following assembly code and i wanted to call this function from a c code.
> can anybody tell me how to include this code in a c program?
> 
> /******************************************************************************
> *
> * sysWbFlush - flush the write buffer
> *
> * This routine flushes the write buffers, making certain all
> * subsequent memory writes have occurred.  It is used during critical periods
> * only, e.g., after memory-mapped I/O register access.
> *
> * RETURNS: N/A
> 
> * sysWbFlush (void)
> 
> */
>         .ent    sysWbFlush
> sysWbFlush:
>         li      t0, K1BASE              /* load uncached address        */
>         lw      t0, 0(t0)               /* read in order to flush       */
>         j       ra                      /* return to caller             */
>         .end    sysWbFlush
> 
> 
> regards
> durai
-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer
