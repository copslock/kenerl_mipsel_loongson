Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Apr 2012 12:48:10 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:53317 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904105Ab2DGKrx convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 7 Apr 2012 12:47:53 +0200
Received: by iaky10 with SMTP id y10so5002382iak.36
        for <multiple recipients>; Sat, 07 Apr 2012 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zuv1IqXPti0IU5BmZ75kblFNCIACtH3XD1ImdEoTN1w=;
        b=xJNOCz6Xs7P3GJW6twCbRm7Cl/j0Zc+xCC2eH7kDIYkWRq30Qskc79GhfGKO2M0ulu
         69ZkhBgz04EhbhB/fwLHsvhpaDKalZbu+rr03I6Z/v1nKtCpTMIdOOMcrWjf8Jc/HRbe
         2sBQ/hpiqsXCmRwAmOTOTkAvSRNv8unFv4yfBtps80a6BP5f9JhEv/PJ2h3e3Mogotsb
         /yQ42gCX6mes9+OskoCmF4EY4OhyBtVRZiW8ReLDKjgW/zzoTZKqa1Ke+h61wS7s2j/J
         A3FO2WGtd5yCH5UdEfo8JxNzuH9UuzimzZ+g3G18d+o2yVf1LLC8RoVfIUgrz1hdCm3T
         8PsQ==
Received: by 10.50.46.138 with SMTP id v10mr697637igm.18.1333795667532; Sat,
 07 Apr 2012 03:47:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.42.202.144 with HTTP; Sat, 7 Apr 2012 03:47:27 -0700 (PDT)
In-Reply-To: <1333735064-15672-1-git-send-email-sjhill@mips.com>
References: <1333735064-15672-1-git-send-email-sjhill@mips.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Sat, 7 Apr 2012 12:47:27 +0200
Message-ID: <CAOiHx=nRxy-RPhpbZhbMD++qnM2Uqf6=oP9JMvc+6HcciW8ang@mail.gmail.com>
Subject: Re: [PATCH 1/5] MIPS: Add support for the 1074K core.
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        sjhill@realitydiluted.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 32877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

On 6 April 2012 19:57, Steven J. Hill <sjhill@mips.com> wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> This patch adds support for detecting and using 1074K cores.
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
>
> (snip)
>
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index bda8eb2..a08e75d 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -977,7 +977,7 @@ static void __cpuinit probe_pcache(void)
>                        c->icache.linesz = 2 << lsize;
>                else
>                        c->icache.linesz = lsize;
> -               c->icache.sets = 64 << ((config1 >> 22) & 7);
> +               c->icache.sets = 32 << (((config1 >> 22) + 1) & 7);

Why this change? According to the 1074K datasheet it is still 64 *
2^S, so to me it looks like the previous version was correct. Also
adding first and then masking looks really wrong, and will produce
wrong results for 0x7.

>                c->icache.ways = 1 + ((config1 >> 16) & 7);
>
>                icache_size = c->icache.sets *
> @@ -997,7 +997,7 @@ static void __cpuinit probe_pcache(void)
>                        c->dcache.linesz = 2 << lsize;
>                else
>                        c->dcache.linesz= lsize;
> -               c->dcache.sets = 64 << ((config1 >> 13) & 7);
> +               c->dcache.sets = 32 << (((config1 >> 13) + 1) & 7);

See above.

>                c->dcache.ways = 1 + ((config1 >> 7) & 7);
>
>                dcache_size = c->dcache.sets *
> (snip)


Jonas
