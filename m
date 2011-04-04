Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2011 19:41:29 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:3221 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491909Ab1DDRl0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2011 19:41:26 +0200
X-TM-IMSS-Message-ID: <87a58c0000000126@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 87a58c0000000126 ; Mon, 4 Apr 2011 10:41:15 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 4 Apr 2011 10:42:15 -0700
Date:   Mon, 4 Apr 2011 23:12:14 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     "wilbur.chan" <wilbur512@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: System suffers frequent TLB miss
Message-ID: <20110404174213.GA30412@jayachandranc.netlogicmicro.com>
References: <BANLkTikpqk-UcFHHD6MGyZgv6LociaETtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTikpqk-UcFHHD6MGyZgv6LociaETtg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 04 Apr 2011 17:42:15.0630 (UTC) FILETIME=[A304D6E0:01CBF2EF]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

On Sun, Apr 03, 2011 at 11:49:13AM +0800, wilbur.chan wrote:
> Hi all
> 
> We have a system running on mips64 xlr 732.  Our major application
[...]
> I'm  totally exhausted about the tlb miss, I wonder if we can record
> the virtual region of tlb miss  and the miss count in each region, in
> that way,
> 
> I can find out which part leads to this tlb miss.That is , to record
> C0_BADVADDR  in tlb miss.
> 
> 
> However I'm not sure how to add code in build_r4000_tlb_refill_handler
> function, for it is wrote in some strage way .
> 
> Any  suggestion on how to reduce tlb miss?

In our SDK linux, there is some code to add instructions in the TLB 
exception handler using the cpu scratch registers to count TLB misses.
(see mips/mm/tlbex.c code generated with OS_SCRATCH_REG2)

You can extend it with another scratch register containing the an address
per cpu where to record TLB miss badvaddr values(you would just need to 
add code to add sizeof(void*) to the scratch reg value and UASM_i_SW to
store addr). This should give you and idea which adresses are causing the
TLB miss.

I have not actually tried this out on linux(but I have implemented similar
code on FreeBSD and vxWorks) so it should work, let me know if you are
able to get this going...

JC.
