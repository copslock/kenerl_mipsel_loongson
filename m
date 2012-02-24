Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 11:48:22 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:54524 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903648Ab2BXKsR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2012 11:48:17 +0100
Received: by bkcjk13 with SMTP id jk13so2437974bkc.36
        for <linux-mips@linux-mips.org>; Fri, 24 Feb 2012 02:48:12 -0800 (PST)
Received-SPF: pass (google.com: domain of sshtylyov@mvista.com designates 10.204.148.79 as permitted sender) client-ip=10.204.148.79;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sshtylyov@mvista.com designates 10.204.148.79 as permitted sender) smtp.mail=sshtylyov@mvista.com
Received: from mr.google.com ([10.204.148.79])
        by 10.204.148.79 with SMTP id o15mr841456bkv.33.1330080492504 (num_hops = 1);
        Fri, 24 Feb 2012 02:48:12 -0800 (PST)
Received: by 10.204.148.79 with SMTP id o15mr701574bkv.33.1330080492299;
        Fri, 24 Feb 2012 02:48:12 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-85-203.pppoe.mtu-net.ru. [91.79.85.203])
        by mx.google.com with ESMTPS id jc4sm7903668bkc.7.2012.02.24.02.48.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Feb 2012 02:48:11 -0800 (PST)
Message-ID: <4F476AA0.7030703@mvista.com>
Date:   Fri, 24 Feb 2012 14:46:56 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 07/14] MIPS: lantiq: convert gpio_stp driver to clkdev
 api
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org> <1330012993-13510-7-git-send-email-blogic@openwrt.org>
In-Reply-To: <1330012993-13510-7-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmtDQzAdxi2EQCfFOnnjFlLLF0K9LZs42NkeYJRo3sQ21e05n6vIoD1iKuK0Ge6Sz2QJNGQ
X-archive-position: 32543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 23-02-2012 20:03, John Crispin wrote:

> Update from old pmu_{dis,en}able() to ckldev api.

> Signed-off-by: John Crispin<blogic@openwrt.org>
[...]

> diff --git a/arch/mips/lantiq/xway/gpio_stp.c b/arch/mips/lantiq/xway/gpio_stp.c
> index e6b4809..8e07958 100644
> --- a/arch/mips/lantiq/xway/gpio_stp.c
> +++ b/arch/mips/lantiq/xway/gpio_stp.c
[...]
> @@ -105,7 +108,9 @@ static int ltq_stp_hw_init(void)
>   	 */
>   	ltq_stp_w32_mask(0, LTQ_STP_ADSL_SRC, LTQ_STP_CON0);
>
> -	ltq_pmu_enable(PMU_LED);
> +	clk = clk_get(dev, NULL);
> +	WARN_ON(!clk);

    clk_get() returns error, not NULL.

WBR, Sergei
