Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2011 03:58:59 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:33380 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491765Ab1E0B6y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 May 2011 03:58:54 +0200
Received: by pwi8 with SMTP id 8so681364pwi.36
        for <multiple recipients>; Thu, 26 May 2011 18:58:47 -0700 (PDT)
Received: by 10.68.18.73 with SMTP id u9mr635538pbd.347.1306461527836;
        Thu, 26 May 2011 18:58:47 -0700 (PDT)
Received: from localhost (S01060002b3d79728.cg.shawcable.net [70.72.87.49])
        by mx.google.com with ESMTPS id k9sm82962pbc.86.2011.05.26.18.58.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 18:58:46 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id E5614181B8A; Thu, 26 May 2011 19:58:45 -0600 (MDT)
Date:   Thu, 26 May 2011 19:58:45 -0600
From:   Grant Likely <grant.likely@secretlab.ca>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 4/6] MIPS: Prune some target specific code out of
 prom.c
Message-ID: <20110527015845.GD5032@ponder.secretlab.ca>
References: <1305930343-31259-1-git-send-email-ddaney@caviumnetworks.com>
 <1305930343-31259-5-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1305930343-31259-5-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Fri, May 20, 2011 at 03:25:41PM -0700, David Daney wrote:
> This code is not common enough to be in a shared file.  It is also not
> used by any existing boards, so just remove it.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/kernel/prom.c |   49 -----------------------------------------------
>  1 files changed, 0 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
> index a19811e9..a07b6f1 100644
> --- a/arch/mips/kernel/prom.c
> +++ b/arch/mips/kernel/prom.c
> @@ -59,52 +59,3 @@ void __init early_init_dt_setup_initrd_arch(unsigned long start,
>  	initrd_below_start_ok = 1;
>  }
>  #endif
> -
> -/*
> - * irq_create_of_mapping - Hook to resolve OF irq specifier into a Linux irq#
> - *
> - * Currently the mapping mechanism is trivial; simple flat hwirq numbers are
> - * mapped 1:1 onto Linux irq numbers.  Cascaded irq controllers are not
> - * supported.
> - */
> -unsigned int irq_create_of_mapping(struct device_node *controller,
> -				   const u32 *intspec, unsigned int intsize)
> -{
> -	return intspec[0];
> -}
> -EXPORT_SYMBOL_GPL(irq_create_of_mapping);

In $NEXT_KERNEL+1 irq_create_of_mapping will be replaced by common
infrastructure code after irq_domain is merged, so this will become
irrelevant anyway.

> -
> -void __init early_init_devtree(void *params)
> -{
> -	/* Setup flat device-tree pointer */
> -	initial_boot_params = params;
> -
> -	/* Retrieve various informations from the /chosen node of the
> -	 * device-tree, including the platform type, initrd location and
> -	 * size, and more ...
> -	 */
> -	of_scan_flat_dt(early_init_dt_scan_chosen, NULL);
> -
> -	/* Scan memory nodes */
> -	of_scan_flat_dt(early_init_dt_scan_root, NULL);
> -	of_scan_flat_dt(early_init_dt_scan_memory_arch, NULL);
> -}
> -
> -void __init device_tree_init(void)
> -{
> -	unsigned long base, size;
> -
> -	if (!initial_boot_params)
> -		return;
> -
> -	base = virt_to_phys((void *)initial_boot_params);
> -	size = be32_to_cpu(initial_boot_params->totalsize);
> -
> -	/* Before we do anything, lets reserve the dt blob */
> -	reserve_mem_mach(base, size);
> -
> -	unflatten_device_tree();
> -
> -	/* free the space reserved for the dt blob */
> -	free_mem_mach(base, size);
> -}

I'm a little concerned that the MIPS platforms are not sharing the
same DT init code.  This isn't really something that should need to be
customized per-platform.

g.
