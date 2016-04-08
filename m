Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2016 13:15:30 +0200 (CEST)
Received: from conssluserg-01.nifty.com ([210.131.2.80]:47649 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006842AbcDHLPZQ-cV9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Apr 2016 13:15:25 +0200
Received: from mail-yw0-f172.google.com (mail-yw0-f172.google.com [209.85.161.172]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id u38BF5CW026196;
        Fri, 8 Apr 2016 20:15:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com u38BF5CW026196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1460114106;
        bh=7iYfkuzhBj5PVuJ7KDovykWQ07dY9hb0lwZdlH1S49c=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc:From;
        b=Nxk54R49VfIU/c9Xm0EpJVXQNMjzs0THuKKm/D8kqVso57xCnbtG29ARfktpA8fUA
         KZDR5MrwM55SIenxfHwAnyfb/ISMN5gR6Q1UPSZG8YSMTOR/b3cS70J2eObkFfSecJ
         kukys4mEmsgcHyfxyKXF0AxtmFknpLrvyHI53l/DWIh6R0F6HVX8koi7a/8M2cPC6B
         rLWYlkP1abbRJeUxOfc3sTo1vb37MhwJYPRNPXfBD76R5NELsP+HRQ1ZuQQi9DBOuQ
         OrTKn22cxg4J+KgL6BAyzcujwpR5rYMjecyGUS9vwGNjX/B0yTUM28TLhedXrUk5eD
         P9ueRATZLbppQ==
X-Nifty-SrcIP: [209.85.161.172]
Received: by mail-yw0-f172.google.com with SMTP id i84so124364782ywc.2;
        Fri, 08 Apr 2016 04:15:06 -0700 (PDT)
X-Gm-Message-State: AD7BkJJMHAKQjbhKMA+712ewEhS2hHKR32shwULCzf4YW89uBcl3V4CM0FCUgYwzZaKW6J4uAUqPejPFD7w6gQ==
MIME-Version: 1.0
X-Received: by 10.129.120.8 with SMTP id t8mr4125162ywc.204.1460114105305;
 Fri, 08 Apr 2016 04:15:05 -0700 (PDT)
Received: by 10.37.118.2 with HTTP; Fri, 8 Apr 2016 04:15:05 -0700 (PDT)
In-Reply-To: <20160408100600.GI1668@linux-mips.org>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
        <20160408003328.GA14441@codeaurora.org>
        <20160408100600.GI1668@linux-mips.org>
Date:   Fri, 8 Apr 2016 20:15:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNASmvJfmFKVLWpQ8GZYKs6ntSk1Lae-witX=1hDGotQV_Q@mail.gmail.com>
Message-ID: <CAK7LNASmvJfmFKVLWpQ8GZYKs6ntSk1Lae-witX=1hDGotQV_Q@mail.gmail.com>
Subject: Re: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Greg Ungerer <gerg@uclinux.org>,
        linux-clk@vger.kernel.org,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Kevin Hilman <khilman@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Steven Miao <realmz6@gmail.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Simon Horman <horms@verge.net.au>, linux-omap@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        John Crispin <blogic@openwrt.org>,
        Paul Walmsley <paul@pwsan.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Ryan Mallon <rmallon@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52931
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

2016-04-08 19:06 GMT+09:00 Ralf Baechle <ralf@linux-mips.org>:
> On Thu, Apr 07, 2016 at 05:33:28PM -0700, Stephen Boyd wrote:
>
>> On 04/05, Masahiro Yamada wrote:
>> > The clk_disable() in the common clock framework (drivers/clk/clk.c)
>> > returns immediately if a given clk is NULL or an error pointer.  It
>> > allows clock consumers to call clk_disable() without IS_ERR_OR_NULL
>> > checking if drivers are only used with the common clock framework.
>> >
>> > Unfortunately, NULL/error checking is missing from some of non-common
>> > clk_disable() implementations.  This prevents us from completely
>> > dropping NULL/error checking from callers.  Let's make it tree-wide
>> > consistent by adding IS_ERR_OR_NULL(clk) to all callees.
>> >
>> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > Acked-by: Greg Ungerer <gerg@uclinux.org>
>> > Acked-by: Wan Zongshun <mcuos.com@gmail.com>
>> > ---
>> >
>> > Stephen,
>> >
>> > This patch has been unapplied for a long time.
>> >
>> > Please let me know if there is something wrong with this patch.
>> >
>>
>> I'm mostly confused why we wouldn't want to encourage people to
>> call clk_disable or unprepare on a clk that's an error pointer.
>> Typically an error pointer should be dealt with, instead of
>> silently ignored, so why wasn't it dealt with by passing it up
>> the probe() path?
>
> While your argument makes perfect sense, Many clk_disable implementations
> are already doing similar checks, for example:
>
> arch/arm/mach-davinci/clock.c:
>
> void clk_disable(struct clk *clk)
> {
>         unsigned long flags;
>
>         if (clk == NULL || IS_ERR(clk))
>                 return;
> [...]
>
> arch/arm/mach-omap1/clock.c
>
> void clk_disable(struct clk *clk)
> {
>         unsigned long flags;
>
>         if (clk == NULL || IS_ERR(clk))
>                 return;
> [...]
>
> arch/avr32/mach-at32ap/clock.c
>
> void clk_disable(struct clk *clk)
> {
>         unsigned long flags;
>
>         if (IS_ERR_OR_NULL(clk))
>                 return;
> [...]
>
> arch/mips/lantiq/clk.c:
>
> static inline int clk_good(struct clk *clk)
> {
>         return clk && !IS_ERR(clk);
> }
>
> [...]
>
> void clk_disable(struct clk *clk)
> {
>         if (unlikely(!clk_good(clk)))
>                 return;
>
>         if (clk->disable)
> [...]
>
> So should we go and weed out these checks?
>
>   Ralf


Please help me understand your thought clearly.

[1] Should calling clk_unprepare/disable() with a NULL pointer be allowed?

[2] Should calling clk_unprepare/disable() with an error pointer be allowed?


-- 
Best Regards
Masahiro Yamada
