Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2015 06:58:36 +0100 (CET)
Received: from conssluserg003.nifty.com ([202.248.44.41]:41936 "EHLO
        conssluserg003-v.nifty.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010421AbbKFF6d4G6Yt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2015 06:58:33 +0100
Received: from mail-yk0-f174.google.com (mail-yk0-f174.google.com [209.85.160.174]) (authenticated)
        by conssluserg003-v.nifty.com with ESMTP id tA65w4WL002450;
        Fri, 6 Nov 2015 14:58:05 +0900
X-Nifty-SrcIP: [209.85.160.174]
Received: by ykdr3 with SMTP id r3so172408163ykd.1;
        Thu, 05 Nov 2015 21:58:04 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.13.204.149 with SMTP id o143mr721380ywd.46.1446789484137;
 Thu, 05 Nov 2015 21:58:04 -0800 (PST)
Received: by 10.37.26.69 with HTTP; Thu, 5 Nov 2015 21:58:04 -0800 (PST)
In-Reply-To: <3770393.BLNOaUSB5Q@wuerfel>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
        <3770393.BLNOaUSB5Q@wuerfel>
Date:   Fri, 6 Nov 2015 14:58:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNARjtTXUNQFDtcqtxUo0c49h_kfNCf-2WZUEFXmttZoFyA@mail.gmail.com>
Message-ID: <CAK7LNARjtTXUNQFDtcqtxUo0c49h_kfNCf-2WZUEFXmttZoFyA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] reset: make RESET_CONTROLLER a select'ed option
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@linux-mips.org, kernel@stlinux.com,
        David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel@lists.freedesktop.org,
        Patrice Chotard <patrice.chotard@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Alexandre Courbot <gnurou@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Yao <mark.yao@rock-chips.com>,
        =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Jens Kuske <jenskuske@gmail.com>, linux-tegra@vger.kernel.org,
        Michael Turquette <mturquette@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Maxime Coquelin <maxime.coquelin@st.com>,
        Barry Song <baohua@kernel.org>,
        Vishnu Patekar <vishnupatekar0510@gmail.com>,
        Eric Miao <eric.y.miao@gmail.com>, linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-spi@vger.kernel.org,
        Tuomas Tynkkynen <ttynkkynen@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

Hi Arnd,



2015-11-05 23:49 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 05 November 2015 20:15:21 Masahiro Yamada wrote:
>> When I was implementing a new reset controller for my SoCs,
>> I struggled to make my sub-menu shown under the reset
>> controller menu.
>> I noticed the Kconfig in reset sub-system are screwed up due to two
>> config options (ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER).
>>
>> I think only the former should be select'ed by relevant SoCs,
>> but in fact the latter is also select'ed here and there.
>> Mixing "select" to a user-configurable option is a mess.
>>
>> Finally, I started to wonder whether it could be more simpler?
>>
>> The first patch drops ARCH_HAS_RESET_CONTROLLER.
>> RESET_CONTROLLER should be directly selected by SoCs.
>>
>> The rest of this series are minor clean ups in other
>> sub-systems.
>> I can postpone them if changes over cross sub-systems
>> are not preferred.
>
> Thanks a lot for picking up this topic! It has been annoying me
> for a while and I have submitted an experimental patch some time
> ago, but not finished it myself.
>
> For some reason, I only see a subset of your patches here (patch 1, 4 and 6),
> so I don't know exactly what you did.

All the patches CCed linux-kernel@vger.kernel.org,
so you can dig into LKML log or the following patchwork
https://patchwork.kernel.org/project/LKML/list/




> For reference, you can find
> my original patch below. Please check if I did things that your
> series doesn't do, and whether those are still needed.

Thanks.

Yours looks mostly nice, and this work is worth continuing.
(I am pleased to review it when you submit the next version.)

I have some comments.

[1]
Why is ARCH_HAS_RESET_CONTROLLER select'ed by
ARCH_MULTIPLATFORM, but not by others?
This seems weird.

We do not have such options like
  ARCH_HAS_PINCTRL,  ARCH_HAS_COMMON_CLK...


[2]
The difference is that yours is adding per-driver options such as
RESET_SOCFPGA, RESET_BERLIN, etc.
I think this is a good idea.

But, I notice lowlevel drivers select RESET_CONTROLLER,
for example, RESET_SOCFPGA select RESET_CONTROLLER.

We generally do the opposite in other subsystems, I think.


For example, the whole of clk menu is guarded by "depends on COMMON_CLK".

menu "Common Clock Framework"
         depends on COMMON_CLK

     <bunch of low-level drivers>

endmenu


Likewise for pinctrl.





-- 
Best Regards
Masahiro Yamada
