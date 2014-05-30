Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2014 13:39:23 +0200 (CEST)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:53395 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820484AbaE3LjVqulLa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 May 2014 13:39:21 +0200
Received: by mail-ie0-f176.google.com with SMTP id rl12so1531927iec.7
        for <linux-mips@linux-mips.org>; Fri, 30 May 2014 04:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OkGu2XAdQDtGEDkjBSnP1m7ETork3htY1dxzi/wi/28=;
        b=SxHvge+zgTPdg9ZdtZTyqhdraPVnN5nJunGIcTMXaXVPJtL6eaNreOdOacddJKYjMU
         ov3erkEj3IgoekJVvOx0k38bZKhh4slmx+3RBtc+GjznNN2K0O1SIu7SbpMHoKgq9gwS
         azWpj+M4HWY9/inzNKpIn8L0uO20xANeNNB0bf7/Y0ox3MRan/gbF8f6kYga/p8H2Ebj
         h9Cq2DYqw7UDrWoepGOa+hAey/U2ZC2Cm6zbTE7Neolc2pc9Zs0oJSdoChEBubBOXlmc
         kcD+6pT3Va/8Uug+7txskVGjU360jW4rjdXyb7j30l7Uj1D9YkmNKph9EdMkSRwmfL9U
         ckrg==
MIME-Version: 1.0
X-Received: by 10.50.25.105 with SMTP id b9mr4894120igg.28.1401449955736; Fri,
 30 May 2014 04:39:15 -0700 (PDT)
Received: by 10.64.17.199 with HTTP; Fri, 30 May 2014 04:39:15 -0700 (PDT)
In-Reply-To: <1401449454-30895-2-git-send-email-berthe.ab@gmail.com>
References: <20140530094025.3b78301e@canb.auug.org.au>
        <1401449454-30895-1-git-send-email-berthe.ab@gmail.com>
        <1401449454-30895-2-git-send-email-berthe.ab@gmail.com>
Date:   Fri, 30 May 2014 13:39:15 +0200
X-Google-Sender-Auth: X5ccsM5FgG3baozVM2z1TwX4DjE
Message-ID: <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: gpiolib: set gpiochip_remove retval to void
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     abdoulaye berthe <berthe.ab@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>, m@bues.ch,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        patches@opensource.wolfsonmicro.com,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-samsungsoc@vger.kernel.org, spear-devel@list.st.com,
        platform-driver-x86@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Fri, May 30, 2014 at 1:30 PM, abdoulaye berthe <berthe.ab@gmail.com> wrote:
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1263,10 +1263,9 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gpiochip);
>   *
>   * A gpio_chip with any GPIOs still requested may not be removed.
>   */
> -int gpiochip_remove(struct gpio_chip *chip)
> +void gpiochip_remove(struct gpio_chip *chip)
>  {
>         unsigned long   flags;
> -       int             status = 0;
>         unsigned        id;
>
>         acpi_gpiochip_remove(chip);
> @@ -1278,24 +1277,15 @@ int gpiochip_remove(struct gpio_chip *chip)
>         of_gpiochip_remove(chip);
>
>         for (id = 0; id < chip->ngpio; id++) {
> -               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags)) {
> -                       status = -EBUSY;
> -                       break;
> -               }
> -       }
> -       if (status == 0) {
> -               for (id = 0; id < chip->ngpio; id++)
> -                       chip->desc[id].chip = NULL;
> -
> -               list_del(&chip->list);
> +               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags))
> +                       panic("gpio: removing gpiochip with gpios still requested\n");

panic?

Is this likely to happen?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
