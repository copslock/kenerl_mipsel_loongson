Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2016 22:13:03 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34279 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014294AbcFXUNBTDiWf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jun 2016 22:13:01 +0200
Received: by mail-wm0-f68.google.com with SMTP id 187so7909940wmz.1;
        Fri, 24 Jun 2016 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WLhWrBka5NMewTtWDoNN90cJEHjYyvV4kFPJfIKpDfc=;
        b=snqXcMDFothogKI6pb3K4XeAYkgkBtzlL8tuGzNOn1DoKfUVuKpSF2MK877YAK8Smi
         HACDTc+vCTNBlTb1MXI/sNhYGwZd7UdXw0JIUACC1uB8Ltg9WV8q44wk9UZDGUNzHeBq
         Pksn0ZX44MPT7qFc3jQFzXeGn6JVwUNJ6U4YUsP79Ju6XlRUIYO/+zVwnBmXrtPVkZ6d
         XKJOS+CTWmSl1oJglDZcYY4IZa9cg/R8d2uTBND8Zndb3dD3+CVvEXhguUTa0sVtN5HW
         nvvUsfEcGRK2Bs79ViTJNMhMjDA0V2QE63TiRsNtIrRNbzHf+l2wnwW/qmCmfCtzvCDQ
         ueYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WLhWrBka5NMewTtWDoNN90cJEHjYyvV4kFPJfIKpDfc=;
        b=Y6eITFrVq8em9TWuNBUjl9pQVgkLbdKOHweF2QyvA+s+fSIL28GNdTRcQ+rt8Ik6be
         /MFWjLwOdxf8UOfH0oVLSIYSHOHUfjJj4ENnDVXL8Men1tQwZ/QfITfsqCl+s60N82r5
         LT+AaokODDxabPYTQWeizZxCpVXZWhIEPNrQbdI29miekdiXJA1oHXnAtx/RUwlyAAoT
         QWOjlyOCFxTwhwS+Wl4r59168rKO1RSY1EM+pYr7+6QVypBzwKPw+j78opa1b3i6sewn
         3321k7VNnajZadQN6t2nKuRrZhsk2XFg7o9Adi0h0BR8Y4MhI9vqk6LtgxZDpvV84gPF
         +f0g==
X-Gm-Message-State: ALyK8tLnEp9Wy/czETmJfRi8wdWYVZEIifS3pj7kXD4VFLrFnWDe5InuZfnykyJyq0IJMg==
X-Received: by 10.28.68.85 with SMTP id r82mr856wma.18.1466799176016;
        Fri, 24 Jun 2016 13:12:56 -0700 (PDT)
Received: from localhost (2-238-57-164.ip242.fastwebnet.it. [2.238.57.164])
        by smtp.gmail.com with ESMTPSA id i74sm4620176wmg.21.2016.06.24.13.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2016 13:12:54 -0700 (PDT)
Date:   Fri, 24 Jun 2016 22:12:52 +0200
From:   Carlo Caione <carlo@caione.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ley Foon Tan <lftan@altera.com>,
        Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
        Maxime Coquelin <maxime.coquelin@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Kevin Hilman <khilman@baylibre.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <kernel@pengutronix.de>,
        Joachim Eastwood <manabian@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Noam Camus <noamc@ezchip.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@ti.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "open list:SYNOPSYS ARC ARCH..." <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:RALINK MIPS ARCHI..." <linux-mips@linux-mips.org>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>,
        "open list:ARM/STI ARCHITECTURE" <kernel@stlinux.com>,
        "moderated list:BROADCOM BCM2835..." 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:BROADCOM BCM281XX..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:ARM/SAMSUNG EXYNO..." 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:TEGRA ARCHITECTUR..." <linux-tegra@vger.kernel.org>,
        "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>
Subject: Re: [PATCH V2 63/63] clocksources: Switch back to the clksrc table
Message-ID: <20160624201252.GA2382@localhost>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <carlo.caione@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carlo@caione.org
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

On 16/06/16 23:27, Daniel Lezcano wrote:
> All the clocksource drivers's init function are now converted to return
> an error code. CLOCKSOURCE_OF_DECLARE is no longer used as well as the
> clksrc-of table.
> 
> Let's convert back the names:
>  - CLOCKSOURCE_OF_DECLARE_RET => CLOCKSOURCE_OF_DECLARE
>  - clksrc-of-ret              => clksrc-of
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/meson6_timer.c        |  2 +-

Acked-by: Carlo Caione <carlo@caione.org>
