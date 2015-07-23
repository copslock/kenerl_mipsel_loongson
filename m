Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jul 2015 15:03:46 +0200 (CEST)
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34011 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009844AbbGWNDmo8gr8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jul 2015 15:03:42 +0200
Received: by oigd21 with SMTP id d21so122246220oig.1
        for <linux-mips@linux-mips.org>; Thu, 23 Jul 2015 06:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7lVRm14h5PfJZjTTqjXOcBkONXsT8zoiJIztnHdzVQg=;
        b=AbnttRE0q0opR9ihXLQffGWpY6ewP9N3nXDqSTEta+nvHV0ebZZiVd1DXuzhPTNibb
         IvMYJrIGoy7OHYM746uHhk/p6jJsC1qpN2jOoMXyvLS+VfY/2ZHAerlf24uUUwKzka5n
         uPRSTCOZjs972hgwVN+Y2EDOYegDWlMewazc4q5nSey+VgG41Tw18TYOcSej7PbkpiRB
         j2AnDjJuvfgJWzvs2ovyKmSlaGjDcLgm387/MUdcW8ZjE6sHf0IR9Q3kW3ICe3lfw4jJ
         5QGLF9gvHpBdvX/yHepsJRMkXqjt/SGYesO5obhj4WV6GKLGo4lzgNvZj+WdpzLy8BhR
         LqeA==
X-Gm-Message-State: ALoCoQnT2mjO8lyDrFSMG9AUuaV+hfq/9EqzuLPwTX0NvAZ4di3pbVC7BlhjZoQMQ696Xq7Zb4mc
MIME-Version: 1.0
X-Received: by 10.182.230.70 with SMTP id sw6mr8057095obc.48.1437656616812;
 Thu, 23 Jul 2015 06:03:36 -0700 (PDT)
Received: by 10.182.204.41 with HTTP; Thu, 23 Jul 2015 06:03:36 -0700 (PDT)
In-Reply-To: <1437586416-14735-1-git-send-email-albeu@free.fr>
References: <1437586416-14735-1-git-send-email-albeu@free.fr>
Date:   Thu, 23 Jul 2015 15:03:36 +0200
Message-ID: <CACRpkdYqwOymyK31rwhe7EQnSxLFrcy3PTBvCsyK1TR+J7=EQg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Remove most of the custom gpio.h
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Alban Bedel <albeu@free.fr>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>,
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
        Waldemar Brodkorb <wbx@openadk.org>,
        James Hogan <james.hogan@imgtec.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Levente Kurusa <levex@linux.com>,
        abdoulaye berthe <berthe.ab@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48402
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

On Wed, Jul 22, 2015 at 7:33 PM, Alban Bedel <albeu@free.fr> wrote:

> Currently CONFIG_ARCH_HAVE_CUSTOM_GPIO_H is defined for all MIPS
> machines, and each machine type provides its own gpio.h. However only
> the Alchemy machine really use the feature, all other machines only
> use the default wrappers.
>
> For most machine types we can just remove the custom gpio.h, as well
> as the custom wrappers if some exists. A few more fixes are need in
> a few drivers as they rely on linux/gpio.h to provides some machine
> specific definitions, or used asm/gpio.h instead of linux/gpio.h for
> the gpio API.
>
> Signed-off-by: Alban Bedel <albeu@free.fr>

This is exactly what the kernel needs. Enjoy my:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

And feel free to merge this through the MIPS tree.

Yours,
Linus Walleij
