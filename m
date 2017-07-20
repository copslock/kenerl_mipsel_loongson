Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jul 2017 22:46:31 +0200 (CEST)
Received: from mail-ua0-x241.google.com ([IPv6:2607:f8b0:400c:c08::241]:36475
        "EHLO mail-ua0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993905AbdGTUqYIjxX1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jul 2017 22:46:24 +0200
Received: by mail-ua0-x241.google.com with SMTP id w45so3598204uac.3;
        Thu, 20 Jul 2017 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1Ik4KZ8A4jVWWCzZO8vYaPOiOt2nHwOs27opywxwyT0=;
        b=HQNQ2dohzsi9HgDimZway8wzPMddtUHpKOppwEWbsHQy/bRCpf3HHRl76wv0AaAYiT
         KmsnLqNLs25LiwgcYRGmUMbVKteT4eFkvTbrRkR02Ijn32mGwqqYvSq0ANsDY0TNOheR
         bl7qonMUSJEKrbi8PYDZmTD5OAlcOYG7QQTy9mc6jtqO9QXQPeGLXVHlHGuN2G/iRilu
         rp0WiAPRWIJ/1cEN9uYWF8nGotLOYq3NtBjFRwZJVK/g7vaFmKNrbxT4pmt3d7g0bUSX
         pFwpzRG+fPVYRKhjyE6YcmYvXrCtlbcPVGK75Sr8s9z5/TQ5ziecI3YlfC+G+i2/56IM
         V1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1Ik4KZ8A4jVWWCzZO8vYaPOiOt2nHwOs27opywxwyT0=;
        b=iavzNEtthp3fq/eAPhxf+FYfklbyQIQMo8Jo09uPMQHV/ynfvYFnZRStv8nmEmUzL4
         ejEvR8ow2jj3LqaLC7uiEURxronoM5b1mxmUi71uYZ60tp1csRinYtQVab3wUiyMXmyb
         olAvFJtECr/jL8ZJShhRSoJYL/A4M7aAm97qNTb9V1Pe/6FJO6CqLc9NQP+PZ+iTFLnj
         glQ+6CTNsmXZsWzrWE09XXiK7YvD6s2ueDHXL5//iG4adX1fVjyOgKhMy1JIEfdpoJGq
         8FhT5EYOvHELr6r5/vGgMmiFWR3NhR+/fJBWGiv1ejYOYTHHYftZ9AvwohpQwmm9aQ5M
         wbfg==
X-Gm-Message-State: AIVw113k+kV1IqFpnw1+QBrsMso8gHJhbojHXNOdL1FylD1O+1y7PCVa
        KpDFxnNmj/xXM4QMhP4y0cbUWlqmbQ==
X-Received: by 10.31.199.130 with SMTP id x124mr2604909vkf.189.1500583578044;
 Thu, 20 Jul 2017 13:46:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.51.9 with HTTP; Thu, 20 Jul 2017 13:46:17 -0700 (PDT)
In-Reply-To: <1500555312.2354.75.camel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
 <20170719211515.46a1196c@windsurf> <1500543415.2354.37.camel@pengutronix.de>
 <20170720123640.43c2ce01@windsurf> <1500555312.2354.75.camel@pengutronix.de>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 20 Jul 2017 13:46:17 -0700
Message-ID: <CAKdAkRTx8jd8UToz5_EgMmdW3V47i2uo++YvVB_yzytqSA=P1Q@mail.gmail.com>
Subject: Re: [PATCH 000/102] Convert drivers to explicit reset API
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Chen <Peter.Chen@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Marc Dietrich <marvin24@gmx.de>,
        Rakesh Iyer <riyer@nvidia.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-clk@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jiri Slaby <jslaby@suse.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Abriou <vincent.abriou@st.com>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-crypto@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        Philippe Cornu <philippe.cornu@st.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Joachim Eastwood <manabian@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-iio@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-tegra@vger.kernel.org, linux-mtd@lists.infradead.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        ath10k@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Salil Mehta <salil.mehta@huawei.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Brian Norris <computersforpeace@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devel@driverdev.osuosl.org,
        Yannick Fertre <yannick.fertre@st.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Richard Weinberger <richard@nod.at>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Alan Tull <atull@kernel.org>,
        John Youn <johnyoun@synopsys.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Yao <mark.yao@rock-chips.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        netdev <netdev@vger.kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        linux-fpga@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
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

On Thu, Jul 20, 2017 at 5:55 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Hi Thomas,
>
> On Thu, 2017-07-20 at 12:36 +0200, Thomas Petazzoni wrote:
>> Hello,
>>
>> On Thu, 20 Jul 2017 11:36:55 +0200, Philipp Zabel wrote:
>>
>> > > I don't know if it has been discussed in the past, so forgive me if it
>> > > has been. Have you considered adding a "int flags" argument to the
>> > > existing reset_control_get_*() functions, rather than introducing
>> > > separate exclusive variants ?
>> > >
>> > > Indeed, with a "int flags" argument you could in the future add more
>> > > variants/behaviors without actually multiplying the number of
>> > > functions. Something like the "flags" argument for request_irq() for
>> > > example.
>> >
>> > I can't find the discussion right now, but I remember we had talked
>> > about this in the past.
>> > Behind the scenes, all the inline API functions already call common
>> > entry points with flags (well, currently separate bool parameters for
>> > shared and optional).
>> > One reason against exposing those as an int flags in the user facing API
>> > is the possibility to accidentally provide a wrong value.
>>
>> This is a quite strange argument. You could also accidentally use the
>> wrong variant of the function, just like you could use the wrong flag.
>
> You can't accidentally use no flag at all or a completely bogus value
> with the "plethora of inline functions" variant.
>
>> Once again, the next time you have another parameter for those reset
>> functions, beyond the exclusive/shared variant, you will multiply again
>> by two the number of functions ? You already have the  exclusive/shared
>> and optional/mandatory variants, so 4 variants. When you'll add a new
>> parameter, you'll have 8 variants. Doesn't seem really good.
>
> I'd rather avoid adding more variants, if possible. The complexity
> increases regardless of whether the API is expressed as a bunch of
> functions or as a single function with a bunch of flags.
>
>> What about reset_control_get(struct device *, const char *, int flags)
>> to replace all those variants ?
>
> While I like how this looks, unfortunately (devm_)reset_control_get
> already exists without the flags, so we can't change to that with a
> gentle transition.

This was done for gpiod_get() and its flags argument with horrifying
#define-ry, which thankfully was completely hidden from users.

-- 
Dmitry
