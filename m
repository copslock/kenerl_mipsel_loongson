Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 13:07:42 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55071 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823083Ab3FTLHklDzSq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Jun 2013 13:07:40 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5KB7ddZ020215;
        Thu, 20 Jun 2013 13:07:39 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5KB7cKW020214;
        Thu, 20 Jun 2013 13:07:38 +0200
Date:   Thu, 20 Jun 2013 13:07:38 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH] MIPS: Add missing hazard barrier in TLB load handler.
Message-ID: <20130620110738.GB17009@linux-mips.org>
References: <1371707874-6632-1-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371707874-6632-1-git-send-email-Steven.Hill@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37048
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

On Thu, Jun 20, 2013 at 12:57:54AM -0500, Steven J. Hill wrote:

> MIPS R2 documents state that an execution hazard barrier is needed
> after a TLBR before reading EntryLo.
> 
> Change-Id: Idef3b6abbb63a1bbd5e153c6110a979fa7bd5896
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
>  arch/mips/mm/tlbex.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index d9969d2..5ef426c 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -1922,6 +1922,11 @@ static void build_r4000_tlb_load_handler(void)
>  		uasm_i_nop(&p);
>  
>  		uasm_i_tlbr(&p);
> +#if !defined(CONFIG_CPU_CAVIUM_OCTEON)
> +		/* hazard barrier after TLBR but before read EntryLo */
> +		if (cpu_has_mips_r2)
> +			uasm_i_ehb(&p);
> +#endif
>  		/* Examine  entrylo 0 or 1 based on ptr. */
>  		if (use_bbit_insns()) {
>  			uasm_i_bbit0(&p, wr.r2, ilog2(sizeof(pte_t)), 8);
> @@ -1976,6 +1981,11 @@ static void build_r4000_tlb_load_handler(void)
>  		uasm_i_nop(&p);
>  
>  		uasm_i_tlbr(&p);
> +#if !defined(CONFIG_CPU_CAVIUM_OCTEON)
> +		/* hazard barrier after TLBR but before read EntryLo */
> +		if (cpu_has_mips_r2)
> +			uasm_i_ehb(&p);
> +#endif
>  		/* Examine  entrylo 0 or 1 based on ptr. */
>  		if (use_bbit_insns()) {
>  			uasm_i_bbit0(&p, wr.r2, ilog2(sizeof(pte_t)), 8);

And guess which lines the sulphur smell in this patch is coming from.

  Ralf
