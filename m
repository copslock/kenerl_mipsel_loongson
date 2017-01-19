Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 11:55:55 +0100 (CET)
Received: from mail-wm0-x234.google.com ([IPv6:2a00:1450:400c:c09::234]:38729
        "EHLO mail-wm0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993014AbdASKzrd0qhn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2017 11:55:47 +0100
Received: by mail-wm0-x234.google.com with SMTP id r144so71014237wme.1
        for <linux-mips@linux-mips.org>; Thu, 19 Jan 2017 02:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rlAt0DX2AO1UB/vHMjMYJ8sL1KIrq0JqdB0WuFTgx70=;
        b=B8cIC6arcAR1dCgwDP1m108GV+nVaYJyxehwrAYOT/zMGQtrEzRa981RdPn6qaF8xg
         neSqLLH0yWffdyx6fAc8t6c/ox1JKyJ3o6GK4GJhBDsqkbIPScCcNjfDyaqj0AMcjTUv
         UoAFyvbtKWRmGrJLudhlMPA7MQRjNNGYXC2Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rlAt0DX2AO1UB/vHMjMYJ8sL1KIrq0JqdB0WuFTgx70=;
        b=R7z0vjXF/BpdxhBDeCBx/fBwP86/qMLdD7zXCF4kJv4ODlbRlS+cTbBtwNLITqe2wy
         v91Z//haQRfc6wHpXVH6MQAAGcbToiOeaqXZy/05Y+3qdSDIihSQ/A2yVZB3iTz0Vrii
         FyLORlNhW4nbsQtTjvHMWkbf1Z4us12shZO8bXEGuaeNNmot5bKyUi4dLmq3xdElGPJo
         4iw7z9PGvCMAu0MioX6rH965W+UHkBv9GkLKfomDb6ua16BjZm2buvaFdhXo32+Gu8Kl
         JE7EiZXnqCRVermI4eygCQKHXv661b+k4aYD1nK2KU7W+8X9WvtqCVuVIJwBQrvcBWN8
         Io6w==
X-Gm-Message-State: AIkVDXLWG5Cw0lZMWDsSAPhIo6Rj7RXMJJx/Rtey49HQj4ub4XUcCCOXPcMN5mArzx34JTEVr0WGvVAxAfMHOVjW
X-Received: by 10.28.62.144 with SMTP id l138mr6235652wma.50.1484823342211;
 Thu, 19 Jan 2017 02:55:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.185.107 with HTTP; Thu, 19 Jan 2017 02:55:41 -0800 (PST)
In-Reply-To: <20170117231421.16310-10-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net> <20170117231421.16310-10-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Jan 2017 11:55:41 +0100
Message-ID: <CAPDyKFp4idZx+ynQByz22zwsiK+reBcvt3OdHm1kR2QUy+sUhw@mail.gmail.com>
Subject: Re: [PATCH 09/13] mmc: jz4740: Let the pinctrl driver configure the pins
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

[...]

>
> -#ifdef CONFIG_PM_SLEEP
> -
> -static int jz4740_mmc_suspend(struct device *dev)
> -{
> -       struct jz4740_mmc_host *host = dev_get_drvdata(dev);
> -
> -       jz_gpio_bulk_suspend(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
> -

Shouldn't this be replaced with a call to:
pinctrl_pm_select_sleep_state();

> -       return 0;
> -}
> -
> -static int jz4740_mmc_resume(struct device *dev)
> -{
> -       struct jz4740_mmc_host *host = dev_get_drvdata(dev);
> -
> -       jz_gpio_bulk_resume(jz4740_mmc_pins, jz4740_mmc_num_pins(host));

Shouldn't this be replaced with a call to:
pinctrl_pm_select_default_state();

[...]

Kind regards
Uffe
