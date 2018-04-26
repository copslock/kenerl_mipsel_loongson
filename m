Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2018 12:06:16 +0200 (CEST)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:42557
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbeDZKGIreey8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Apr 2018 12:06:08 +0200
Received: by mail-lf0-x241.google.com with SMTP id u21-v6so28232155lfu.9
        for <linux-mips@linux-mips.org>; Thu, 26 Apr 2018 03:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FaicVP2hlFEmCqsKp73lET+VBMhchgg5D+RDqonb6TU=;
        b=KlXLg/t6nHS4Z+HG3m+YN0+5T4k+VVnTXfMdJ7uPtZCjVwxu2WQE0beFX8BUhSSyvq
         qtgckF/8z1t1ZHCbiOins8HzaPUncZrKMLbnlfrw+7uDu6p64rI8o1cOJOg1J1h8pSkP
         5JX+mLa8Q/Elgl/sZqhjxPAjQcotSsuWtszOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FaicVP2hlFEmCqsKp73lET+VBMhchgg5D+RDqonb6TU=;
        b=Yxu/kgMyFa7oR5hhrbmQV4Px/1rpS7HFFU2z+1WO2klM7u21I6FHJycCdWml3tXQct
         pDX6T5ZvHSwW5WH6emIRXlt33X/VjUBa9mD1P5AriIYP9h3gFUweZWNctpiTSmxAlXcc
         N7hEhbgStCS0oWV4xSW3rLJJm1KLLrVFj2ncXNs58KrTzze8sNwjwIlnttoUZygR65uC
         KSQXPt8bu+h0aIdSwGoxvTTPSAs3s76Qgz+w8+4iEjfj4c/OA+fBzuavP8BUod/7AF8C
         IN5wxu05bgUtiMoQRHbhX4tYwdKTbkShnT+KSk4HgCT4yo3JAoouXnWP1Wo+2Os6nWHf
         SYQw==
X-Gm-Message-State: ALQs6tDbm0WTu5i5+AvfTRBnVMGRTJ1Xq0XpblrNedBKpKd3aQRRRo3I
        FKTXLZ06F+fLdTo52tTXy2SgZHbVoKbCif4k5Q6VwA==
X-Google-Smtp-Source: AIpwx4/6ea/mRbDnSbl1G/tw7LzxT/ygxnaH7VwjxOfPXW6/eQO2XdU7fM0macsJNAPiPsd9N5TD1YacqoiKR+GsXRE=
X-Received: by 10.46.64.77 with SMTP id n74mr22688080lja.6.1524737160892; Thu,
 26 Apr 2018 03:06:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.45.1 with HTTP; Thu, 26 Apr 2018 03:05:20 -0700 (PDT)
In-Reply-To: <1524672085206172@kroah.com>
References: <1524672085206172@kroah.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 26 Apr 2018 15:35:20 +0530
Message-ID: <CAMi1Hd2JT10MmretDX0zFAKsXetJ41aUwMr8vJa=JdVPz+VGaw@mail.gmail.com>
Subject: Re: Patch "irqchip/mips-gic: Fix local interrupts" has been added to
 the 4.9-stable tree
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     jason@lakedaemon.net, linux-mips@linux-mips.org,
        marc.zyngier@arm.com,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        stable-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

Hi Greg,

Please drop this patch. It was NACKed on stable before
https://www.spinics.net/lists/stable/msg170768.html. Thanks.

Regards,
Amit Pundir

On 25 April 2018 at 21:31,  <gregkh@linuxfoundation.org> wrote:
>
> This is a note to let you know that I've just added the patch titled
>
>     irqchip/mips-gic: Fix local interrupts
>
> to the 4.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      irqchip-mips-gic-fix-local-interrupts.patch
> and it can be found in the queue-4.9 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
> From 4cfffcfa5106492f5785924ce2e9af49f075999b Mon Sep 17 00:00:00 2001
> From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> Date: Wed, 25 Jan 2017 15:08:25 +0100
> Subject: irqchip/mips-gic: Fix local interrupts
>
> From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
>
> commit 4cfffcfa5106492f5785924ce2e9af49f075999b upstream.
>
> Some local interrupts are not initialised properly at the moment and
> cannot be used since the domain's alloc method is never called for them.
>
> This has been observed earlier and partially fixed in commit
> e875bd66dfb ("irqchip/mips-gic: Fix local interrupts"), but that change
> still relied on the interrupt to be requested by an external driver (eg.
> drivers/clocksource/mips-gic-timer.c).
>
> This does however not solve the issue for interrupts that are not
> referenced by any driver through the device tree and results in
> request_irq() calls returning -ENOSYS. It can be observed when attempting
> to use perf tool to access hardware performance counters.
>
> Fix this by explicitly calling irq_create_fwspec_mapping() for local
> interrupts.
>
> Fixes: e875bd66dfb ("irqchip/mips-gic: Fix local interrupts")
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  drivers/irqchip/irq-mips-gic.c |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -969,6 +969,34 @@ static struct irq_domain_ops gic_ipi_dom
>         .match = gic_ipi_domain_match,
>  };
>
> +static void __init gic_map_single_int(struct device_node *node,
> +                                     unsigned int irq)
> +{
> +       unsigned int linux_irq;
> +       struct irq_fwspec local_int_fwspec = {
> +               .fwnode         = &node->fwnode,
> +               .param_count    = 3,
> +               .param          = {
> +                       [0]     = GIC_LOCAL,
> +                       [1]     = irq,
> +                       [2]     = IRQ_TYPE_NONE,
> +               },
> +       };
> +
> +       if (!gic_local_irq_is_routable(irq))
> +               return;
> +
> +       linux_irq = irq_create_fwspec_mapping(&local_int_fwspec);
> +       WARN_ON(!linux_irq);
> +}
> +
> +static void __init gic_map_interrupts(struct device_node *node)
> +{
> +       gic_map_single_int(node, GIC_LOCAL_INT_TIMER);
> +       gic_map_single_int(node, GIC_LOCAL_INT_PERFCTR);
> +       gic_map_single_int(node, GIC_LOCAL_INT_FDC);
> +}
> +
>  static void __init __gic_init(unsigned long gic_base_addr,
>                               unsigned long gic_addrspace_size,
>                               unsigned int cpu_vec, unsigned int irqbase,
> @@ -1069,6 +1097,7 @@ static void __init __gic_init(unsigned l
>
>         bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
>         gic_basic_init();
> +       gic_map_interrupts(node);
>  }
>
>  void __init gic_init(unsigned long gic_base_addr,
>
>
> Patches currently in stable-queue which might be from marcin.nowakowski@imgtec.com are
>
> queue-4.9/irqchip-mips-gic-fix-local-interrupts.patch
> queue-4.9/mips-fix-mem-x-y-commandline-processing.patch
