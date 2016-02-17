Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Feb 2016 02:17:16 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33196 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010964AbcBQBP2EGBph (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Feb 2016 02:15:28 +0100
Received: by mail-pa0-f42.google.com with SMTP id fl4so1321809pad.0;
        Tue, 16 Feb 2016 17:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=skv31tHwcrOISI2nr+pEo4dpS4pNxlRjACTaP9NEAz0=;
        b=kVnJ+ZPYLrmtCNyjLdLoKPeYsYvx9L6PEWWQz8ryGWnE4xrurhRXen4dLCDoAhujmR
         XB0u51Z9w28R21tse3pjVm+Ey6/uZDLqzjwtr+nFP+OH47Dqp7dOu9iSJdhUiwap5PPc
         LM3PTcwEow6xA33ws8SfxZKE4XzD8+NBmvd5XA9TRQtLAgCivVaDrej8wGlAU/+FD/R+
         NzIqXxWAxiJqG22qc4mMAGjsQIp7SHkOyFfHqvdZrrBDmv3MFfV6S4RZjHSWkVsU1rCA
         bRvJK1jxGmfRFVdgnKVDZ2z13VtGw4rF+BYKvYJwzRkk9Bsyg0wORwO/dbo3qnrawgnD
         ivyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=skv31tHwcrOISI2nr+pEo4dpS4pNxlRjACTaP9NEAz0=;
        b=WmwYvhlc+7bsCnlp6wW4c9bK2KDzf/ZGm3wJlU6Wwgr/I+za8NELzF1gDGjFaKXZ8q
         HrnVBesouoC9LDSymKezUkTIoZwrBjgYQoOQD5GYAuTEYo1u31xPeJcl65K4xu6PPkS3
         WpovzeKMt7KCvedJyow3EBiPvnZXUeJPDYvFi2VuKC+PPNuWWxg+iKzeBx+j4Fgro3Xo
         LEov8jNuCPuQ4XNfsVpTFwMxaSVIV5n6UqcE/A5ltPkgeg6MKzv0vSjzSHQsK9LMcWfL
         q6i7+gYsAVVmNo/iBAr24N/o5/p3mz6KqxqoL8eYq7VvCgphaeMQEOtPY1UqjOVHFctQ
         vWDQ==
X-Gm-Message-State: AG10YOSYLzc857DICVFzTWUyU5t/RJyibGpQHm1YjRyfc1Jv+rvGhk/1nkIOwQXlaJUyCw==
X-Received: by 10.66.152.204 with SMTP id va12mr35255776pab.0.1455671719415;
        Tue, 16 Feb 2016 17:15:19 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id a21sm48447283pfj.40.2016.02.16.17.15.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Feb 2016 17:15:17 -0800 (PST)
Message-ID: <56C3C9A4.1040109@gmail.com>
Date:   Tue, 16 Feb 2016 17:15:16 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ioan Nicu <ioan.nicu.ext@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Uwe Duerr <uwe.duerr.ext@nokia.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Octeon: do not change affinity for disabled irqs
References: <20160215154513.GF25050@ulegcpding.emea.nsn-net.net>
In-Reply-To: <20160215154513.GF25050@ulegcpding.emea.nsn-net.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52100
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

On 02/15/2016 07:45 AM, Ioan Nicu wrote:
> Octeon sets the default irq affinity to value 1 in the early arch init
> code, so by default all irqs get registered with their affinity set to
> core 0.
>
> When setting one CPU ofline, octeon_irq_cpu_offline_ciu() calls
> irq_set_affinity_locked(), but this function sets the IRQD_AFFINITY_SET bit
> in the irq descriptor. This has the side effect that if one irq is
> requested later, after putting one CPU offline, the affinity of this irq
> would not be the default anymore, but rather forced to "all cores - the
> offline core".
>
> This patch sets the IRQCHIP_ONOFFLINE_ENABLED flag in octeon irq
> controllers, so that the kernel would call the irq_cpu_[on|off]line()
> callbacks only for enabled irqs. If some other irq is requested after
> setting one cpu offline, it would use the default irq affinity, same as it
> would do in the normal case where there is no CPU hotplug operation.
>
> Signed-off-by: Ioan Nicu <ioan.nicu.ext@nokia.com>
> Acked-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

In principle, I don't object.

I would like to see what tglx has to say about this though.  If we are 
worried about the IRQD_AFFINITY_SET bit, I am not convinced that this is 
the best place to be tweaking code.  Are we papering over something that 
should be handled in a more general manner?  I don't know.

David Daney



> ---
>   arch/mips/cavium-octeon/octeon-irq.c |   15 ++++++++++++---
>   1 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> index 368eb49..684582e 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -935,6 +935,7 @@ static struct irq_chip octeon_irq_chip_ciu_v2 = {
>   #ifdef CONFIG_SMP
>   	.irq_set_affinity = octeon_irq_ciu_set_affinity_v2,
>   	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
> +	.flags = IRQCHIP_ONOFFLINE_ENABLED,
>   #endif
>   };
>
> @@ -948,6 +949,7 @@ static struct irq_chip octeon_irq_chip_ciu_v2_edge = {
>   #ifdef CONFIG_SMP
>   	.irq_set_affinity = octeon_irq_ciu_set_affinity_v2,
>   	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
> +	.flags = IRQCHIP_ONOFFLINE_ENABLED,
>   #endif
>   };
>
> @@ -963,6 +965,7 @@ static struct irq_chip octeon_irq_chip_ciu_sum2 = {
>   #ifdef CONFIG_SMP
>   	.irq_set_affinity = octeon_irq_ciu_set_affinity_sum2,
>   	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
> +	.flags = IRQCHIP_ONOFFLINE_ENABLED,
>   #endif
>   };
>
> @@ -976,6 +979,7 @@ static struct irq_chip octeon_irq_chip_ciu_sum2_edge = {
>   #ifdef CONFIG_SMP
>   	.irq_set_affinity = octeon_irq_ciu_set_affinity_sum2,
>   	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
> +	.flags = IRQCHIP_ONOFFLINE_ENABLED,
>   #endif
>   };
>
> @@ -988,6 +992,7 @@ static struct irq_chip octeon_irq_chip_ciu = {
>   #ifdef CONFIG_SMP
>   	.irq_set_affinity = octeon_irq_ciu_set_affinity,
>   	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
> +	.flags = IRQCHIP_ONOFFLINE_ENABLED,
>   #endif
>   };
>
> @@ -1001,6 +1006,7 @@ static struct irq_chip octeon_irq_chip_ciu_edge = {
>   #ifdef CONFIG_SMP
>   	.irq_set_affinity = octeon_irq_ciu_set_affinity,
>   	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
> +	.flags = IRQCHIP_ONOFFLINE_ENABLED,
>   #endif
>   };
>
> @@ -1041,7 +1047,7 @@ static struct irq_chip octeon_irq_chip_ciu_gpio_v2 = {
>   	.irq_set_affinity = octeon_irq_ciu_set_affinity_v2,
>   	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
>   #endif
> -	.flags = IRQCHIP_SET_TYPE_MASKED,
> +	.flags = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_ONOFFLINE_ENABLED,
>   };
>
>   static struct irq_chip octeon_irq_chip_ciu_gpio = {
> @@ -1056,7 +1062,7 @@ static struct irq_chip octeon_irq_chip_ciu_gpio = {
>   	.irq_set_affinity = octeon_irq_ciu_set_affinity,
>   	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
>   #endif
> -	.flags = IRQCHIP_SET_TYPE_MASKED,
> +	.flags = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_ONOFFLINE_ENABLED,
>   };
>
>   /*
> @@ -1838,6 +1844,7 @@ static struct irq_chip octeon_irq_chip_ciu2 = {
>   #ifdef CONFIG_SMP
>   	.irq_set_affinity = octeon_irq_ciu2_set_affinity,
>   	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
> +	.flags = IRQCHIP_ONOFFLINE_ENABLED,
>   #endif
>   };
>
> @@ -1851,6 +1858,7 @@ static struct irq_chip octeon_irq_chip_ciu2_edge = {
>   #ifdef CONFIG_SMP
>   	.irq_set_affinity = octeon_irq_ciu2_set_affinity,
>   	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
> +	.flags = IRQCHIP_ONOFFLINE_ENABLED,
>   #endif
>   };
>
> @@ -1886,7 +1894,7 @@ static struct irq_chip octeon_irq_chip_ciu2_gpio = {
>   	.irq_set_affinity = octeon_irq_ciu2_set_affinity,
>   	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
>   #endif
> -	.flags = IRQCHIP_SET_TYPE_MASKED,
> +	.flags = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_ONOFFLINE_ENABLED,
>   };
>
>   static int octeon_irq_ciu2_xlat(struct irq_domain *d,
> @@ -2537,6 +2545,7 @@ static struct irq_chip octeon_irq_chip_ciu3 = {
>   #ifdef CONFIG_SMP
>   	.irq_set_affinity = octeon_irq_ciu3_set_affinity,
>   	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
> +	.flags = IRQCHIP_ONOFFLINE_ENABLED,
>   #endif
>   };
>
>
