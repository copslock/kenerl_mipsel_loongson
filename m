Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 11:35:55 +0100 (CET)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:49133 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011914AbbA2KfxcXqZ2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 11:35:53 +0100
Received: by mail-lb0-f182.google.com with SMTP id l4so26479068lbv.13
        for <linux-mips@linux-mips.org>; Thu, 29 Jan 2015 02:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ipkhbWGbUrztaTfps6jKqneklVuYT9BY6RP1h4A8HEI=;
        b=aTMQMfAvTKjX0iYme52gTSQLBWmpWA7FrZaa05k5r2YLCInyE0GjczXFEuFzXAxXNJ
         aJsRempdn2RYQSb+KZBj8QxX1CwDftO/dk1YZ++HJD+yhFhBafhJxlnMBJbZrNWID3Tl
         Y+KyTcBZC700KtL7YXAzn+tBfM5mlz+QlkJIXxj4aICU5rf4CysZZlMhM/Xt8w1vjbzw
         iK4nlVLRgVH4x8nZ+8HTyD1Ijal+9nsFgAtqrvay/JHXOKi9JZguOPzq2QSKgr1qCacF
         w4c+QhHNoCbYuUpH171Mo0Fnf7JTDR5H6RRWVWd6UWJNyfO1aB335lr2O1GNDwurvtB9
         HaMQ==
X-Gm-Message-State: ALoCoQnF2+dCg1CIFfNWb2qQu9C7rY/LkbHcxS3hYstjCnkop4obaaD9pF+dzFTGe3ZNs4GhR2Gk
X-Received: by 10.112.159.195 with SMTP id xe3mr13335582lbb.64.1422527748215;
        Thu, 29 Jan 2015 02:35:48 -0800 (PST)
Received: from [192.168.3.68] (ppp83-237-255-144.pppoe.mtu-net.ru. [83.237.255.144])
        by mx.google.com with ESMTPSA id ay2sm2025722lab.37.2015.01.29.02.35.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2015 02:35:47 -0800 (PST)
Message-ID: <54CA0D01.2080905@cogentembedded.com>
Date:   Thu, 29 Jan 2015 13:35:45 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: Alchemy: fix Au1000/Au1500 LRCLK calculation
References: <1422525243-1756-1-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1422525243-1756-1-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45521
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

On 1/29/2015 12:54 PM, Manuel Lauss wrote:

> The Au1000 and Au1500 calculate the LRCLK a bit differently than
> newer models: a single bit in MEM_STCFG0 selects if pclk is divided
> by 4 or 5.

> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
>   arch/mips/alchemy/common/clock.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)

> diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
> index 48a9dfc..428c9f0 100644
> --- a/arch/mips/alchemy/common/clock.c
> +++ b/arch/mips/alchemy/common/clock.c
> @@ -315,17 +315,27 @@ static struct clk __init *alchemy_clk_setup_mem(const char *pn, int ct)
>
>   /* lrclk: external synchronous static bus clock ***********************/
>
> -static struct clk __init *alchemy_clk_setup_lrclk(const char *pn)
> +static struct clk __init *alchemy_clk_setup_lrclk(const char *pn, int t)
>   {
> -	/* MEM_STCFG0[15:13] = divisor.
> +	/* Au1000, Au1500: MEM_STCFG0[11]: If bit is set, lrclk=pclk/5,
> +	 * otherwise lrclk=pclk/4.
> +	 * All other variants: MEM_STCFG0[15:13] = divisor.
>   	 * L/RCLK = periph_clk / (divisor + 1)
>   	 * On Au1000, Au1500, Au1100 it's called LCLK,
>   	 * on later models it's called RCLK, but it's the same thing.
>   	 */
>   	struct clk *c;
> -	unsigned long v = alchemy_rdsmem(AU1000_MEM_STCFG0) >> 13;
> +	unsigned long v;
>
> -	v = (v & 7) + 1;
> +	switch (t) {
> +	case ALCHEMY_CPU_AU1000:
> +	case ALCHEMY_CPU_AU1500:
> +		v = 4 + ((alchemy_rdsmem(AU1000_MEM_STCFG0) >> 11) & 1);
> +		break;
> +	default:	/* all other models */
> +		v = alchemy_rdsmem(AU1000_MEM_STCFG0) >> 13;

    How about reading MEM_STCFG0 only once, before *switch*?

[...]

WBR, Sergei
