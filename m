Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2015 15:42:35 +0100 (CET)
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34103 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006918AbbLROmdywoz0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Dec 2015 15:42:33 +0100
Received: by mail-oi0-f53.google.com with SMTP id o124so60622059oia.1
        for <linux-mips@linux-mips.org>; Fri, 18 Dec 2015 06:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Z3pJXm/y737zIIDVTjIv1wfR8fm+2rM/e5M5LF5Ja74=;
        b=e/ERk4Yp/MeJWghZF+i7xu4pAAZGUr+JGB7NGTXtrX2s1rBDxTYUZ+ckaCeQLFVMVe
         I+i5Tvac9pwNLlXpk9J7dh5eBdoJ4gRU8XZrVUDaDNokac313UegaAGQqUfR3peEzQ4Z
         qvR/MfJ3SwPQrB4RKPE21tTDRuAiXRQAhE70o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Z3pJXm/y737zIIDVTjIv1wfR8fm+2rM/e5M5LF5Ja74=;
        b=AQX39X+e8uKQBzZNoab2TKPPcO3eqeQZY4BJtY7BNeVQPYsNGbTqpZthhMuMaaao46
         CkaP9znL3tylXpBrWT/Pc/oAwO5u1fRpUnSJ0IC0M80zY2cZlJQVCSLMqBbSJd3aQ735
         L2EKAi5M/57mpSZZfTuyulKRAjsmv8orI2PyBd4l7wK9Z+CAJQR3iJiIqFva0kuMeCX0
         jlqFjMZPMRb/CKYvU+nrfR/1Qv7ZYhW2uCVC0mITugSn7XWXErCC2Q2/ODeaojHCQ2LK
         5XUIsxh0PwUw82jQyiaGPl62lBY7+Jg9CRiX1WJespCtYNxDqecJifgq6+SNNmmWqD16
         u78A==
X-Gm-Message-State: ALoCoQnXygwZhMlKkIKDgOLfOQp7Xam4JqEHdM9WXT7KsSKIYdr/FYzNjUScbGJ5bkD53I+NsSgG+alOBRkt8Nxp/cX1GIMnUqG2qgapF7LwqXnCKXyZEsU=
MIME-Version: 1.0
X-Received: by 10.202.107.68 with SMTP id g65mr1596021oic.135.1450449747801;
 Fri, 18 Dec 2015 06:42:27 -0800 (PST)
Received: by 10.182.32.70 with HTTP; Fri, 18 Dec 2015 06:42:27 -0800 (PST)
In-Reply-To: <20151214124626.GG23327@localhost>
References: <1449666515-23343-1-git-send-email-linus.walleij@linaro.org>
        <20151209134410.GH8644@n2100.arm.linux.org.uk>
        <CACRpkdZcz73vtgZsCKZCJ=G3nq-yCPiO8hws4ro5HVWd8AVRCw@mail.gmail.com>
        <20151214124626.GG23327@localhost>
Date:   Fri, 18 Dec 2015 15:42:27 +0100
Message-ID: <CACRpkdZ9vZmMWHemb8_XDwdhMDjMNoE7EyLUSnvVS6R5yU3i_A@mail.gmail.com>
Subject: Re: [PATCH 000/182] Rid struct gpio_chip from container_of() usage
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "arm@kernel.org" <arm@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Sonic Zhang <sonic.zhang@analog.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Anatolij Gustschin <agust@denx.de>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50687
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

On Mon, Dec 14, 2015 at 1:46 PM, Johan Hovold <johan@kernel.org> wrote:

> Ok, but let's take a step back. So you have all this in place and a
> consumer calls gpiod_get_value() that returns an errno because the device
> is gone. Note that this wasn't even possible before e20538b82f1f ("gpio:
> Propagate errors from chip->get()") that went into *v4.3*, and I assume
> most drivers would need to be updated to even handle that that gpio
> call, and all future calls, are now suddenly failing.

I actually have a revert of that in my fixes queue. So another step back
and two forward for v4.5 (hopefully): audit all drivers to respect this.

Yours,
Linus Walleij
