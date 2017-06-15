Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2017 18:02:18 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:33428
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994780AbdFOQCKY02Ix (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jun 2017 18:02:10 +0200
Received: by mail-wm0-x242.google.com with SMTP id f90so620741wmh.0;
        Thu, 15 Jun 2017 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SmVgIARh1dK7QxCwgkT6u2Mk86zhhjO2n29HXGF3d2w=;
        b=FV0IlckV07tDs0yGoVNs0b1a/50pzQk8p6UKfnkk3h6kqWNN3lM7RGQA47P26dDly+
         L0/W4DVSE5Xt9/77Sdohr3IlLG0yszMjN9nvmyTRJF4IaOG0YiKXs2erj+/ketCScRUe
         Puwi4Yg7vJWO8PCyCfYDymxvu+NP8KAqR9GkqZtsVJvrwYZzJhGw6nYyYuMoGfESYHsp
         XQ9iyjJtKcUzqWLOfabZliMurTcqdLa3VRUIgPaQ4K81P0gl8UtntBRHJKLIAOiTsfSW
         z+DgyX2n2+HMnIra5tZctRRp8R+LSZUrGphltPKCiIXv7obd3rdQ69X/3kEQOydBNg8g
         GlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SmVgIARh1dK7QxCwgkT6u2Mk86zhhjO2n29HXGF3d2w=;
        b=hvPbWrs8DrpqKzqgvM9TQ8bV9PfN2F4RqNdOCT2c2pz+siqvHdkyRYJfiUcl8XS2Uy
         xfNiiSwj0NJ/zplTb4A3pTmEGhiWJMeRChbo/J6+sdyNLrUjrVSURiM7UnRFnT/+kcWi
         omHtg3Oh2wOHKxchnmLc4VcuXotwqyDQzEehb/uNWxjWwkGpW51sUW3zyCHYLrH2rTQj
         ehNhSQvbME71xH07M0l2lmKPdTTN0y6OxTd82bhMRdQyFONZZY8ic8bujzCsK7NYlYsl
         D4Hh++m/LT/7ll+atIuE9dJqoI78iZYkdl1m/o1afW4D0rTqifxHc0wFbq+14QsoNiyl
         ZqBg==
X-Gm-Message-State: AKS2vOyoUhZLnV9G84rE1mbM+oE809zSGcp+qhf6EESlC4PIz/4AU2oR
        Ih+hfC+vdZKn2g==
X-Received: by 10.28.19.11 with SMTP id 11mr4148389wmt.123.1497542524193;
        Thu, 15 Jun 2017 09:02:04 -0700 (PDT)
Received: from linux-gy6r.site (214.10.133.37.dynamic.jazztel.es. [37.133.10.214])
        by smtp.gmail.com with ESMTPSA id f15sm526703wmf.22.2017.06.15.09.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 09:02:03 -0700 (PDT)
Subject: Re: [PATCH 13/23] clocksource/drivers: Rename clocksource_probe to
 timer_probe
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hartley <james.hartley@imgtec.com>,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        John Crispin <john@phrozen.org>,
        Ley Foon Tan <lftan@altera.com>,
        Rich Felker <dalias@libc.org>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Vlad Zakharov <Vladislav.Zakharov@synopsys.com>,
        Rob Herring <robh@kernel.org>, Noam Camus <noamc@ezchip.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        "open list:SYNOPSYS ARC ARCH..." <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        "open list:OMAP2+ SUPPORT" <linux-omap@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:ARM/SHMOBILE ARM..." <linux-renesas-soc@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:TENSILICA XTENSA..." <linux-xtensa@linux-xtensa.org>
References: <20170614123800.GH2261@mai>
 <1497443984-12371-1-git-send-email-daniel.lezcano@linaro.org>
 <1497443984-12371-13-git-send-email-daniel.lezcano@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a6614bcf-5552-b168-eee9-a1d604673494@gmail.com>
Date:   Thu, 15 Jun 2017 18:02:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1497443984-12371-13-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <matthias.bgg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58473
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



On 14/06/17 14:39, Daniel Lezcano wrote:
> The function name is now renamed to 'timer_probe' for consistency with
> the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
[...]
> diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
> index a6e3c98..c3cf215 100644
> --- a/arch/arm/mach-mediatek/mediatek.c
> +++ b/arch/arm/mach-mediatek/mediatek.c
> @@ -41,7 +41,7 @@ static void __init mediatek_timer_init(void)
>   	}
>   
>   	of_clk_init(NULL);
> -	clocksource_probe();
> +	timer_probe();
>   };

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
