Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 17:55:17 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:56474 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012150AbaJ2QzA1i8P2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 17:55:00 +0100
Received: by mail-pa0-f52.google.com with SMTP id fa1so3500735pad.25
        for <multiple recipients>; Wed, 29 Oct 2014 09:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=S2uf5nNU3kamqnzxjqi8W066Y6zQFL+/yYa9TG4SKes=;
        b=eFe2sD3BAtsGPCpbnA5eWgqUNo5j0FmUBKIBSyWywASSExtjH5QgqOpLLwE7CQ0usj
         krzSXrll9hvaPkOhYvzpQ/Twn3vJ1ahDUX09Cd1ovfiRMEriCpz49pRTnR/01hxDGwUp
         QVAOXMWi1bhvpxuaUYsVVpVJG9/fq82bK6zdxO8dHk2DoDEkXwR6B1G0SAK6kvYRgW3M
         o2+1vIJrpsKaSYDuaKPsCzIEnHnlK923xbBEv7jB04YloPOjAHZzI3ChKinYpaXQuSX/
         oAMEiFYEW59E22lyhJ70znq91nz36e+MEgp68E1W6npj8QvFEeekf9oazPPxwJTdj9N2
         T3vA==
X-Received: by 10.66.170.14 with SMTP id ai14mr2607797pac.136.1414601694374;
        Wed, 29 Oct 2014 09:54:54 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id bj7sm1050224pad.20.2014.10.29.09.54.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 09:54:53 -0700 (PDT)
Message-ID: <54511BC3.6050305@gmail.com>
Date:   Wed, 29 Oct 2014 09:54:27 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 07/11] irqchip: brcmstb-l2: Use irq_reg_* accessors
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-7-git-send-email-cernekee@gmail.com>
In-Reply-To: <1414555138-6500-7-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43704
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

On 10/28/2014 08:58 PM, Kevin Cernekee wrote:
> This change was just made on bcm7120-l2, so let's keep things consistent
> between the two drivers.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/irqchip/irq-brcmstb-l2.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
> index c9bdf20..8b82b86 100644
> --- a/drivers/irqchip/irq-brcmstb-l2.c
> +++ b/drivers/irqchip/irq-brcmstb-l2.c
> @@ -58,8 +58,8 @@ static void brcmstb_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
>  
>  	chained_irq_enter(chip, desc);
>  
> -	status = __raw_readl(b->base + CPU_STATUS) &
> -		~(__raw_readl(b->base + CPU_MASK_STATUS));
> +	status = irq_reg_readl(b->base + CPU_STATUS) &
> +		~(irq_reg_readl(b->base + CPU_MASK_STATUS));
>  
>  	if (status == 0) {
>  		raw_spin_lock(&desc->lock);
> @@ -71,7 +71,7 @@ static void brcmstb_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
>  	do {
>  		irq = ffs(status) - 1;
>  		/* ack at our level */
> -		__raw_writel(1 << irq, b->base + CPU_CLEAR);
> +		irq_reg_writel(1 << irq, b->base + CPU_CLEAR);
>  		status &= ~(1 << irq);
>  		generic_handle_irq(irq_find_mapping(b->domain, irq));
>  	} while (status);
> @@ -86,12 +86,12 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
>  
>  	irq_gc_lock(gc);
>  	/* Save the current mask */
> -	b->saved_mask = __raw_readl(b->base + CPU_MASK_STATUS);
> +	b->saved_mask = irq_reg_readl(b->base + CPU_MASK_STATUS);
>  
>  	if (b->can_wake) {
>  		/* Program the wakeup mask */
> -		__raw_writel(~gc->wake_active, b->base + CPU_MASK_SET);
> -		__raw_writel(gc->wake_active, b->base + CPU_MASK_CLEAR);
> +		irq_reg_writel(~gc->wake_active, b->base + CPU_MASK_SET);
> +		irq_reg_writel(gc->wake_active, b->base + CPU_MASK_CLEAR);
>  	}
>  	irq_gc_unlock(gc);
>  }
> @@ -103,11 +103,11 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
>  
>  	irq_gc_lock(gc);
>  	/* Clear unmasked non-wakeup interrupts */
> -	__raw_writel(~b->saved_mask & ~gc->wake_active, b->base + CPU_CLEAR);
> +	irq_reg_writel(~b->saved_mask & ~gc->wake_active, b->base + CPU_CLEAR);
>  
>  	/* Restore the saved mask */
> -	__raw_writel(b->saved_mask, b->base + CPU_MASK_SET);
> -	__raw_writel(~b->saved_mask, b->base + CPU_MASK_CLEAR);
> +	irq_reg_writel(b->saved_mask, b->base + CPU_MASK_SET);
> +	irq_reg_writel(~b->saved_mask, b->base + CPU_MASK_CLEAR);
>  	irq_gc_unlock(gc);
>  }
>  
> @@ -132,8 +132,8 @@ int __init brcmstb_l2_intc_of_init(struct device_node *np,
>  	}
>  
>  	/* Disable all interrupts by default */
> -	__raw_writel(0xffffffff, data->base + CPU_MASK_SET);
> -	__raw_writel(0xffffffff, data->base + CPU_CLEAR);
> +	irq_reg_writel(0xffffffff, data->base + CPU_MASK_SET);
> +	irq_reg_writel(0xffffffff, data->base + CPU_CLEAR);
>  
>  	data->parent_irq = irq_of_parse_and_map(np, 0);
>  	if (data->parent_irq < 0) {
> 
