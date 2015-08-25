Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Aug 2015 16:32:17 +0200 (CEST)
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33410 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013180AbbHYOcPYwq6U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Aug 2015 16:32:15 +0200
Received: by oieu205 with SMTP id u205so31280706oie.0
        for <linux-mips@linux-mips.org>; Tue, 25 Aug 2015 07:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jGQhOqwCPjBzXyfOJKHsM/LF8zXqLj7DA+yiB7B/qbs=;
        b=fgJSfUW8vKT/jtKPtVAepGgHGMNBZr+dWAqjpqtEa8DZXNwr7tgcOH1oGUY+F1ymz4
         2GjqPYAEVLQYkFtvdMPlW6s2fe9StgXh2MMkAB8Z1xn1Bk19kfHWAErmE6HVNZUQ15/+
         xST/WDrhSQzAlkozi/d5HEKR7hEgmWlXZXmVntvwlaMECa+yh2OriqRVS4ciLDDZbQwV
         R6655Jm3GrW7kjekZjT+GHjVaFZ1ziNeHw2x7HX7gL0wjyMs6DwLcOlOQKfcTgcYqm7x
         zXqwKYGJKNDnrD68UUdm5vZUXGDpy02T6PZm9MmCLMf/vvdEhbVHNvOhnvoY8xX+ukub
         l1og==
X-Gm-Message-State: ALoCoQmuFMwVp0CfPEnT8Z1jmBm3MUd6rkWD7E+fzKdsNoP2xBjWlhy6U8b9KaFaXztpZyjh2SW+
MIME-Version: 1.0
X-Received: by 10.202.22.132 with SMTP id 4mr3935957oiw.45.1440513129345; Tue,
 25 Aug 2015 07:32:09 -0700 (PDT)
Received: by 10.182.245.73 with HTTP; Tue, 25 Aug 2015 07:32:09 -0700 (PDT)
In-Reply-To: <1438678305-25524-1-git-send-email-albeu@free.fr>
References: <1438678305-25524-1-git-send-email-albeu@free.fr>
Date:   Tue, 25 Aug 2015 16:32:09 +0200
Message-ID: <CACRpkdYB7dJM8LNBqSt6sLm4xLdoVPvWEQ+Rix6=ihfoz2q_2g@mail.gmail.com>
Subject: Re: [PATCH v3] MIPS: Remove all the uses of custom gpio.h
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
        Manuel Lauss <manuel.lauss@gmail.com>,
        Joe Perches <joe@perches.com>,
        Daniel Walter <dwalter@google.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hartley <james.hartley@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Brian Norris <computersforpeace@gmail.com>,
        Varka Bhadram <varkabhadram@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        Michael Buesch <m@bues.ch>,
        abdoulaye berthe <berthe.ab@gmail.com>,
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
X-archive-position: 49010
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

On Tue, Aug 4, 2015 at 10:50 AM, Alban Bedel <albeu@free.fr> wrote:

> Currently CONFIG_ARCH_HAVE_CUSTOM_GPIO_H is defined for all MIPS
> machines, and each machine type provides its own gpio.h. However
> only a handful really implement the GPIO API, most just forward
> everythings to gpiolib.
>
> The Alchemy machine is notable as it provides a system to allow
> implementing the GPIO API at the board level. But it is not used by
> any board currently supported, so it can also be removed.
>
> For most machine types we can just remove the custom gpio.h, as well
> as the custom wrappers if some exists. Some of the code found in
> the wrappers must be moved to the respective GPIO driver.
>
> A few more fixes are need in some drivers as they rely on linux/gpio.h
> to provides some machine specific definitions, or used asm/gpio.h
> instead of linux/gpio.h for the gpio API.
>
> Signed-off-by: Alban Bedel <albeu@free.fr>

I bet I already ACKed this but anyways:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
