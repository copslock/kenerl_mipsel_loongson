Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Sep 2017 03:32:53 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:35564
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993960AbdIIBcmkhWke (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Sep 2017 03:32:42 +0200
Received: by mail-pf0-x243.google.com with SMTP id g13so2193188pfm.2;
        Fri, 08 Sep 2017 18:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ulBdcO7IvtjALr4RjZEgyCdh00vQ76tvmCjc+1TGsUI=;
        b=ltINuvOfn5d7buMuHt6HcfA7yIv7/5x7cNXXHDh6GyjpB6k7AUY20oUcQRecizJyvq
         J8E1G/5lbCrJG/LuJ47hGyaAGZRNbCBc7n/z88n9O1cxDtuuzaGK/5d+oHi9xd6mB6Xk
         SqpmlM/BjXc6LpBJJWY797b7YpuhExg8aEJUxZeULYCZ4FqU9KY+QHoM8vpFsKEzafcm
         oh+OWVq/ykiqwoTYJ9ay+SjqnoMhFnA8WAIi9VnjSuCoaZCDTA/Pxh4VDmhztF0po/xN
         abVfAG84r7SIzbx9JtJBdoNrLkO7dXXmG0RajSoP37ZLa8/OhTDIO3YPrstEotmROZJj
         ifNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ulBdcO7IvtjALr4RjZEgyCdh00vQ76tvmCjc+1TGsUI=;
        b=L+0dc0jTV04jf4keeFcE9M4q6ZB05X0sV5dji3aGbi8UEaoAVTgPVZLNaXeJEPP6S2
         78pdtXvgtoTatqphYGaWN3y+5rZC6eKLADTtZcip1vwMFMmsq4tv2i+y7QREqPDFNDt9
         i4g7mgqW9BR4VNf0phNs7lZm6Uxj5UXl78ZyoPkTxbsDcnqlJeZ+SgckKTHDscqHaMgn
         KDEQXwQpUh8j8Y2GpChrmZ/24Q2Q5iZwTINiVtHkLmwhfmSTlfobJkC/LISKYLwYCXE/
         3KCYQPYFFo+Hq23gDpv62jy6/tp/SEMZDV28WY8ZJuR+48LxXTQDZ03dUWLOx+db1NPX
         jX6w==
X-Gm-Message-State: AHPjjUhj/T0ThKHGBgNR8CtW6ubviL7fS2nDEPg8GhsjzgqENnVptaGq
        9KCVKixlw5+BWA==
X-Google-Smtp-Source: ADKCNb6ZkZ0Op5RkpAQdbBqwWFbYwDluTx5/7AAs1WvRF6jgGsbUzh/tOLWinkK/WFHa8DPS868EQA==
X-Received: by 10.98.141.77 with SMTP id z74mr4961560pfd.179.1504920755729;
        Fri, 08 Sep 2017 18:32:35 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e3sm5293565pga.80.2017.09.08.18.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Sep 2017 18:32:34 -0700 (PDT)
Subject: Re: [PATCH 2/3] watchdog: jz4780: Allow selection of jz4740-wdt
 driver
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20170908183558.1537-1-malat@debian.org>
 <20170908183558.1537-2-malat@debian.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <65d7a551-9496-c0ef-f4a2-5dacc4678326@roeck-us.net>
Date:   Fri, 8 Sep 2017 18:32:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170908183558.1537-2-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 09/08/2017 11:35 AM, Mathieu Malaterre wrote:
> This driver works for jz4740 & jz4780
> 
> Suggested-by: Maarten ter Huurne <maarten@treewalker.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c722cbfdc7e6..ca200d1f310a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1460,7 +1460,7 @@ config INDYDOG
>   
>   config JZ4740_WDT
>   	tristate "Ingenic jz4740 SoC hardware watchdog"
> -	depends on MACH_JZ4740
> +	depends on MACH_JZ4740 || MACH_JZ4780
>   	select WATCHDOG_CORE
>   	help
>   	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoCs.
> 
