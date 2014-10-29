Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 17:54:07 +0100 (CET)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41476 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012143AbaJ2Qx5hdEkf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 17:53:57 +0100
Received: by mail-pd0-f172.google.com with SMTP id r10so3350097pdi.3
        for <multiple recipients>; Wed, 29 Oct 2014 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OztiVPXp4L0R9M0dL5ydLQK+L3J4SggGrTB+6H9ghIU=;
        b=CZ8/M8q0j1bSzzdZazCxO5WM/qlLXV1UayyhrCzf+ydKOLgpAD3+ZEFclXVwt+Ci+P
         Na0XNJNa/fiv/8LJb89Wp6VrWTv04It/aCFwXRqz0pKHJkMYMW/1kDaUJK2a4J4wiAkD
         PMYaRgzOsV8JZ3dk8tCEkcAu3HIRpskVmHDPa5UiBS2YCL2MTqyJmCCO4VVuZMIkx5dz
         BWFg4DwIO8LXoO8OdwBe+emsCdkuG4Hmrx3+5EhLeqaG5nRBxU6U7GAt0amK2EHuXUJ4
         tb2PmqJ9xW3ifYHtOFb0xc/UXBNrMZlBuaSnZngK+P/I5X5ff1v4EGjzQRQ7Ik5+Gn8U
         Gh/A==
X-Received: by 10.66.220.34 with SMTP id pt2mr3404533pac.142.1414601631362;
        Wed, 29 Oct 2014 09:53:51 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id c1sm4823185pbu.23.2014.10.29.09.53.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 09:53:50 -0700 (PDT)
Message-ID: <54511B84.7010404@gmail.com>
Date:   Wed, 29 Oct 2014 09:53:24 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 03/11] irqchip: bcm7120-l2: Eliminate bad IRQ check
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-3-git-send-email-cernekee@gmail.com>
In-Reply-To: <1414555138-6500-3-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43700
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
> This check may be prone to race conditions, e.g.
> 
> 1) Some external event (e.g. GPIO level) causes an IRQ to become pending
> 2) Peripheral asserts the L2 IRQ
> 3) CPU takes an interrupt
> 4) The event from #1 goes away
> 5) bcm7120_l2_intc_irq_handle() reads back a 0 status
> 
> Unlike the hardware supported by brcmstb-l2, the bcm7120-l2 controller
> does not latch the IRQ status.  Bits can change if the inputs to the
> controller change.  Also, do_bad_IRQ() is an ARM-specific macro.
> 
> So let's just nuke it.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/irqchip/irq-bcm7120-l2.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
> index b9f4fb8..49d8f3d 100644
> --- a/drivers/irqchip/irq-bcm7120-l2.c
> +++ b/drivers/irqchip/irq-bcm7120-l2.c
> @@ -27,8 +27,6 @@
>  
>  #include "irqchip.h"
>  
> -#include <asm/mach/irq.h>
> -
>  /* Register offset in the L2 interrupt controller */
>  #define IRQEN		0x00
>  #define IRQSTAT		0x04
> @@ -51,19 +49,12 @@ static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
>  	chained_irq_enter(chip, desc);
>  
>  	status = __raw_readl(b->base + IRQSTAT);
> -
> -	if (status == 0) {
> -		do_bad_IRQ(irq, desc);
> -		goto out;
> -	}
> -
>  	do {
>  		irq = ffs(status) - 1;
>  		status &= ~(1 << irq);
>  		generic_handle_irq(irq_find_mapping(b->domain, irq));
>  	} while (status);
>  
> -out:
>  	chained_irq_exit(chip, desc);
>  }
>  
> 
