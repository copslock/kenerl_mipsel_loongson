Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2016 14:13:45 +0200 (CEST)
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33540 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992002AbcHVMNfmJfEm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Aug 2016 14:13:35 +0200
Received: by mail-lf0-f47.google.com with SMTP id b199so76233891lfe.0
        for <linux-mips@linux-mips.org>; Mon, 22 Aug 2016 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ne2hDNlO414CdhSFH8PJ0d3EOPnGpEBqfQo67UnRBUY=;
        b=hyNFpoBnM61tHWHRTyCvyXaXYNDke8c3ss0oHSFC1pJN7ZbKnmEdXaFTef2q3yZIeC
         vUPMjK+qUn6JR+Pgm/o4f2jwbKj87ZTLXU5mPiVC/HnVoDRtv7pzIJaASkP6l1JypxyS
         4AZ38P3R4044r+WYt+aFvZK6ylMOhby/o1BZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ne2hDNlO414CdhSFH8PJ0d3EOPnGpEBqfQo67UnRBUY=;
        b=Y81OIaMdhC5cWnB5dmMpq26cLHZX4F1WU5FtbNyzyu/v04/zjDvv7wh0JfUNFIMpDD
         vWrucqUdN3PveQtcgD4hvow0spZy2GwPR1rVf5LFbc2Z2bG543D2MEb+RsSnl/E3GNnE
         q6ts4X5/lLorvWrc2eECnoJnnYu4mOT58NxFCKqlpkyWuAIlCeR6wk6Lw0HICVZEomuG
         cwHUbN+vl3/QlCxqpiVFt0Q2UXVFmvWt39jY658rQ3ujPwqmh3twXL6jFYuBhN847NHt
         9fv/blCoinP9wWxqyCYtpVK4MteUcFi/lh1cqYe4Y2qhLRxsi2gaPabK9d0x+nZ2P6vN
         h92w==
X-Gm-Message-State: AEkoousQfflrBSkARkYTdcxqdTIVYbGlgUIsLWB/cre6nptsJ3zJdRCZvlXh5uzUnj1EuVL8y92Xq/2ejeKBrW+o
X-Received: by 10.46.32.131 with SMTP id g3mr5017955lji.46.1471868010192; Mon,
 22 Aug 2016 05:13:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.10.208 with HTTP; Mon, 22 Aug 2016 05:13:29 -0700 (PDT)
In-Reply-To: <1471525068-1525-3-git-send-email-geert@linux-m68k.org>
References: <1471525068-1525-1-git-send-email-geert@linux-m68k.org> <1471525068-1525-3-git-send-email-geert@linux-m68k.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Aug 2016 14:13:29 +0200
Message-ID: <CACRpkdaWzHvUzF6xiu9w2oAn+UDCYn0s5-bX06K_jGLwadY7nQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: TXx9: tx49xx: Move GPIO setup from .mem_setup()
 to .arch_init()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54723
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

On Thu, Aug 18, 2016 at 2:57 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

> txx9_gpio_init() calls gpiochip_add_data(), which fails with -ENOMEM as
> it is called too early in the boot process. This causes all subsequent
> GPIO operations to fail silently (before commit 54d77198fdfbc4f0 ("gpio:
> bail out silently on NULL descriptors") it printed the error message
> "gpiod_direction_output_raw: invalid GPIO" on RBTX49[23]7).
>
> Postpone all GPIO setup to .arch_init() time to fix this.
>
> Suggested-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
