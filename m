Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Dec 2011 15:48:01 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:58158 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903657Ab1LJOry (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Dec 2011 15:47:54 +0100
Received: by bkat2 with SMTP id t2so2173692bka.36
        for <multiple recipients>; Sat, 10 Dec 2011 06:47:48 -0800 (PST)
Received: by 10.204.152.208 with SMTP id h16mr6299813bkw.15.1323528467866;
        Sat, 10 Dec 2011 06:47:47 -0800 (PST)
Received: from [192.168.2.2] ([91.79.83.92])
        by mx.google.com with ESMTPS id fg16sm17406062bkb.16.2011.12.10.06.47.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 06:47:46 -0800 (PST)
Message-ID: <4EE370D9.9090900@mvista.com>
Date:   Sat, 10 Dec 2011 18:46:49 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 4/5] MIPS: BCM63XX: add RNG driver platform_device stub
References: <1323457270-16330-1-git-send-email-florian@openwrt.org> <1323457270-16330-5-git-send-email-florian@openwrt.org>
In-Reply-To: <1323457270-16330-5-git-send-email-florian@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8343

Hello.

On 09-12-2011 23:01, Florian Fainelli wrote:

> Signed-off-by: Florian Fainelli<florian@openwrt.org>
[...]

> diff --git a/arch/mips/bcm63xx/dev-trng.c b/arch/mips/bcm63xx/dev-trng.c
> new file mode 100644
> index 0000000..19ccfbf
> --- /dev/null
> +++ b/arch/mips/bcm63xx/dev-trng.c
> @@ -0,0 +1,40 @@
[...]
> +static struct resource trng_resources[] = {
> +	{
> +		.start		= -1, /* filled at runtime */
> +		.end		= -1, /* filled at runtime */
> +		.flags		= IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct platform_device bcm63xx_trng_device = {
> +	.name		= "bcm63xx-trng",
> +	.id		= 0,

    Why not -1? Isn't there only single device of this sort?

WBR, Sergei
