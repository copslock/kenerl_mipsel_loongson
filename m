Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Apr 2012 03:52:00 +0200 (CEST)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:59333 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904084Ab2DGBvz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Apr 2012 03:51:55 +0200
Received: by ggnk1 with SMTP id k1so1609490ggn.36
        for <linux-mips@linux-mips.org>; Fri, 06 Apr 2012 18:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=nI8zXZJZpwIoHZ6XeMQP8Mw/SuzNU8LHjQif08NtX48=;
        b=imhFcFEg0JQZj0BZwy1xC2ci399B/pRMiTjIJryV2j1z0roWQGIOaKe5b0qNuhDgVV
         jPqmiTk012jtdXacB4dSsBIZmho225KYoo+b9t40WlbkjsADirenfjrlmPJtn8ft0Box
         Oemz+8Hm92E+PmHsvHOPUm+JMVhSF+gyPoCYPn9LXt/TN2MWR7BQuE1pkQP2AubTCQ9N
         rbzfYZag/lmC8WBfKN617vced35Z6wumiRfZ9NmmrFJmv3wCPbFA5C81DP9KNT+CD5oo
         hzUPDEqDgImP4IxibAN0PtoZMNgSBJxcNW23uPjNXNUCYbn/B7qOTxXX9njyRaFTWa5U
         tQFQ==
Received: by 10.236.168.41 with SMTP id j29mr30759yhl.24.1333763509575;
        Fri, 06 Apr 2012 18:51:49 -0700 (PDT)
Received: from localhost (mf90f36d0.tmodns.net. [208.54.15.249])
        by mx.google.com with ESMTPS id 34sm14860486anu.6.2012.04.06.18.51.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Apr 2012 18:51:48 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id 62D133E17B2; Fri,  6 Apr 2012 18:26:16 -0700 (PDT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] irq/irq_domain: Quit ignoring error returns from irq_alloc_desc_from().
To:     David Daney <ddaney.cavm@gmail.com>,
        devicetree-discuss@lists.ozlabs.org,
        Rob Herring <rob.herring@calxeda.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
In-Reply-To: <1333669933-25267-1-git-send-email-ddaney.cavm@gmail.com>
References: <1333669933-25267-1-git-send-email-ddaney.cavm@gmail.com>
Date:   Fri, 06 Apr 2012 18:26:16 -0700
Message-Id: <20120407012616.62D133E17B2@localhost>
X-Gm-Message-State: ALoCoQmDRLjydZscKYTOoYmkiSdY1Ke3Ka/qu1JtqGH5VCLTvGra+tjp/rzKceqDzAnLQPjcbtyL
X-archive-position: 32875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu,  5 Apr 2012 16:52:13 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
> 
> In commit 4bbdd45a (irq_domain/powerpc: eliminate irq_map; use
> irq_alloc_desc() instead) code was added that ignores error returns
> from irq_alloc_desc_from() by (silently) casting the return value to
> unsigned.  The negitive value error return now suddenly looks like a
> valid irq number.
> 
> Commits cc79ca69 (irq_domain: Move irq_domain code from powerpc to
> kernel/irq) and 1bc04f2c (irq_domain: Add support for base irq and
> hwirq in legacy mappings) move this code to its current location in
> irqdomain.c
> 
> The result of all of this is a null pointer dereference OOPS if one of
> the error cases is hit.
> 
> The fix: Don't cast away the negativeness of the return value and then
> check for errors.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  kernel/irq/irqdomain.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index af48e59..9d3e3ae 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -351,6 +351,7 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
>  				irq_hw_number_t hwirq)
>  {
>  	unsigned int virq, hint;
> +	int irq;

Merged, but I've dropped the new variable in favour of making virq an
int.  Makes for a smaller diffstat.

g.

>  
>  	pr_debug("irq: irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
>  
> @@ -380,14 +381,14 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
>  	hint = hwirq % irq_virq_count;
>  	if (hint == 0)
>  		hint++;
> -	virq = irq_alloc_desc_from(hint, 0);
> -	if (!virq)
> -		virq = irq_alloc_desc_from(1, 0);
> -	if (!virq) {
> +	irq = irq_alloc_desc_from(hint, 0);
> +	if (irq <= 0)
> +		irq = irq_alloc_desc_from(1, 0);
> +	if (irq <= 0) {
>  		pr_debug("irq: -> virq allocation failed\n");
>  		return 0;
>  	}
> -
> +	virq = irq;
>  	if (irq_setup_virq(domain, virq, hwirq)) {
>  		if (domain->revmap_type != IRQ_DOMAIN_MAP_LEGACY)
>  			irq_free_desc(virq);
> -- 
> 1.7.2.3
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
