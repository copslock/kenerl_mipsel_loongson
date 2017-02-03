Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2017 14:59:03 +0100 (CET)
Received: from mail-io0-x236.google.com ([IPv6:2607:f8b0:4001:c06::236]:34771
        "EHLO mail-io0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993884AbdBCN646BOiG convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Feb 2017 14:58:56 +0100
Received: by mail-io0-x236.google.com with SMTP id l66so17892393ioi.1
        for <linux-mips@linux-mips.org>; Fri, 03 Feb 2017 05:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=If2GWOrGcomfswRfB+MxFg0cRZeoYra2P1SZChSQxDA=;
        b=ez+yZGUC2VgSW/OCDe3/4t+fITWNZ5w/a1go1TC+AIsUIi/nK083RVMY2uBt938/W+
         EawVLY7Dan6/mRyInlKvanMx5r2oNt0wIHSvaNKFTOulmFn78dsB/VnWreKowuQrpMKX
         0tKaekQqQB5qWvUaB4kxuzOQiEtU202YV8Gvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=If2GWOrGcomfswRfB+MxFg0cRZeoYra2P1SZChSQxDA=;
        b=HqAw5s2dsCXWRhcAURUqAHc8t0bTgb06IsnMgCsToK8akZl8xUNyJLza57ktNpdcWj
         myENB/EsARejcAqkylBq4f5TtxvM1Mz2/0FCcDUuoQLiWbTgd88Qy33gEQiMG2mnCEG5
         hB6lEOVownDzr5Wa3lbSXQ8w1afgS9V8zeX31+e9Xr0SOTGwevd5g+JcvdkUbUpiWcD8
         B/Oz8DSe0KPW3g+a8FRvJIiENJSHKf9x/WZsL4P6WkoQNXjXhC0h/gtlrgx5tg/T/ZGp
         ulFpG57VUaQy7dNUcabisiMdq8FKEIvPOarwhSmCHkC2RRbedlnj48vyAnVtJFM4cmO/
         y9Xw==
X-Gm-Message-State: AIkVDXJ1aUvQ1ai8d2DwUceIP2jEmYcuUAABWmARhTDygHAWzxh1lxvmx+ZuSLqbw4U7sTHEeLdcwkzOj20KqP99
X-Received: by 10.107.134.85 with SMTP id i82mr11994778iod.151.1486130331157;
 Fri, 03 Feb 2017 05:58:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.169.75 with HTTP; Fri, 3 Feb 2017 05:58:50 -0800 (PST)
In-Reply-To: <699f0c63e95ecdafe6946fdcdbb97a37@mail.crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net> <20170125185207.23902-5-paul@crapouillou.net>
 <CACRpkdbcO+1c7izYpn0sb1mkE1ORFETMq=xtzVi1hKbJz0EWfw@mail.gmail.com> <699f0c63e95ecdafe6946fdcdbb97a37@mail.crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Feb 2017 14:58:50 +0100
Message-ID: <CACRpkdZNodsRJ33wTJGgrAJpSs=_bXa0yv5ate_7XwjKR0xEnw@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] GPIO: Add gpio-ingenic driver
To:     Paul Cercueil <paul@crapouillou.net>
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
Content-Transfer-Encoding: 8BIT
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56625
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

On Tue, Jan 31, 2017 at 4:29 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> Le 2017-01-31 15:20, Linus Walleij a écrit :
>
>>> + of_property_read_u32(dev->of_node, "base", &jzgc->gc.base);
>>
>>
>> Remove this. Dynamic allocation should be fine, if you're using the
>> new userspace ABI like tools/gpio/* or libgpiod and only that and
>> in-kernel
>> consumers, dynamic numbers are just fine.
>
>
> The problem is that the QI_LB60 board code still have a lot of references
> to global GPIO numbers. Just grep for JZ_GPIO_PORT in
> arch/mips/jz4740/board-qi_lb60.c to see what I mean...

OK I understand we might need a compromise here to get the code moving.

But we need to keep it out of the device tree.

I think it's better to put a base table relative to the memory base in
the driver in that case:

unsigned int gpio_global_base;

switch (memory_base_address) {
case 0x41000000:
    gpio_global_base = 0x00;
    break;
case 0x42000000:
    gpio_global_base = 0x20;

(...)

etc. (Those are not your base addresses but you get the idea).

Include a few comments like:

/*
 * DO NOT EXPAND THIS: FOR BACKWARD GPIO NUMBERSPACE
 * COMPATIBIBILITY ONLY: WORK TO TRANSITION CONSUMERS TO
 * USE THE GPIO DESCRIPTOR API IN <linux/gpio/consumer.h> INSTEAD.
 */

Then I'll be happy :)

Yours,
Linus Walleij
