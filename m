Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Sep 2016 09:45:32 +0200 (CEST)
Received: from conssluserg-04.nifty.com ([210.131.2.83]:58791 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991960AbcIPHpXGOOo6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Sep 2016 09:45:23 +0200
Received: from mail-yw0-f175.google.com (mail-yw0-f175.google.com [209.85.161.175]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id u8G7iprX024075;
        Fri, 16 Sep 2016 16:44:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com u8G7iprX024075
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1474011892;
        bh=dz0/BvCzbclI4ctFJusiqWJqXhrmh2nxRNAAwVHpUKY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=yb3hftKQYmrMtnb0iqo8+3eJoD3dh9j8L3QOQcgbVffIBQg0XZwQ0JZXKtECEDJuB
         9cM7z/Ua4CJpAF2HHOaS0ARgtscWdH9WPE1hojoKk/Rql5r8b1UYrRDaJ1N7yF9du1
         IwdQ7rB2yjDlWs5HnMHYMzTIr2uPttNvfVTR/m5VnprXeI9I5RU/iEmPG8xk74Xs0+
         WKTrbgUSqZdnw1I+XC+TL4p47N4KgpBsqIUBMzIUesFddlaZraUWxxvRoVp5y2sJZ8
         s0GqJQH4QCrujrPtpUsHbkf5sLX3jjruvUrQsLrzOH+/b6EyH0C85DMvYh0zBTZ3/Q
         PHZNWZ7yvA5iw==
X-Nifty-SrcIP: [209.85.161.175]
Received: by mail-yw0-f175.google.com with SMTP id u82so77922691ywc.2;
        Fri, 16 Sep 2016 00:44:51 -0700 (PDT)
X-Gm-Message-State: AE9vXwPec6PwO9ld9CH/tqjAui4AZtv1iqxSFSOLFJZhyIUS7kqsBLlAlwCJP9KCRMYFoR/ZWSuUvnuOvU8edw==
X-Received: by 10.129.179.135 with SMTP id r129mr12485215ywh.156.1474011890913;
 Fri, 16 Sep 2016 00:44:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.49.137 with HTTP; Fri, 16 Sep 2016 00:44:50 -0700 (PDT)
In-Reply-To: <194aebe5-38dd-f43d-fb4d-16ce592a68e8@gmail.com>
References: <1472059613-30551-1-git-send-email-yamada.masahiro@socionext.com> <194aebe5-38dd-f43d-fb4d-16ce592a68e8@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 16 Sep 2016 16:44:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNARaV6Ga5G1GnYf9hywrr+YwOqqm-v1AzBpfXtM4u9ofBA@mail.gmail.com>
Message-ID: <CAK7LNARaV6Ga5G1GnYf9hywrr+YwOqqm-v1AzBpfXtM4u9ofBA@mail.gmail.com>
Subject: Re: [PATCH v3] clk: let clk_disable() return immediately if clk is NULL
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>, linux-mips@linux-mips.org,
        Eric Miao <eric.y.miao@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Steven Miao <realmz6@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55147
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

Hi Stephen, Michael,

2016-08-26 0:27 GMT+09:00 Florian Fainelli <f.fainelli@gmail.com>:
> On 08/24/2016 10:26 AM, Masahiro Yamada wrote:
>> Many of clk_disable() implementations just return for NULL pointer,
>> but this check is missing from some.  Let's make it tree-wide
>> consistent.  It will allow clock consumers to call clk_disable()
>> without NULL pointer check.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Acked-by: Greg Ungerer <gerg@uclinux.org>
>> Acked-by: Wan Zongshun <mcuos.com@gmail.com>
>> ---
>>
>> I came back after a long pause.
>> You can see the discussion about the previous version:
>> https://www.linux-mips.org/archives/linux-mips/2016-04/msg00063.html
>>
>>
>> Changes in v3:
>>   - Return only when clk is NULL.  Do not take care of error pointer.
>>
>> Changes in v2:
>>   - Rebase on Linux 4.6-rc1
>>
>>  arch/arm/mach-mmp/clock.c        | 3 +++
>>  arch/arm/mach-w90x900/clock.c    | 3 +++
>>  arch/blackfin/mach-bf609/clock.c | 3 +++
>>  arch/m68k/coldfire/clk.c         | 4 ++++
>>  arch/mips/bcm63xx/clk.c          | 3 +++
>


Gentle ping...


If you are not keen on this,
shall I split it per-arch and send to each arch subsystem?



-- 
Best Regards
Masahiro Yamada
