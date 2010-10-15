Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2010 03:28:25 +0200 (CEST)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:41522 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491107Ab0JOB2W convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Oct 2010 03:28:22 +0200
Received: by gxk7 with SMTP id 7so141961gxk.36
        for <multiple recipients>; Thu, 14 Oct 2010 18:28:15 -0700 (PDT)
Received: by 10.150.177.17 with SMTP id z17mr512824ybe.170.1287106095322; Thu,
 14 Oct 2010 18:28:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.150.49.9 with HTTP; Thu, 14 Oct 2010 18:27:54 -0700 (PDT)
In-Reply-To: <1287090174-15601-1-git-send-email-ddaney@caviumnetworks.com>
References: <1287090174-15601-1-git-send-email-ddaney@caviumnetworks.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Thu, 14 Oct 2010 19:27:54 -0600
X-Google-Sender-Auth: KNlteChETFviXH0BPbdARC8Yk0s
Message-ID: <AANLkTi=M0Fk5EGy+JB2CZcGxspv3hPde10A-R5sUs3Jq@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add some irq definitins required by OF
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Thu, Oct 14, 2010 at 3:02 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> Using the forthcoming open firmware (OF) on mips patches, requires
> that several interrupt related definitions be added.
>
> In the future we may want to allow some sort of override for
> irq_create_mapping, but for now it is just supplies an identity
> mapping.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Hi David,

If you try my current next-devicetree branch then this patch should
not be necessary.  I was able to build the mips patch before I posted it.

> ---
>  arch/mips/include/asm/irq.h |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
> index dea4aed..f109e67 100644
> --- a/arch/mips/include/asm/irq.h
> +++ b/arch/mips/include/asm/irq.h
> @@ -16,6 +16,39 @@
>
>  #include <irq.h>
>
> +#define NO_IRQ UINT_MAX

Really?  The verdict came down a long time ago that 0 is to be the
value that means no irq, and only a few architectures still define
NO_IRQ as -1.  It is assumed that the architectures which do not
define NO_IRQ use 0 as the invalid value.  Mostly notably x86 does not
define NO_IRQ, and Linus nack'd the patch to add it.

linux-2.6$ git grep '#define[ \t]*NO_IRQ[^_]'
arch/arm/include/asm/irq.h:#define NO_IRQ       ((unsigned int)(-1))
arch/microblaze/include/asm/irq.h:#define NO_IRQ (-1)
arch/mn10300/include/asm/irq.h:#define NO_IRQ           INT_MAX
arch/parisc/include/asm/irq.h:#define NO_IRQ            (-1)
arch/powerpc/include/asm/irq.h:#define NO_IRQ                   (0)
arch/xtensa/variants/s6000/include/variant/irq.h:#define NO_IRQ         (-1)
drivers/input/touchscreen/ucb1400_ts.c:#define NO_IRQ   0
drivers/of/irq.c:#define NO_IRQ 0
drivers/pcmcia/pd6729.c:#define NO_IRQ  ((unsigned int)(0))
drivers/rtc/rtc-m48t59.c:#define NO_IRQ (-1)
drivers/scsi/arm/fas216.h:#define NO_IRQ 255

As far as I can tell, only arm, microblaze, mn10200, parisc, and
xtensa define NO_IRQ to -1, and of those I've got a pending patch to
change Microblaze to use 0.  arm is the hard holdout because of all
the legacy board ports.

> +
> +/*
> + * This type is the placeholder for a hardware interrupt number. It
> + * has to be big enough to enclose whatever representation is used by
> + * a given platform.
> + */
> +typedef unsigned long irq_hw_number_t;
> +
> +static inline void irq_dispose_mapping(unsigned int virq)
> +{
> +       return;
> +}
> +
> +struct irq_host;
> +
> +/**
> + * irq_create_mapping - Map a hardware interrupt into linux virq space
> + * @host: host owning this hardware interrupt or NULL for default host
> + * @hwirq: hardware irq number in that host space
> + *
> + * Only one mapping per hardware interrupt is permitted. Returns a linux
> + * virq number.
> + * If the sense/trigger is to be specified, set_irq_type() should be called
> + * on the number returned from that call.
> + */
> +static inline unsigned int irq_create_mapping(struct irq_host *host,
> +                                             irq_hw_number_t hwirq)
> +{
> +       /* For now, an identity mapping. */
> +       return (unsigned int)hwirq;
> +}
> +
>  #ifdef CONFIG_I8259
>  static inline int irq_canonicalize(int irq)
>  {
> --
> 1.7.2.3
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
