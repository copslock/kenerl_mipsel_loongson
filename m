Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2017 16:32:32 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:56813 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990430AbdLUPcXFUMSb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Dec 2017 16:32:23 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 21 Dec 2017 15:30:26 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Dec
 2017 07:30:06 -0800
Date:   Thu, 21 Dec 2017 15:30:05 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Matt Redfearn <matt.redfearn@mips.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "stable # v4 . 9+" <stable@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 1/3] MIPS: c-r4k: instruction_hazard should immediately
 follow cache op
Message-ID: <20171221153004.GH5027@jhogan-linux.mipstec.com>
References: <1513854965-3880-1-git-send-email-matt.redfearn@mips.com>
 <20171221151443.GG5027@jhogan-linux.mipstec.com>
 <a6bfa1da-806f-a852-f33f-309cd153c596@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <a6bfa1da-806f-a852-f33f-309cd153c596@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1513870224-452059-9817-93841-1
X-BESS-VER: 2017.16.1-r1712081705
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188221
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender 
        Domain Matches Recipient Domain 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, Dec 21, 2017 at 03:19:35PM +0000, Matt Redfearn wrote:
> Hi James,
> 
> On 21/12/17 15:14, James Hogan wrote:
> > On Thu, Dec 21, 2017 at 11:16:02AM +0000, Matt Redfearn wrote:
> >> During ftrace initialisation, placeholder instructions in the prologue
> >> of every kernel function not marked "notrace" are replaced with nops.
> >> After the instructions are written (to the dcache), flush_icache_range()
> >> is used to ensure that the icache will be updated with these replaced
> >> instructions. Currently there is an instruction_hazard guard at the end
> >> of __r4k_flush_icache_range, since a hazard can be created if the CPU
> >> has already begun fetching the instructions that have have been
> >> replaced. The placement, however, ignores the calls to preempt_enable(),
> >> both in __r4k_flush_icache_range and r4k_on_each_cpu. When
> >> CONFIG_PREEMPT is enabled, these expand out to at least calls to
> >> preempt_count_sub(). The lack of an instruction hazard between icache
> >> invalidate and the execution of preempt_count_sub, in rare
> >> circumstances, was observed to cause weird crashes on Ci40, where the
> >> CPU would end up taking a kernel unaligned access exception from the
> >> middle of do_ade(), which it somehow reached from preempt_count_sub
> >> without executing the start of do_ade.
> >>
> >> Since the instruction hazard exists immediately after the dcache is
> >> written back and icache invalidated, place the instruction_hazard()
> >> within __local_r4k_flush_icache_range. The one at the end of
> >> __r4k_flush_icache_range is too late, since all of the functions in the
> >> call path of preempt_enable have already been executed, so remove it.
> >>
> >> This fixes the crashes during ftrace initialisation on Ci40.
> >>
> >> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> >> Cc: stable <stable@vger.kernel.org> # v4.9+
> >>
> >> ---
> >>
> >>   arch/mips/mm/c-r4k.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> >> index 6f534b209971..ce7a54223504 100644
> >> --- a/arch/mips/mm/c-r4k.c
> >> +++ b/arch/mips/mm/c-r4k.c
> >> @@ -760,6 +760,8 @@ static inline void __local_r4k_flush_icache_range(unsigned long start,
> >>   			break;
> >>   		}
> >>   	}
> >> +	/* Hazard to force new i-fetch */
> >> +	instruction_hazard();
> > 
> > By the sounds of it that is a hardware bug, that it didn't try and
> > execute either the old instruction or the new instruction.
> 
> Yeah, possibly.
> 
>   Maybe an
> > expanded comment would be worthwhile here. If it wasn't for that issue
> > it would I suppose be safe for it to be directly before the
> > preempt_enable() in __r4k_flush_icache_range().
> 
> No - there's another preempt_enable() in r4k_on_each_cpu (noted in the 
> commit message) so by the time the local CPU gets to the 
> preempt_enable() in __r4k_flush_icache_range, it has potentially already 
> executed the preempt_enable path and died. That's why I put it here.

Right, but it wouldn't matter since it would still execute valid code?

Cheers
James

> 
> Thanks,
> Matt
> 
> > 
> > Cheers
> > James
> > 
> >>   }
> >>   
> >>   static inline void local_r4k_flush_icache_range(unsigned long start,
> >> @@ -817,7 +819,6 @@ static void __r4k_flush_icache_range(unsigned long start, unsigned long end,
> >>   	}
> >>   	r4k_on_each_cpu(args.type, local_r4k_flush_icache_range_ipi, &args);
> >>   	preempt_enable();
> >> -	instruction_hazard();
> >>   }
> >>   
> >>   static void r4k_flush_icache_range(unsigned long start, unsigned long end)
> >> -- 
> >> 2.7.4
> >>
