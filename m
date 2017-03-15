Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 10:37:27 +0100 (CET)
Received: from mail-io0-x233.google.com ([IPv6:2607:f8b0:4001:c06::233]:35182
        "EHLO mail-io0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992028AbdCOJhS7T52G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 10:37:18 +0100
Received: by mail-io0-x233.google.com with SMTP id z13so16318027iof.2
        for <linux-mips@linux-mips.org>; Wed, 15 Mar 2017 02:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ll1gfwVgZ6ehnu/+3uutyDh0NV13jjrSxy9mknGUdE8=;
        b=e7iuV4XCVzvZUca6h88Fr9CPTULiNaIv3P35MtqmUtwp/FxoK8oNVXiUjjVOCc1SKf
         E5dJahwSudXNundt0ZTghhb/tAjTYBnhX2Il5bVb5MAJC79Pvttfx89q1W30NIp0NOxS
         QoWbXfjIT+BA7cq8kkaeavg9yp+rfy4aXNauM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ll1gfwVgZ6ehnu/+3uutyDh0NV13jjrSxy9mknGUdE8=;
        b=tOA7U7HlEBVjVrBoh621vZtJlshsQyP9jHylDhJKfFW0bO+KUMItwYDYDPBkfX7GMv
         osXWNr8FCsAFD+sPVD976b3FzqJPijU7ky77ClSzd4AbidoF48jfWe0TBKLCuO+jPxZq
         JTp+u4CIBwC9DTVbLoX9Ftrqes4W/PRVbnO+wGC4nmHdoQugyrlegzofgURux/430ATf
         r+xg0QJax81qXbLzluP/mW0Z5DcMKKI2MXh6dwzOF5I354KQ98zCoyv6te1wVMzB47eO
         POAxoqFflR504Av9FOpzgNGC9Lv3JyWb437VOcSMGhS5XMhEnLxCeCAPOcUq1q1TKQHB
         h+1Q==
X-Gm-Message-State: AFeK/H25eya0zoOkI2h7wcdPPFNzZAWSkdEEGnLmvAvkVbZl1SAbbV9OTFV/OC1Udzn5dAgX5/gSJi9llvkCyGHa
X-Received: by 10.107.59.74 with SMTP id i71mr4580585ioa.151.1489570633299;
 Wed, 15 Mar 2017 02:37:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.134.193 with HTTP; Wed, 15 Mar 2017 02:37:12 -0700 (PDT)
In-Reply-To: <1488830761-681-3-git-send-email-nathan.sullivan@ni.com>
References: <1488830761-681-1-git-send-email-nathan.sullivan@ni.com> <1488830761-681-3-git-send-email-nathan.sullivan@ni.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Mar 2017 10:37:12 +0100
Message-ID: <CACRpkda0xsm+iN_Kxg4pB43LQ7i2MzfJgqibDAt3V5xCRinHEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: NI 169445 board support
To:     Nathan Sullivan <nathan.sullivan@ni.com>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Mon, Mar 6, 2017 at 9:06 PM, Nathan Sullivan <nathan.sullivan@ni.com> wrote:

> Support the National Instruments 169445 board.
>
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
(...)

> +               gpio1:gpio-controller@1f300010 {
> +                       compatible = "ni,169445-nand-gpio";
> +                       reg = <0x10 0x4>;
> +                       reg-names = "dat";
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       ngpios = <5>;

Here I would add:

gpio-line-names = "NC", "NCE", "ALE", "CLE", "NWP";

(Dunno about the first one, maybe you have a schematic?)

> +               };
> +
> +               gpio2:gpio-controller@1f300014 {
> +                       compatible = "ni,169445-nand-gpio";
> +                       reg = <0x14 0x4>;
> +                       reg-names = "dat";
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       ngpios = <1>;

gpio-line-names = "RDY";

> +               };
> +
> +               nand@1f300000 {
> +                       compatible = "gpio-control-nand";
> +                       nand-on-flash-bbt;
> +                       nand-ecc-mode = "soft_bch";
> +                       nand-ecc-step-size = <512>;
> +                       nand-ecc-strength = <4>;
> +                       reg = <0x0 4>;
> +                       gpios = <&gpio2 0 0>, /* rdy */
> +                               <&gpio1 1 0>, /* nce */
> +                               <&gpio1 2 0>, /* ale */
> +                               <&gpio1 3 0>, /* cle */
> +                               <&gpio1 4 0>; /* nwp */
> +               };

To reflect this. "lsgpio" gives better info after that.

Other than that:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
