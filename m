Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2016 10:46:37 +0200 (CEST)
Received: from mail-io0-f195.google.com ([209.85.223.195]:35737 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991977AbcHVIqbTqzkh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Aug 2016 10:46:31 +0200
Received: by mail-io0-f195.google.com with SMTP id q83so8495482iod.2;
        Mon, 22 Aug 2016 01:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=A6oerL0JPTGclWtRWXfc+NzZNOHWWJG0mmxObNrpvTo=;
        b=gLsyBuNo1OgI97iDkIQM1+CeO2bc+nSUSEQT+6G/AQ1mSlkDWCC4E4/F9plyjkNYLC
         OQb5VdLLdP/wDX2OHNVmNQA/KBceZ1/FXMIDPa7vzAntPYkbzob/HVxZzXkWnkLz/q0s
         3if0FwZlVhVlQpBr2Y/IuhM4fU2U06xUlW20hiCGB5W1rlYHBU0BmyXvMUVBoaDlIwDO
         G/R/M6LEBSi88/5aJHJ6G8XkRsq83j1H+6HVGmI+B0CuPw6zyU9C7MLkVCjm/nuj53c0
         CuCXXE4CZfUAuIVRhnZHC6qxhSTfjc2oIMoYHYqawEwUQ4Y7uzSH1b5U9ScUQuy4csYL
         Zb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=A6oerL0JPTGclWtRWXfc+NzZNOHWWJG0mmxObNrpvTo=;
        b=nGWsA9ssR/ia8mcOIzozKMWSU4nXk7jDKezeGZoU1XLbNcBmY9IU384+ki1/QKIgas
         iUQETT//k1JTKaOoFVSPIKStGV9aGCrkhUnnff6+Jca3+KpcJRgGQ3s8FMWuSP+73uWh
         WZnIZg+xqxp0jNvvQi8kjon6/RisF+CHv1oN8jBHjYcceBdAD7lxWUeV5CfBLfAVWqWI
         DlmK5sa1ouRRrOV3j9DliAS+/aBllxPSNgBKRhAMLvOMIrNPDf0aARaiq4noxktsxTVZ
         k/yYUxeIMAPjsCMy1gQeUgCnhtDML05t9tvl6F0SUn9zT3v2yQWtBrs4Iv4c4Kmem6WM
         xlHA==
X-Gm-Message-State: AEkooutg4CEdJD6kg2o/mVVHebsfCMibrremnl05dOYYpsSX0G67T+ioR2sDFoPHBMNdGExF4bAeW2xyZcS+0Q==
X-Received: by 10.107.43.16 with SMTP id r16mr21883707ior.81.1471855585385;
 Mon, 22 Aug 2016 01:46:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.232 with HTTP; Mon, 22 Aug 2016 01:46:24 -0700 (PDT)
In-Reply-To: <20160819191750.GV361@codeaurora.org>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
 <1471541667-30689-4-git-send-email-geert@linux-m68k.org> <20160819191750.GV361@codeaurora.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Aug 2016 10:46:24 +0200
X-Google-Sender-Auth: aPu4Aod3ofx5l6f640qNEZpfvec
Message-ID: <CAMuHMdVjd5iJL8AJBb0aVOEkcgJ-m-K19pjD-tJL=GLhPVm_Pg@mail.gmail.com>
Subject: Re: [PATCH 3/3] MIPS: TXx9: Convert to Common Clock Framework
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Fri, Aug 19, 2016 at 9:17 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 08/18, Geert Uytterhoeven wrote:
>> diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
>> index ada92db92f87d91a..2fdbcf91b2cc472c 100644
>> --- a/arch/mips/txx9/generic/setup.c
>> +++ b/arch/mips/txx9/generic/setup.c
>> @@ -560,8 +527,39 @@ void __init plat_time_init(void)
>>       txx9_board_vec->time_init();
>>  }
>>
>> +static void txx9_clk_init(void)
>> +{
>> +     struct clk *clk;
>> +     int error;
>> +
>> +     clk = clk_register_fixed_rate(NULL, "gbus", NULL, 0, txx9_gbus_clock);
>
> Can we use the clk_hw_*() based variants instead please?

Yes we can.

BTW, is it intentional that clk_hw_register_clkdev() doesn't detect errors
from a previous registration call, like clk_register_clkdev() does?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
