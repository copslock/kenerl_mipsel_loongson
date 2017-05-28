Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 May 2017 11:18:57 +0200 (CEST)
Received: from mail-wr0-x236.google.com ([IPv6:2a00:1450:400c:c0c::236]:36420
        "EHLO mail-wr0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992100AbdE1JSuBpJRN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 May 2017 11:18:50 +0200
Received: by mail-wr0-x236.google.com with SMTP id l50so21024656wrc.3
        for <linux-mips@linux-mips.org>; Sun, 28 May 2017 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yv2IObl3ZI7jMzDsPZhHPAquQoLgFH8qT4uQTb1RsX8=;
        b=U8TAJmgSwegsadtZsi8ZQYpisiJqbLs6T1IhgBmltacg7ln6CsbN301oKBLnQlH+nY
         StgeAotA9ZPJyeySp/nK9Vfwh98M1fWpn8MTucYPzc6OPaKn6j+WcRlNriUFAf5hSXUV
         v5uHlp9+XZnrTvyB6b53sQfuU6LeLFU04S3wQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yv2IObl3ZI7jMzDsPZhHPAquQoLgFH8qT4uQTb1RsX8=;
        b=U9d9dftRMHsgNi+yPqBPWeOxqvo7huK8mhMyBX40NiWjRaPh81oj9saKv7vNH/nq+m
         DV8V7afBb525dypKsXzyJol5L41m0Veb88472gRxx0xbYgArbq22lKGp+xqQ/9a8SrRI
         9QGuGRoyDEFH/l0yfti/Rzb6Ktwu62psIPBBwUvXmmm7rHpDT0ygTtstTBpLDtV9+3JS
         7VAjO3XuWoAf8xsuVimNzD1Q/vFFwMz84neeul5AwjXJIKbHRT4nskSeBZbGZfZwL7Te
         LQwj0YeP8ZZGW+W9tUkELNL1N1xr739J+ND5RaXLP93S5sAKKRvbRVt556K0B8LPXZT9
         xYQA==
X-Gm-Message-State: AODbwcD+y7StUsjT39Bk0p76tM0FWnDcFfbmulcoc02vnz+SZWrp8tiu
        Snj+S/wwYiMitRCK
X-Received: by 10.223.164.65 with SMTP id e1mr6630001wra.21.1495963123529;
        Sun, 28 May 2017 02:18:43 -0700 (PDT)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id d16sm4066577wra.16.2017.05.28.02.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 May 2017 02:18:42 -0700 (PDT)
Subject: Re: [PATCH 6/7] clocksource: Rename CLKSRC_OF to TIMER_OF
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ley Foon Tan <lftan@altera.com>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
 <1495879129-28109-6-git-send-email-daniel.lezcano@linaro.org>
 <20170528030058.GC4528@dragon>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3bea2d43-e582-5b62-03df-3557028cc4b8@linaro.org>
Date:   Sun, 28 May 2017 11:18:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170528030058.GC4528@dragon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58034
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

On 28/05/2017 05:00, Shawn Guo wrote:
> On Sat, May 27, 2017 at 11:58:47AM +0200, Daniel Lezcano wrote:
>> diff --git a/arch/arm/mach-imx/epit.c b/arch/arm/mach-imx/epit.c
>> index fb9a73a..4a4d2e2 100644
>> --- a/arch/arm/mach-imx/epit.c
>> +++ b/arch/arm/mach-imx/epit.c
>> @@ -39,7 +39,7 @@
>>  #define EPITCR_OM_TOGGLE		(1 << 22)
>>  #define EPITCR_OM_CLEAR			(2 << 22)
>>  #define EPITCR_OM_SET			(3 << 22)
>> -#define EPITCR_CLKSRC_OFF		(0 << 24)
>> +#define EPITCR_TIMER_OFF		(0 << 24)
>>  #define EPITCR_CLKSRC_PERIPHERAL	(1 << 24)
>>  #define EPITCR_CLKSRC_REF_HIGH		(1 << 24)
>>  #define EPITCR_CLKSRC_REF_LOW		(3 << 24)
> 
> I do not think this change should be there.

Right. Thanks!


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
