Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 17:38:02 +0100 (CET)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:36140
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeABQhxidimp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 17:37:53 +0100
Received: by mail-io0-x243.google.com with SMTP id i143so29358190ioa.3;
        Tue, 02 Jan 2018 08:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gEp8sub2EiUqQvo61VEfOm8QzgFbh7P1EFsBrIlNMxw=;
        b=sJRencxp7cxge7lm/HBBRfEdlWgM3gKLxQOoJUZnJZc2ZJdsdY/aq3WwX2QbsCU7ud
         cDPd8lSMjONyVhU9e3dXlMPv7jhbBhGh2UMOQJ+lAmk7vF7mwXhAhN/oc6fiLUxeamwb
         9JamH5ZfXxMe7829pbzueL301CJNW9pqtDPIBzkACTYfZ6YRRoFGs8GVJ7Qr6Fb+4qU1
         +itI3+sS/qj3dr/TMkyP/pUpmORflzJWH8Rj64QtrOoxeEgmM+08Ot9uJJHiNgZwTpwe
         5Ofo6b/PooaWBs3QVdq3hvr5oI0CD6PfH1ZIzwmxhQ5+eE98aHlZAa9pJ39fH7sCAZae
         K1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gEp8sub2EiUqQvo61VEfOm8QzgFbh7P1EFsBrIlNMxw=;
        b=p2B0jUBCo8O2Ebf8+VwmVIHmtvD2UEOqkgyuY1dnZpGBq+FJMId8C9kV/DyunZmtXy
         fYOTUV4o+JSSnPBrlweJ7th5SLmmhB2LV0Tqa3+yeumpDiw1p7/uM3Hgd8ekW1R83snB
         HsL6JEBRspz5J4SZIohskY+6VtpCCgloVMnSAbqGrU3rZcubDasgO7DiPxJCG43CA5am
         +ef6vbHy225CvffKKnS2o28sGI2nDKz1hu9sbZUxpFlv6VgwrsbvJ/63R/HiQR65nMsv
         WQdwpT2wb5ngQACPmnf4DWmhZV5WTG3YyHsc8EpwSaKFXPBbguaFdynCPQM3ulwPyXtg
         yBaQ==
X-Gm-Message-State: AKGB3mIQDlvTa5LbZWxEk3pbI6oAHdlzl1S/7HqR3ZSAfNGN7QtC4NHc
        PgvhSaQCL5MLi31/cK8RpU1C7PeVhLmUakGXRRMQhPJ//iw=
X-Google-Smtp-Source: ACJfBosbptLXMvQpXQ0NPbR5v+LJtOabyjLKDU53QZpQm9fAvPHivdheVLqMudQ6zAFPD8+GydtSyQbN6wXnPGRGmVs=
X-Received: by 10.107.142.11 with SMTP id q11mr47652144iod.165.1514911067191;
 Tue, 02 Jan 2018 08:37:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.144.208 with HTTP; Tue, 2 Jan 2018 08:37:46 -0800 (PST)
In-Reply-To: <20171230135108.6834-5-paul@crapouillou.net>
References: <20171228162939.3928-2-paul@crapouillou.net> <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-5-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Tue, 2 Jan 2018 22:07:46 +0530
Message-ID: <CANc+2y5ZUM_ZzXaGgbx9b7O1GF4GrbaYsv97G+akvhP2d2VVUA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] MIPS: jz4740: dts: Add bindings for the jz4740-wdt driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Hi Paul,

On 30 December 2017 at 19:21, Paul Cercueil <paul@crapouillou.net> wrote:
> Also remove the watchdog platform_device from platform.c, since it
> wasn't used anywhere anyway.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/boot/dts/ingenic/jz4740.dtsi |  8 ++++++++
>  arch/mips/jz4740/platform.c            | 16 ----------------
>  2 files changed, 8 insertions(+), 16 deletions(-)
>
>  v2: No change
>
> diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> index cd5185bb90ae..26c6b561d6f7 100644
> --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> @@ -45,6 +45,14 @@
>                 #clock-cells = <1>;
>         };
>
> +       watchdog: watchdog@10002000 {
> +               compatible = "ingenic,jz4740-watchdog";
> +               reg = <0x10002000 0x10>;
> +
> +               clocks = <&cgu JZ4740_CLK_RTC>;
> +               clock-names = "rtc";
> +       };
> +

The watchdog driver calls jz4740_timer_enable_watchdog and
jz4740_timer_disable_watchdog which defined in
arch/mips/jz4740/timer.c. It accesses registers iomapped by timer
code. Declaring register size as 0x10 does not show the real picture.
Better use register size as 0x100 and let timer, wdt, pwm drivers to
share them.

Code from one of your branches
(https://github.com/OpenDingux/linux/blob/for-upstream-clocksource/arch/mips/boot/dts/ingenic/jz4740.dtsi)
does it. Can you prepare a patch series and send it?
I have a patch set that moves timer code out of arch/mips/jz4740/ and
does a similar thing for watchdog and pwm. As your new timer driver is
better than the existing one I have not sent my patches yet. I would
like to see it getting mainlined as it paves way for removing most of
code in arch/mips/jz4740.

>         rtc_dev: rtc@10003000 {
>                 compatible = "ingenic,jz4740-rtc";
>                 reg = <0x10003000 0x40>;
> diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
> index 5b7cdd67a9d9..cbc5f8e87230 100644
> --- a/arch/mips/jz4740/platform.c
> +++ b/arch/mips/jz4740/platform.c
> @@ -233,22 +233,6 @@ struct platform_device jz4740_adc_device = {
>         .resource       = jz4740_adc_resources,
>  };
>
> -/* Watchdog */
> -static struct resource jz4740_wdt_resources[] = {
> -       {
> -               .start = JZ4740_WDT_BASE_ADDR,
> -               .end   = JZ4740_WDT_BASE_ADDR + 0x10 - 1,
> -               .flags = IORESOURCE_MEM,
> -       },
> -};
> -
> -struct platform_device jz4740_wdt_device = {
> -       .name          = "jz4740-wdt",
> -       .id            = -1,
> -       .num_resources = ARRAY_SIZE(jz4740_wdt_resources),
> -       .resource      = jz4740_wdt_resources,
> -};
> -
>  /* PWM */
>  struct platform_device jz4740_pwm_device = {
>         .name = "jz4740-pwm",
> --
> 2.11.0
>
>

Regards,
PrasannaKumar
