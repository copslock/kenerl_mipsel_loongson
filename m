Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 May 2017 06:34:50 +0200 (CEST)
Received: from mail-pf0-x231.google.com ([IPv6:2607:f8b0:400e:c00::231]:33141
        "EHLO mail-pf0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992036AbdE2EenqkM46 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 May 2017 06:34:43 +0200
Received: by mail-pf0-x231.google.com with SMTP id e193so42405572pfh.0
        for <linux-mips@linux-mips.org>; Sun, 28 May 2017 21:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZyHKb+017KeqP8D8fZhefF0SDQcHj8k43BRlMZyfC08=;
        b=K4BqnHOmMm5lpB2Xt0pbKEhsl/jOgSp3kbL4/ocTa3vFX+JDtTOGG5e9TFyJ4LcCaz
         Q7Xtv6qjG8mFvTpMDwFOzVQ3O0k/onu3yY7C069+7yKbeMlbYwE4HWkYl5vPlMFZeRpH
         TdFKp4omr8AUSuoW7tMiX868vip4SqBdt70uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZyHKb+017KeqP8D8fZhefF0SDQcHj8k43BRlMZyfC08=;
        b=c6b2LLIeVyseYO8KaI8BDndmvgq0MhUuyYmVhi0MZaWoxvyvjCCNCw6sDs2V6JiX39
         EScSLXolV5uj0T1FTOIfluzzVKnqmgRZpTrJXYfpeXPDPi6quS9odz9BMLWyFK40TfRZ
         MfTYofkxYDoZ7Paw+GrQIqYJM8eEPmg2v5nka2ag/naID+KOsiGMjcpEKe8vKN9K4Ve0
         x99jVAO292M3c7YFO5oBbH6BpiVoqH0WaMlERumcxSB7v5bmQzWKabQvf8QuKjObSGry
         s8uhVIaxefVmuLS+jQVS2re6cGemZxW4sq9P33MDt8uNud5d9xqx3zkYV0Smawr75OF0
         rJgQ==
X-Gm-Message-State: AODbwcCFQKsRiucHDiCwMntS5ih7UMWmqInYcDvrOZWnbfN7ZcAkayem
        DHBVh6fK39/M/YgV
X-Received: by 10.98.16.215 with SMTP id 84mr15554888pfq.210.1496032477258;
        Sun, 28 May 2017 21:34:37 -0700 (PDT)
Received: from localhost ([122.172.209.220])
        by smtp.gmail.com with ESMTPSA id b24sm16383301pfm.17.2017.05.28.21.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 May 2017 21:34:36 -0700 (PDT)
Date:   Mon, 29 May 2017 10:04:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
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
        Noam Camus <noamc@ezchip.com>, Rob Herring <robh@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Paul Burton <paul.burton@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Eric Anholt <eric@anholt.net>, Ray Jui <ray.jui@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:OMAP2+ SUPPORT" <linux-omap@vger.kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        "open list:ARM/SHMOBILE ARM ARCHITECTURE" 
        <linux-renesas-soc@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH 3/7] clocksource: Rename clocksource_probe
Message-ID: <20170529043434.GB5752@vireshk-i7>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
 <1495879129-28109-3-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495879129-28109-3-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

On 27-05-17, 11:58, Daniel Lezcano wrote:
>  arch/arm/mach-spear/spear13xx.c          |  2 +-

> diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
> index ca2f6a8..31c43ca 100644
> --- a/arch/arm/mach-spear/spear13xx.c
> +++ b/arch/arm/mach-spear/spear13xx.c
> @@ -124,5 +124,5 @@ void __init spear13xx_timer_init(void)
>  	clk_put(pclk);
>  
>  	spear_setup_of_timer();
> -	clocksource_probe();
> +	timer_probe();
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
