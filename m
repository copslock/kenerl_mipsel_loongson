Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2016 03:50:17 +0200 (CEST)
Received: from conssluserg-02.nifty.com ([210.131.2.81]:62711 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026541AbcDNBuPK0GWt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Apr 2016 03:50:15 +0200
Received: from mail-yw0-f173.google.com (mail-yw0-f173.google.com [209.85.161.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id u3E1ni4Q020948;
        Thu, 14 Apr 2016 10:49:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com u3E1ni4Q020948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1460598585;
        bh=UvXR8Gro0quIwPR20LPENhM1ih/dIwj6iGWtUs7VRDE=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc:From;
        b=g9q5gz3Jb0JbrduWSLchpTHBZHQQ1K9PdjBYmvTN0IE9Z43nRCArTGtxjOOs2sQHY
         /5slMZf7Qi3xQ3RI3vXOo/T0nwNhF3kK48Tev1u8R4YpQwzUEB0tNVeOdWI8hsy5zW
         N5jZ54sH5TkR0qTDQexhYRZR5V0v8NrQuHMCAQgiGd1qntQQhWDGzhpNPQtm/v77qH
         uixiSkWqkzTXA+JHx/4NTML6Q+Gb2mfT34VFTplmiOR8C/D7EgoE+nw+danT5Qq/i6
         sjPiEB4Wr+OdX2yutNMboYv4Kxi3zOE8RbMPQBtwxOO4gnNxEI1S9B2Gn8RsLq4xrr
         aCErlXLTSpcgQ==
X-Nifty-SrcIP: [209.85.161.173]
Received: by mail-yw0-f173.google.com with SMTP id i84so90018416ywc.2;
        Wed, 13 Apr 2016 18:49:44 -0700 (PDT)
X-Gm-Message-State: AOPr4FWc6wY+BIjuegIpBHVSXv3sL5WlfC0dbuWyjTmFJlfk5kWlgyqTTa6FPWXSPo6Wbi9zYLn47FOoclr6VA==
MIME-Version: 1.0
X-Received: by 10.37.13.138 with SMTP id 132mr6500005ybn.163.1460598583733;
 Wed, 13 Apr 2016 18:49:43 -0700 (PDT)
Received: by 10.37.118.79 with HTTP; Wed, 13 Apr 2016 18:49:43 -0700 (PDT)
In-Reply-To: <20160414003341.GH14441@codeaurora.org>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
        <20160408003328.GA14441@codeaurora.org>
        <CAK7LNASW+D0B_k97r__AZeYDR5UqNPqn_j1aoQepHz-bGgV2ng@mail.gmail.com>
        <20160414003341.GH14441@codeaurora.org>
Date:   Thu, 14 Apr 2016 10:49:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbzRLq_NGWJ8CFBBf6w4cVGCNh45fo6JO=+F7FACBSxA@mail.gmail.com>
Message-ID: <CAK7LNARbzRLq_NGWJ8CFBBf6w4cVGCNh45fo6JO=+F7FACBSxA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
        linux-sh@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Greg Ungerer <gerg@uclinux.org>, linux-clk@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Steven Miao <realmz6@gmail.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-m68k@lists.linux-m68k.org, Simon Horman <horms@verge.net.au>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        John Crispin <blogic@openwrt.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Ryan Mallon <rmallon@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-renesas-soc@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52976
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

Hi Stephen,


2016-04-14 9:33 GMT+09:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 04/08, Masahiro Yamada wrote:
>>
>>
>> This makes our driver programming life easier.
>>
>>
>> For example, let's see drivers/tty/serial/8250/8250_of.c
>>
>>
>> The "clock-frequency" DT property takes precedence over "clocks" property.
>> So, it is valid to probe the driver with a NULL pointer for info->clk.
>>
>>
>>         if (of_property_read_u32(np, "clock-frequency", &clk)) {
>>
>>                 /* Get clk rate through clk driver if present */
>>                 info->clk = devm_clk_get(&ofdev->dev, NULL);
>>                 if (IS_ERR(info->clk)) {
>>                         dev_warn(&ofdev->dev,
>>                                 "clk or clock-frequency not defined\n");
>>                         return PTR_ERR(info->clk);
>>                 }
>>
>>                 ret = clk_prepare_enable(info->clk);
>>                 if (ret < 0)
>>                         return ret;
>>
>>                 clk = clk_get_rate(info->clk);
>>         }
>>
>>
>> As a result, we need to make sure the clk pointer is valid
>> before calling clk_disable_unprepare().
>>
>>
>> If we could support pointer checking in callees, we would be able to
>> clean-up lots of clock consumers.
>>
>>
>
> I'm not sure if you meant to use that example for the error
> pointer case? It bails out if clk_get() returns an error pointer.
>
> I'm all for a no-op in clk_disable()/unprepare() when the pointer
> is NULL. But when it's an error pointer the driver should be
> handling it and bail out before it would ever call enable/prepare
> on it or disable/unprepare.



Let me explain my original idea.

We do various initialization in a probe method,
so we (OK, I) sometimes want to split init code
into some helper function(s) like this:


static int foo_clk_init(struct platform_device *pdev,
                        struct foo_priv *priv)
{
        int ret;

        priv->clk = devm_clk_get(&pdev->dev, NULL);     /* case 1 */
        if (IS_ERR(priv->clk)) {
                 dev_err(&pdev->dev, "falied to get clk\n");
                 return PTR_ERR(priv->clk);
        }

        ret = clk_prepare_enable(priv->clk);          /* case 2 */
        if (ret < 0) {
                 dev_err(&pdev->dev, "falied to enable clk\n");
                 return ret;
        }

        priv->clk_rate = clk_get_rate(priv->clk);    /* case 3 */
        if (!priv->clk_rate) {
                  dev_err(&pdev->dev, "clk rate should not be zero\n");
                  return -EINVAL;
        }


        [ do something ]

        return 0;
}


static int foo_probe(struct platform_device *pdev)
{
        [memory allocation, OF parse, various init.... ]

        ret = foo_clk_init(pdev, priv);
        if (ret < 0)
                goto err;

        ret = foo_blahblah_init(pdev, priv)          /* case 4 */
        ir (ret < 0)
                goto err;

        [  more initialization ... ]

        return 0;
err:
        clk_disable_unprepare(priv->clk);

        return ret;
}


There are some failure paths in this example.

 [1] If case 1 fails, priv->clk contains an error pointer.
     We should not do clk_disable_unprepare().
 [2] If case 2 fails, priv->clk contains a valid pointer,
     but we should not do clk_disable_unprepare().
 [3] If case 3 fails, priv->clk contains a valid pointer,
     and we should do clk_disable_unprepare().
 [4] If case 4 fails, priv->clk contains a valid pointer,
     and we should do clk_disable_unprepare().


My difficulty is that [1]-[3] are contained in one helper function.
(A real example is drivers/i2c/busses/i2c-uniphier.c)


If foo_clk_init() fails for reason [1],
I want clk_disable_unprepare() to just return.
(This is my original intention of this patch.)

If foo_clk_init() fails for reason [3],
I want clk_disable_unprepare() to do its job.


OK, now I notice another problem in my code;
if foo_clk_init() fails for reason [2],
clk_disable() WARN's due to zero enable_count.

if (WARN_ON(core->enable_count == 0))
         return;



Perhaps, I got screwed up by splitting clock init stuff
into a helper function.



-- 
Best Regards
Masahiro Yamada
