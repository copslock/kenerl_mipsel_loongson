Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 18:21:01 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:61253 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010966AbaJIQU7Ygz8z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 18:20:59 +0200
Received: by mail-lb0-f177.google.com with SMTP id w7so1501187lbi.36
        for <linux-mips@linux-mips.org>; Thu, 09 Oct 2014 09:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=bNBezvmg3W9s54iFR7yhCKgV6jsnUWQtSAx3qcW14ug=;
        b=lrs2wSp07Yc53nyvdbWPctWsj3X/7VcEFM7E5k3Tdb1eoFGER31SEIU80Sk5ArWbq3
         ymIpPWB+8HHjfanMwlbsNBe5UMeXsVSLZZYx7tfxkN++iclgf4WFehk8n/KNiuSohz9K
         Ovf8nfjs6VO8jPnD4iT5nvhVTRTOzhSJ15WvY0yDtrJhmbGqEdtD/ANgrLUqaLXs+ImC
         k88eZZqqXkpr36sZuMO7lFz63zdPFZX7hKRxHrBN4bqsMOo8i/pZMKQCZZrNtfwIGSEG
         OH0jicM2ogGXIQloqBzc/I+rSpSCOI7sTI/LTs5oaXy052ajlwQkrGo9vfHfoTU7a246
         zgtA==
X-Gm-Message-State: ALoCoQlYiJF2ZVQ0mVlT9rqDRjFnvNfkqqHC2Bt2hrfthzrBoobODaEQac0iJBsmPeD7twP837ic
X-Received: by 10.152.5.169 with SMTP id t9mr17259579lat.33.1412871654012;
        Thu, 09 Oct 2014 09:20:54 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp17-169.pppoe.mtu-net.ru. [81.195.17.169])
        by mx.google.com with ESMTPSA id ad3sm1069774lbc.45.2014.10.09.09.20.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 09:20:53 -0700 (PDT)
Message-ID: <5436B5E1.4060201@cogentembedded.com>
Date:   Thu, 09 Oct 2014 20:20:49 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 08/10] MIPS: ralink: add rt2880 wmac clock
References: <1412812385-64820-1-git-send-email-blogic@openwrt.org> <1412812385-64820-9-git-send-email-blogic@openwrt.org>
In-Reply-To: <1412812385-64820-9-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43151
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

On 10/09/2014 03:53 AM, John Crispin wrote:

> Register the wireleass mac clock on rt2880. This is required by the wifi driver.

> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   arch/mips/ralink/rt288x.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
> index f87de1a..90e8934 100644
> --- a/arch/mips/ralink/rt288x.c
> +++ b/arch/mips/ralink/rt288x.c
> @@ -76,7 +76,7 @@ struct ralink_pinmux rt_gpio_pinmux = {
>
>   void __init ralink_clk_init(void)
>   {
> -	unsigned long cpu_rate;
> +	unsigned long cpu_rate, wmac_rate = 40000000;

    Why you need this variable at all?

>   	u32 t = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG);
>   	t = ((t >> SYSTEM_CONFIG_CPUCLK_SHIFT) & SYSTEM_CONFIG_CPUCLK_MASK);
>
> @@ -101,6 +101,7 @@ void __init ralink_clk_init(void)
>   	ralink_clk_add("300500.uart", cpu_rate / 2);
>   	ralink_clk_add("300c00.uartlite", cpu_rate / 2);
>   	ralink_clk_add("400000.ethernet", cpu_rate / 2);
> +	ralink_clk_add("480000.wmac", wmac_rate);
>   }

WBR, Sergei
