Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 17:54:58 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:55687 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012151AbaJ2QyoPpNtO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 17:54:44 +0100
Received: by mail-pa0-f52.google.com with SMTP id fa1so3523526pad.39
        for <multiple recipients>; Wed, 29 Oct 2014 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=0YjfXpj4dF1YWJkXL/v5X2i7khcu/ZOBe4cfiAkFYWM=;
        b=nj0GuZ1D7YPszyX3FhH3hoiGzvWTltEf5ECxj3agecR9+HWukuMEou/arYeVduBZcJ
         r8Tp668srsxXU3aBabD1bVyg6VAqaJEC1dgZyCYgdfddlw0OF35jmQKn6loHGvxNP/WS
         XvrHOG/Of+otpXVPVDyffcbkMFp7b1Y2TfwIqsGLtV5tSp9P4dV/EtjaUXjclGzjDOvC
         0IWBuSMs+8tZyd0/O492+bYxO6MYanfGNmvQPT3j9aoOD84C+zB1MOucP/XeIm/lsj6T
         0o6zZII85bx/5VlkgHlrXe9vRij6Vd0C+DHnFE4FAQZ9//bQWohHCHD3b+E7jgrZqvFl
         zcfQ==
X-Received: by 10.70.56.103 with SMTP id z7mr2141169pdp.164.1414601676447;
        Wed, 29 Oct 2014 09:54:36 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id rh5sm4850759pdb.4.2014.10.29.09.54.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 09:54:35 -0700 (PDT)
Message-ID: <54511BB1.2070202@gmail.com>
Date:   Wed, 29 Oct 2014 09:54:09 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 06/11] irqchip: bcm7120-l2: Use irq_reg_* accessors
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-6-git-send-email-cernekee@gmail.com>
In-Reply-To: <1414555138-6500-6-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43703
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
> This keeps things consistent between the "core" bcm7120-l2 driver and the
> helpers in generic-chip.c.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/irqchip/irq-bcm7120-l2.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
> index 6472b71..f041992 100644
> --- a/drivers/irqchip/irq-bcm7120-l2.c
> +++ b/drivers/irqchip/irq-bcm7120-l2.c
> @@ -48,7 +48,7 @@ static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
>  
>  	chained_irq_enter(chip, desc);
>  
> -	status = __raw_readl(b->base + IRQSTAT);
> +	status = irq_reg_readl(b->base + IRQSTAT);
>  	do {
>  		irq = ffs(status) - 1;
>  		status &= ~(1 << irq);
> @@ -66,10 +66,10 @@ static void bcm7120_l2_intc_suspend(struct irq_data *d)
>  
>  	irq_gc_lock(gc);
>  	/* Save the current mask and the interrupt forward mask */
> -	b->saved_mask = __raw_readl(b->base + IRQEN) | b->irq_fwd_mask;
> +	b->saved_mask = irq_reg_readl(b->base + IRQEN) | b->irq_fwd_mask;
>  	if (b->can_wake) {
>  		reg = b->saved_mask | gc->wake_active;
> -		__raw_writel(reg, b->base + IRQEN);
> +		irq_reg_writel(reg, b->base + IRQEN);
>  	}
>  	irq_gc_unlock(gc);
>  }
> @@ -81,7 +81,7 @@ static void bcm7120_l2_intc_resume(struct irq_data *d)
>  
>  	/* Restore the saved mask */
>  	irq_gc_lock(gc);
> -	__raw_writel(b->saved_mask, b->base + IRQEN);
> +	irq_reg_writel(b->saved_mask, b->base + IRQEN);
>  	irq_gc_unlock(gc);
>  }
>  
> @@ -133,7 +133,7 @@ int __init bcm7120_l2_intc_of_init(struct device_node *dn,
>  	/* Enable all interrupt specified in the interrupt forward mask and have
>  	 * the other disabled
>  	 */
> -	__raw_writel(data->irq_fwd_mask, data->base + IRQEN);
> +	irq_reg_writel(data->irq_fwd_mask, data->base + IRQEN);
>  
>  	num_parent_irqs = of_irq_count(dn);
>  	if (num_parent_irqs <= 0) {
> 
