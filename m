Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jul 2015 08:04:55 +0200 (CEST)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33628 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010694AbbGaGEyFuCr0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Jul 2015 08:04:54 +0200
Received: by wicmv11 with SMTP id mv11so45145652wic.0;
        Thu, 30 Jul 2015 23:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=F7fz2DweN0rgoYPsHURbJ3lj61hKZKYA+NvU+/4tWJc=;
        b=c8YnwC71J1vf7AhphpmU6oOWpWKax0rc9OSXuJyjVNC00UJeUxhszoAcBJC5gDjdKD
         lFTtxY2T+QAiABs/Vibc+ItiUuDVSV7pxxmUYW3syk7H72DiW9yUMtLIgmFpxVTJ9aJV
         n1Ej2OgZlTAm2FTgBWfNCbx84ltlyUBTywaIWztKdCfCTQk0HTwhfzg1Q8wvf5glGczK
         fEpFgPUWTBylXuMhs93QWsGhofQzlOuRvd1XhFq0JQUidY2klwTtTKSo+4VKJBGr+fuX
         YPEKaZDQdMxjRX+WL38BTd6oIJNe2UaJYpUtuDXSw72wj+nFX/tviL8wn4sNJcCmWmmu
         dEow==
X-Received: by 10.194.123.4 with SMTP id lw4mr2146350wjb.94.1438322688893;
 Thu, 30 Jul 2015 23:04:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.170.170 with HTTP; Thu, 30 Jul 2015 23:04:09 -0700 (PDT)
In-Reply-To: <1438277338-7246-1-git-send-email-albeu@free.fr>
References: <1438277338-7246-1-git-send-email-albeu@free.fr>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Fri, 31 Jul 2015 08:04:09 +0200
Message-ID: <CAOLZvyFdY9z9tVd6BR4H4xnito=X5m_=71bmUr=7FHRGcB-SEw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Remove all the uses of custom gpio.h
To:     Alban Bedel <albeu@free.fr>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Florian Fainelli <florian@openwrt.org>,
        Joe Perches <joe@perches.com>,
        Daniel Walter <dwalter@google.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Varka Bhadram <varkabhadram@gmail.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Michael Buesch <m@bues.ch>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        abdoulaye berthe <berthe.ab@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Thu, Jul 30, 2015 at 7:28 PM, Alban Bedel <albeu@free.fr> wrote:
> Currently CONFIG_ARCH_HAVE_CUSTOM_GPIO_H is defined for all MIPS
> machines, and each machine type provides its own gpio.h. However
> only a handful really implement the GPIO API, most just forward
> everythings to gpiolib.
>
> The Alchemy machine is notable as it provides a system to allow
> implementing the GPIO API at the board level. But it is not used by
> any board currently supported, so it can also be removed.

Threre's only out-of-tree users which I also maintain, so it's fine with me.


>  arch/mips/alchemy/Kconfig                       |   7 --
>  arch/mips/alchemy/board-gpr.c                   |   1 +
>  arch/mips/alchemy/board-mtx1.c                  |   1 +
>  arch/mips/alchemy/common/Makefile               |   7 +-
>  arch/mips/alchemy/devboards/db1000.c            |   1 +
>  arch/mips/alchemy/devboards/db1300.c            |   1 +
>  arch/mips/alchemy/devboards/db1550.c            |   1 +
>  arch/mips/alchemy/devboards/pm.c                |   2 +-
>  arch/mips/include/asm/mach-au1x00/gpio-au1000.h | 148 ++----------------------
>  arch/mips/include/asm/mach-au1x00/gpio.h        |  86 --------------

For the alchemy parts:

Acked-by: Manuel Lauss <manuel.lauss@gmail.com>


-- 
   Manuel
