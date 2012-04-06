Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Apr 2012 05:37:32 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:57921 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901346Ab2DFDhS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Apr 2012 05:37:18 +0200
Received: by obhx4 with SMTP id x4so3172556obh.36
        for <linux-mips@linux-mips.org>; Thu, 05 Apr 2012 20:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yXaelibPcftGTS+vcOBg9qlNwv/j4rEukrjrmUdp9qY=;
        b=KMakba/1z/r9jmnmP/ulShyFP4lbk6lCbcOBYoYxRgr8gFbOnMpUzTpUA3URiHN+0V
         BXA2b/oGswdZXC0lPta1YAq8qyn6XZANDaektSCDgML7eDvzqeONMbyDiReB4gkdBGc3
         5N7wuqgzi8zyw33KquiyXRXs1Kg5KhWfkPow8jZlpieV2B1NuHSL0usoUQDO910Y7/Uv
         /OlDR3E3fPEv++GZ8C2vYuL9HRlk/CeBkNokEjKrFxkZLyry7B9ac8Ul+Re4Cfkk6WIf
         ofcCtdpSpPEu2cOW4YrrQ6gtdz6kujm+rYPfP25EN6s5AoGuZxFvqvt6PtFkOWuycoKm
         qYQQ==
Received: by 10.60.32.210 with SMTP id l18mr7278615oei.1.1333683432252;
        Thu, 05 Apr 2012 20:37:12 -0700 (PDT)
Received: from [192.168.1.103] (65-36-72-55.dyn.grandenetworks.net. [65.36.72.55])
        by mx.google.com with ESMTPS id c6sm5005332oec.13.2012.04.05.20.37.09
        (version=SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 20:37:10 -0700 (PDT)
Message-ID: <4F7E64E4.3080509@gmail.com>
Date:   Thu, 05 Apr 2012 22:37:08 -0500
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] irq/irq_domain: Quit ignoring error returns from irq_alloc_desc_from().
References: <1333669933-25267-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1333669933-25267-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/05/2012 06:52 PM, David Daney wrote:
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
>  
>  	pr_debug("irq: irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
>  
> @@ -380,14 +381,14 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
>  	hint = hwirq % irq_virq_count;
>  	if (hint == 0)
>  		hint++;
> -	virq = irq_alloc_desc_from(hint, 0);

You are not looking at mainline. hint was removed in later versions, and
the referenced commit ids don't exist.

Rob

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
