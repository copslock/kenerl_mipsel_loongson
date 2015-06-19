Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jun 2015 01:40:41 +0200 (CEST)
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34562 "EHLO
        mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008411AbbFSXkjfM7gM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Jun 2015 01:40:39 +0200
Received: by pdbki1 with SMTP id ki1so99996399pdb.1
        for <linux-mips@linux-mips.org>; Fri, 19 Jun 2015 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=lSMXnqZ2SzGFNRDmNUTgrcZyxCeuEqpA6AN3gOxa7+U=;
        b=YpFmDZXRb4XEKgvO8mtxwX43AfSGw5ZWeVRHT8wWjNFRJKwKR9fYtu+lgmMM5iNTsP
         GEzzfteVCFxMk+TwAxrREdntCElAEhnk/lMbL26TnvQyMKFM2i/PWN53b7/MSl5a0qbE
         sy53mWAfLRw0qOA7N/Z1BPHB5KLgxtHpZojgZpNcq9vC+wGG4iX5W3x0he7JigdOl0HO
         h2BSPmNQoGG+4cZsRyV7Ry5IK4wHtmA/7ByTzjH2O0APoweF1U+XCXj4iaJyAO4nzfmY
         8i90CYfFKpEgD9OEHcotLkxETxxnUvCPx9QNIagGtTFHjJ3oBwBGm9h6NWwX2NvEBpXP
         HXvg==
X-Received: by 10.68.197.161 with SMTP id iv1mr36922160pbc.0.1434757233950;
        Fri, 19 Jun 2015 16:40:33 -0700 (PDT)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id jd4sm12269584pbd.46.2015.06.19.16.40.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2015 16:40:32 -0700 (PDT)
Message-ID: <5584A82A.4080906@gmail.com>
Date:   Fri, 19 Jun 2015 16:39:22 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Brian Norris <computersforpeace@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 2/2] IRQCHIP: bcm7120-l2: perform suspend/resume even
 without installed child IRQs
References: <20150619224123.GL4917@ld-irv-0074> <1434756403-379-1-git-send-email-computersforpeace@gmail.com> <1434756403-379-2-git-send-email-computersforpeace@gmail.com>
In-Reply-To: <1434756403-379-2-git-send-email-computersforpeace@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 19/06/15 16:26, Brian Norris wrote:
> Make use of the new irq_chip chip_{suspend,resume} callbacks.
> 
> This is required because if there are no installed child IRQs for
> this chip, the irq_{suspend,resume} functions will not be called.
> However, we still need to save/restore the forwarding mask, to enable
> the top-level GIC interrupt; otherwise, we lose UART output after S3
> resume.
> 
> In addition to refactoring the callbacks, we have to self-initialize the
> mask cache, since the genirq core also doesn't initialize this until the
> first child IRQ is installed.
> 
> The original problem report is described in extra detail here:
> http://lkml.kernel.org/g/20150619224123.GL4917@ld-irv-0074
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/irqchip/irq-bcm7120-l2.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
> index 299d4de2deb5..98f0129fe843 100644
> --- a/drivers/irqchip/irq-bcm7120-l2.c
> +++ b/drivers/irqchip/irq-bcm7120-l2.c
> @@ -81,10 +81,9 @@ static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> -static void bcm7120_l2_intc_suspend(struct irq_data *d)
> +static void bcm7120_l2_intc_suspend(struct irq_chip_generic *gc)
>  {
> -	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> -	struct irq_chip_type *ct = irq_data_get_chip_type(d);
> +	struct irq_chip_type *ct = gc->chip_types;
>  	struct bcm7120_l2_intc_data *b = gc->private;
>  
>  	irq_gc_lock(gc);
> @@ -94,10 +93,9 @@ static void bcm7120_l2_intc_suspend(struct irq_data *d)
>  	irq_gc_unlock(gc);
>  }
>  
> -static void bcm7120_l2_intc_resume(struct irq_data *d)
> +static void bcm7120_l2_intc_resume(struct irq_chip_generic *gc)
>  {
> -	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> -	struct irq_chip_type *ct = irq_data_get_chip_type(d);
> +	struct irq_chip_type *ct = gc->chip_types;
>  
>  	/* Restore the saved mask */
>  	irq_gc_lock(gc);
> @@ -281,8 +279,15 @@ int __init bcm7120_l2_intc_probe(struct device_node *dn,
>  		ct->chip.irq_mask = irq_gc_mask_clr_bit;
>  		ct->chip.irq_unmask = irq_gc_mask_set_bit;
>  		ct->chip.irq_ack = irq_gc_noop;
> -		ct->chip.irq_suspend = bcm7120_l2_intc_suspend;
> -		ct->chip.irq_resume = bcm7120_l2_intc_resume;
> +		ct->chip.chip_suspend = bcm7120_l2_intc_suspend;
> +		ct->chip.chip_resume = bcm7120_l2_intc_resume;
> +
> +		/*
> +		 * Initialize mask-cache, in case we need it for
> +		 * saving/restoring fwd mask even w/o any child interrupts
> +		 * installed
> +		 */

Your commit message is a tad clearer than this comment, but this is
still good enough to understand what is being done here.

> +		gc->mask_cache = irq_reg_readl(gc, ct->regs.mask);
>  
>  		if (data->can_wake) {
>  			/* This IRQ chip can wake the system, set all
> 


-- 
Florian
