Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 15:20:20 +0100 (CET)
Received: from mail-it0-x231.google.com ([IPv6:2607:f8b0:4001:c0b::231]:38813
        "EHLO mail-it0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993893AbdAaOUMXwe8e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 15:20:12 +0100
Received: by mail-it0-x231.google.com with SMTP id c7so125923334itd.1
        for <linux-mips@linux-mips.org>; Tue, 31 Jan 2017 06:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IMfAZK98G9atBXspM11XUvvX8YP7L62N9J93DgKTPVw=;
        b=TtLPcObHxzqMg37FYxEhGToYsBjB00CB+I+35sU8HH+bzZPNjgiMyHVOE0vV3Fz8VA
         Ow4YZw0yg9d/8yTvK6ObPQQUqGGS+YUCgykXR0EygOg1GU8DpVIFaIVKZcGGoChk8G6u
         ZYqyMnoZY4e4qIWM2JXgv0AFuxQSxISfBoHy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IMfAZK98G9atBXspM11XUvvX8YP7L62N9J93DgKTPVw=;
        b=niF6A5+ki+enzyY5i/otIO8sCa1+Ui1B8U97r7/MGrqKwkAeFrfhO3kc9ucMuAOQAc
         92yniyzCDfYIXanC83Qkrd5jiUEInNugH3AqM2CvZBn69Rq1PIQOK5QgRqYwadFjOPGv
         s1JwgH5IWOFyvMlbkJS1wBmeYhc7GiweessCHFO3mNkK91qhCsNZzbN4k6LkaKk4mM8I
         basa7XQ8d3qVklUezD5eZh/AYccvSVUj5cFELd/erTcUILcYC+mQxLGPJrGroXxtZX46
         Ld326Nryvr4O6Dg/NV6cpVWCEWVn9aoe2USgh7GJ1p6aPeTZ40C0D1ukeo2purJ5UxAd
         pxrg==
X-Gm-Message-State: AIkVDXKMSSdAJt5Pc9mAqbdT2HHQNymQ7ELn5hh5eb8F5TbNg+jEhtnawtmkB9IFyuepM8CQGjFD2mMztfhVbZuN
X-Received: by 10.36.123.136 with SMTP id q130mr20074939itc.25.1485872406754;
 Tue, 31 Jan 2017 06:20:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.83.7 with HTTP; Tue, 31 Jan 2017 06:20:04 -0800 (PST)
In-Reply-To: <20170125185207.23902-5-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net> <20170125185207.23902-5-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Jan 2017 15:20:04 +0100
Message-ID: <CACRpkdbcO+1c7izYpn0sb1mkE1ORFETMq=xtzVi1hKbJz0EWfw@mail.gmail.com>
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
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56549
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

Forgot to mention this:

On Wed, Jan 25, 2017 at 7:51 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> This driver handles the GPIOs of all the Ingenic JZ47xx SoCs
> currently supported by the upsteam Linux kernel.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
(...)
> +       jzgc->gc.base = -1;

Nice

> +       of_property_read_u32(dev->of_node, "base", &jzgc->gc.base);

Remove this. Dynamic allocation should be fine, if you're using the
new userspace ABI like tools/gpio/* or libgpiod and only that and in-kernel
consumers, dynamic numbers are just fine.

If you have old sysfs userspace that you need to support using the
global GPIO numberspace, please look into ways to phase that out.

Yours,
Linus Walleij
