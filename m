Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Jul 2015 18:58:59 +0200 (CEST)
Received: from mail-vn0-f41.google.com ([209.85.216.41]:35299 "EHLO
        mail-vn0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009246AbbGDQ65vFqdr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Jul 2015 18:58:57 +0200
Received: by vnbg190 with SMTP id g190so19391121vnb.2;
        Sat, 04 Jul 2015 09:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PHQGWs0bT5mRe6P62JoZBbWhiKHaczjmoq5tK7vRjOM=;
        b=I9ohEloXaFcyeQpolLKAw0Sr4PgBJ2LVt7o54saF5oz8VOcPwXYhu0zqD+5WlqPz78
         9pi5DPE6JxBa6WFsHD3e16y94juSlXPgixZjcD9FPgVRp+EOJls/WHOPhmAqaQjn9ski
         zH8qMiWwiUgZSMiDCYAFkClaup5EEg+v11SpKkikkdAOjA2sanizsHsI3kbsHNYoqPM9
         VpWO4hvXsGYNpoakVD/90/Q4CmeTH7jR0RMI+pGcM/b2G5g90b1j9sM3FX8kURptOA2v
         SwmMDggOxNdwgH6/9VOui0SyBIcUWECAr7NVetjy3+Bb7XRFenLOoIl0gVBSGoG604ee
         mf4Q==
X-Received: by 10.52.98.65 with SMTP id eg1mr17627392vdb.46.1436029132036;
 Sat, 04 Jul 2015 09:58:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.52.195 with HTTP; Sat, 4 Jul 2015 09:58:32 -0700 (PDT)
In-Reply-To: <1435914709-15092-2-git-send-email-albeu@free.fr>
References: <1435914709-15092-1-git-send-email-albeu@free.fr> <1435914709-15092-2-git-send-email-albeu@free.fr>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Sat, 4 Jul 2015 19:58:32 +0300
Message-ID: <CAHNKnsSgyzQu5uxZHu80X9MRQ5sJ+WEBatv9599QYxBsty66pg@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: ath79: Remove the unused GPIO function API
To:     Alban Bedel <albeu@free.fr>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2015-07-03 12:11 GMT+03:00 Alban Bedel <albeu@free.fr>:
> To prepare moving the GPIO driver to drivers/gpio remove the
> platform specific pinmux API. As it is not used by any board,
> and such functionality should better be implemented using the
> pinmux subsystem just removing it seems to be the best option.
>
For reference: OpenWRT uses this functions to activate UART.

-- 
Sergey
