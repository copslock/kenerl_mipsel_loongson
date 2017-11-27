Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Nov 2017 22:40:00 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:36249 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990409AbdK0VjxggSCr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Nov 2017 22:39:53 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 27 Nov 2017 21:39:45 +0000
Received: from [10.20.78.190] (10.20.78.190) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Mon, 27 Nov 2017
 13:39:22 -0800
Date:   Mon, 27 Nov 2017 21:39:10 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Paul Burton <paul.burton@mips.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Validate PR_SET_FP_MODE prctl(2) requests against
 the ABI of the task
In-Reply-To: <20171127184642.ny2lad4y6zz6am2b@pburton-laptop>
Message-ID: <alpine.DEB.2.00.1711272105460.31156@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1711251259130.3865@tp.orcam.me.uk> <20171127184642.ny2lad4y6zz6am2b@pburton-laptop>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1511818784-452060-30630-31335-5
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187352
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

Hi Paul,

> > Fix an API loophole introduced with commit 9791554b45a2 ("MIPS,prctl: 
> > add PR_[GS]ET_FP_MODE prctl options for MIPS"), where the caller of 
> > prctl(2) is incorrectly allowed to make a change to CP0.Status.FR or 
> > CP0.Config5.FRE register bits even if CONFIG_MIPS_O32_FP64_SUPPORT has 
> > not been enabled, despite that an executable requesting the mode 
> > requested via ELF file annotation would not be allowed to run in the 
> > first place, or for n64 and n64 ABI tasks which do not have non-default 
> > modes defined at all.  Add suitable checks to `mips_set_process_fp_mode' 
> > and bail out if an invalid mode change has been requested for the ABI in 
> > effect, even if the FPU hardware or emulation would otherwise allow it.
> 
> This seems reasonable, though in my view more because the FPU emulator
> optimises out code for cases we shouldn't hit via cop1_64bit(). Allowing
> user code to trigger these cases can only lead to odd and incorrect
> behaviour so preventing that makes sense.

 For !CONFIG_MIPS_O32_FP64_SUPPORT we end up with messed up state, yes. 
However for n64/n32 (and CONFIG_MIPS_O32_FP64_SUPPORT set) the state 
should be consistent yet not defined by the respective ABIs, so we 
shouldn't allow that either.

> > Always succeed however without taking any further action if the mode 
> > requested is the same as one already in effect, regardless of whether 
> > any mode change, should it be requested, would actually be allowed for 
> > the task concerned.
> 
> This seems like a distinct change that I think would be worth splitting
> out to a separate patch.

 I've been thinking about it before posting and decided it's inherent.  

 Indeed in developing this fix this part was the last one I realised that 
had to be done for the change to be overall self-consistent, following a 
principle typically applied to hardware registers where the programmer is 
architecturally allowed to write individual bits with the values 
previously read from them even if these bits are undefined in the 
specification of hardware concerned.

 So here you'll be able to issue a PR_SET_FP_MODE request with a value 
previously obtained with PR_GET_FP_MODE and it will succeed, even if all 
the bits are actually read-only for the ABI in effect.  This is important 
as GDB will soon be using these calls and expect PR_SET_FP_MODE not to 
fail if an attempt is made to write back a value previously obtained with 
PR_GET_FP_MODE.

 I could have buried this check in the two conditions that follow, making 
execution fall through if the mode remains unchanged, however I have 
realised that making the check upfront makes the resulting code cleaner.

 That written, I could make it 1/2 with the ABI checks becoming 2/2, but 
then 1/2 wouldn't make sense on its own (except perhaps as a 
microoptimisation, but that would be an entirely different purpose) and 
would have to be considered in conjunction with 2/2 anyway.

> Both changes look good to me though, so feel free to add:
> 
>     Reviewed-by: Paul Burton <paul.burton@mips.com>

 Thanks for your review.  Do you feel convinced with the justification I 
gave?

  Maciej
