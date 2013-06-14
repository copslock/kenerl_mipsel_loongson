Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 19:20:59 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:53319 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822508Ab3FNRU6kqJQt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jun 2013 19:20:58 +0200
Received: by mail-pd0-f177.google.com with SMTP id p10so771871pdj.22
        for <multiple recipients>; Fri, 14 Jun 2013 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=apOM5iE4HYlVyrVHVNtxYFf6AXQmf7VgvNKx1IC7uww=;
        b=Q9N8uPexxztkEmuni06P7FUzZxgNeyiGRltKdbfzHIiGr3SA65zBNlC5O3TyrSIMkx
         slUuTi5WkEnLIT4Fz5JepahtI63DBiO8TOvJhdBeM5Uez2K/gwQ7hJ1P44iItEoLyvHA
         sFMLVK0dg6n/Glp6rvJbEuRUYzkTSENGaM94SdiPxYUxXTq6m63SLc3r3Dbx2cj5GTCy
         Z7qLg62hmr6o0BlROcGUfr03flWGU2KRuZhmiNX3/l282ac9NUGKqeZNFguzaHVP5qnK
         ogT5ZIS+plqmoHqb99X89kzz3pODJk0NbnPRwMferX9lwqy2Xb3qAlFxZet6NCGo+IKj
         tvug==
X-Received: by 10.68.101.226 with SMTP id fj2mr3534527pbb.6.1371230450684;
        Fri, 14 Jun 2013 10:20:50 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id v7sm2950832pbq.32.2013.06.14.10.20.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 10:20:49 -0700 (PDT)
Message-ID: <51BB50EF.1050207@gmail.com>
Date:   Fri, 14 Jun 2013 10:20:47 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@arm.linux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] MIPS: octeon: use irq_get_trigger_type() to get IRQ
 flags
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk> <1371228049-27080-7-git-send-email-javier.martinez@collabora.co.uk>
In-Reply-To: <1371228049-27080-7-git-send-email-javier.martinez@collabora.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36903
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

On 06/14/2013 09:40 AM, Javier Martinez Canillas wrote:
> Use irq_get_trigger_type() to get the IRQ trigger type flags
> instead calling irqd_get_trigger_type(irq_desc_get_irq_data(irq))
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/cavium-octeon/octeon-irq.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> index a22f06a..7181def 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -607,7 +607,7 @@ static void octeon_irq_ciu_gpio_ack(struct irq_data *data)
>
>   static void octeon_irq_handle_gpio(unsigned int irq, struct irq_desc *desc)
>   {
> -	if (irqd_get_trigger_type(irq_desc_get_irq_data(desc)) & IRQ_TYPE_EDGE_BOTH)
> +	if (irq_get_trigger_type(irq) & IRQ_TYPE_EDGE_BOTH)
>   		handle_edge_irq(irq, desc);
>   	else
>   		handle_level_irq(irq, desc);
>
