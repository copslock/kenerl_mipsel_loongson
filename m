Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 11:26:17 +0200 (CEST)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:37379
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992517AbdIRJ0LUEC0M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 11:26:11 +0200
Received: by mail-pg0-x242.google.com with SMTP id v5so4954286pgn.4
        for <linux-mips@linux-mips.org>; Mon, 18 Sep 2017 02:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BkLVJltjxh2pb+aDKiJcZBZbSmUV1Ddmy1n91rmGA9w=;
        b=aR6qQtpLp4wM8jgHvoD73uYSt46QKxVNUwQvvao0aFUHtKz/UXH+FUWfKq7s9E7slj
         QeyOZB+871QMEI/eGCe0lFUywEMVTRyiKe9tp9zLwPavlDSb2oLAx5AER8+UC7M18z2N
         7uKqqdqJv3376HqnL1rjG991wtrVT5qZF80SeSX8VyR9mxyUrVKl3cuO7KJtsPnc+k0/
         oGv5a6tRPl9oVbCekXHYDtReQBvyhGMGAkIB0bxL9X6gyeXSKvgKRq2PZdCxo195g/4a
         5uz7WNgV/TbsCrvHsLd6Rd5HM//ugA4tbps2dWGduMcX1aPHmR4RdyJN7MXq+bNwQPwN
         QbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BkLVJltjxh2pb+aDKiJcZBZbSmUV1Ddmy1n91rmGA9w=;
        b=ihT7uqgqTyub0vf8gK+Pq1I+oN/pWcO+QuchHSEDeaxzsMxlpOC2W7OKsUn9A//zMp
         v4uuzU7F3Hb9adg9fPwFzlfJZ05TbQa2mJLW99bZrQIfG1YV70IYzQTKO50Dpe/mSlbw
         cpnDTaf3oFe6iJWsVemqWKFGPcq9DSUKFPY0I8FPdRAYMe7fehqkKxBqBf5djUzglfdu
         /lZ8ZKKWrPZACycpacy22L4lASVZjJHOB2AyIP5ZKEyt1GupsaK9O+PK9WAbV1xzWPaL
         SohVPUslSnPYpM9c42Ir+jrxaC+wwjL42iRZEIeJ2QNAgxMcZiCsLXF+t6qe59hHZTCA
         mDAQ==
X-Gm-Message-State: AHPjjUgipFxc0JwKGpBwjwDesZjbEvvE4dzdYqAbXYSJa5Swio01bQCQ
        ZTyEDj241MFd/PB4dEftDxGFAOUTuRo+sRWLpG8=
X-Google-Smtp-Source: AOwi7QClKLZkNp4foNrFpyQgBNTFlTlUogbu5/Ra6kjX40Cwsq6d7r/pL9kfpoEKtLEsFQhV5K2djol1Z1Kw74GtCdM=
X-Received: by 10.101.67.137 with SMTP id m9mr12755391pgp.63.1505726764815;
 Mon, 18 Sep 2017 02:26:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.160.13 with HTTP; Mon, 18 Sep 2017 02:26:04 -0700 (PDT)
In-Reply-To: <20170917093906.16325-8-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org> <20170917093906.16325-8-linus.walleij@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2017 11:26:04 +0200
X-Google-Sender-Auth: 1usnQCHDrO4-iureelPTJpXwVM0
Message-ID: <CAMuHMdX4+e6D_AEdvVF2Ubyxs0L6-53fqwot=wDXfPatvnMGTg@mail.gmail.com>
Subject: Re: [PATCH 7/7] i2c: gpio: Add support for named gpios in DT
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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
> This adds support for using the "sda" and "scl" GPIOs in
> device tree instead of anonymously using index 0 and 1 of
> the "gpios" property.
>
> We add a helper function to retrieve the GPIO descriptors
> and some explicit error handling since the probe may have
> to be deferred. At least this happened to me when moving
> to using named "sda" and "scl" lines (all of a sudden this
> started to probe before the GPIO driver) so we need to
> gracefully defer probe when we ge -ENOENT in the error

get

> pointer.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
