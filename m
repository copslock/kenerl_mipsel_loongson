Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 17:55:56 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34137 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012161AbaJ2QzxDhbiy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 17:55:53 +0100
Received: by mail-pa0-f48.google.com with SMTP id ey11so3528116pad.21
        for <multiple recipients>; Wed, 29 Oct 2014 09:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EcQ4vVWu2mxg+zV2Hf2B/uKNnGkRS5AKe9XMYiM6lhQ=;
        b=qPDmBq9luter5hb4WT+GUKUP8aFP7+2ZZjHy6RISA7aoGyuRQUQ8+1CsnT90EsWkLi
         YBom9zsS0m2j+U3/F41RRpJb0mJelmxgxoJe2imEOi9xBM2T5tSReTmK4DAD+v/VAWMW
         ozVWp88Ztcc1HfjEDnvz3WrJ0IfY3ZOpFVuWMSXNseHshhth/tb+NvW/v+laWXHQTk9t
         3I5kOsDXCdxIXHHr5lJpnTfDsw6QuQKT4iYj6mANO27FCPmJp9OzwnGCof8/jGjF7vRm
         RCVW06YP8ZqX3R1VbAfD0YWFpI21r2Q6WBR3irjm3Ly3ekti2I/VwWLZSUtANM0aCQOA
         uaqQ==
X-Received: by 10.68.68.141 with SMTP id w13mr11721972pbt.82.1414601745804;
        Wed, 29 Oct 2014 09:55:45 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id y2sm4835411pdp.31.2014.10.29.09.55.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 09:55:45 -0700 (PDT)
Message-ID: <54511BF6.9060908@gmail.com>
Date:   Wed, 29 Oct 2014 09:55:18 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 09/11] irqchip: bcm7120-l2: Use gc->mask_cache to simplify
 suspend/resume functions
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-9-git-send-email-cernekee@gmail.com>
In-Reply-To: <1414555138-6500-9-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43706
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
> The cached value already incorporates irq_fwd_mask, and was saved the
> last time an IRQ was enabled/disabled.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/irqchip/irq-bcm7120-l2.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
> index e9331f8..c76c9ad 100644
> --- a/drivers/irqchip/irq-bcm7120-l2.c
> +++ b/drivers/irqchip/irq-bcm7120-l2.c
> @@ -37,7 +37,6 @@ struct bcm7120_l2_intc_data {
>  	bool can_wake;
>  	u32 irq_fwd_mask;
>  	u32 irq_map_mask;
> -	u32 saved_mask;
>  };
>  
>  static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
> @@ -62,14 +61,11 @@ static void bcm7120_l2_intc_suspend(struct irq_data *d)
>  {
>  	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>  	struct bcm7120_l2_intc_data *b = gc->private;
> -	u32 reg;
>  
>  	irq_gc_lock(gc);
> -	/* Save the current mask and the interrupt forward mask */
> -	b->saved_mask = irq_reg_readl(b->base + IRQEN) | b->irq_fwd_mask;
>  	if (b->can_wake) {
> -		reg = b->saved_mask | gc->wake_active;
> -		irq_reg_writel(reg, b->base + IRQEN);
> +		irq_reg_writel(gc->mask_cache | gc->wake_active,
> +			       b->base + IRQEN);
>  	}
>  	irq_gc_unlock(gc);
>  }
> @@ -77,11 +73,10 @@ static void bcm7120_l2_intc_suspend(struct irq_data *d)
>  static void bcm7120_l2_intc_resume(struct irq_data *d)
>  {
>  	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> -	struct bcm7120_l2_intc_data *b = gc->private;
>  
>  	/* Restore the saved mask */
>  	irq_gc_lock(gc);
> -	irq_reg_writel(b->saved_mask, b->base + IRQEN);
> +	irq_reg_writel(gc->mask_cache, b->base + IRQEN);
>  	irq_gc_unlock(gc);
>  }
>  
> 
