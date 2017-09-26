Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2017 15:17:31 +0200 (CEST)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:34637
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990644AbdIZNRVo1m0O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2017 15:17:21 +0200
Received: by mail-io0-x243.google.com with SMTP id g32so4543418ioj.1;
        Tue, 26 Sep 2017 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/Mr34PPZf4ASzIFK5mR0ItvqX1KVHUd6Yl/2zVToiPE=;
        b=SX+qAE8GkHtbOIwptwNLhDsSReEDBrDxuWnO8JZZhYy1EfX4YtE3OO9m4iE97eE29R
         3awYxp2z38f3J2YDY0aK9AtSYe76WZdQMZr3f9S6/qIfLPRJBYMS9AkurAXw44e7eepu
         r3lRCZuLiYpqHAavGRg4iXc19AqroXDkQ0laHngvfar9I19qKpeVhYgLa8qEEHodPlFt
         qayXkwPL58x7SQ64eJeNamTM8UeXYv5vj3AXiim3ODLyGNzJenEmbnaQaSHRcjPRwQs4
         J66tD9IKGZGmiVmYbDwC2SlODOUw/VTUJIM2RpdXJmL3ZmMSmcjRb62xCJzJdQnLty8O
         EX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/Mr34PPZf4ASzIFK5mR0ItvqX1KVHUd6Yl/2zVToiPE=;
        b=djPmbia1Wfv6xshXHbtGgZEvhTvR8RXtRrBMv38Zg+wXhbhLtr+sI9pZSfjkz/f/Ag
         Ee8fjeas7TO41K7C1qnQ2L1IjI1wnEDC2debS59cGfPLmtvwgRIzEElauRnwotI5G2Ar
         tigltH6jQSVB/sO3GESvF0e3SOwgH0aph3e7Gm1lu/Oibm6YTEv0q6zq2XA13ky2k80e
         FGhJdUY7+D1ufFPdzYD275yPQeSUgEy9PKvIXPWKPx6YoA8dOFFmZ3zR4l3EC08wzp8V
         hAqu52ybIHSRXrV2GEvhMUl6y3VXBbszlXyGnwcomvHUBA8XS2ULUyXMjiiEXbz63IqI
         WNAw==
X-Gm-Message-State: AHPjjUhc6T0HlDsJQKMZ57zoEw7UEVfDGPxynHlPgNv8K/feHpG4HdDZ
        dSrhFlkkaZd90671Oq0aex3SrXa4HNDcDDLn1eA=
X-Google-Smtp-Source: AOwi7QAeKXB3XIO8xjh1bcwJCBGR1lhH7/qGrKsaP9NxKgL+FYcbEclvWMNC+yscjV5xLbdWnI9+4UFf/Dq33mylgMk=
X-Received: by 10.107.78.19 with SMTP id c19mr13774861iob.205.1506431835300;
 Tue, 26 Sep 2017 06:17:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.12.193 with HTTP; Tue, 26 Sep 2017 06:17:14 -0700 (PDT)
In-Reply-To: <20170915191837.27564-1-malat@debian.org>
References: <20170908183558.1537-3-malat@debian.org> <20170915191837.27564-1-malat@debian.org>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Tue, 26 Sep 2017 18:47:14 +0530
Message-ID: <CANc+2y6gZ4UQ7fKbJeV7HhDLLW9pbUEr0K0Tq5eBfg1ba2s_LQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] MIPS: jz4780: DTS: Probe the jz4740-watchdog
 driver from devicetree
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60154
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

Hi Mathieu,

On 16 September 2017 at 00:48, Mathieu Malaterre <malat@debian.org> wrote:
> The jz4740-watchdog driver supports both jz4740 & jz4780.
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> Changes in v2:
> * make the node name generic (Paul Cercueil)
>
>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index 20e37d2d6008..76055bbc823a 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -263,6 +263,11 @@
>                 status = "disabled";
>         };
>
> +       watchdog: watchdog@10002000 {
> +               compatible = "ingenic,jz4780-watchdog";

In drivers/watchdog/jz4740_wdt.c the compatible is declared as
"ingenic,jz4740-watchdog" while your change says
"ingenic,jz4780-watchdog". Can you modify that?

> +               reg = <0x10002000 0x100>;
> +       };
> +

The structures jz4740_wdt_device and jz4740_wdt_resources can be
removed form arch/mips/jz4740/platform.c as watchdog is declared in
device tree. For JZ4740 platform watchdog is not used so the variables
can be removed.

Do you mind adding watchdog entry to JZ4740 device tree? Currently
watchdog is not enabled for JZ4740 platform.

>         nemc: nemc@13410000 {
>                 compatible = "ingenic,jz4780-nemc";
>                 reg = <0x13410000 0x10000>;
> --
> 2.11.0
>

Regards,
PrasannaKumar
