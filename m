Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 17:59:19 +0200 (CEST)
Received: from mail-yh0-f53.google.com ([209.85.213.53]:45613 "EHLO
        mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012242AbaJWP7RXHRHS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 17:59:17 +0200
Received: by mail-yh0-f53.google.com with SMTP id z6so1215251yhz.40
        for <multiple recipients>; Thu, 23 Oct 2014 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=JGHqqP7yT/YGRcY2AmdVFFtIP962LzQEhcNbE5CTZ7U=;
        b=fbMGi7mq9PvYS27RTm758zAAZY0L8OOK6QM3xDI4BPXCrhfOS0yGaogQ0zjBesIoOu
         NgwylhxQSbit/7UfzI+in9ONnlEdjWrd92g+73MVX80rXUI6niv9rfyZlJWU79viB32R
         IoLLXrLRJt1j5n5BTOhyOAnIZjDQepGAjM47N9zOYAQSEQVsxdle52ISW7y6mmLpZQX0
         1fh4p49WBbTF2ghB0+yQ57lEltqPkdZP9ALU2mI0S6xiUjdjNpnILR+LMoOZQ9mbvm0f
         V09XLULb1SQP7jMDIk0ziO1A0lZUahI5UYGRbFHNHvIm2WuNtcNaGJ0x8GWW+9XyAFHa
         HwJA==
X-Received: by 10.170.111.5 with SMTP id d5mr453955ykb.20.1414079950993;
        Thu, 23 Oct 2014 08:59:10 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id qo2sm1260615igb.21.2014.10.23.08.59.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 23 Oct 2014 08:59:10 -0700 (PDT)
Message-ID: <544925CC.7040801@gmail.com>
Date:   Thu, 23 Oct 2014 08:59:08 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Alexander Sverdlin <alexander.sverdlin@nsn.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Make Octeon GPIO IRQ chip CPU hotplug-aware
References: <544908B8.7050109@nsn.com>
In-Reply-To: <544908B8.7050109@nsn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 10/23/2014 06:55 AM, Alexander Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nsn.com>
>
> Make Octeon GPIO IRQ chip CPU hotplug-aware
>
> Seems that irq_cpu_offline callbacks were forgotten in v1 and v2 CIU
> GPIO chips. There is such a callback for octeon_irq_chip_ciu2_gpio,
> covering CIU2 chips. Without this callback GPIO IRQs are not being migrated
> during core offlining. Patch is tested on Octeon II.
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nsn.com>

Acked-by: David Daney <david.daney@cavium.com>

Ralf, please apply.

Thanks,
David Daney


>
> ---
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -809,6 +809,7 @@ static struct irq_chip octeon_irq_chip_ciu_gpio_v2 = {
>   	.irq_set_type = octeon_irq_ciu_gpio_set_type,
>   #ifdef CONFIG_SMP
>   	.irq_set_affinity = octeon_irq_ciu_set_affinity_v2,
> +	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
>   #endif
>   	.flags = IRQCHIP_SET_TYPE_MASKED,
>   };
> @@ -823,6 +824,7 @@ static struct irq_chip octeon_irq_chip_ciu_gpio = {
>   	.irq_set_type = octeon_irq_ciu_gpio_set_type,
>   #ifdef CONFIG_SMP
>   	.irq_set_affinity = octeon_irq_ciu_set_affinity,
> +	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
>   #endif
>   	.flags = IRQCHIP_SET_TYPE_MASKED,
>   };
>
>
>
