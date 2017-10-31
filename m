Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 22:47:34 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:36677 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992338AbdJaVrY0Tf3l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2017 22:47:24 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 31 Oct 2017 21:47:11 +0000
Received: from localhost (10.20.1.18) by mips01.mipstec.com (10.20.43.31) with
 Microsoft SMTP Server id 14.3.361.1; Tue, 31 Oct 2017 14:44:45 -0700
Date:   Tue, 31 Oct 2017 14:45:39 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     James Hogan <james.hogan@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <jhogan@kernel.org>,
        Nathan Sullivan <nathan.sullivan@ni.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH for-4.14] MIPS: generic: Fix NI 169445 its build
Message-ID: <20171031214538.zyr2bnyanjm2gf7i@pburton-laptop>
References: <20171031214107.15596-1-james.hogan@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171031214107.15596-1-james.hogan@mips.com>
User-Agent: NeoMutt/20171013
X-BESS-ID: 1509486426-321457-7505-22691-5
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.61
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186463
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains 
        popular marketing words 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.61 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60618
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

Hi James,

On Tue, Oct 31, 2017 at 09:41:07PM +0000, James Hogan wrote:
> From: James Hogan <jhogan@kernel.org>
> 
> Since commit 04a85e087ad6 ("MIPS: generic: Move NI 169445 FIT image
> source to its own file"), a generic 32r2el_defconfig kernel fails to
> build with the following build error:
> 
>   ITB     arch/mips/boot/vmlinux.gz.itb
> Error: arch/mips/boot/vmlinux.gz.its:111.1-2 syntax error
> FATAL ERROR: Unable to parse input tree
> mkimage Can't read arch/mips/boot/vmlinux.gz.itb.tmp: Invalid argument

Hmm - I fixed this up already here:

  https://patchwork.linux-mips.org/patch/16941/

and Ralf said he was going to fix up the original commit. I guess it got lost
somewhere..?

Thanks,
    Paul

> This is because arch/mips/generic/board-ni169445.its.S doesn't include
> the necessary "/" node path before the first open brace, which did
> previously exist when it was in arch/mips/generic/vmlinux.its.S.
> 
> Fixes: 04a85e087ad6 ("MIPS: generic: Move NI 169445 FIT image source to its own file")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Nathan Sullivan <nathan.sullivan@ni.com>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/generic/board-ni169445.its.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/generic/board-ni169445.its.S b/arch/mips/generic/board-ni169445.its.S
> index d12e12fe90be..e4cb4f95a8cc 100644
> --- a/arch/mips/generic/board-ni169445.its.S
> +++ b/arch/mips/generic/board-ni169445.its.S
> @@ -1,4 +1,4 @@
> -{
> +/ {
>  	images {
>  		fdt@ni169445 {
>  			description = "NI 169445 device tree";
> -- 
> 2.14.1
> 
