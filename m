Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Dec 2012 21:17:44 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:59820 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823043Ab2LPURmJm4-8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Dec 2012 21:17:42 +0100
Received: by mail-lb0-f177.google.com with SMTP id n10so4107894lbo.36
        for <linux-mips@linux-mips.org>; Sun, 16 Dec 2012 12:17:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=MP+T3n1RgdaQNYwDZnCwawtsqMJUhnlvyQnhBIKxbXI=;
        b=USB0WNyuGoZ8N9Hpe0GLZRIBlfdJKebPrCON4YSmEbGFGoKypO0zSrcJK4QM+1kEZ+
         TZjeSiKMojO+mwqxxRaKppjKjtst7NWNo20A/yR2J9H5DCzhed5hI+PhGknFbZLqW8EF
         tO7eS2Z8B/rp+lXTYU1HNEAGvY2ByJcOxqqVKYK/fSE8eTGua021XU2cSxiziGr6XC4f
         5EwvjQl7ZpNpLxvCKt6HBpPDIQF7wV6RgGzwi04cyj7rlZW/1xz1eHhHFlOLAoJf130k
         frbZBC7Nt8GTI9gyrjHSBn+TlB5Pz5Z0X2sRkdv7osC3SACwrJviqxsvrlmBLeRo1Qvt
         8fgw==
Received: by 10.152.46.161 with SMTP id w1mr8904068lam.27.1355689056381;
        Sun, 16 Dec 2012 12:17:36 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-89-229.pppoe.mtu-net.ru. [91.79.89.229])
        by mx.google.com with ESMTPS id pw17sm4039964lab.5.2012.12.16.12.17.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Dec 2012 12:17:35 -0800 (PST)
Message-ID: <50CE2C65.6020805@mvista.com>
Date:   Mon, 17 Dec 2012 00:17:41 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Alchemy: make 32kHz and r4k timer coexist peacefully
References: <1355686896-26001-1-git-send-email-manuel.lauss@googlemail.com>
In-Reply-To: <1355686896-26001-1-git-send-email-manuel.lauss@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlVkkcIL1dO4HVQ8wCly0HbOUf3AN9uU+WNjzTHIJhjcI3D1AutHPvXId42xJICQZdOCeOa
X-archive-position: 35298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 16-12-2012 23:41, Manuel Lauss wrote:

> From: Manuel Lauss <manuel.lauss@gmail.com>

> Now that the r4k timer is registered no matter what, bump the rating of
> the Alchemy 32kHz timer so that it gets used when it is working,
> and fall back on the r4k when it isn't.

> This fixes a timer-related hang on platform with a working 32kHz timer
> (the better rated c0 timer stops while executing 'wait' leading to (almost)
> eternal sleep) and an oops on boot on platforms without a working 32kHz timer
> (due to double registration of the r4k timer).

> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> For what is to become 3.8.

> This is a quick fix; it's far less invasive than my preferred solution:
> having each platform register the r4k clocksource explicitly.
> It should be enough until Alchemy variants with speeds >= 1.3GHz appear
> (which is very unlikely).

>   arch/mips/alchemy/common/time.c | 29 ++++++-----------------------
>   1 file changed, 6 insertions(+), 23 deletions(-)

> diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
> index a7193ae..12589d0 100644
> --- a/arch/mips/alchemy/common/time.c
> +++ b/arch/mips/alchemy/common/time.c
[...]
> @@ -183,11 +169,8 @@ static int alchemy_m2inttab[] __initdata = {
>
>   void __init plat_time_init(void)
>   {
> -	int t;
> -
> -	t = alchemy_get_cputype();
> -	if (t == ALCHEMY_CPU_UNKNOWN)
> -		alchemy_setup_c0timer();
> -	else if (alchemy_time_init(alchemy_m2inttab[t]))
> -		alchemy_setup_c0timer();
> +	int t = alchemy_get_cputype();

    Could you please keep the coding style and insert empty line here?

> +	if ((t == ALCHEMY_CPU_UNKNOWN) ||
> +	    (alchemy_time_init(alchemy_m2inttab[t])))

    Useless parens around == and especially around function call.

WBR, Sergei
