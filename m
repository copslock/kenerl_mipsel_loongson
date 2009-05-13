Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2009 01:23:50 +0100 (BST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:49630 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025541AbZEMAXp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2009 01:23:45 +0100
X-IronPort-AV: E=Sophos;i="4.41,184,1241395200"; 
   d="scan'208";a="303352516"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-6.cisco.com with ESMTP; 13 May 2009 00:23:37 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id n4D0NbeB012136;
	Tue, 12 May 2009 17:23:37 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n4D0NbQE027407;
	Wed, 13 May 2009 00:23:37 GMT
Date:	Tue, 12 May 2009 17:23:37 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Don't branch to eret in TLB refill.
Message-ID: <20090513002337.GA12536@cuplxvomd02.corp.sa.net>
References: <1242168316-4009-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1242168316-4009-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=2159; t=1242174217; x=1243038217;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH]=20MIPS=3A=20Don't=20branch=20to
	=20eret=20in=20TLB=20refill.
	|Sender:=20;
	bh=J4w3AzBNZMzIKvkI6a90+LccDTj1pLmr39v1cvqDp3k=;
	b=YfZ5kOaICgIxpWi/NN40CckO+iGsC6mIW+VbBOQx7zrEbN53DBNzV4BlFY
	IrsjV/R5df9P0HVYiQdlaWmYlUsD0xJz9ClouAVjMVfZjWPsZHL+7rIgslcP
	vg97PdOl/E;
Authentication-Results:	sj-dkim-4; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Tue, May 12, 2009 at 03:45:16PM -0700, David Daney wrote:
> If the TLB refill handler is too bit and needs to be split, there is
> no need to branch around the split if the branch target would be an
> eret.  Since the eret returns from the handler, control flow never
> passes it.  A branch to an eret is equivalent to the eret itself.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/mm/tlbex.c |   50 +++++++++++++++++++++++++++++++++-----------------
>  1 files changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 4dc4f3e..ffa7104 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -723,28 +731,36 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
>  		uasm_copy_handler(relocs, labels, tlb_handler, p, f);
>  		final_len = p - tlb_handler;
>  	} else {
> -		u32 *split = tlb_handler + 30;
> -
> -		/*
> -		 * Find the split point.
> -		 */
> -		if (uasm_insn_has_bdelay(relocs, split - 1))
> -			split--;
> +		u32 *split;
> +		if (split_on_eret) {
> +			split = tlb_handler + 32;
> +		} else {
> +			split = tlb_handler + 30;

It would be a shame to pass up an opportunity to eliminate some of the
pile of magic constants we have in the MIPS tree. Given that the MIPS
documentation describes the size of the TLB Refill handler as 0x80 bytes,
we could add something like:

/* Maximum # of instructions in exception vector for TLB Refill handler */
#define MIPS64_TLB_REFILL_OPS	(0x80 / sizeof(union mips_instruction))

and could change the last few lines of the code above to, for example:

		if (split_on_eret) {
			split = tlb_handler + MIPS64_TLB_REFILL_OPS;
		} else {
			split = tlb_handler + MIPS64_TLB_REFILL_OPS - 2;

(you'd need to include asm/inst.h to get union mips_instruction defined)

> +
> +			/*
> +			 * Find the split point.
> +			 */
> +			if (uasm_insn_has_bdelay(relocs, split - 1))
> +				split--;
> +		}

The code itself makes sense. Does this case actually happen much, or was
this just an itch?

Reviewed-by: David VomLehn <dvomlehn@cisco.com>
