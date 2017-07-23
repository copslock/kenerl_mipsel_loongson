Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jul 2017 20:42:02 +0200 (CEST)
Received: from mail-io0-x236.google.com ([IPv6:2607:f8b0:4001:c06::236]:38025
        "EHLO mail-io0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993256AbdGWSlziAMms (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Jul 2017 20:41:55 +0200
Received: by mail-io0-x236.google.com with SMTP id g13so36163225ioj.5
        for <linux-mips@linux-mips.org>; Sun, 23 Jul 2017 11:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vhqof9grmGhgmVpo8nLVV6yHAMuBhkqXLFjUrJiUi0g=;
        b=jGSHCg4unaKpNUDOy878A+wpEP+j6k8diAqh7lpfrfRh+WjPq1uu8Uq/VeCms9NDyg
         kiy+/2nJQ2EOqsNaKG+tjH6Twdm/D1fVGxQW5EbzB4sviGcrs351/8+Sd26IyqEx5a+6
         ramZgBA3KNoMdbEsKstCzW0xSmrirb0WlGnpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vhqof9grmGhgmVpo8nLVV6yHAMuBhkqXLFjUrJiUi0g=;
        b=hVnJh9BTnA65mKpy3biQVaxC0hosC5N+aoGMw0YKvXgbgwN4qmGHpbYWPk2qriY4h3
         BKq4TyLAl1bKlBi3PlOF8PfpVYzIbYg9MditPRrUeCxnFPQExvMIjVpMK36XilfvyC2O
         +5D5I0Mc6b3npaQIIC1u6klc/fzYiRT8XWgCmEO1cTIpECEjUH4Xw7MzuAaq7Wl9zE8M
         6Mmy91yQLUvZwtH2PRyhNiZavVgjHFNjFRCjajjGjQFVczwMiLYwiQTuzZfHn18+3Lgg
         B7ETQ3+quVr78I8kJEC0jHc8P22shaV3Ngrsawn5DczJSuM7g1jOkQCmWVci5UlTLLo3
         Mpew==
X-Gm-Message-State: AIVw113NkGXOdVRDT6PV3UiBdiUJFApzafsKChAnwDQY3esQ1ZIYdv3Z
        UKrfuJ4V9xpn3zXNy6Uf3GY47fz+VZrT
X-Received: by 10.107.157.9 with SMTP id g9mr14710954ioe.46.1500835309647;
 Sun, 23 Jul 2017 11:41:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.154.22 with HTTP; Sun, 23 Jul 2017 11:41:48 -0700 (PDT)
In-Reply-To: <CAKdAkRTx8jd8UToz5_EgMmdW3V47i2uo++YvVB_yzytqSA=P1Q@mail.gmail.com>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
 <20170719211515.46a1196c@windsurf> <1500543415.2354.37.camel@pengutronix.de>
 <20170720123640.43c2ce01@windsurf> <1500555312.2354.75.camel@pengutronix.de> <CAKdAkRTx8jd8UToz5_EgMmdW3V47i2uo++YvVB_yzytqSA=P1Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 23 Jul 2017 20:41:48 +0200
Message-ID: <CACRpkdaXOv7mX+b-q1K34CB5w0SWPXCKa21wHaxL7qjf91PJXQ@mail.gmail.com>
Subject: Re: [PATCH 000/102] Convert drivers to explicit reset API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Chen <Peter.Chen@nxp.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Marc Dietrich <marvin24@gmx.de>,
        Rakesh Iyer <riyer@nvidia.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
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
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
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
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
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
        Lee Jones <lee.jones@linaro.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
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
        dmaengine@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
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
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59212
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

On Thu, Jul 20, 2017 at 10:46 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Jul 20, 2017 at 5:55 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:

>>> What about reset_control_get(struct device *, const char *, int flags)
>>> to replace all those variants ?
>>
>> While I like how this looks, unfortunately (devm_)reset_control_get
>> already exists without the flags, so we can't change to that with a
>> gentle transition.
>
> This was done for gpiod_get() and its flags argument with horrifying
> #define-ry, which thankfully was completely hidden from users.

For your reference:

commit bae48da237fcedd7ad09569025483b988635efb7
"gpiolib: add gpiod_get() and gpiod_put() functions"

commit 39b2bbe3d715cf5013b5c48695ccdd25bd3bf120
"gpio: add flags argument to gpiod_get*() functions"

commit 0dbc8b7afef6e4fddcfebcbacbeb269a0a3b06d5
"gpio: move varargs hack outside #ifdef GPIOLIB"

commit b17d1bf16cc72a374a48d748940f700009d40ff4
"gpio: make flags mandatory for gpiod_get functions"

Retrospectively ... was that really a good idea... it was a LOT
of trouble to add a flag, maybe it had been better to try and
just slam all users in a single go.

But it worked.

Yours,
Linus Walleij
