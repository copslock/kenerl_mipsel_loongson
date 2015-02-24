Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 01:33:33 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27006864AbbBXAd30kH4V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 01:33:29 +0100
Date:   Tue, 24 Feb 2015 00:33:29 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 41/70] MIPS: mm: tlbex: Use cpu_has_mips_r2_exec_hazard
 for the EHB instruction
In-Reply-To: <54EBA3C3.30108@gmail.com>
Message-ID: <alpine.LFD.2.11.1502240011420.17311@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-42-git-send-email-markos.chandras@imgtec.com> <54EBA3C3.30108@gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Mon, 23 Feb 2015, David Daney wrote:

> For the version of this patch currently in mips-for-linux-next: NACK
> 
> There are two problems:
> 
> 1) It breaks OCTEON, which will now crash in early boot with:
> 
>   Kernel panic - not syncing: No TLB refill handler yet (CPU type: 80)
> 
> 2) The logic is broken.
> 
> The meaning of cpu_has_mips_r2_exec_hazard is that the EHB instruction is
> required.  You change the meaning to be that EHB is part of the ISA.

 Well, the macro is nowhere used I'm afraid, its last use was dropped with 
625c0a21, so it's rather difficult to assume any meaning to the macro.

 Also the intended meaning is clear from the commit message of 41f0e4d0, 
where the macro comes from, however unfortunately not from the definition 
of the macro itself.  It's a pity that along your change you did not 
include an explanatory note in arch/mips/include/asm/cpu-features.h.

 Finally, I think the change made to `build_tlb_write_entry' with 625c0a21 
may need to be reconsidered, as may perhaps the name itself of 
`cpu_has_mips_r2_exec_hazard' (why is it this place only that the macro 
was used? -- would it be better called `cpu_has_tlbw_exec_hazard' 
instead?), and then we'll need `cpu_has_ehb' or suchlike across all the 
other places.

  Maciej
