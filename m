Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2018 19:06:26 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:35894 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990400AbeEXRGTl4Htf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 May 2018 19:06:19 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 24 May 2018 17:06:13 +0000
Received: from [10.20.78.188] (10.20.78.188) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 24
 May 2018 10:06:14 -0700
Date:   Thu, 24 May 2018 18:06:05 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Paul Burton <paul.burton@mips.com>
CC:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE
 requests
In-Reply-To: <20180524163617.dts46enhigc2yjfo@pburton-laptop>
Message-ID: <alpine.DEB.2.00.1805241757321.10896@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1805141439290.10896@tp.orcam.me.uk> <20180524163617.dts46enhigc2yjfo@pburton-laptop>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.188]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1527181573-321457-30576-10480-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193318
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
X-archive-position: 64011
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

> > Having PR_FP_MODE_FRE (i.e. Config5.FRE) set without PR_FP_MODE_FR (i.e. 
> > Status.FR) is not supported as the lone purpose of Config5.FRE is to 
> > emulate Status.FR=0 handling on FPU hardware that has Status.FR=1 
> > hardwired[1][2].  Also we do not handle this case elsewhere, and assume 
> > throughout our code that TIF_HYBRID_FPREGS and TIF_32BIT_FPREGS cannot 
> > be set both at once for a task, leading to inconsistent behaviour if 
> > this does happen.
> 
> Reviewing the code I think we should actually end up with FR=1 in this
> case, because neither __own_fpu() nor the FPU emulator depend on the
> value of TIF_32BIT_FPREGS if TIF_HYBRID_FPREGS is set. So it's not too
> awful & I don't see the kernel doing anything too crazy, but it
> definitely isn't what the user asked for.

 However `arch_ptrace' does check TIF_32BIT_FPREGS and gets things wrong 
if TIF_HYBRID_FPREGS is also set.  Which is actually how I discovered 
this issue.

> > Return unsuccessfully then from prctl(2) PR_SET_FP_MODE calls requesting 
> > PR_FP_MODE_FRE to be set with PR_FP_MODE_FR clear.  This corresponds to 
> > modes allowed by `mips_set_personality_fp'.
> 
> Looks good to me:
> 
>   Reviewed-by: Paul Burton <paul.burton@mips.com>

 Thanks for your review.

  Maciej
