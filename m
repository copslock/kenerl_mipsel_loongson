Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2017 11:44:45 +0200 (CEST)
Received: from mail-io0-x230.google.com ([IPv6:2607:f8b0:4001:c06::230]:33309
        "EHLO mail-io0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992517AbdDGJoiCoNlG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2017 11:44:38 +0200
Received: by mail-io0-x230.google.com with SMTP id t68so12482547iof.0
        for <linux-mips@linux-mips.org>; Fri, 07 Apr 2017 02:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6+Jj3EAoP6gZP9L/9au7W3bkdlbiS2/OflhfyBzhyFk=;
        b=U+GrBGNTQoKyqMylcFJ/yL4lUAD+2VypKar/asJqfnmiswbdxUCu11swu3PXTgcd/T
         Mm3SPDwtemWtSp+lzIoAaONugJb2m+Qb4xUVkAuFNBgpYZvF0wIrJOli8+1bjg8AD8DB
         +LD9xA6LUxg7HaXJNBuKlqnjZfUtAUwKjp1dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6+Jj3EAoP6gZP9L/9au7W3bkdlbiS2/OflhfyBzhyFk=;
        b=i4b18ocKzyYP9EzkJfAtBVpggt8tynO3/545N3A6m9dH/4Aj8dnuK0Nu63NkOIjkRp
         wS4pCEjveWOD/qyg5KQN53y6pTxkQ4/P1gN7szqQvzcshpJV80nuHYNnyyEiJ3AvmndM
         iTcpi8DOwu+SSidvUdnF/2lL9T8Ru4RGIhpk7bMkKO8tRQJjVZgNps5bOoGmVrcQVsrI
         piJJcvFiT6yc1dK4kAnF/q3pT7BkkHGkKDT7rgZE90xk5tnU16v4tYsFwnseyaoxBCC/
         ivONiJe+S24nGtrx7kptrduRF5PYrqn/+7ZrJXa2AJk//VsmlDk8pTxmneI4PYKUUh8c
         v9gg==
X-Gm-Message-State: AFeK/H0a9c5JODSu67MQ36BYVvJxcHiHMbsMttBXNRYugo1bcvMQ12yy5bSAoCE86FvfnybUFCmPPfngjh/dR4yR
X-Received: by 10.107.59.74 with SMTP id i71mr41917857ioa.151.1491558272217;
 Fri, 07 Apr 2017 02:44:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.134.193 with HTTP; Fri, 7 Apr 2017 02:44:31 -0700 (PDT)
In-Reply-To: <20170402204244.14216-7-paul@crapouillou.net>
References: <20170125185207.23902-2-paul@crapouillou.net> <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-7-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Apr 2017 11:44:31 +0200
Message-ID: <CACRpkdbXe1Xxk93jqLXBdEDwWOnWD+CkZrqvok-PcmWxzBbSZA@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] MIPS: jz4740: DTS: Add nodes for ingenic pinctrl
 and gpio drivers
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57614
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

On Sun, Apr 2, 2017 at 10:42 PM, Paul Cercueil <paul@crapouillou.net> wrote:

> For a description of the pinctrl devicetree node, please read
> Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
>
> For a description of the gpio devicetree nodes, please read
> Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/boot/dts/ingenic/jz4740.dtsi | 61 ++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
>  v2: Changed the devicetree bindings to match the new driver
>  v3: No changes
>  v4: Update the bindings for the v4 version of the drivers
(...)

> +       pinctrl: ingenic-pinctrl@10010000 {
> +               compatible = "ingenic,jz4740-pinctrl";
> +               reg = <0x10010000 0x400>;
> +
> +               gpa: gpio-controller@0 {
> +                       compatible = "ingenic,gpio-bank-a", "ingenic,jz4740-gpio";

As Sergei and Rob notes, the bank compatible properties look
a bit strange. Especially if they are all the same essentially.

I like Sergei's idea to simply use the reg property if what you want
is really a unique ID number. What do you think about this?

Yours,
Linus Walleij
