Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2014 12:52:53 +0100 (CET)
Received: from mail-lb0-f179.google.com ([209.85.217.179]:61443 "EHLO
        mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816019AbaCZLwvdOTWq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Mar 2014 12:52:51 +0100
Received: by mail-lb0-f179.google.com with SMTP id p9so1406888lbv.10
        for <linux-mips@linux-mips.org>; Wed, 26 Mar 2014 04:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=W0/7Fr0ikjXsE0odi0pJ4RS/6xFkrny1q/WkOOgWJ7w=;
        b=ARx29syu4XAe8noCmahHJLKto++3Yb/jipxp5fPtb7ekgLBEKqbA0uPDfdytURtXJh
         0P8DtFLIBnHXezuuhISa+H0Uv3CS6eP38Q5db+2fQ1Z/Tjp6yiV4g4+Uk0iZ/1gGhlSr
         jWB5NLTSJHyef8UcslfBm5ySwR0OfRCsqJTJ/iH2/K3SlyUVgKFZ9galf9AobUU2Yd1v
         ll4jE7TXSPvibU2pUZqvWH8zxfEt6tYRwEA4UqXlHztjRWwEMHbcJlPxCsvRRjKNjjw2
         BV6mPwpDPl1kVbiCgD4XF7avsq1Uh5YiEjd1Akp1fdlI6pTEdHtziteSmQfsifZ3BjPA
         xepQ==
X-Gm-Message-State: ALoCoQlhrG21Aet9cMTIs3cSy5o9w8pIGzaVnPZdNoLyvzWt7D152zt/nHZvlaQnPQ+LCUOCGEnI
X-Received: by 10.112.92.109 with SMTP id cl13mr920508lbb.50.1395834765507;
        Wed, 26 Mar 2014 04:52:45 -0700 (PDT)
Received: from [192.168.2.4] (ppp85-140-134-247.pppoe.mtu-net.ru. [85.140.134.247])
        by mx.google.com with ESMTPSA id q8sm13838798lbr.3.2014.03.26.04.52.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 04:52:44 -0700 (PDT)
Message-ID: <5332BF8B.3040006@cogentembedded.com>
Date:   Wed, 26 Mar 2014 15:52:43 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/3] MIPS: Alchemy: pata_platform for DB1200
References: <1395826909-14772-1-git-send-email-manuel.lauss@gmail.com> <1395826909-14772-3-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1395826909-14772-3-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39584
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

On 26-03-2014 13:41, Manuel Lauss wrote:

> The au1xxx-ide driver isn't any faster than pata_platform since it
> spends a lot of time busy waiting for DMA to finish; faster PIO/DMA
> modes only work on the db1200 with a certain cpu speed, UDMA is broken
> and finally the old IDE layer is on death row, so time to switch to
> the winning side.

> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
>   arch/mips/alchemy/devboards/db1200.c | 18 +++++++++++++++---
>   arch/mips/configs/db1xxx_defconfig   |  3 ---
>   2 files changed, 15 insertions(+), 6 deletions(-)

> diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
> index 4bcf2f4..40fa3a6 100644
> --- a/arch/mips/alchemy/devboards/db1200.c
> +++ b/arch/mips/alchemy/devboards/db1200.c
[...]
> @@ -330,6 +331,11 @@ static struct platform_device db1200_eth_dev = {
>
>   /**********************************************************************/
>
> +static struct pata_platform_info db1200_ide_info = {
> +	.ioport_shift	= DB1200_IDE_REG_SHIFT,
> +};
> +
> +#define IDE_ALT_START	(14 << DB1200_IDE_REG_SHIFT)
>   static struct resource db1200_ide_res[] = {
>   	[0] = {
>   		.start	= DB1200_IDE_PHYS_ADDR,
> @@ -337,25 +343,31 @@ static struct resource db1200_ide_res[] = {
>   		.flags	= IORESOURCE_MEM,
>   	},
>   	[1] = {
> +		.start	= DB1200_IDE_PHYS_ADDR + IDE_ALT_START,
> +		.end	= DB1200_IDE_PHYS_ADDR + DB1200_IDE_PHYS_LEN - 1,

    This now intersects with resource 0.

> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[2] = {
>   		.start	= DB1200_IDE_INT,
>   		.end	= DB1200_IDE_INT,
>   		.flags	= IORESOURCE_IRQ,
>   	},
> -	[2] = {
> +/*	[3] = {
>   		.start	= AU1200_DSCR_CMD0_DMA_REQ1,
>   		.end	= AU1200_DSCR_CMD0_DMA_REQ1,
>   		.flags	= IORESOURCE_DMA,
> -	},
> +	},*/
>   };

    Commented out code is not allowed, just remove it please.

WBR, Sergei
