Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jan 2018 08:41:44 +0100 (CET)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:45931
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990391AbeATHlfqNzMt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Jan 2018 08:41:35 +0100
Received: by mail-it0-x244.google.com with SMTP id x42so4637041ita.4;
        Fri, 19 Jan 2018 23:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A7t7ztCnqmiGVSpWgDm/jAyrFO6I53ltGIZes6Mrtdw=;
        b=LbvKrsgp/P5tU3db0m7KDfRoJ6r2oVlZbqDP1vl+Odtir6Vxc25ucyB1Y/mU/9kMr5
         5Vm+r6yELqDyWcAriJi1CNE471zmH4fULy7jlTuf1ZNp9cgC7lsi7f4XmiBCKDQoGAhK
         VtU7TR8SlH7GTbwhGhGPcdpOLiE7TM4s5J8b1TbzlohrQMScZoIegvIPLr9Kd+xM9MiN
         +PiX7YuyAJFNmUHk4S5IDKctoKPUuAyAguKzRa83j5W2FoZwQUodbeRqiVEiDNjb401U
         JucNLm95qZpS2Lona68yJtM/OaHzHLFCIyRxBich2SghCyLRqKwHb5kFmVftNzuEXlp1
         5qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A7t7ztCnqmiGVSpWgDm/jAyrFO6I53ltGIZes6Mrtdw=;
        b=jnnMWVxrLILooiiBv20C7eEBDKd5P/DphBf4GdVo5tnMu1M0Np7u91J529foy9AKkl
         ef8jqcWopk5FrIUgHZsnHw6ZSjTKgB9oY4qFzXKjty4rWUJm6MuNN/zVgpyxPv4tZ+Up
         In9Z/2YP6f89KeJKeP4r/fTato/OJ4n+AGgTyeN8l6wW8SHW1Hu028UQpGV/bjVVZWZU
         rImcbFVbuBduTMZt8xSX+xpnb4Qk+BxBeFnRn5kRnTZTnbBn+TZ853fpd/QeocSBYlA3
         j3rX7C7ROYiNqQhsNPxGrLqh90zFw0oHjtcAN0xdHDLf9oGfangnMLZNDkq/ZLAjWxs2
         jS7g==
X-Gm-Message-State: AKwxyteNEYXgEl+8LUOUowDYPsmx1ZF23cXwsJj55kNo30lg9o5TUmjb
        G59e/vKj7+MMwB/j7gll2u90sI0xARl1Le7cpa0=
X-Google-Smtp-Source: AH8x227a2STT/3gS7P77V2xjkHb/z1vWJb7NwNMQ6UjQo7mwEysHHpkoh+w+g2j+obYdlvwqI0SAp0cqSyl1/kFsvN0=
X-Received: by 10.36.135.138 with SMTP id f132mr833920ite.144.1516434089371;
 Fri, 19 Jan 2018 23:41:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.165.9 with HTTP; Fri, 19 Jan 2018 23:41:28 -0800 (PST)
In-Reply-To: <20171230135108.6834-4-paul@crapouillou.net>
References: <20171228162939.3928-2-paul@crapouillou.net> <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-4-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sat, 20 Jan 2018 13:11:28 +0530
Message-ID: <CANc+2y4z-_++zUG8DUR6+zZYjc26AyJjU-yX+Lx37TSRXb4u0g@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] watchdog: JZ4740: Drop module remove function
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Hi Paul,

On 30 December 2017 at 19:21, Paul Cercueil <paul@crapouillou.net> wrote:
> When the watchdog was configured for nowayout, and after the
> userspace watchdog daemon closed the dev node without sending the
> magic character, unloading this module stopped the watchdog
> hardware, which was clearly a problem.
>
> Besides, unloading the module is not possible when the userspace
> watchdog daemon is running, so it's safe to assume that we don't
> need to stop the watchdog hardware in the jz4740_wdt_remove()
> function.
>
> For this reason, the jz4740_wdt_remove() function can then be
> dropped alltogether.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/watchdog/jz4740_wdt.c | 8 --------
>  1 file changed, 8 deletions(-)
>
>  v2: New patch in this series
>
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index fa7f49a3212c..02b9b8e946a2 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -205,16 +205,8 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>         return 0;
>  }
>
> -static int jz4740_wdt_remove(struct platform_device *pdev)
> -{
> -       struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
> -
> -       return jz4740_wdt_stop(&drvdata->wdt);
> -}
> -
>  static struct platform_driver jz4740_wdt_driver = {
>         .probe = jz4740_wdt_probe,
> -       .remove = jz4740_wdt_remove,
>         .driver = {
>                 .name = "jz4740-wdt",
>                 .of_match_table = of_match_ptr(jz4740_wdt_of_matches),
> --
> 2.11.0
>
>

As ".remove" is removed and wdt is required for restarting the system
I am thinking that stop callback is also not required. If so does it
makes sense to remove the stop callback? I can submit a patch for the
same once this patch series goes in.

Regards,
PrasannaKumar
