Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2014 11:24:51 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:36546 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008535AbaI2JYtPByAO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Sep 2014 11:24:49 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 1131028BF2F;
        Mon, 29 Sep 2014 11:24:04 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qa0-f48.google.com (mail-qa0-f48.google.com [209.85.216.48])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 916B628BE17;
        Mon, 29 Sep 2014 11:23:57 +0200 (CEST)
Received: by mail-qa0-f48.google.com with SMTP id f12so882497qad.7
        for <multiple recipients>; Mon, 29 Sep 2014 02:24:39 -0700 (PDT)
X-Received: by 10.140.21.104 with SMTP id 95mr21072223qgk.69.1411982678997;
 Mon, 29 Sep 2014 02:24:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.101.178 with HTTP; Mon, 29 Sep 2014 02:24:18 -0700 (PDT)
In-Reply-To: <CACRpkda3Cq+d47DMm018nAC7ThcHAOv-tOqEbNsUY1mOSnKyoA@mail.gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
 <1410723213-22440-10-git-send-email-ryazanov.s.a@gmail.com> <CACRpkda3Cq+d47DMm018nAC7ThcHAOv-tOqEbNsUY1mOSnKyoA@mail.gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 29 Sep 2014 11:24:18 +0200
Message-ID: <CAOiHx==oJX_4qEigoQ4PwMYqUEek86fAY+ZYue7KWSk-Dc9HFw@mail.gmail.com>
Subject: Re: [RFC 09/18] gpio: add driver for Atheros AR5312 SoC GPIO controller
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Mon, Sep 29, 2014 at 11:18 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Sun, Sep 14, 2014 at 9:33 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>
>> Atheros AR5312 SoC have a builtin GPIO controller, which could be
>> accessed via memory mapped registers. This patch adds new driver
>> for them.
>>
>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Alexandre Courbot <gnurou@gmail.com>
>> Cc: linux-gpio@vger.kernel.org
> (...)
>> -       /* Attempt to jump to the mips reset location - the boot loader
>> -        * itself might be able to recover the system */
>> +       /* Cold reset does not work on the AR2315/6, use the GPIO reset bits
>> +        * a workaround. Give it some time to attempt a gpio based hardware
>> +        * reset (atheros reference design workaround) */
>> +       gpio_request_one(AR2315_RESET_GPIO, GPIOF_OUT_INIT_LOW, "Reset");
>> +       mdelay(100);
>
> Please try to use the new GPIO descriptor API.
> See Documentation/gpio/consumer.txt
>
> (...)
>> +++ b/drivers/gpio/gpio-ar2315.c
>
>> +static u32 ar2315_gpio_intmask;
>> +static u32 ar2315_gpio_intval;
>> +static unsigned ar2315_gpio_irq_base;
>> +static void __iomem *ar2315_mem;
>
> Get rid of these local variables and put them into an allocated
> state container, see
> Documentation/driver-model/design-patterns.txt
>
> Get rid of _gpio_irq_base altogether. (See comments below.)
>
> (...)
>> +static inline u32 ar2315_gpio_reg_read(unsigned reg)
>> +{
>> +       return __raw_readl(ar2315_mem + reg);
>> +}
>
> Use readl_relaxed()

ar2315/ar5312 is big endian, so readl_relaxed would mess up the byte
order. There does not seem to be a big endian equivalent for _relaxed.


Regards
Jonas
