Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 17:53:50 +0100 (CET)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:52665 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012115AbaJ2QxsVnDlK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 17:53:48 +0100
Received: by mail-pd0-f171.google.com with SMTP id r10so3325880pdi.2
        for <multiple recipients>; Wed, 29 Oct 2014 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=DViovryhBUiX5QHXafYZxrETeWMI6vJij2s2vJ17DKQ=;
        b=ovin78GmtpYODQ+mvHggFK2GJMNleospFeRVy9aW4jkXC5pbkfHxO9gvLQJG0GD1D2
         UNqrdvsW6fpnuS5RRK2SqRurwn30Xe47JNjoLxk4nBsJcj4QUbRG7GM0lljqVb1DItpt
         zrLWnYRHT0uCk1ngm3U2laGMpO2wxUWfGW/OTN4PTIs1ih60bog8/L64YgV/lqLCh24I
         w62Ncj9gkSKBNVKmEIxcn4nh6gCF5eY4+bwSedc4ilo/eJOaJb2MkPJI+cW4PmntqL0g
         KULluFiakwIoicKc6WqkBWg2J05xqy649UMoMch3WA4hBXQ5koQN41pPex+TGveyIV1k
         NrlA==
X-Received: by 10.70.95.198 with SMTP id dm6mr11740393pdb.58.1414601620591;
        Wed, 29 Oct 2014 09:53:40 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id iw1sm4849010pac.21.2014.10.29.09.53.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 09:53:39 -0700 (PDT)
Message-ID: <54511B79.9080005@gmail.com>
Date:   Wed, 29 Oct 2014 09:53:13 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 02/11] irqchip: brcmstb-l2: Eliminate dependency on ARM
 code
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-2-git-send-email-cernekee@gmail.com>
In-Reply-To: <1414555138-6500-2-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43699
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
> The irq-brcmstb-l2 driver has a single dependency on the ARM code, the
> do_bad_IRQ macro.  Expand this macro in-place so that the driver can be
> built on non-ARM platforms.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/irqchip/irq-brcmstb-l2.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
> index c15c840..c9bdf20 100644
> --- a/drivers/irqchip/irq-brcmstb-l2.c
> +++ b/drivers/irqchip/irq-brcmstb-l2.c
> @@ -19,6 +19,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/spinlock.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
> @@ -30,8 +31,6 @@
>  #include <linux/irqchip.h>
>  #include <linux/irqchip/chained_irq.h>
>  
> -#include <asm/mach/irq.h>
> -
>  #include "irqchip.h"
>  
>  /* Register offsets in the L2 interrupt controller */
> @@ -63,7 +62,9 @@ static void brcmstb_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
>  		~(__raw_readl(b->base + CPU_MASK_STATUS));
>  
>  	if (status == 0) {
> -		do_bad_IRQ(irq, desc);
> +		raw_spin_lock(&desc->lock);
> +		handle_bad_irq(irq, desc);
> +		raw_spin_unlock(&desc->lock);
>  		goto out;
>  	}
>  
> 
