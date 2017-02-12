Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Feb 2017 21:49:14 +0100 (CET)
Received: from mail-it0-x22b.google.com ([IPv6:2607:f8b0:4001:c0b::22b]:36811
        "EHLO mail-it0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992111AbdBLUtHTMEEC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Feb 2017 21:49:07 +0100
Received: by mail-it0-x22b.google.com with SMTP id c7so167339075itd.1
        for <linux-mips@linux-mips.org>; Sun, 12 Feb 2017 12:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VU6MePYwC3WTaeq40ZJGa+YANAnRcbVJshZDCJyEZ7g=;
        b=Dltn1pcfsguz0yqcTgqudJ22ctxZpkBGWy0gpCqjaGmH1JHsyj23uNqfKwnJBN6OdW
         bPbK9E7HVsgnGuTydq2/aHJcv9fFkvQj7P4Cf+bztiDFwm5vm1WxgU1RxdH/CAme4j7O
         b1jtZS3vzBu9/u9dLpv9uGOTrQUTgpw0GmL8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VU6MePYwC3WTaeq40ZJGa+YANAnRcbVJshZDCJyEZ7g=;
        b=cWocovTeQRIho0W5qw9TjXDD8Ix7JLtYlTdT2GPcM6EIe8JeQgWZxEoB5kxffVsTnO
         5MpRAcm8aXeWBuM80eh1e0USawpYyyWY69w/pYE87DXyOi0QMIsyCBrwZgw16FdLpcA7
         UqiL5kHI2VUcvrP/z04hC5jy5L4StXE/AErLWXds8FVIfhmLO6KxACeWXgzKs3QW51pU
         ytSKqriBDjyDaqanqbGVEazfBdmlDI57+WDKx01HFYxF9+K50B056x1+fHSUL6Zviejb
         lPZ/mzZCeYp80xKfcuPl6d0tBKbl788capx3Wxhg+fPf1QIOM3r7tc/1d5suoeN25+EE
         H7SA==
X-Gm-Message-State: AIkVDXIV09SfCikI78qVZ5sMVG7pbbboIIXIVgda70KYzzoUh9tF1RftX1qH88UzqKRDHk2dBiBFTmGd6dG9/DTE
X-Received: by 10.36.236.3 with SMTP id g3mr38443952ith.56.1486932540768; Sun,
 12 Feb 2017 12:49:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.169.75 with HTTP; Sun, 12 Feb 2017 12:48:59 -0800 (PST)
In-Reply-To: <b032ad924ae905ce4fd11535d08c29a8@mail.crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net> <20170125185207.23902-5-paul@crapouillou.net>
 <CACRpkdaqQ2==B1_o-Ru81Nbu_kUF+Kxn=XFYms-1e=nAtHiJ4A@mail.gmail.com> <b032ad924ae905ce4fd11535d08c29a8@mail.crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 12 Feb 2017 21:48:59 +0100
Message-ID: <CACRpkdbusY=gsZ=a9yGfRMi5t=+539OwKt0i5FNczxNyEVPHwg@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] GPIO: Add gpio-ingenic driver
To:     Paul Cercueil <paul@crapouillou.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56782
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

On Thu, Feb 9, 2017 at 6:14 PM, Paul Cercueil <paul@crapouillou.net> wrote:

>> If you're not just replacing these with GPIO_GENERIC, please also
>> include a .get_direction() callback.
>
> My .direction_input() and .direction_output() callbacks just call into
> the pinctrl driver, using pinctrl_gpio_direction_[in,out]put().
> I didn't find a way to get the direction info from the pinctrl driver,
> is that something that the core should provide?

Hm OK you have a clear point there, there is no such callback.

OK I do not require you to fix that at this time.

I am hesitant about providing ever more callbacks from GPIO
to pin control, I might need some help for consolidation here.

With Mika's patches we have a .set_config() call to
pinctrl_gpio_set_config() so essentially
we *could* actually refactor all pin control drivers providing
a GPIO back-end to use:

pinctrl_gpio_set_config(gpio, PIN_CONF_PACKED(PIN_CONFIG_INPUT_ENABLE, 0));
pinctrl_gpio_set_config(gpio, PIN_CONF_PACKED(PIN_CONFIG_OUTPUT, val));

And replace the calls to pinctrl_gpio_direction_input()
and pinctrl_gpio_direction_output() with this throughout.

It makes things a bit simpler. If we need to figure things
out the reverse direction then pinctrl_gpio_get_config()
should be implemented and used as back-end for
figuring out direction.

Yours,
Linus Walleij
