Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2009 23:04:33 +0000 (GMT)
Received: from mail-bw0-f13.google.com ([209.85.218.13]:18394 "EHLO
	mail-bw0-f13.google.com") by ftp.linux-mips.org with ESMTP
	id S21365068AbZAHXEb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Jan 2009 23:04:31 +0000
Received: by bwz6 with SMTP id 6so24578567bwz.0
        for <linux-mips@linux-mips.org>; Thu, 08 Jan 2009 15:04:24 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eASU8P5nK7k3iz8ta0J02HsvqsNMXJBkx/zsSGS8dk8=;
        b=TI4THdvC/JUm9rx/U3b4h5d6u9Lva8CDJ3eJIBxF5ZVwcs7kI8pFntwhHxAGaLw0zn
         jU2tm9Qp7dqwcXghT0Ac6QD6t1+RYMtzig0hrmC1yeeAvdD4Ng4aeO4jLdzR5YQK1Llm
         dpmE/Us22hK84P9HMtTVoczN4AsyUkhzJyd2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tEVtRW4zkDaIv8PkKmMsvj+NGjE8zqh854B5quEaCSqF5ooBPreuDHn4oTSDLzKJ66
         BOIUc3a1fIAQblFrGQT63X3Pwl3rTLv82I2FGB+eRtdiqhdHFyuNnsgyjCoNJFAOpoFg
         OBsd69TEmLMBkhw3cGeVSLhQrPfgwOOQ9UIFE=
Received: by 10.181.148.2 with SMTP id a2mr9490848bko.117.1231455864721;
        Thu, 08 Jan 2009 15:04:24 -0800 (PST)
Received: by 10.180.255.19 with HTTP; Thu, 8 Jan 2009 15:04:24 -0800 (PST)
Message-ID: <fce2a370901081504n41f58383x5e1b77f4bac7a410@mail.gmail.com>
Date:	Fri, 9 Jan 2009 01:04:24 +0200
From:	"Ihar Hrachyshka" <ihar.hrachyshka@gmail.com>
To:	"David Daney" <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 2/2] cpumask fallout: Initialize irq_default_affinity earlier (v2).
Cc:	rusty@rustcorp.com.au, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	travis@sgi.com
In-Reply-To: <1231455345-29453-2-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <496683D0.6000509@caviumnetworks.com>
	 <1231455345-29453-2-git-send-email-ddaney@caviumnetworks.com>
Return-Path: <ihar.hrachyshka@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihar.hrachyshka@gmail.com
Precedence: bulk
X-list: linux-mips

#ifdef X
void func(args)
{
  operation();
}
#else
void func(args)
{
}
#endif

is better than:

void func(args)
{
#ifdef X
  operation();
#endif
}

IMHO.

On Fri, Jan 9, 2009 at 12:55 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> Move the initialization of irq_default_affinity to early_irq_init as
> core_initcall is too late.
>
> irq_default_affinity can be used in init_IRQ and potentially timer and
> SMP init as well.  All of these happen before core_initcall.  Moving
> the initialization to early_irq_init ensures that it is initialized
> before it is used.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  kernel/irq/handle.c |   12 ++++++++++++
>  kernel/irq/manage.c |    8 --------
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> index c20db0b..a9fbb01 100644
> --- a/kernel/irq/handle.c
> +++ b/kernel/irq/handle.c
> @@ -39,6 +39,14 @@ void handle_bad_irq(unsigned int irq, struct irq_desc *desc)
>        ack_bad_irq(irq);
>  }
>
> +static inline void __init init_irq_default_affinity(void)
> +{
> +#if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_HARDIRQS)
> +       alloc_bootmem_cpumask_var(&irq_default_affinity);
> +       cpumask_setall(irq_default_affinity);
> +#endif
> +}
> +
>  /*
>  * Linux has a controller-independent interrupt architecture.
>  * Every controller has a 'controller-template', that is used
> @@ -134,6 +142,8 @@ int __init early_irq_init(void)
>        int legacy_count;
>        int i;
>
> +       init_irq_default_affinity();
> +
>        desc = irq_desc_legacy;
>        legacy_count = ARRAY_SIZE(irq_desc_legacy);
>
> @@ -219,6 +229,8 @@ int __init early_irq_init(void)
>        int count;
>        int i;
>
> +       init_irq_default_affinity();
> +
>        desc = irq_desc;
>        count = ARRAY_SIZE(irq_desc);
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 618a64f..291f036 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -18,14 +18,6 @@
>  #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_HARDIRQS)
>  cpumask_var_t irq_default_affinity;
>
> -static int init_irq_default_affinity(void)
> -{
> -       alloc_cpumask_var(&irq_default_affinity, GFP_KERNEL);
> -       cpumask_setall(irq_default_affinity);
> -       return 0;
> -}
> -core_initcall(init_irq_default_affinity);
> -
>  /**
>  *     synchronize_irq - wait for pending IRQ handlers (on other CPUs)
>  *     @irq: interrupt number to wait for
> --
> 1.5.6.6
>
>
>
