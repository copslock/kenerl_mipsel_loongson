Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Sep 2013 00:08:20 +0200 (CEST)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35702 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827331Ab3ISWIS60Wew (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Sep 2013 00:08:18 +0200
Received: by mail-lb0-f174.google.com with SMTP id w6so8223794lbh.5
        for <linux-mips@linux-mips.org>; Thu, 19 Sep 2013 15:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KAnRo3ZCCPDWwFLVThzWjjkoyyiJkCnsVrx8TxOxUgI=;
        b=RYmDHsfEY3TGDpVUkdiWeO02lET21eShb5ZGvhk6EZafTim9+q9q3oFtKK8IkMDhKC
         CGXQPkq7sY0YSsQRLuR+WbNOf3tu6lKyakf/rnY260iU8RooH50wfHUw4HuYL4zQl70X
         H/MX8+yIcnC/mQWwHLMvOxjhCuDdjWd5b8vTfJZCQcarI2VcFidx69AN/hHX3CBtxODR
         N8GJIksoGyYih0UvwxkinN5MCwIassAxFFU1U9oFBj5SXrnkfWn7y+GTNRpNdmQ4LVpg
         K1exBPC/W+bsKlEy2j2jTDNoWdCSGw8F5MzWQRaEHZLrg1fq/1O+qflnlmOUi/3vE2JJ
         rK+g==
X-Gm-Message-State: ALoCoQnkCbiye/WnRxL93cWm5R0efouenpoSW8ghcka1eaRCAhP05Z73ZqT+ui4tjLo8BCBx7yKe
X-Received: by 10.152.8.12 with SMTP id n12mr3135329laa.10.1379628493380;
        Thu, 19 Sep 2013 15:08:13 -0700 (PDT)
Received: from wasted.dev.rtsoft.ru (ppp91-76-92-54.pppoe.mtu-net.ru. [91.76.92.54])
        by mx.google.com with ESMTPSA id l10sm4802293lbh.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 15:08:12 -0700 (PDT)
Message-ID: <523B75D0.7090709@cogentembedded.com>
Date:   Fri, 20 Sep 2013 02:08:16 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: BCM47XX: add EARLY_PRINTK_8250 support
References: <1379627091-30769-1-git-send-email-hauke@hauke-m.de> <1379627091-30769-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1379627091-30769-2-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37899
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

On 09/20/2013 01:44 AM, Hauke Mehrtens wrote:

> The BCM47xx SoCs have a 8250 serial compatible console at address
> 0xb8000300 and an other at 0xb8000400. On most devices 0xb8000300 is
> wired to some pins on the board, we should use that.

    I think these are KSEG1 virtual addresses, not physical.

> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>   arch/mips/Kconfig        |    2 ++
>   arch/mips/bcm47xx/prom.c |    1 +
>   2 files changed, 3 insertions(+)

[...]
> diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
> index 99c3ce2..26f49f8 100644
> --- a/arch/mips/bcm47xx/prom.c
> +++ b/arch/mips/bcm47xx/prom.c
> @@ -97,6 +97,7 @@ static __init void prom_init_mem(void)
>   void __init prom_init(void)
>   {
>   	prom_init_mem();
> +	setup_8250_early_printk_port(CKSEG1ADDR(0xb8000300), 0, 0);

    Applying CKSEG1ADDR() to virtual address is wrong.

WBR, Sergei
