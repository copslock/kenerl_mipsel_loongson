Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2017 11:34:57 +0200 (CEST)
Received: from mail-it0-x230.google.com ([IPv6:2607:f8b0:4001:c0b::230]:34226
        "EHLO mail-it0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990557AbdDGJeo4oVDG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2017 11:34:44 +0200
Received: by mail-it0-x230.google.com with SMTP id y18so3254345itc.1
        for <linux-mips@linux-mips.org>; Fri, 07 Apr 2017 02:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jq23BH6RhgFtfLR2NpxNMRvxVhddsXjRk4qjeCCul/E=;
        b=Kz6ionrWUZ9lsVu0rkT1y6zMAV9VXb5RrdnpiRfsegyGvKBK2xBGuBY99Qy7F42yzC
         ngRnfEeUeIKBnlEo/D3Id90K3H00Mr+D+W8ahe4zf8X8J5DYrMImElWoR+xU1blTSJu3
         7Bexh0PRlxX+PpKIQ6PjQFxIOEC+zqonzgmE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jq23BH6RhgFtfLR2NpxNMRvxVhddsXjRk4qjeCCul/E=;
        b=UYyo0XTT5WplxfhQSvlrSQRcLUqj63Zm7G/1O2e8eVhGXBwEFpbtk+tiJ+hS8h/sUA
         6fFvPppHByHeIMe5h6CppM4DzbwTqYuMbdGwu/om9vFboOkyHS71ZVw5GjqRY190h83r
         SLVP6JxpCe3hGmtgAHpsAdQRhHD6Uz6pERv+2v46ZjbmXVzY59LqRru5OSu+v4lgTQOs
         ecidY20lKQiBEu2r9jEXWMlTnaescdVi2lZ2Wlr/abR115PRGWpiBFPCL1BOhF1+HSts
         eIx2K5DjTxiiTT+yYUKIpVx1K71mTCHbYS8SbbkweIJiOlYMAg0XoVyLMio9pBSfL7zC
         nysg==
X-Gm-Message-State: AN3rC/5AQatK5ZP+CAAls3xT3200PowNfwfjTo6Rt66WlfHcnhN791xf
        FF3Qq3VE5/aPBm6uJPldrZFDE1fPDHVv
X-Received: by 10.36.181.71 with SMTP id j7mr2632933iti.56.1491557679066; Fri,
 07 Apr 2017 02:34:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.134.193 with HTTP; Fri, 7 Apr 2017 02:34:38 -0700 (PDT)
In-Reply-To: <20170402204244.14216-5-paul@crapouillou.net>
References: <20170125185207.23902-2-paul@crapouillou.net> <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-5-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Apr 2017 11:34:38 +0200
Message-ID: <CACRpkdaH1J8J6y9cBEfspiAUYTB+NXcoOK1j4Uzud943TgVsow@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] GPIO: Add gpio-ingenic driver
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
X-archive-position: 57612
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

> This driver handles the GPIOs of all the Ingenic JZ47xx SoCs
> currently supported by the upsteam Linux kernel.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

I guess you saw the Kconfig complaint from the build robot, please fix that
so we get silent builds.

>  v2: Consider it's a new patch. Completely rewritten from v1.
>  v3: Add missing include <linux/pinctrl/consumer.h> and drop semicolon after }
>  v4: Completely rewritten from v3.

I really like v4 :)

> +static inline bool gpio_get_value(struct ingenic_gpio_chip *jzgc, u8 offset)

Actually the return value should be an int.

I know, it is a historical artifact, if we change it we need to change
it everywhere.

> +       /* DO NOT EXPAND THIS: FOR BACKWARD GPIO NUMBERSPACE COMPATIBIBILITY
> +        * ONLY: WORK TO TRANSITION CONSUMERS TO USE THE GPIO DESCRIPTOR API IN
> +        * <linux/gpio/consumer.h> INSTEAD.
> +        */
> +       jzgc->gc.base = cell->id * 32;

OK then :)

This is merge material.

Yours,
Linus Walleij
