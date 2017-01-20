Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2017 09:40:43 +0100 (CET)
Received: from mail-it0-x235.google.com ([IPv6:2607:f8b0:4001:c0b::235]:36318
        "EHLO mail-it0-x235.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993014AbdATIkhJAEb- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jan 2017 09:40:37 +0100
Received: by mail-it0-x235.google.com with SMTP id c7so14705645itd.1
        for <linux-mips@linux-mips.org>; Fri, 20 Jan 2017 00:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZEifAQkp528gHRg4iQrwCp1BjT1q40TeSWF9LgBaDiY=;
        b=Gnxkm5Hp30hwbnSr/FPavb02rVcOLCz4DG2apRJ+MHSRwQAay8zCik64PND4Zh6ID3
         hFiahyhcFbBIWobzSUsnwreSR/7LC7TjwXHmZehZ4xCkvMD/MmjhpHaIMPDr0AnQnNOz
         du+zOgJOrfYnUbOpHHl88XiTmftM5YE9/tkBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZEifAQkp528gHRg4iQrwCp1BjT1q40TeSWF9LgBaDiY=;
        b=RVfrJz15lQpreRVmHpIyUX69yKbm5RuqA31PIjuenZUOXIzOhsezp17jhpAwgX4p+f
         DU47ylESyje3KhPWOb6cYeVEIH95buwGXQQgSKLz/ZNTbZ4pkIv5NnHpn7bU/fznF6oR
         1nHW9ajNtAJ0HY/omKmie2Gjv8x1iT1ZFdBStPRPUPvby8HIAGcs8Hy6P+DB46JjKogD
         +2dZjV29cOOo8tdZw2DhYgpTwWfDCkm+PIwSYyAqZs+deBHF69EBIA7ixWU/Us0FBk+w
         9avbk1xFK4r6KyQ5s0as6EBEdYYUQH88rED5kHtgRNxf5Bk5Uw6DeBfEqKjCp17vdN7a
         CjLA==
X-Gm-Message-State: AIkVDXLaCbkavxgniUW+C2tOfI/b8LNkablV0fOv4FPZ3oj77PG9vpjYO1OXPTJ3lABRwkAQw3KIaiGn/pDY5F5k
X-Received: by 10.36.88.20 with SMTP id f20mr2438017itb.9.1484901631345; Fri,
 20 Jan 2017 00:40:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.169.75 with HTTP; Fri, 20 Jan 2017 00:40:30 -0800 (PST)
In-Reply-To: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net> <20170118071530.GA18989@ulmo.ba.sec>
 <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Jan 2017 09:40:30 +0100
Message-ID: <CACRpkdaeu9OxaSPeOrkKtKNQGUQh4puCFw8A2h=xhqVdDWgoow@mail.gmail.com>
Subject: Re: [PATCH 00/13] Ingenic JZ4740 / JZ4780 pinctrl driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
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
X-archive-position: 56428
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

On Thu, Jan 19, 2017 at 12:19 PM, Paul Cercueil <paul@crapouillou.net> wrote:

> The problem with pinctrl and PWM, is that the pinctrl API works by "states".
> A default state, sleep state, and basically any custom state that the
> devicetree
> provides. This works well until you need to control individually each pin;
> with
> 8 pins, you would need 2^8 states, each one corresponding to a given
> configuration.

I do not really understand, do you really use all 2^8 states in a given
system?

The pin control states are to be used for practical situations, not
for all theoretical situations.

You should define in your device tree the states that your
particular system will use. Not all possible states on all possible
systems.

Yours,
Linus Walleij
