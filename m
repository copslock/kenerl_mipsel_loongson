Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2016 02:17:36 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:43644 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008716AbcCRBReZUb8Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2016 02:17:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=cic4/4tRW7b8cJt1qv/igmgFHyPB42vSHDMFJPlfRe8=; b=Io+Opd81oLbkjrJcgRvHt7ydyS
        GgpcxEd2KGJ4ae50iAsurR8ZuPjwEGF3enKtEvrKhSx1znV3fuusUTHl+PMYj/BKmEEPCiDDdhjej
        mZ2YD35W1Wydt0SSdIJKPKUI9aHDuvSOuUgeoWM57Br8fP4h/SFvRI2Er+CFjZs6iUL4BX4Tefmu6
        HzfQZ8IjukX7KN6xcBs8jnhXS5ehV+cghhHMa9IhM6E4zSu5dlY7rVO6umh2pIXO1DuXH1yfnfwrj
        emoeN3D4VR1TAwdSUAZ9p1ZCqaKETj/G9F6zsBSaaclZDlK8vAMWQ3D5e7A2dyOx/pDRB+rKAWlJa
        l+yhYFwQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41562 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1agj2a-00413i-Ii; Fri, 18 Mar 2016 01:17:27 +0000
Date:   Thu, 17 Mar 2016 18:17:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Qais Yousef <qsyousef@gmail.com>
Cc:     ralf@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix broken malta qemu
Message-ID: <20160318011724.GA9717@roeck-us.net>
References: <1458248889-24663-1-git-send-email-qsyousef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458248889-24663-1-git-send-email-qsyousef@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Thu, Mar 17, 2016 at 09:08:09PM +0000, Qais Yousef wrote:
> Malta defconfig compiles with GIC on. Hence when compiling for SMP it causes the
> new IPI code to be activated. But on qemu malta there's no GIC causing a
> BUG_ON(!ipidomain) to be hit in mips_smp_ipi_init().
> 
> Since in that configuration one can only run a single core SMP (!), skip IPI
> initialisation if we detect that this is the case. It is a sensible behaviour
> to introduce and should keep such possible configuration to run rather than die
> hard unnecessarily.
> 
> Signed-off-by: Qais Yousef <qsyousef@gmail.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/mips/kernel/smp.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index 37708d9..27cb638 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -243,6 +243,18 @@ static int __init mips_smp_ipi_init(void)
>  	struct irq_domain *ipidomain;
>  	struct device_node *node;
>  
> +	/*
> +	 * In some cases like qemu-malta, it is desired to try SMP with
> +	 * a single core. Qemu-malta has no GIC, so an attempt to set any IPIs
> +	 * would cause a BUG_ON() to be triggered since there's no ipidomain.
> +	 *
> +	 * Since for a single core system IPIs aren't required really, skip the
> +	 * initialisation which should generally keep any such configurations
> +	 * happy and only fail hard when trying to truely run SMP.
> +	 */
> +	if (cpumask_weight(cpu_possible_mask) == 1)
> +		return 0;
> +
>  	node = of_irq_find_parent(of_root);
>  	ipidomain = irq_find_matching_host(node, DOMAIN_BUS_IPI);
>  
> -- 
> 2.7.3
> 
