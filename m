Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jul 2015 02:51:49 +0200 (CEST)
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34506 "EHLO
        mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011341AbbG1AvraivBh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Jul 2015 02:51:47 +0200
Received: by ykax123 with SMTP id x123so83768587yka.1
        for <linux-mips@linux-mips.org>; Mon, 27 Jul 2015 17:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=okGgXp95S0NUpxNOkEJsOm04m2gih/rl/GyApwkqLdo=;
        b=z8fNxcS5GTFbCP6m90NA5bi1vXtHKPb4YwgM9uF34JRBrWd2vbYef7+Z3vSX5TULRF
         QVdg7fj4lgMpRVx0l19GJyu561OAEC2WALpSSChHgBIcG63KrnShClbB1BlCDMdiLQ7s
         bOdpwFAVR8VRmW7zokn9+qCqTWliRYTjVq0+Ggo/pxbsULshy+KfXx6/HrhLxcY081bI
         7M+JQTyx+ppwHJhv4ARzi8VRsDJcIB+ukZmcYliFkmVgz0jNTZfOsp47V1tuewb0jvlH
         8kubD3cK5VBwGPT1P0voJL/SqcMog8Kl1Z/OVzkFo9mhnbJa+5LYBsL1XDCr4JRhNybU
         hw5g==
X-Received: by 10.13.209.7 with SMTP id t7mr33460513ywd.121.1438044701622;
 Mon, 27 Jul 2015 17:51:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.215.198 with HTTP; Mon, 27 Jul 2015 17:51:12 -0700 (PDT)
In-Reply-To: <1437691941-3100-1-git-send-email-f.fainelli@gmail.com>
References: <1437691941-3100-1-git-send-email-f.fainelli@gmail.com>
From:   Gregory Fong <gregory.0xf0@gmail.com>
Date:   Mon, 27 Jul 2015 17:51:12 -0700
Message-ID: <CADtm3G5o+GRxTfgWGRTdPoAJqoDO8AGs0LLgGMS=PNimAaaDvA@mail.gmail.com>
Subject: Re: [PATCH] irqchip: bcm7120-l2: Fix interrupt status for multiple
 parent IRQs
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, Kevin Cernekee <cernekee@gmail.com>,
        jason@lakedaemon.net, tglx@linutronix.de,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Brian Norris <computersforpeace@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregory.0xf0@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregory.0xf0@gmail.com
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

On Thu, Jul 23, 2015 at 3:52 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Our irq-bcm7120-l2 interrupt controller driver utilizes the same handler
> function for the different parent interrupts it services: UPG_MAIN, UPG_BSC for
> instance.
>
> The problem is that function reads the IRQSTAT register which can combine
> interrupt causes for different parent interrupts, such that we can end-up in
> the following situation:
>
> - CPU takes an interrupt
> - bcm7120_l2_intc_irq_handle() reads IRQSTAT
> - generic_handle_irq() is invoked
> - there are still pending interrupts flagged in IRQSTAT from a different parent
> - handle_bad_irq() is invoked for these since they come from a different irq_desc/irq
>
> In order to fix this, make sure that we always mask IRQSTAT with the
> appropriate bits that correspond go the parent interrupt source this is coming
> from. To simplify things, associate an unique structure per parent interrupt
> handler to avoid multiplying the number of lookups.
>
> Fixes: a5042de2688d ("irqchip: bcm7120-l2: Add Broadcom BCM7120-style Level 2 interrupt controller")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>

> ---
>  drivers/irqchip/irq-bcm7120-l2.c | 51 ++++++++++++++++++++++++++++++----------
>  1 file changed, 39 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
> index 3ba5cc780fcb..8302d45d13ac 100644
> --- a/drivers/irqchip/irq-bcm7120-l2.c
> +++ b/drivers/irqchip/irq-bcm7120-l2.c
> @@ -47,14 +47,20 @@ struct bcm7120_l2_intc_data {
>         struct irq_domain *domain;
>         bool can_wake;
>         u32 irq_fwd_mask[MAX_WORDS];
> -       u32 irq_map_mask[MAX_WORDS];
> +       struct bcm7120_l1_intc_data *l1_data;
>         int num_parent_irqs;
>         const __be32 *map_mask_prop;
>  };
>
> +struct bcm7120_l1_intc_data {
> +       struct bcm7120_l2_intc_data *b;
> +       u32 irq_map_mask[MAX_WORDS];
> +};

I'm not sure the name bcm7120_l1_intc_data is a good name for this,
but I can't think of a better one, and it really doesn't matter that
much.
