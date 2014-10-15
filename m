Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Oct 2014 09:33:09 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:61883 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011468AbaJOHdIB0REF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Oct 2014 09:33:08 +0200
Received: by mail-ie0-f177.google.com with SMTP id rd18so658604iec.36
        for <linux-mips@linux-mips.org>; Wed, 15 Oct 2014 00:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vIQLR5DP8cE4+7hBGPLuPurHCnzhy56nP56+mOLxKWA=;
        b=FObPY1xSrxaCznl7MEL9dckhJXWa65WRsvz/RgqwPTM0Hu1pSXklyX1cLCdLFVhsan
         jm2XiTU4nekESjfNuUPuLS6nQU/Pxuxc5iJvAjS+Yq06Lfv2wYCNPKgnm8y4GUYG5PHl
         tPpmGBnFow3qR3blc8s1fQ3YXRcs6PRKBJusbw1zBlP3ExJ+d6lrxUGs3QccpD8Y1SOp
         ldJ4rTMilr7wjV0gjMCxs1B3aO+ON9KaPDujXvR1rLejSmDlrAQ/sbbRgdgnyedYVRGB
         V3zX7x80g1EFksKinzVqvXsC8o8GbUeWm4jao03uvlB/uBhyaUU5p9Aeei7ldJIKoXQc
         kUAQ==
X-Gm-Message-State: ALoCoQlcIGhfRc2QHh/DPTUJ1bIMgfFSfzvaf2Xd/b1Ew+Ww/51BdO9o4sqhKF3/HwhZWNpwqVtj
MIME-Version: 1.0
X-Received: by 10.107.11.80 with SMTP id v77mr133312ioi.76.1413358381980; Wed,
 15 Oct 2014 00:33:01 -0700 (PDT)
Received: by 10.43.102.201 with HTTP; Wed, 15 Oct 2014 00:33:01 -0700 (PDT)
In-Reply-To: <1411929195-23775-10-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
        <1411929195-23775-10-git-send-email-ryazanov.s.a@gmail.com>
Date:   Wed, 15 Oct 2014 09:33:01 +0200
Message-ID: <CACRpkda-DkGfEhWw14Dhw0ovf6Kmv6SYeefVFGuy83ZTzn=Caw@mail.gmail.com>
Subject: Re: [PATCH 09/16] gpio: add driver for Atheros AR5312 SoC GPIO controller
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43289
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

On Sun, Sep 28, 2014 at 8:33 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:

> Atheros AR5312 SoC have a builtin GPIO controller, which could be accessed
> via memory mapped registers. This patch adds new driver for them.
>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-gpio@vger.kernel.org

This driver is extremely simple. You should be able to use
drivers/gpio/gpio-generic.c for this.

NAK for the time being.

> +#define AR5312_GPIO_CR_INT(x)  (1 << ((x)+8))  /* mask for interrupt */

Seems to be unused.
For a MMIO gpiochip using interrupts it's still possible
to use gpio-generic.c as a library-

> +#define AR5312_GPIO_CR_UART(x) (1 << ((x)+16)) /* uart multiplex */

That sounds like pin control business.

Yours,
Linus Walleij
