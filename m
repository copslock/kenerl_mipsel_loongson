Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Oct 2017 03:05:37 +0200 (CEST)
Received: from mail-io0-x236.google.com ([IPv6:2607:f8b0:4001:c06::236]:43888
        "EHLO mail-io0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992994AbdJBBF3QE0Hy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Oct 2017 03:05:29 +0200
Received: by mail-io0-x236.google.com with SMTP id k101so3616713iod.0
        for <linux-mips@linux-mips.org>; Sun, 01 Oct 2017 18:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YdiEDqkHt02u1pb+caHosMt4TmWpdDZco/TUnhb0heI=;
        b=TAgPkHMrPOtP77ntmXVAS51q+I8Sb3dBhvMcqIlMkXPYMGcLoiiN9/J6K9Ek9m2zd9
         HMRxgwD/pacKWklQjKlHNbCM7wUM2hEer1zQKd8K2zZcOaUpa2iRDzSxdY6Rob65Puv9
         ihfA5+qnQuzH2PuP6bPoKlYSK65jARamf8UwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YdiEDqkHt02u1pb+caHosMt4TmWpdDZco/TUnhb0heI=;
        b=ogC3xFoQJ8katJge0ag9ziyFbkmWnAtHw/+P3qxj5Vth+XH3lmLS0ZZVlBocADvsqN
         RlSy4vCg/kkY6xLNmdYgXVCVxbHmU/1j/qip76lasMIQsYpZu0bk9DzrRUZoDCRNecAw
         zB1tMLUBuw7mETZn++7BKnR4gpcioxfLQ0tTx6ewU896rDyBxxu7uXIfTfhUPPR4dFEB
         zo3KP/XYBJbAol3037WDUY6YiULeV6SIVkuUy8nrHBpnT53IS+LEiy+hos/7j1dd5DxA
         xtUF4+17tf9/J8AhNUIEp6yXkGPHnxAhmbzvfN8z8SYiVrKZZ3d+MS00rbig/YfegayF
         eCzQ==
X-Gm-Message-State: AMCzsaWAn6k4gakbrsPgWM2DnkyjvDHP3RcnHdXD0d/Pujb/q4ySs1RR
        IZLiD8MwCaup1eVPYWr9EhlUR7tn0bqdTnH7hLv8fw==
X-Google-Smtp-Source: AOwi7QAIUn2aBibG+Lblm9J7oscafQAUvCRhGeVzP9Y3Z7UcZ1AxLvXSkIGkOtBKlOve6pBzJjRLrq0IDtVvAAngcE4=
X-Received: by 10.107.22.65 with SMTP id 62mr22943857iow.269.1506906322843;
 Sun, 01 Oct 2017 18:05:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.6.195 with HTTP; Sun, 1 Oct 2017 18:05:22 -0700 (PDT)
In-Reply-To: <20170917093906.16325-2-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org> <20170917093906.16325-2-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Oct 2017 03:05:22 +0200
Message-ID: <CACRpkdZ=BZHp3mjccUYaPTuMbXgwGSErvLprnp4j0H+7C5NYJQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] i2c: gpio: Convert to use descriptors
To:     Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Vincent Sanders <vincent.sanders@collabora.co.uk>,
        Vincent Sanders <vince@kyllikki.org>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Heiko Schocher <hs@denx.de>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60212
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

On Sun, Sep 17, 2017 at 11:39 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> - The MFD Silicon Motion SM501 is a special case. It dynamically
>   spawns an I2C bus off the MFD using sm501_create_subdev().
>   We use an approach to dynamically create a machine descriptor
>   table and attach this to the "SM501-LOW" or "SM501-HIGH"
>   gpiochip. We use chip-local offsets to grab the right lines.
>   We can get rid of two local static inline helpers as part
>   of this refactoring.
(...)
> SM501 users: requesting Tested-by on this patch.

Paging Simtec (if it reaches anyone), Vincent Sanders,
Teddy Wang at Silicon Motion:

Does any of you have an "Anubis" board so you can test GPIO
on this board before/after this patch and see if it checks out right?

I guess it's this board:
http://www.simtec.co.uk/products/BBD20EUROA/

Does anyone know of a commercially obtainable product using
SM501 with reasonable mainline Linux support so I can test it myself?

Getting a bit desperate...

Yours,
Linus Walleij
