Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 11:38:14 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:42177 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903647Ab2BXKiI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2012 11:38:08 +0100
Received: by bkcjk13 with SMTP id jk13so2430056bkc.36
        for <linux-mips@linux-mips.org>; Fri, 24 Feb 2012 02:38:03 -0800 (PST)
Received-SPF: pass (google.com: domain of sshtylyov@mvista.com designates 10.204.130.129 as permitted sender) client-ip=10.204.130.129;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sshtylyov@mvista.com designates 10.204.130.129 as permitted sender) smtp.mail=sshtylyov@mvista.com
Received: from mr.google.com ([10.204.130.129])
        by 10.204.130.129 with SMTP id t1mr818573bks.42.1330079883138 (num_hops = 1);
        Fri, 24 Feb 2012 02:38:03 -0800 (PST)
Received: by 10.204.130.129 with SMTP id t1mr679672bks.42.1330079882941;
        Fri, 24 Feb 2012 02:38:02 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-85-203.pppoe.mtu-net.ru. [91.79.85.203])
        by mx.google.com with ESMTPS id o7sm7808015bkw.16.2012.02.24.02.38.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Feb 2012 02:38:02 -0800 (PST)
Message-ID: <4F47683F.1010303@mvista.com>
Date:   Fri, 24 Feb 2012 14:36:47 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V2 4/6] NET: MIPS: lantiq: convert etop to managed gpio
References: <1330012913-13293-1-git-send-email-blogic@openwrt.org> <1330012913-13293-4-git-send-email-blogic@openwrt.org>
In-Reply-To: <1330012913-13293-4-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmKmSW3SrRZ2GNMV4pdVLW+H8VLu7jXzvHDlrIVJqicfIdhFGCmcOQdop76fdJUvHcrmbPo
X-archive-position: 32539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 23-02-2012 20:01, John Crispin wrote:

> ltq_gpio_request() now uses devres to manage the gpios. We need to pass a
> struct device pointer to make it work.

> Signed-off-by: John Crispin<blogic@openwrt.org>
> Cc: netdev@vger.kernel.org
> ---
>   drivers/net/ethernet/lantiq_etop.c |    9 ++++++---
>   1 files changed, 6 insertions(+), 3 deletions(-)

> diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
> index 66ec54a..e5ec8b1 100644
> --- a/drivers/net/ethernet/lantiq_etop.c
> +++ b/drivers/net/ethernet/lantiq_etop.c
> @@ -292,9 +292,6 @@ ltq_etop_gbit_init(void)
>   {
>   	ltq_pmu_enable(PMU_SWITCH);
>
> -	ltq_gpio_request(42, 2, 1, "MDIO");
> -	ltq_gpio_request(43, 2, 1, "MDC");
> -
>   	ltq_gbit_w32_mask(0, GCTL0_SE, LTQ_GBIT_GCTL0);
>   	/** Disable MDIO auto polling mode */
>   	ltq_gbit_w32_mask(0, PX_CTL_DMDIO, LTQ_GBIT_P0_CTL);
> @@ -873,6 +870,12 @@ ltq_etop_probe(struct platform_device *pdev)
>   			err = -ENOMEM;
>   			goto err_out;
>   		}
> +		if (ltq_gpio_request(&pdev->dev, 42, 2, 1, "MDIO") ||
> +				ltq_gpio_request(&pdev->dev, 43, 2, 1, "MDC")) {

    This needs to be merged with patch 1 to keep the git tree bisectable

WBR, Sergei
