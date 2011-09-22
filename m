Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2011 12:21:51 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:55742 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491115Ab1IVKVn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2011 12:21:43 +0200
Received: by wyi11 with SMTP id 11so1377951wyi.36
        for <multiple recipients>; Thu, 22 Sep 2011 03:21:38 -0700 (PDT)
Received: by 10.227.38.66 with SMTP id a2mr396412wbe.81.1316686898237;
        Thu, 22 Sep 2011 03:21:38 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.94.176])
        by mx.google.com with ESMTPS id y10sm10829349wbm.14.2011.09.22.03.21.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Sep 2011 03:21:36 -0700 (PDT)
Message-ID: <4E7B0C02.7060703@mvista.com>
Date:   Thu, 22 Sep 2011 14:20:50 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        Florian Fainelli <ffainelli@freebox.fr>
Subject: Re: [PATCH 2/5] MIPS: bcm63xx: fix SDRAM size computation for BCM6345
References: <1316612390-6367-1-git-send-email-florian@openwrt.org> <1316612390-6367-3-git-send-email-florian@openwrt.org>
In-Reply-To: <1316612390-6367-3-git-send-email-florian@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12428

Hello.

On 21-09-2011 17:39, Florian Fainelli wrote:

> From: Florian Fainelli<ffainelli@freebox.fr>

> Instead of hardcoding the amount of available RAM, read the number of
> effective multiples of 8MB from SDRAM_MBASE_REG.

> Signed-off-by: Florian Fainelli<florian@openwrt.org>
> ---
>   arch/mips/bcm63xx/cpu.c |    6 ++++--
>   1 files changed, 4 insertions(+), 2 deletions(-)

> diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
> index 7c7e4d4..7ad1b39 100644
> --- a/arch/mips/bcm63xx/cpu.c
> +++ b/arch/mips/bcm63xx/cpu.c
> @@ -260,8 +260,10 @@ static unsigned int detect_memory_size(void)
>   	unsigned int cols = 0, rows = 0, is_32bits = 0, banks = 0;
>   	u32 val;
>
> -	if (BCMCPU_IS_6345())
> -		return (8 * 1024 * 1024);
> +	if (BCMCPU_IS_6345()) {
> +		val = bcm_sdram_readl(SDRAM_MBASE_REG);
> +		return (val * 8 * 1024 * 1024);

    Parens not needed here.

WBR, Sergei
