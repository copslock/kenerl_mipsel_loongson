Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2015 23:20:05 +0200 (CEST)
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38088 "EHLO
        mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010785AbbGOVUD11Y0E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jul 2015 23:20:03 +0200
Received: by iggf3 with SMTP id f3so46431292igg.1;
        Wed, 15 Jul 2015 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=bZS3on5b6iAjaRF3ZEKK7HdXM9xiUp/vPcBWzeLsIZc=;
        b=mxY5D49Zcou1wTSDnISaXw40pP8i5Bpap05uZMUNMzEiXGfE7QMXQafI2oDjwCQPCt
         4B6dVXZeH6emCdxKZ8l1BYMhMIjuUJY6YdwiSMCcHcQJhyYBv+hgwpZwYhTr+Of5o90s
         4PtlHhq6yKRFjdlECZvQVtI/I6BemsWc6WmEOCuS4pM4SpS/s3WYVhSxg14bbvMGXRd4
         UcCnF0xjX5zKbXqPrhy2WoOerD7/bjdsIwGmE+nVTpcmNoheDaH/A7ZqFTwJ22m2RNTU
         YM6vUoarkiHTXs3pIsMMiTcgnYK8DszS4G+B0C5hKQqhcyRia9bAudM/RWcB/uqvuiwS
         5IaA==
X-Received: by 10.107.164.168 with SMTP id d40mr7523960ioj.130.1436995196707;
        Wed, 15 Jul 2015 14:19:56 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id j20sm4010928igt.16.2015.07.15.14.19.54
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 Jul 2015 14:19:55 -0700 (PDT)
Message-ID: <55A6CE79.9020502@gmail.com>
Date:   Wed, 15 Jul 2015 14:19:53 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [patch 10/12] MIPS/cavium/octeon: Replace the homebrewn flow
 handler
References: <20150713200602.799079101@linutronix.de> <20150713200715.290025879@linutronix.de>
In-Reply-To: <20150713200715.290025879@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48316
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

On 07/13/2015 01:46 PM, Thomas Gleixner wrote:
> The gpio interrupt handling of octeon contains a homebrewn flow
> handler which calls either handle_level_irq or handle_edge_irq
> depending on the trigger type. Thats an extra conditional and call in
> the interrupt handling path. The proper way to handle different types
> and therefor different flows is to update the handler in the
> irq_set_type() callback.
>
> Remove the extra indirection and add the handler update to
> octeon_irq_ciu_gpio_set_type(). At mapping time it defaults to
> handle_level_irq which gets updated if the device tree contains a
> different trigger type.
>
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>

This looks sane, not tested, but ...

Acked-by: David Daney <david.daney@cavium.com>



> Cc: Ralf Baechle<ralf@linux-mips.org>
> Cc: David Daney<david.daney@cavium.com>
> Cc: Jiang Liu<jiang.liu@linux.intel.com>
> Cc:linux-mips@linux-mips.org
> ---
>   arch/mips/cavium-octeon/octeon-irq.c |   22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>
> Index: tip/arch/mips/cavium-octeon/octeon-irq.c
> ===================================================================
> --- tip.orig/arch/mips/cavium-octeon/octeon-irq.c
> +++ tip/arch/mips/cavium-octeon/octeon-irq.c
> @@ -663,6 +663,11 @@ static int octeon_irq_ciu_gpio_set_type(
>   	irqd_set_trigger_type(data, t);
>   	octeon_irq_gpio_setup(data);
>
> +	if (irqd_get_trigger_type(data) & IRQ_TYPE_EDGE_BOTH)
> +		irq_set_handler_locked(data, handle_edge_irq);
> +	else
> +		irq_set_handler_locked(data, handle_level_irq);
> +
>   	return IRQ_SET_MASK_OK;
>   }
>
> @@ -697,16 +702,6 @@ static void octeon_irq_ciu_gpio_ack(stru
>   	cvmx_write_csr(CVMX_GPIO_INT_CLR, mask);
>   }
>
> -static void octeon_irq_handle_trigger(unsigned int irq, struct irq_desc *desc)
> -{
> -	struct irq_data *data = irq_desc_get_irq_data(desc);
> -
> -	if (irqd_get_trigger_type(data) & IRQ_TYPE_EDGE_BOTH)
> -		handle_edge_irq(irq, desc);
> -	else
> -		handle_level_irq(irq, desc);
> -}
> -
>   #ifdef CONFIG_SMP
>
>   static void octeon_irq_cpu_offline_ciu(struct irq_data *data)
> @@ -1229,8 +1224,13 @@ static int octeon_irq_gpio_map(struct ir
>   		octeon_irq_ciu_to_irq[line][bit] != 0)
>   		return -EINVAL;
>
> +	/*
> +	 * Default to handle_level_irq. If the DT contains a different
> +	 * trigger type, it will call the irq_set_type callback and
> +	 * the handler gets updated.
> +	 */
>   	r = octeon_irq_set_ciu_mapping(virq, line, bit, hw,
> -		octeon_irq_gpio_chip, octeon_irq_handle_trigger);
> +				       octeon_irq_gpio_chip, handle_level_irq);
>   	return r;
>   }
>
>
>
>
>
>
