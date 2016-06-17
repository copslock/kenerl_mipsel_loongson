Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 18:18:24 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33341 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042843AbcFQQSW1Z1hf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jun 2016 18:18:22 +0200
Received: by mail-wm0-f67.google.com with SMTP id r201so886386wme.0;
        Fri, 17 Jun 2016 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=pMF1zOcDZObNBV5lgFc70xacYxiVklvA3TchBoJYH1k=;
        b=YhBXMQjU4RM+XkX0a/KVrGvt+brlYvmSBseUevj+LhY6/CWxZqWw0xRtBvskkW/mrm
         K4pKeGP58qsejAHwgyCMr9W4du+OyvPegMSFxGnNmblZZQ/dyJaqP61ZHdVBi+AMXZ7C
         vAE6JXcVBjCuPtw5EF/e7foCsuQpPfnQq6/1/mlsL4ToQm6f3GzG2D3aCIr2L6MXp2vW
         LAp+JChn21Z3701gICSB7iJwy5R4wbVP6oqTpEU8wRXP+B86Pvxyh/3YWzBb9D3KWkPX
         bFB3bYm+o7Sfko3dOX2k80y+/RkUQvBIiF2oOt5RsH+PdJBO6g9/liB4kg13tjEivi/m
         +FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=pMF1zOcDZObNBV5lgFc70xacYxiVklvA3TchBoJYH1k=;
        b=XhEN6JxGANPmg3JAd4IYSgc0DYHo+I20S0YJYT4Y8oMKu1R7T4szXlahO5TAo7PKKK
         Cyy2de+b49RVUxC96bbmoyNv7nYZ4xBlaYGF6xmvJv4DrsAKS05nXqYo+NGYIqc1IwIZ
         ON54aDULAnQH64fEwl1TAUfH7RI4osZgg5HEqiMSXGKqEYvAZHpLNOMq8uIifjmjc3jD
         PYhg1+VgIyojhTUNjnJaB2TuYHlcEI9FTm9TQlaq4NPDx1GOl5z/w67d2/DZpnhfj75M
         bhhd4e7+0kjgKgmG3MxOwNHyko5zX7rHYJtjJH7F1HIKlucfB4ZVQWh0rVEmjbjgF9f2
         01VQ==
X-Gm-Message-State: ALyK8tL5iFkSqP+IlO2uO6fhVAxw7t8zzErg6MJPGVQWRUnJMYBZbHU2PEi3v3T8lECp+w==
X-Received: by 10.194.80.70 with SMTP id p6mr3022104wjx.45.1466180297122;
        Fri, 17 Jun 2016 09:18:17 -0700 (PDT)
Received: from linux-gy6r.site (0.red-83-38-219.dynamicip.rima-tde.net. [83.38.219.0])
        by smtp.gmail.com with ESMTPSA id x10sm35893666wjj.14.2016.06.17.09.18.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Jun 2016 09:18:16 -0700 (PDT)
Subject: Re: [PATCH V2 63/63] clocksources: Switch back to the clksrc table
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
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
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
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
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <576422C4.2000104@gmail.com>
Date:   Fri, 17 Jun 2016 18:18:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <matthias.bgg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthias.bgg@gmail.com
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
>   - CLOCKSOURCE_OF_DECLARE_RET => CLOCKSOURCE_OF_DECLARE
>   - clksrc-of-ret              => clksrc-of
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   arch/arc/kernel/time.c                    |  6 +++---

[...]

>   drivers/clocksource/mtk_timer.c           |  2 +-

For mediatek driver:
Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
