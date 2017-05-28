Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 May 2017 15:49:54 +0200 (CEST)
Received: from mail-it0-x233.google.com ([IPv6:2607:f8b0:4001:c0b::233]:38813
        "EHLO mail-it0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993935AbdE1NtptvQcB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 May 2017 15:49:45 +0200
Received: by mail-it0-x233.google.com with SMTP id r63so16199081itc.1
        for <linux-mips@linux-mips.org>; Sun, 28 May 2017 06:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EqLKToHiKS9899Y7CBDnpPUg/QULDq9jB+CAp+ZJlLc=;
        b=QauAQQ+2GYx8AUnvJuO+tjygQk4uHOfPEW/ZHBNs4nOvroVbEb2BwweZAgUKfTudkQ
         Y4sOgFpqL0a5vD9jYjWBOdBWRia2tXXMo7pf5t+cUVNCIxOqG3g6DJTMdSaxEsBHuZpe
         eTW3mV6s2dx7jLpQWVz927Z7c1bojM0PDREXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EqLKToHiKS9899Y7CBDnpPUg/QULDq9jB+CAp+ZJlLc=;
        b=JooyW3pjyu1wNp9mo6kzyxwOVvVc584MV/MJ3neCo0x32+MkYIPgZZNvzYBIsQ0I1X
         9H5OC/uC8Nq0v8SFWXwwOIJkBAp79KE8Wzx54eAqHCWRUW61mclAY4XkYFW1RGugCrvI
         k2rER4gN1+X5ilWDoisQIF/NQVhl7rBIgxNWzYRWQD44Giwzrbk3owG9VritZDzEeWDT
         w9uy9FEfKQ2sEDEd6srTM6eR4nxxuiHuXxj+gGeSUeXady75dc0XL33tCHx8pGmwS619
         ASODlhwT0j3ZNeDGHWL6/MMSizYBXs9A2W9gfWWbUKXyUq0Pkp49W3iMGp8ixoCWXpNs
         xJyw==
X-Gm-Message-State: AODbwcDAXPmfiIC1zy1zccJGkrHEGkEV0yVZhCk712epNzGpXDMGhVnR
        awNZjjVEmQvBQ8X5Ts8mRnEQaLls7AkQ
X-Received: by 10.36.43.146 with SMTP id h140mr11952674ita.7.1495979379812;
 Sun, 28 May 2017 06:49:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.154.7 with HTTP; Sun, 28 May 2017 06:49:38 -0700 (PDT)
In-Reply-To: <1495879129-28109-3-git-send-email-daniel.lezcano@linaro.org>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org> <1495879129-28109-3-git-send-email-daniel.lezcano@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 28 May 2017 15:49:38 +0200
Message-ID: <CACRpkdZGUkcpE97cQ6a=tk-UZZf6j4MwRh+xq9L0LzuaGNaUKQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] clocksource: Rename clocksource_probe
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
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
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
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
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58036
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

On Sat, May 27, 2017 at 11:58 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> The function name is now renamed to 'timer_probe' for consistency with
> the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
