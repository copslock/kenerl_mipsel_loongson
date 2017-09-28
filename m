Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2017 20:22:58 +0200 (CEST)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:38236
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992378AbdI1SWtfp3tF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Sep 2017 20:22:49 +0200
Received: by mail-qk0-x243.google.com with SMTP id q8so1542445qkl.5
        for <linux-mips@linux-mips.org>; Thu, 28 Sep 2017 11:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3TeW4X2HTRDnQB5hBNv4azwqnfAFcT5TcKTM8jEsWXY=;
        b=ehJd6sJFZtDpa0ZNwNUZIJbynZSWPyrXjOg+GdxlL7pte1iwmcFLV/cSSdu6zhvPBj
         ZrzOks0coFVeqaFmBoMiHBDAvisKXQcST9KQqgBD21QtEJzFb8ZQtaDS1h4dJS1d6d4A
         lUdf99+vq5Cci7HbNeTSQLzpmblJ+fPOPAMJwbdKXWwWx9pGwZiFSe97gCHl7iCdHoSg
         hsuG3lhMQUFbH3gPN1cwF98+8O1E79a6wvan6J5GedG8iK+6k8RJmyBk4UilcjZZj3WF
         M34u18eNT2bpOeztC8KJ7rANXshmnUlWrTmePmP7axph27LtZiFwhHQ5GsKEYj0G3FmX
         LZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3TeW4X2HTRDnQB5hBNv4azwqnfAFcT5TcKTM8jEsWXY=;
        b=rTIqmEWgN2BuFenNHufvJBc+3HkFlBuvZIxLpC8cKj+ZijdgOSOsQeJcs1f3J8qfFg
         hDFQegEmvNHodTKnAXvVVxEL9XdI3ROEaZ3pBTtwmwos3tYn+k36phjIUAnS/0oxl9/C
         TVL0Qspt73s89MKJC1+uI5MDBRZBGcYqS07BWCSFQ2+DxL+971r828qxDuK8uVU1KCi2
         PsszXt5OYV/JUKkPFJL1AlULNx4WAj/G+QMSGSrlTH4mCxdWS2uV4MZbbG0Jkq4Jlnnz
         CtZQkVZW57p4yYLrE4RHeXhP0FFLuN17bx4W+TIewS2hMxFSf5P+I4Iroxc5IGIZllLT
         Ke2w==
X-Gm-Message-State: AHPjjUhsTJuWMyHyJE0UG5PNwAYkEvZuKYsXAIzHmJREZ0ESS+Tpvucw
        mn9/JUgpnXx6MRG+VGXj7lI=
X-Google-Smtp-Source: AOwi7QBmKNZBPGUY+Y/blAtuBz7m0D7xCznoW04x30VuY8hFK0sp1JnMfaIOzeXXUujyMDU8TsjxtA==
X-Received: by 10.55.217.18 with SMTP id u18mr7793085qki.53.1506622963289;
        Thu, 28 Sep 2017 11:22:43 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id r190sm1420114qke.9.2017.09.28.11.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Sep 2017 11:22:42 -0700 (PDT)
Subject: Re: [PATCH] MIPS: BMIPS: Do not mask IPIs during suspend
To:     justinpopo6@gmail.com, linux-mips@linux-mips.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com
References: <20170928001515.22917-1-justinpopo6@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9b61aae3-53a3-8e96-e00e-76117b19f079@gmail.com>
Date:   Thu, 28 Sep 2017 11:22:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170928001515.22917-1-justinpopo6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60198
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

On 09/27/2017 05:15 PM, justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> Commit a3e6c1eff548 ("MIPS: IRQ: Fix disabled_irq on CPU IRQs") fixes
> an issue where disable_irq did not actually disable the irq. The
> bug caused our IPIs to not be disabled, which actually is the correct
> behavior.
> 
> With the addition of Commit a3e6c1eff548 ("MIPS: IRQ: Fix disabled_irq
> on CPU IRQs"), the IPIs were getting disabled going into suspend,
> thus schedule_ipi() was not being called. This caused deadlocks where
> schedulable task were not being scheduled and other cpus were waiting
> for them to do something.
> 
> Add the IRQF_NO_SUSPEND flag so an irq_disable will not be called
> on the IPIs during suspend.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> Fixes: a3e6c1eff548 ("MIPS: IRQ: Fix disabled_irq on CPU IRQs")

This looks good to me, not sure if this is the recommended way to solve
this bug, but this definitively works.

> ---
>  arch/mips/kernel/smp-bmips.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
> index 1b070a76fcdd..3b900a04d724 100644
> --- a/arch/mips/kernel/smp-bmips.c
> +++ b/arch/mips/kernel/smp-bmips.c
> @@ -168,10 +168,10 @@ static void bmips_prepare_cpus(unsigned int max_cpus)
>  		return;
>  	}
>  
> -	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
> +	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt, IRQF_PERCPU | IRQF_NO_SUSPEND,
>  			"smp_ipi0", NULL))
>  		panic("Can't request IPI0 interrupt");
> -	if (request_irq(IPI1_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
> +	if (request_irq(IPI1_IRQ, bmips_ipi_interrupt, IRQF_PERCPU | IRQF_NO_SUSPEND,
>  			"smp_ipi1", NULL))
>  		panic("Can't request IPI1 interrupt");
>  }
> 


-- 
Florian
