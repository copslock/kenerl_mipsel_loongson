Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 15:08:15 +0200 (CEST)
Received: from mail-io0-x22c.google.com ([IPv6:2607:f8b0:4001:c06::22c]:34242
        "EHLO mail-io0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992178AbdDJNIHgjUKC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Apr 2017 15:08:07 +0200
Received: by mail-io0-x22c.google.com with SMTP id a103so29434376ioj.1
        for <linux-mips@linux-mips.org>; Mon, 10 Apr 2017 06:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QM3PjCQW+Eq+KSEme7OdRx7KPvziCpvqjHZ7UQt+ifw=;
        b=JpVODI+dfPEJnziCFI5XjWPJPCnqtp3+fnTAJvh4e2cWKF8z+1MbZcOixqWJ9oajwz
         1ov5PJmEg28bI6YmdWXiqNzeElLwcD57tMO/HOjlY8q2jIsaTJzcU8WG/XZUQYRkGikd
         CeDrRqIsA1z4bxQ3HSRazG2yky2QSk+S+PXCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QM3PjCQW+Eq+KSEme7OdRx7KPvziCpvqjHZ7UQt+ifw=;
        b=I4bGbbgdo4VaAIAmfpuPuFCKj/3D7wYx32clvB3lNulWNkN2QO8BbI+XHTovFjrv3q
         Z6FzwBVBt1MbnWJtAXbJZ+5C4ytk+4gjw5JGoppP1UYoqlURy8KMjVS1xbdCuri3zMf+
         NrlzCiiIvGws8QGTDuX6mK7dKxIrSJcVAj8a5hk9O3TdyUZLvej+7fit75onlSy2jh07
         Qic10TrXLYQtjlFI//mnIPzWRmCJgCHwbu/P9X2chDHpaabCCFX01n8UwvG76ZpS/5N7
         VJ2ERnfUSWCeRN/qZGpstjscQh47qQcB2DGtj7Br5Dq81Kk/EOtCYCEkkk26yjustSH/
         xa4w==
X-Gm-Message-State: AN3rC/6VerkxCqXaoRZzb8JEunvhX5SOzfq0GqYJ6ChAwvsKjzCTxjEv
        FV+RTv6xRv5RekGisCY3gB9v/V2qq25r
X-Received: by 10.36.175.28 with SMTP id t28mr7778424ite.68.1491829680143;
 Mon, 10 Apr 2017 06:08:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.33.200 with HTTP; Mon, 10 Apr 2017 06:07:19 -0700 (PDT)
In-Reply-To: <20170410125930.26495-47-jslaby@suse.cz>
References: <20170410125930.26495-1-jslaby@suse.cz> <20170410125930.26495-47-jslaby@suse.cz>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Mon, 10 Apr 2017 18:37:19 +0530
Message-ID: <CAMi1Hd1P9w6H2N6A9D6=ZYJY2Txd4yPww7Atw3iUSjJGSb4NLg@mail.gmail.com>
Subject: Re: [patch added to 3.12-stable] MIPS: Lantiq: Fix cascaded IRQ setup
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57633
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

Hi Jiri,

On 10 April 2017 at 18:29, Jiri Slaby <jslaby@suse.cz> wrote:
> From: Felix Fietkau <nbd@nbd.name>
>
> This patch has been added to the 3.12 stable tree. If you have any
> objections, please let us know.
>
> ===============
>
> commit 6c356eda225e3ee134ed4176b9ae3a76f793f4dd upstream.
>
> With the IRQ stack changes integrated, the XRX200 devices started
> emitting a constant stream of kernel messages like this:
>
> [  565.415310] Spurious IRQ: CAUSE=0x1100c300
>
> This is caused by IP0 getting handled by plat_irq_dispatch() rather than
> its vectored interrupt handler, which is fixed by commit de856416e714
> ("MIPS: IRQ Stack: Fix erroneous jal to plat_irq_dispatch").
>
> Fix plat_irq_dispatch() to handle non-vectored IPI interrupts correctly
> by setting up IP2-6 as proper chained IRQ handlers and calling do_IRQ
> for all MIPS CPU interrupts.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Acked-by: John Crispin <john@phrozen.org>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/15077/
> [james.hogan@imgtec.com: tweaked commit message]
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>

Just to let you know that I cherry-picked this patch from LEDE source
for 4.4 and 4.9 stable but James pointed out that this patch fixes a
Mips IRQ bug introduced in later (4.10+) kernels. So we dropped it
from 4.4 and 4.9 plan as such. Thanks.

Regards,
Amit Pundir

> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  arch/mips/lantiq/irq.c | 38 +++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
>
> diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
> index eb3e18659630..1637f165deab 100644
> --- a/arch/mips/lantiq/irq.c
> +++ b/arch/mips/lantiq/irq.c
> @@ -268,6 +268,11 @@ static void ltq_hw5_irqdispatch(void)
>  DEFINE_HWx_IRQDISPATCH(5)
>  #endif
>
> +static void ltq_hw_irq_handler(struct irq_desc *desc)
> +{
> +       ltq_hw_irqdispatch(irq_desc_get_irq(desc) - 2);
> +}
> +
>  #ifdef CONFIG_MIPS_MT_SMP
>  void __init arch_init_ipiirq(int irq, struct irqaction *action)
>  {
> @@ -312,23 +317,19 @@ static struct irqaction irq_call = {
>  asmlinkage void plat_irq_dispatch(void)
>  {
>         unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
> -       unsigned int i;
> -
> -       if ((MIPS_CPU_TIMER_IRQ == 7) && (pending & CAUSEF_IP7)) {
> -               do_IRQ(MIPS_CPU_TIMER_IRQ);
> -               goto out;
> -       } else {
> -               for (i = 0; i < MAX_IM; i++) {
> -                       if (pending & (CAUSEF_IP2 << i)) {
> -                               ltq_hw_irqdispatch(i);
> -                               goto out;
> -                       }
> -               }
> +       int irq;
> +
> +       if (!pending) {
> +               spurious_interrupt();
> +               return;
>         }
> -       pr_alert("Spurious IRQ: CAUSE=0x%08x\n", read_c0_status());
>
> -out:
> -       return;
> +       pending >>= CAUSEB_IP;
> +       while (pending) {
> +               irq = fls(pending) - 1;
> +               do_IRQ(MIPS_CPU_IRQ_BASE + irq);
> +               pending &= ~BIT(irq);
> +       }
>  }
>
>  static int icu_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
> @@ -353,11 +354,6 @@ static const struct irq_domain_ops irq_domain_ops = {
>         .map = icu_map,
>  };
>
> -static struct irqaction cascade = {
> -       .handler = no_action,
> -       .name = "cascade",
> -};
> -
>  int __init icu_of_init(struct device_node *node, struct device_node *parent)
>  {
>         struct device_node *eiu_node;
> @@ -413,7 +409,7 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
>         mips_cpu_irq_init();
>
>         for (i = 0; i < MAX_IM; i++)
> -               setup_irq(i + 2, &cascade);
> +               irq_set_chained_handler(i + 2, ltq_hw_irq_handler);
>
>         if (cpu_has_vint) {
>                 pr_info("Setting up vectored interrupts\n");
> --
> 2.12.2
>
