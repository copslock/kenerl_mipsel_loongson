Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 13:30:53 +0200 (CEST)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:49471 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834987Ab3DOLawbPvBg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Apr 2013 13:30:52 +0200
Received: by mail-lb0-f172.google.com with SMTP id u10so4417309lbi.31
        for <linux-mips@linux-mips.org>; Mon, 15 Apr 2013 04:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=xSHfmoKVDC+/+4l0XvUluHkzVVk9e4jEQJT3Gm/z3eQ=;
        b=IdEw8HqMO5PYJNvGn5RtRgDEZmA3KptAHdAkFrU+lxpP96Gxu9ExSN7YixyqTveo/S
         I9ldG0W0+0s3vttfPuTWhiNyEObblB4IQp/KNV6WXBz4zLnc6+oel+Vvw8ZME9nxR4mV
         XyiR3Vv5RYVk9Qug+I+NPBK6KCkCBTH1ooFJbbQH4iFsWS4OTw1E8jOjtmMjuiQzB5DP
         KKQsZnLDDmNri5xyDC/2gwMCdYlB9U3n931mauW+J65PIPrsmBlePAkCEqZ9urH8/Nid
         QxKEeb8u+4i+fspOiprf8hC4b5jBRejS+YPBmL6BFUWfhu7Kws7gj3Ut+M1QZOLNa6Z8
         CtSA==
X-Received: by 10.152.87.226 with SMTP id bb2mr66419lab.12.1366025446913;
        Mon, 15 Apr 2013 04:30:46 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-88-234.pppoe.mtu-net.ru. [91.79.88.234])
        by mx.google.com with ESMTPS id jh4sm7923009lab.7.2013.04.15.04.30.45
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 04:30:45 -0700 (PDT)
Message-ID: <516BE4A6.8010108@cogentembedded.com>
Date:   Mon, 15 Apr 2013 15:29:42 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/7] MIPS: ralink: add memory definition for RT305x
References: <1366022494-8355-1-git-send-email-blogic@openwrt.org> <1366022494-8355-3-git-send-email-blogic@openwrt.org>
In-Reply-To: <1366022494-8355-3-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkW1BD07Ns0Po6JQIewcAIjotmJ8wMnuNdVrt9pp5rbJH/I9C91HTZ709dIw8DvGiKKFLAO
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36180
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

On 15-04-2013 14:41, John Crispin wrote:

> Populate struct soc_info with the data that describes our RAM window.

> As memory detection fails on RT5350 we read the amount of available memory
> from the system controller.

> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   arch/mips/include/asm/mach-ralink/rt305x.h |    6 ++++
>   arch/mips/ralink/rt305x.c                  |   45 ++++++++++++++++++++++++++++
>   2 files changed, 51 insertions(+)

> diff --git a/arch/mips/include/asm/mach-ralink/rt305x.h b/arch/mips/include/asm/mach-ralink/rt305x.h
> index 80cda8a..e68afef 100644
> --- a/arch/mips/include/asm/mach-ralink/rt305x.h
> +++ b/arch/mips/include/asm/mach-ralink/rt305x.h
> @@ -157,4 +157,10 @@ static inline int soc_is_rt5350(void)
>   #define RT3352_RSTCTRL_UDEV		BIT(25)
>   #define RT3352_SYSCFG1_USB0_HOST_MODE	BIT(10)
>
> +#define RT305X_SDRAM_BASE		0x00000000
> +#define RT305X_MEM_SIZE_MIN		(2 * 1024 * 1024)
> +#define RT305X_MEM_SIZE_MAX		(64 * 1024 * 1024)
> +#define RT3352_MEM_SIZE_MIN		(2 * 1024 * 1024)
> +#define RT3352_MEM_SIZE_MAX		(256 * 1024 * 1024)
> +
>   #endif
> diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
> index e9dbf8c..da85f10 100644
> --- a/arch/mips/ralink/rt305x.c
> +++ b/arch/mips/ralink/rt305x.c
> @@ -122,6 +122,40 @@ struct ralink_pinmux rt_gpio_pinmux = {
>   	.wdt_reset = rt305x_wdt_reset,
>   };
>
> +static unsigned long rt5350_get_mem_size(void)
> +{
> +	void __iomem *sysc = (void __iomem *) KSEG1ADDR(RT305X_SYSC_BASE);
> +	unsigned long ret;
> +	u32 t;
> +
> +	t = __raw_readl(sysc + SYSC_REG_SYSTEM_CONFIG);
> +	t = (t >> RT5350_SYSCFG0_DRAM_SIZE_SHIFT) &
> +		RT5350_SYSCFG0_DRAM_SIZE_MASK;
> +
> +	switch (t) {
> +	case RT5350_SYSCFG0_DRAM_SIZE_2M:
> +		ret = 2 * 1024 * 1024;
> +		break;
> +	case RT5350_SYSCFG0_DRAM_SIZE_8M:
> +		ret = 8 * 1024 * 1024;
> +		break;
> +	case RT5350_SYSCFG0_DRAM_SIZE_16M:
> +		ret = 16 * 1024 * 1024;
> +		break;
> +	case RT5350_SYSCFG0_DRAM_SIZE_32M:
> +		ret = 32 * 1024 * 1024;
> +		break;
> +	case RT5350_SYSCFG0_DRAM_SIZE_64M:
> +		ret = 64 * 1024 * 1024;
> +		break;
> +	default:

    Maybe it's worth including <linux/sizes.h> as well?

WBR, Sergei
