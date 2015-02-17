Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2015 12:35:55 +0100 (CET)
Received: from mail-la0-f41.google.com ([209.85.215.41]:45518 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013445AbbBQLf21mF2o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Feb 2015 12:35:28 +0100
Received: by labge10 with SMTP id ge10so35048958lab.12
        for <linux-mips@linux-mips.org>; Tue, 17 Feb 2015 03:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=fKgC1CIKgg/tRnppl7Q1LsGrLi6QQsDhhu7EEpc8Xws=;
        b=RlW+QqcNYZ3X8ZzYyYlAnrnUphi96Bxs5ljEVBy8GwHX1sn8TXgcW0kXbO8pwBaCRD
         aVsrwI/X92Csav5+7mzUbAVKExPhVH8N3T8jZyK+hjFexex9ZWcFMwtHypc6MR/w0gfb
         4ebPULecBIiq43IzAmInBSdji6F55tpdFCh2GTYmMCJ0wXemFsQjZnXmGmD0ZCVmtesg
         s1uJK1xOeY1SmrkPB15BHwTJt5sutOd+zI1hL32pdHhvnsaLlOOjs2rOuwrmAWgndyAF
         P02ORgb5EHFS0T+G9+1IxvGmG+MTTRgRvUGtYY8BBRD8KurDMkw1m5+HfbUGYWT5BXUG
         eFuA==
X-Gm-Message-State: ALoCoQk80Ffl9JVCxm7EraccyHRu2TN5lHGtJgdDjOfwDrcNg/uQgACb/vkq2FHqSuBQAm91ggbB
X-Received: by 10.112.188.165 with SMTP id gb5mr11869454lbc.35.1424172923226;
        Tue, 17 Feb 2015 03:35:23 -0800 (PST)
Received: from [192.168.3.154] (ppp31-177.pppoe.mtu-net.ru. [81.195.31.177])
        by mx.google.com with ESMTPSA id g5sm3507875lag.11.2015.02.17.03.35.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Feb 2015 03:35:22 -0800 (PST)
Message-ID: <54E32778.3060307@cogentembedded.com>
Date:   Tue, 17 Feb 2015 14:35:20 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Florian Fainelli <f.fainelli@gmail.com>, linux-mips@linux-mips.org
CC:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mpm@selenic.com, herbert@gondor.apana.org.au, wsa@the-dreams.de,
        cernekee@gmail.com
Subject: Re: [PATCH 2/4] hw_random: bcm63xx-rng: move register definitions
 to driver
References: <1424138956-11563-1-git-send-email-f.fainelli@gmail.com> <1424138956-11563-3-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1424138956-11563-3-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 2/17/2015 5:09 AM, Florian Fainelli wrote:

> arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h contains the register
> definitions for this random number generator block, incorporate these
> register definitions directly into the bcm63xx-rng driver so we do not
> rely on this header to be provided.

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   drivers/char/hw_random/bcm63xx-rng.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

> diff --git a/drivers/char/hw_random/bcm63xx-rng.c b/drivers/char/hw_random/bcm63xx-rng.c
> index ed9b28b35a39..c7f3af852599 100644
> --- a/drivers/char/hw_random/bcm63xx-rng.c
> +++ b/drivers/char/hw_random/bcm63xx-rng.c
> @@ -13,7 +13,15 @@
>   #include <linux/platform_device.h>
>   #include <linux/hw_random.h>
>
> -#include <bcm63xx_regs.h>
> +#define RNG_CTRL			0x00
> +#define RNG_EN				(1 << 0)
> +
> +#define RNG_STAT			0x04
> +#define RNG_AVAIL_MASK			(0xff000000)

    Parens not needed here.

WBR, Sergei
