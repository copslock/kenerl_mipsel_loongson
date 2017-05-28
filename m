Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 May 2017 16:20:25 +0200 (CEST)
Received: from mail-wm0-x22e.google.com ([IPv6:2a00:1450:400c:c09::22e]:36363
        "EHLO mail-wm0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993913AbdE1OURKlAHB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 May 2017 16:20:17 +0200
Received: by mail-wm0-x22e.google.com with SMTP id 7so27642579wmo.1
        for <linux-mips@linux-mips.org>; Sun, 28 May 2017 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0CysKYRzxbmKXESMb/CwE5c8iUi7OocNNIr72tREMEw=;
        b=QWjMs5PJ454PFzELtga+RnIoopp+zB0E1tDRFih8IKvaphr8xI6NpMstQNFAhHHSL0
         PS3gwE4GKy9kuHxYB9Z1FJ/zKx1BCuORRP8tIChSkBgekXKtM/52FPrXTR5V9nAf9G7B
         4LrmuMxJSeRsNFBcNCx9Zbedy+XAkVgZy2MuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0CysKYRzxbmKXESMb/CwE5c8iUi7OocNNIr72tREMEw=;
        b=H6+5ke/dBa8+GJpgmzenisaOmKPxJLalp+EYZAe3lYfC8iqA3if7UOKybryC2oUDAc
         /ti9O537Nh3indRF0FtSNV0BlE9ZAmw3B7UqsZaXqaH5G6LhCw+NSuqcVlR/kj7Au/DC
         MnXwpxoSgvWd+fJPx2M1aGf3VAVC+//z7wDsUNJgNVhQPQHiBUrA8GTebIwfLjiDsbWF
         c9AbYvR1onSM2yIBnSKjn359Py/BPj1wg7dv72LjRd4YjLQGFc0ZY9ahv31pFdsONQOf
         4o/zMDpp0reZjb964bem+jeJLD/v5xpx9HzOmS80COpiySXnSTVk6GkeuuSiaMPFYwMq
         Vkzg==
X-Gm-Message-State: AODbwcAVIbagbGnI65JDQPoBYOPYhAPwI+DUq2EyJ7s5eVzF4TIablKV
        SfMRkhHnhOFuVkzX
X-Received: by 10.28.133.78 with SMTP id h75mr20557961wmd.81.1495981211735;
        Sun, 28 May 2017 07:20:11 -0700 (PDT)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id c8sm6662527wmd.5.2017.05.28.07.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 May 2017 07:20:09 -0700 (PDT)
Subject: Re: [PATCH 2/7] clocksource: Rename CLOCKSOURCE_OF_DECLARE
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ley Foon Tan <lftan@altera.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <kernel@pengutronix.de>,
        Joachim Eastwood <manabian@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Richard Cochran <rcochran@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Noam Camus <noamca@mellanox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:ARM/STI ARCHITECTURE" <kernel@stlinux.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        "moderated list:ARM/OXNAS platform support" 
        <linux-oxnas@lists.tuxfamily.org>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
 <1495879129-28109-2-git-send-email-daniel.lezcano@linaro.org>
 <CACRpkdZbVv94hE9Gg+xiH2dxJANo-fPwLSek+BE4QwWWWWUixw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <376de2ec-c557-8541-9480-66472bd153a5@linaro.org>
Date:   Sun, 28 May 2017 16:20:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdZbVv94hE9Gg+xiH2dxJANo-fPwLSek+BE4QwWWWWUixw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 28/05/2017 15:48, Linus Walleij wrote:
> On Sat, May 27, 2017 at 11:58 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> 
>> The CLOCKSOUCE_OF_DECLARE macro is used widely for the timers to declare the
>> clocksource at early stage. However, this macro is also used to initialize
>> the clockevent if any, or the clockevent only.
>>
>> It was originally suggested to declare another macro to initialize a
>> clockevent, so in order to separate the two entities even they belong to the
>> same IP. This was not accepted because of the impact on the DT where splitting
>> a clocksource/clockevent definition does not make sense as it is a Linux
>> concept not a hardware description.
>>
>> On the other side, the clocksource has not interrupt declared while the
>> clockevent has, so it is easy from the driver to know if the description is
>> for a clockevent or a clocksource, IOW it could be implemented at the driver
>> level.
>>
>> So instead of dealing with a named clocksource macro, let's use a more generic
>> one: TIMER_OF_DECLARE.
>>
>> The patch has not functional changes.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>'
> 
> This makes the macro make sense and I had this idea one time too.
> Awesome.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Thanks Linus for reviewing the series.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
