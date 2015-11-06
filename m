Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2015 10:31:45 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.13]:49395 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012731AbbKFJbnjp1zp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2015 10:31:43 +0100
Received: from wuerfel.localnet ([134.3.118.24]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0Ma2zH-1a9hO6361H-00LpBz; Fri, 06 Nov
 2015 10:30:10 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mips@linux-mips.org, kernel@stlinux.com,
        David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Alexandre Courbot <gnurou@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michael Turquette <mturquette@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Coquelin <maxime.coquelin@st.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Jens Kuske <jenskuske@gmail.com>, linux-tegra@vger.kernel.org,
        Terje =?ISO-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Mark Yao <mark.yao@rock-chips.com>,
        Barry Song <baohua@kernel.org>,
        Vishnu Patekar <vishnupatekar0510@gmail.com>,
        Eric Miao <eric.y.miao@gmail.com>, linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-spi@vger.kernel.org,
        Tuomas Tynkkynen <ttynkkynen@nvidia.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [RFC PATCH 0/7] reset: make RESET_CONTROLLER a select'ed option
Date:   Fri, 06 Nov 2015 10:29:54 +0100
Message-ID: <4121507.a7FHqRxKcX@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CAK7LNARjtTXUNQFDtcqtxUo0c49h_kfNCf-2WZUEFXmttZoFyA@mail.gmail.com>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com> <3770393.BLNOaUSB5Q@wuerfel> <CAK7LNARjtTXUNQFDtcqtxUo0c49h_kfNCf-2WZUEFXmttZoFyA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:EeCZCvxjW4tm5AvhtPWOUy9iCTtUJFsqzIvzBCYxI+7HlJcalL5
 d6plB8nC+AGhEwI+Q1OMDTj+WguhnXAGlTUtYKjfuAxMSMU4ciOL6TMaHjgSR4Wo+H3vi5v
 rgN1KJ7iwqekdmPzS4cCQ9EhVcjopHPJw9wk7jKbpxe4dQ2+jh18ArNY7oRMooiwVpIPrUQ
 AdAjQu452BRSyrAZKVWtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f2RmRuHy1Yw=:A3Rco0XPGUQPexb67LaZ7F
 X1X/r+AUb+u8HXqlfzAHBhg331/MHRe6A+PKTsWkjAfZmwHpgpj3Nrv2+IYUEEFIGTlKrYC+n
 BJgvqlfp8xe0e0QY1XZFU5e/qg81IuJeIQ9nvupfLY8K5uNwBrjZmPIAGMxejUUZf1PMYVcXB
 s9SUrlQNSrjaxh4UykbVprmIPTOPPjWVd5lOIWglgy2ew/qbksXpzsXadJ/n89z4EySSB/OrV
 0qr/V5niyM1duTsS0azwUtrQ5oENFn7/kbLb6t7PtkVGzRRgicNVycVLAi+VTE09HqiZddxEf
 fGSsJ2KrqtOrA9tqybl/sUyAtvGTR/2TvT2J5kOHKTI34pImQOPO8dfgBrgx4YgNw+S1MIyRf
 /Od+7aINl0JL+Di62gb1kq9cM/v21SJQSfWZFb21/7eJbQpA/CuxA6PK8HlQluKtLFfxQbe0X
 oYoolC1xxav+1rEArlg0ZQNSLZO2srSldLpw9k0tpQIH1cNjAZbZN+wM/Nu4EbSrU6e1tV6eT
 I5oSV99hyVtuNb+LLQypW10pbTP39ngJ5MK5BzQR16LBlYQVabasADDGKhejpAxYQA9B0NWSw
 M323Ol+T/5gtfpq6WMWEqpjjzNH9P/91/C887cKg/plhFUSdUoukri0KsXtMnfZfz/dsjfSKS
 VSayKcuKOa9BMb9fPGNuyomcB4V6veljDOlmHOZcPhNmaKGAPNl2PWbROMj3zcqiV2pXX+jal
 GelUr2DEIRrzWu6y
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49859
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

On Friday 06 November 2015 14:58:04 Masahiro Yamada wrote:
> 2015-11-05 23:49 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> [1]
> Why is ARCH_HAS_RESET_CONTROLLER select'ed by
> ARCH_MULTIPLATFORM, but not by others?
> This seems weird.

I tried to avoid having to set this from each platform separately,
and all users of ARCH_HAS_RESET_CONTROLLER on ARM are also
based on ARCH_MULTIPLATFORM. The other platforms are lagging behind
in their conversion and use neither reset controllers not
multiplatform. If anyone wants to make them use reset controllers,
we probably want them to use multiplatform as well.

> We do not have such options like
>   ARCH_HAS_PINCTRL,  ARCH_HAS_COMMON_CLK...

We could of course change it in one direction or another, but it
didn't seem urgent here.

> [2]
> The difference is that yours is adding per-driver options such as
> RESET_SOCFPGA, RESET_BERLIN, etc.
> I think this is a good idea.
> 
> But, I notice lowlevel drivers select RESET_CONTROLLER,
> for example, RESET_SOCFPGA select RESET_CONTROLLER.
> 
> We generally do the opposite in other subsystems, I think.
> 
> 
> For example, the whole of clk menu is guarded by "depends on COMMON_CLK".
> 
> menu "Common Clock Framework"
>          depends on COMMON_CLK
> 
>      <bunch of low-level drivers>
> 
> endmenu
> 
> 
> Likewise for pinctrl.

We can do that too, either way works for me, and we are using both
in other parts of the kernel. REGMAP is an example for another subsystem
that gets selected by each driver that relies on the framework.

The practical difference is only in the case that the subsystem
is enabled (e.g. by using ARCH_MULTIPLATFORM) but all reset drivers
are disabled. A device driver using the API in one case will see
the stubbed-out inline helpers and not contain any object code
that relies on non-NULL return values from them, while in the
other case it calls into the subsystem code to get the same
return value at runtime.

If you volunteer to clean up my patch, feel free to choose between
the two options as you like.

	Arnd
