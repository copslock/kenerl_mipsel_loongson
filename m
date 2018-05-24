Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2018 18:36:35 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:40581 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990400AbeEXQg0kv3Pf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 May 2018 18:36:26 +0200
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 24 May 2018 16:36:18 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 24
 May 2018 09:36:21 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Thu, 24 May
 2018 09:36:21 -0700
Date:   Thu, 24 May 2018 09:36:17 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     "Maciej W. Rozycki" <macro@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE
 requests
Message-ID: <20180524163617.dts46enhigc2yjfo@pburton-laptop>
References: <alpine.DEB.2.00.1805141439290.10896@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1805141439290.10896@tp.orcam.me.uk>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1527179778-298553-3491-57502-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193318
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender 
        Domain Matches Recipient Domain 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Maciej,

On Tue, May 15, 2018 at 11:04:44PM +0100, Maciej W. Rozycki wrote:
> Having PR_FP_MODE_FRE (i.e. Config5.FRE) set without PR_FP_MODE_FR (i.e. 
> Status.FR) is not supported as the lone purpose of Config5.FRE is to 
> emulate Status.FR=0 handling on FPU hardware that has Status.FR=1 
> hardwired[1][2].  Also we do not handle this case elsewhere, and assume 
> throughout our code that TIF_HYBRID_FPREGS and TIF_32BIT_FPREGS cannot 
> be set both at once for a task, leading to inconsistent behaviour if 
> this does happen.

Reviewing the code I think we should actually end up with FR=1 in this
case, because neither __own_fpu() nor the FPU emulator depend on the
value of TIF_32BIT_FPREGS if TIF_HYBRID_FPREGS is set. So it's not too
awful & I don't see the kernel doing anything too crazy, but it
definitely isn't what the user asked for.

> Return unsuccessfully then from prctl(2) PR_SET_FP_MODE calls requesting 
> PR_FP_MODE_FRE to be set with PR_FP_MODE_FR clear.  This corresponds to 
> modes allowed by `mips_set_personality_fp'.

Looks good to me:

  Reviewed-by: Paul Burton <paul.burton@mips.com>

Thanks,
  Paul

> References:
> 
> [1] "MIPS Architecture For Programmers, Vol. III: MIPS32 / microMIPS32
>     Privileged Resource Architecture", Imagination Technologies,
>     Document Number: MD00090, Revision 6.02, July 10, 2015, Table 9.69 
>     "Config5 Register Field Descriptions", p. 262
> 
> [2] "MIPS Architecture For Programmers, Volume III: MIPS64 / microMIPS64 
>     Privileged Resource Architecture", Imagination Technologies, 
>     Document Number: MD00091, Revision 6.03, December 22, 2015, Table 
>     9.72 "Config5 Register Field Descriptions", p. 288
> 
> Cc: stable@vger.kernel.org # 4.0+
> Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS")
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>
> ---
>  arch/mips/kernel/process.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> linux-mips-set-process-fp-mode-fr-fre.diff
> Index: linux/arch/mips/kernel/process.c
> ===================================================================
> --- linux.orig/arch/mips/kernel/process.c	2018-05-12 22:52:11.000000000 +0100
> +++ linux/arch/mips/kernel/process.c	2018-05-12 23:07:15.147112000 +0100
> @@ -721,6 +721,10 @@ int mips_set_process_fp_mode(struct task
>  	if (value & ~known_bits)
>  		return -EOPNOTSUPP;
>  
> +	/* Setting FRE without FR is not supported.  */
> +	if ((value & (PR_FP_MODE_FR | PR_FP_MODE_FRE)) == PR_FP_MODE_FRE)
> +		return -EOPNOTSUPP;
> +
>  	/* Avoid inadvertently triggering emulation */
>  	if ((value & PR_FP_MODE_FR) && raw_cpu_has_fpu &&
>  	    !(raw_current_cpu_data.fpu_id & MIPS_FPIR_F64))
> 
