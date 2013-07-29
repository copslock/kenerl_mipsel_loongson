Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jul 2013 12:41:00 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:49743 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818027Ab3G2Kk459ctu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Jul 2013 12:40:56 +0200
Received: by mail-pd0-f180.google.com with SMTP id 10so5264971pdi.25
        for <multiple recipients>; Mon, 29 Jul 2013 03:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=t5WjskEj1BFLFnCcp8RjTwRY7XTSfCwanVO1enULmuw=;
        b=a4HFadjgG9eNcs9DxNL47GycCTdu39P/fE4ZASKw8GrefpVeX3fvfKKH4lmvuGsS43
         OMvqsid6LUCJ4Fw2lZ6YSwZ7MuMKi64Bu/H3oGOofD2Ie2fD0NhWmlZdkGTlqEFF9GFD
         RkWI4JR4a47fl+EjpoizcBFCvxWX3pQfE9PCNk+Ws/rn1xRRMrxioaXCOntdMdKgb/eW
         vz35ROjw0bYbbZav78h5GR0LK2rU2ikv8X6NSG1BAl3uSmngqqo8Z88cck8DWGAFctaY
         ac7J6KKiNXEgKCDZlKLaN5oNlEXbd1hzTw37r0/PVX7RN57s0SJMqoB1DZjYM4rJRIgY
         66zg==
X-Received: by 10.66.9.71 with SMTP id x7mr68691477paa.37.1375094450076; Mon,
 29 Jul 2013 03:40:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.10.101 with HTTP; Mon, 29 Jul 2013 03:40:10 -0700 (PDT)
In-Reply-To: <1375091743-20608-1-git-send-email-blogic@openwrt.org>
References: <1375091743-20608-1-git-send-email-blogic@openwrt.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Mon, 29 Jul 2013 11:40:10 +0100
Message-ID: <CAGVrzcYXyWB1bwoKyEFrSO7YEJx9Q_v2vOnnPnqVrFVKiigFrA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: add proper set_mode() to cevt-r4k
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37385
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

Hello John,

2013/7/29 John Crispin <blogic@openwrt.org>:
> On ralink SoC a secondary cevt exists, that shares irq 7 with the r4k timer.
> For this to work, we first need to teach cevt-r4k to not hog the irq.

It is not clear to me whether this secondary cevt is also a r4k-cevt
device, or if it is something else? If the IRQ is shared, is there any
way to differentiate the ralink cevt from the r4k cevt, such that both
could request the same irq with the IRQF_SHARED flag?

It looks to me like you are moving the irq setup later just to ensure
that your ralink clockevent device has been registered before and has
set cp0_timer_irq_installed when the set_mode() r4k clockevent device
runs, such that it won't register the same IRQ that your platforms
uses. If that it the case, cannot you just ensure that you run your
cevt device registration before mips_clockevent_init() is called?

>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/kernel/cevt-r4k.c |   39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
> index 50d3f5a..b726422 100644
> --- a/arch/mips/kernel/cevt-r4k.c
> +++ b/arch/mips/kernel/cevt-r4k.c
> @@ -38,12 +38,6 @@ static int mips_next_event(unsigned long delta,
>
>  #endif /* CONFIG_MIPS_MT_SMTC */
>
> -void mips_set_clock_mode(enum clock_event_mode mode,
> -                               struct clock_event_device *evt)
> -{
> -       /* Nothing to do ...  */
> -}
> -
>  DEFINE_PER_CPU(struct clock_event_device, mips_clockevent_device);
>  int cp0_timer_irq_installed;
>
> @@ -90,6 +84,32 @@ struct irqaction c0_compare_irqaction = {
>         .name = "timer",
>  };
>
> +void mips_set_clock_mode(enum clock_event_mode mode,
> +                               struct clock_event_device *evt)
> +{
> +       switch (mode) {
> +       case CLOCK_EVT_MODE_ONESHOT:
> +               if (cp0_timer_irq_installed)
> +                       break;
> +
> +               cp0_timer_irq_installed = 1;
> +
> +               setup_irq(evt->irq, &c0_compare_irqaction);
> +               break;
> +
> +       case CLOCK_EVT_MODE_SHUTDOWN:
> +               if (!cp0_timer_irq_installed)
> +                       break;
> +
> +               cp0_timer_irq_installed = 0;
> +               free_irq(evt->irq, &c0_compare_irqaction);
> +               break;
> +
> +       default:
> +               pr_err("Unhandeled mips clock_mode\n");
> +               break;
> +       }
> +}
>
>  void mips_event_handler(struct clock_event_device *dev)
>  {
> @@ -215,13 +235,6 @@ int r4k_clockevent_init(void)
>  #endif
>         clockevents_register_device(cd);
>
> -       if (cp0_timer_irq_installed)
> -               return 0;
> -
> -       cp0_timer_irq_installed = 1;
> -
> -       setup_irq(irq, &c0_compare_irqaction);
> -
>         return 0;
>  }
>
> --
> 1.7.10.4



-- 
Florian
