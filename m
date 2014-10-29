Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 17:54:41 +0100 (CET)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:37140 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012146AbaJ2QyaNG05a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 17:54:30 +0100
Received: by mail-pd0-f174.google.com with SMTP id p10so3300930pdj.5
        for <multiple recipients>; Wed, 29 Oct 2014 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XFuDMMg3e7Kh0hOj5KKhHrsgL+jwZ02vdBbUmHL+1hg=;
        b=y5kV5yoGvzNAMpplAc5dLUYl23G0Hr4gCkOZF/hZ7gNlolgOuUO9rSGc5D/yTMyF0g
         yLfpUKHpgCnfaJI0ebyKpYVeobS4xEsD3m0jz4orBQLCnVdMnUBbsVgKmw/vprG4y/gE
         1tTFO7JM7VbKw/ZZ1V3M3FPR42WUrNfci5HfWB0hzabWCI0IGLaIPIVql44U8Mmt7RNL
         7kFDneqxzAeNeb4ZLnw/xEOw47AqEZn4iuLFR+LnBKLxrkjWKkvVBkUs3JUCuZpDVQ5t
         CBDh3uIwWZYexzzUsaoJIHrzYHndbyfsYpXhCvz10tz0yi3TdqNj5h7gCQbj7QAXRs4B
         wssQ==
X-Received: by 10.68.110.161 with SMTP id ib1mr11334166pbb.109.1414601664095;
        Wed, 29 Oct 2014 09:54:24 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id f7sm4843250pdj.15.2014.10.29.09.54.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 09:54:23 -0700 (PDT)
Message-ID: <54511BA4.4000509@gmail.com>
Date:   Wed, 29 Oct 2014 09:53:56 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 05/11] irqchip: bcm7120-l2: Make sure all register accesses
 use base+offset
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-5-git-send-email-cernekee@gmail.com>
In-Reply-To: <1414555138-6500-5-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43702
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
> A couple of accesses to IRQEN (base+0x00) just used "base" directly, so
> they would break if IRQEN ever became nonzero.  Make sure that all
> reads/writes specify the register offset constant.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/irqchip/irq-bcm7120-l2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
> index 49d8f3d..6472b71 100644
> --- a/drivers/irqchip/irq-bcm7120-l2.c
> +++ b/drivers/irqchip/irq-bcm7120-l2.c
> @@ -66,10 +66,10 @@ static void bcm7120_l2_intc_suspend(struct irq_data *d)
>  
>  	irq_gc_lock(gc);
>  	/* Save the current mask and the interrupt forward mask */
> -	b->saved_mask = __raw_readl(b->base) | b->irq_fwd_mask;
> +	b->saved_mask = __raw_readl(b->base + IRQEN) | b->irq_fwd_mask;
>  	if (b->can_wake) {
>  		reg = b->saved_mask | gc->wake_active;
> -		__raw_writel(reg, b->base);
> +		__raw_writel(reg, b->base + IRQEN);
>  	}
>  	irq_gc_unlock(gc);
>  }
> @@ -81,7 +81,7 @@ static void bcm7120_l2_intc_resume(struct irq_data *d)
>  
>  	/* Restore the saved mask */
>  	irq_gc_lock(gc);
> -	__raw_writel(b->saved_mask, b->base);
> +	__raw_writel(b->saved_mask, b->base + IRQEN);
>  	irq_gc_unlock(gc);
>  }
>  
> 
