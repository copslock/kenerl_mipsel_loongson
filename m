Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2017 12:56:47 +0200 (CEST)
Received: from mail-wr0-x22c.google.com ([IPv6:2a00:1450:400c:c0c::22c]:32783
        "EHLO mail-wr0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991532AbdDGK4iqbf6E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2017 12:56:38 +0200
Received: by mail-wr0-x22c.google.com with SMTP id g19so58123833wrb.0
        for <linux-mips@linux-mips.org>; Fri, 07 Apr 2017 03:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=97t+Uoah3UWwq/e/Ajvo+1qMMfauo5dh4olaWgjuVsI=;
        b=QGnFjGXXIBvxACXB85bcxO6yd6BDkpRGTDvAuFGSlsvdMVLURd2n/X+5tJJtKdNx42
         8MHOBB+kkhDKV71an5ytL53N/rBNAbCbHigTGDPeHAJRKiLVdLMR3IOi92pWX7bsA9cW
         IEiv0KgtT440O6yxn8YDQMLxjjDhEkXMl6Tfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=97t+Uoah3UWwq/e/Ajvo+1qMMfauo5dh4olaWgjuVsI=;
        b=dAGjIs4X3qH48kIECFcUjY3Ph15i9gDB81nc1byfK7gA+S9a9gOej6Uf4XLweQRqYT
         IjRNymF8MLPT/5NdoyohrndIa97wIbuO4wJhTucNIAIQifNf09yRSpz3uQkOTIB+VTGN
         gi2sHFoPKuiTrCdlmA++0xj3uLJe2T2lUKXQBsNGCJRlmuMqTiJVEzOUQRTt3Ljyhnfb
         feb3+GGjJ+JsaUeQA1O+DuEhcvM3O2z55z6UXAY0AS0ZMoAR7fFmTxLjgzTrHqdsVaw3
         WpZjKZtN0ea5hOxg7e+e0uZB5X1LFqnx8sof4LOcTqEnt8CchhId0xSnehP2dlMjc8bR
         nrig==
X-Gm-Message-State: AFeK/H24k7X5jp2NwUQCbrg+qiFl6Kes6fMkOptEJn6x7O0c717nHgeJ
        L3kXdfCUIXQ78OUH
X-Received: by 10.28.157.140 with SMTP id g134mr28827465wme.81.1491562593361;
        Fri, 07 Apr 2017 03:56:33 -0700 (PDT)
Received: from dell ([193.35.235.117])
        by smtp.gmail.com with ESMTPSA id g23sm5867891wme.8.2017.04.07.03.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Apr 2017 03:56:32 -0700 (PDT)
Date:   Fri, 7 Apr 2017 11:56:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Alexandre Courbot <gnurou@gmail.com>,
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
Subject: Re: [PATCH v4 03/14] pinctrl-ingenic: add a pinctrl driver for the
 Ingenic jz47xx SoCs
Message-ID: <20170407105629.n6a2cxt3pof66gu2@dell>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-4-paul@crapouillou.net>
 <CACRpkdbeudhXDE8KEgB_kZSAUUwS4Sd3=+GyR0YZ2-PQnEa9zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbeudhXDE8KEgB_kZSAUUwS4Sd3=+GyR0YZ2-PQnEa9zw@mail.gmail.com>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Return-Path: <lee.jones@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lee.jones@linaro.org
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

On Fri, 07 Apr 2017, Linus Walleij wrote:

> On Sun, Apr 2, 2017 at 10:42 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> 
> > This driver handles pin configuration and pin muxing for the
> > JZ4740 and JZ4780 SoCs from Ingenic.
> >
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> (...)
> > +       select MFD_CORE
> (...)
> > +#include <linux/mfd/core.h>
> 
> That's unorthodox. Still quite pretty!
> I would nee Lee Jones to say something about this, as it is
> essentially hijacking MFD into the pinctrl subsystem.
> 
> > +static struct mfd_cell ingenic_pinctrl_mfd_cells[] = {
> > +       {
> > +               .id = 0,
> > +               .name = "GPIOA",
> > +               .of_compatible = "ingenic,gpio-bank-a",
> > +       },
> > +       {
> > +               .id = 1,
> > +               .name = "GPIOB",
> > +               .of_compatible = "ingenic,gpio-bank-b",
> > +       },
> > +       {
> > +               .id = 2,
> > +               .name = "GPIOC",
> > +               .of_compatible = "ingenic,gpio-bank-c",
> > +       },
> > +       {
> > +               .id = 3,
> > +               .name = "GPIOD",
> > +               .of_compatible = "ingenic,gpio-bank-d",
> > +       },
> > +       {
> > +               .id = 4,
> > +               .name = "GPIOE",
> > +               .of_compatible = "ingenic,gpio-bank-e",
> > +       },
> > +       {
> > +               .id = 5,
> > +               .name = "GPIOF",
> > +               .of_compatible = "ingenic,gpio-bank-f",
> > +       },
> > +};
> (...)
> > +       err = devm_mfd_add_devices(dev, 0, ingenic_pinctrl_mfd_cells,
> > +                       ARRAY_SIZE(ingenic_pinctrl_mfd_cells), NULL, 0, NULL);
> > +       if (err) {
> > +               dev_err(dev, "Failed to add MFD devices\n");
> > +               return err;
> > +       }
> 
> I guess the alternative would be to reimplement the MFD structure.
> 
> Did you check the approach to use "simple-mfd" and just let the subnodes
> spawn as devices that way? I guess you did and this adds something
> necessary.

I'd like to hear what the OP has to say about why this is necessary.
However, as a first glimpse, I'm dead against exporting MFD
functionality to outside of the subsystem.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
