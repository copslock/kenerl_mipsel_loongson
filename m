Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 17:48:51 +0200 (CEST)
Received: from mail-oi0-x244.google.com ([IPv6:2607:f8b0:4003:c06::244]:48536
        "EHLO mail-oi0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992540AbdJSPsocavZr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 17:48:44 +0200
Received: by mail-oi0-x244.google.com with SMTP id m198so15597228oig.5;
        Thu, 19 Oct 2017 08:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tcyTuQEjo6x0t+GQc8CMN4wHLvtt3KoupdHBTJJxfL4=;
        b=h6Yz57mbk40rw1KOh/dHL8l+4Sij91qdsUkt3WvNh5Qkb4FEzOek8pEHnLUo4PYS1c
         Z09rVu+OVxKw5l7+MYsjrZbI55CFL/ijm9VwpWgQyE0F/k6vzx8wTTLnuc1iM9AcB25s
         ICB/y2LWtgLWSkUh7Y9orj08P6ANyt0HBvyZBTzVx7GkQpzraRkRHTiMG/Kc3CU2Qp2I
         Xel8Npxwt0h97SraaF00hjh0WnM0PZ2t95QE7Onxi0HdxRtF9TyQVIla7+5RMEeekwh8
         LJeH2TDqCVKGDZC2VZETYftsRGK5J1ggtEAQkWT3Qi+2Fzx1oebQ6UqKbUNT5aE6WTeo
         VatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tcyTuQEjo6x0t+GQc8CMN4wHLvtt3KoupdHBTJJxfL4=;
        b=ezV2ewks6eQQ5ZSmoK8aR/j/zJfPqxxn2KSzOGzuDMOxqMJixTq0ldEeJSIHFvDzT7
         Fr/NJVgbBfSnjl6CqHDMYbK8YGysVZHCiEEeC9KZMZ5QOZ3birptN4C/4nYMDTPxFsNq
         BG18CMJFTiDORPQjt5GZfLD/x/c/ugg3RCTysN99tHCcJy/oPDrWj6qUUcd2q89p7YPX
         DFmbFr130isR9nsClM/YlPoAOWjObxHil41A1tFWv4vE0p/CETfr1sQ4Ay3Uf9SXRi1b
         PCPy+tzWE4p6BkmIgEP8RaNrNX87q9I9APbHxAQIlxvY2GDJhta/wTR4DCwovok2nM6l
         80hw==
X-Gm-Message-State: AMCzsaWQZLLDVC34dHSO44De1vFVnCO6HCofXFiyjX8CmxFtYtYLa2eQ
        ZqJdYJrgZSDrL92dRP2EA2InlFZ7/oqAnqf5C7Q=
X-Google-Smtp-Source: ABhQp+TVq3wVbx9zgI8RA5KG9hWCcaqd9KDlvbmEti3dynMb4WqM71aFgXzwy+pODxWhgARGGP2zaa+oOIyBez9nk70=
X-Received: by 10.157.42.9 with SMTP id t9mr1270620ota.459.1508428118184; Thu,
 19 Oct 2017 08:48:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.28.152 with HTTP; Thu, 19 Oct 2017 08:48:37 -0700 (PDT)
In-Reply-To: <20170910214424.14945-5-linus.walleij@linaro.org>
References: <20170910214424.14945-1-linus.walleij@linaro.org> <20170910214424.14945-5-linus.walleij@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Oct 2017 17:48:37 +0200
X-Google-Sender-Auth: Sx7Ue8PNVTKDnR4JxsxHW3zUGN0
Message-ID: <CAK8P3a30U3pSEPqQtVN7MwE4dOC+Rj___adSEAebSBuX_2KadA@mail.gmail.com>
Subject: Re: [PATCH 4/5] i2c: gpio: Augment all boardfiles to use open drain
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        arm-soc <arm@kernel.org>, Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Sun, Sep 10, 2017 at 11:44 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> We now handle the open drain mode internally in the I2C GPIO
> driver, but we will get warnings from the gpiolib that we
> override the default mode of the line so it becomes open
> drain.
>
> We can fix all in-kernel users by simply passing the right
> flag along in the descriptor table, and we already touched
> all of these files in the series so let's just tidy it up.
>
> Cc: arm@kernel.org
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: requesting ACK for Wolfram to take this patch.

Acked-by: Arnd Bergmann <arnd@arndb.de>
