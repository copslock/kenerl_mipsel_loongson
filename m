Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 13:15:16 +0200 (CEST)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34212 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008635AbbDALPOrU60t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 13:15:14 +0200
Received: by lboc7 with SMTP id c7so33422039lbo.1
        for <linux-mips@linux-mips.org>; Wed, 01 Apr 2015 04:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ECXeJiy/z58ZXQ7htW1m/cjg23BPZIyoTE+P3s+5qVc=;
        b=RU7xtB9+zQ0A2x/OZHJtYGWTbNLrSv7xVMWugZl/3N87cPa+5AizFOZ9y9FV4EI2JA
         9L4y1pbopEDKwp3F45LtCfTukfZFJ52UzxY/dQ9IuLpp28IuoUX/rPV3605Zc1HySXrQ
         7kqscbpPrxN8xGS1nmXnbdC4bjpsbcH6U+yo1tLGViGtdFxhKm7QxPRQ9o8FbMwhTYFm
         5OdrHJ06so5TXxlSaJ+80Ol7AMQrHUkUKf06ylqmeZDcsGRWOVSp1GJJ8bndjzTwvc4W
         BWkbfxQpR4/JpzDXupCVTuCaaE5lNZvl2VayddJI+/LGjZYDfW65DBVCafkx7G9HKEQz
         TPyQ==
X-Gm-Message-State: ALoCoQlX+7563Ap/hp83fCtochB/G6nOj+bC3K2lA6TF1lNhgAc5PEKnJYGoNpWB51VRTWSS9ROs
X-Received: by 10.112.48.107 with SMTP id k11mr19358793lbn.92.1427886910158;
        Wed, 01 Apr 2015 04:15:10 -0700 (PDT)
Received: from [192.168.3.154] (ppp85-141-196-14.pppoe.mtu-net.ru. [85.141.196.14])
        by mx.google.com with ESMTPSA id e1sm347086lbc.7.2015.04.01.04.15.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2015 04:15:09 -0700 (PDT)
Message-ID: <551BD33B.5030707@cogentembedded.com>
Date:   Wed, 01 Apr 2015 14:15:07 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH 1/3] MIPS: BCM47XX: Include io.h directly and fix brace
 indent
References: <1427869385-23333-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1427869385-23333-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46683
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

On 4/1/2015 9:23 AM, Rafał Miłecki wrote:

> We use IO functions like readl & ioremap_nocache, so include linux/io.h

> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
>   arch/mips/bcm47xx/nvram.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
> index 6a97732..2357ea3 100644
> --- a/arch/mips/bcm47xx/nvram.c
> +++ b/arch/mips/bcm47xx/nvram.c
[...]
> @@ -203,7 +204,7 @@ int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len)
>   		if (eq - var == strlen(name) &&
>   		    strncmp(var, name, eq - var) == 0)
>   			return snprintf(val, val_len, "%s", value);
> -		}
> +	}

    Unrelated (and undescribed) change.

[...]

WBR, Sergei
