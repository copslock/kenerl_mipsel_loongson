Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jul 2013 19:05:24 +0200 (CEST)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:46789 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825732Ab3GYRFMAl0X4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Jul 2013 19:05:12 +0200
Received: by mail-pa0-f48.google.com with SMTP id kp13so993340pab.7
        for <multiple recipients>; Thu, 25 Jul 2013 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ycuKg9S4Zo/L1723qFFoJUsuxGdm18LebFBb/3oQbsU=;
        b=HQRL7T8Dld40JJNO24OGQ0ZXqd3mtYDHv0zLl5/BGAD0xjVGExCXQ5JyqNoZV5VvOT
         UxKOyXmEhM9LXEDPSv1p5qfiO5Yvqr85KlEsev/Ln4A3vYZW4REIY0WVd9ujqzTxv4KS
         yhhGuE60YXc4/sJJpvDBqCYA8SbQaZdYyFUA5KESlQnAzStfeAKUFBsO7ZpwTuD//vTp
         AhwIg6DIDcwK7Wt476xb0IYa1ppiw9m5aTO4A6bvxblb9EFXKzuNatpjUAeXiUYVt+Yj
         Sm1TBiTq8O0E8zUymAwzPMpiy9B4aleEHKPNUF0nh+GBr4mcfYgvFvwYYqtOyLWMezrA
         /FJw==
X-Received: by 10.66.182.166 with SMTP id ef6mr49308419pac.35.1374771904965;
        Thu, 25 Jul 2013 10:05:04 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id nm10sm55061839pbc.28.2013.07.25.10.05.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jul 2013 10:05:03 -0700 (PDT)
Message-ID: <51F15ABD.4010404@gmail.com>
Date:   Thu, 25 Jul 2013 10:05:01 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Octeon: Move declaration of 'fixup_irqs' to common
 header.
References: <1374730817-9040-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1374730817-9040-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37373
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

On 07/24/2013 10:40 PM, Steven J. Hill wrote:
> To prepare for CPU hotplug of CM-based platforms.
>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>

It still builds after this, so...

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/cavium-octeon/smp.c |    2 --
>   arch/mips/include/asm/irq.h   |    1 +
>   2 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index 138cc80..a63dbc0 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -255,8 +255,6 @@ static void octeon_cpus_done(void)
>   /* State of each CPU. */
>   DEFINE_PER_CPU(int, cpu_state);
>
> -extern void fixup_irqs(void);
> -
>   static int octeon_cpu_disable(void)
>   {
>   	unsigned int cpu = smp_processor_id();
> diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
> index 7bc2cdb..8994ca8 100644
> --- a/arch/mips/include/asm/irq.h
> +++ b/arch/mips/include/asm/irq.h
> @@ -126,6 +126,7 @@ extern void do_IRQ_no_affinity(unsigned int irq);
>
>   extern void arch_init_irq(void);
>   extern void spurious_interrupt(void);
> +extern void fixup_irqs(void);
>
>   extern int allocate_irqno(void);
>   extern void alloc_legacy_irqno(void);
>
