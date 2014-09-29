Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2014 11:03:28 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34302 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008572AbaI2JD0O1Q0A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Sep 2014 11:03:26 +0200
Received: by mail-ie0-f177.google.com with SMTP id x19so18549829ier.8
        for <linux-mips@linux-mips.org>; Mon, 29 Sep 2014 02:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hmrTIR4yJo2kSMUjAkVTe1MN5LAD5OhqUMaKoFsR99c=;
        b=Vk+PsP4Zr175Rh+yccBJ0cEJtellAsnnFN/Wd4hLK9mAKZl1xjbG4EIBOODhXlOSJK
         QmpauG0PtPMMZ2K7EqlBag3oTIU6Qre9jgPklvBa+OBW4RjqtmvzKyspmU4piHJTLgR6
         IVnclFVPvvN3GZeuUtv6IdAv6IbsZ/gvImNobUUs9LAkwCZwFuk2EhjwPPz6pWg08RPW
         2eKk/cxuZkHaSAFyXGQrbZB7JhHiO2YwveEvkXbkSnzeAOCNQ4bx+w6ujDWL7ihmXDnS
         meezZ37L4fy6yDSNeuikPtpcc/LS41tZAXGsm0dba67pBrkySZZAKQhanFTlopgMtZe7
         SytA==
X-Gm-Message-State: ALoCoQlikpaJwPTqmTVZBpjBaj6d8QFInDbMsnXyNqFMTQ9EXiWlXkxfXoz1gdeceUKAQMMCbU5/
MIME-Version: 1.0
X-Received: by 10.50.115.73 with SMTP id jm9mr50217344igb.3.1411981400190;
 Mon, 29 Sep 2014 02:03:20 -0700 (PDT)
Received: by 10.43.102.201 with HTTP; Mon, 29 Sep 2014 02:03:20 -0700 (PDT)
In-Reply-To: <1410723213-22440-9-git-send-email-ryazanov.s.a@gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
        <1410723213-22440-9-git-send-email-ryazanov.s.a@gmail.com>
Date:   Mon, 29 Sep 2014 11:03:20 +0200
Message-ID: <CACRpkda2nNqb9iARw+ze=vsdmXVePGu+Fb5PMGo75FSCGJ+tDA@mail.gmail.com>
Subject: Re: [RFC 08/18] gpio: add driver for Atheros AR5312 SoC GPIO controller
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
X-archive-position: 42875
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

On Sun, Sep 14, 2014 at 9:33 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:

> Atheros AR5312 SoC have a builtin GPIO controller, which could be accessed
> via memory mapped registers. This patch adds new driver for them.
>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-gpio@vger.kernel.org
(...)

> diff --git a/arch/mips/ar231x/Kconfig b/arch/mips/ar231x/Kconfig
> diff --git a/arch/mips/ar231x/ar5312.c b/arch/mips/ar231x/ar5312.c
> diff --git a/arch/mips/include/asm/mach-ar231x/ar5312_regs.h b/arch/mips/include/asm/mach-ar231x/ar5312_regs.h

Please put these MIPS-related changes into a separate patch
to be handled through the MIPS git tree.

This driver seems surplus, it's just MMIO. Use
drivers/gpio/gpio-generic.c instead.

Yours,
Linus Walleij
