Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 01:52:07 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55613 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009221AbaLTAwFsjzSW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 20 Dec 2014 01:52:05 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBK0q3RT024180;
        Sat, 20 Dec 2014 01:52:03 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBK0q3OA024171;
        Sat, 20 Dec 2014 01:52:03 +0100
Date:   Sat, 20 Dec 2014 01:52:03 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] Revert broken C0_Pagegrain[PG_IEC] support.
Message-ID: <20141220005203.GA5104@linux-mips.org>
References: <1419035585-21671-1-git-send-email-ddaney.cavm@gmail.com>
 <5494C639.8050808@imgtec.com>
 <5494C798.60706@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5494C798.60706@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Dec 19, 2014 at 04:49:28PM -0800, Leonid Yegoshin wrote:
> Date:   Fri, 19 Dec 2014 16:49:28 -0800
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> To: David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
>  ralf@linux-mips.org
> Subject: Re: [PATCH 0/2] Revert broken C0_Pagegrain[PG_IEC] support.
> Content-Type: text/plain; charset="windows-1252"; format=flowed
> 
> On 12/19/2014 04:43 PM, Leonid Yegoshin wrote:
> >On 12/19/2014 04:33 PM, David Daney wrote:
> >>From: David Daney <david.daney@cavium.com>
> >>
> >>The two patches reverted here break eXecute-Inhibit (XI) memory
> >>protection support.  Before the patches we get SIGSEGV when attempting
> >>to execute in non-executable memory, after the patches we loop forever
> >>in handle_tlbl.
> >>
> >>It is probably possible to make C0_Pagegrain[PG_IEC] work, but I think
> >>the most prudent thing is to revert these patches, and then only reapply
> >>something that works after it has been well tested.
> >>
> >>David Daney (2):
> >>   Revert "MIPS: Use dedicated exception handler if CPU supports RI/XI
> >>     exceptions"
> >>   Revert "MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions"
> >>
> >>  arch/mips/include/asm/mipsregs.h | 1 -
> >>  arch/mips/kernel/cpu-probe.c     | 9 ---------
> >>  arch/mips/kernel/traps.c         | 7 -------
> >>  arch/mips/mm/tlbex.c             | 4 ++--
> >>  4 files changed, 2 insertions(+), 19 deletions(-)
> >>
> >Well, it may be have sense just to fix tlb_init() instead.
> 
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index aa6e4b3b2fe2..ed18efd9374b 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -602,7 +602,7 @@ void __cpuinit tlb_init(void)
>  #ifdef CONFIG_64BIT
>                 pg |= PG_ELPA;
>  #endif
> -               write_c0_pagegrain(pg);
> +               write_c0_pagegrain(pg | read_c0_pagegrain());

Simpler:
 		set_c0_pagegrain(pg);

  Ralf
