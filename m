Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 11:56:43 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:42842 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903647Ab2BXK4f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2012 11:56:35 +0100
Received: by bkcjk13 with SMTP id jk13so2444340bkc.36
        for <linux-mips@linux-mips.org>; Fri, 24 Feb 2012 02:56:30 -0800 (PST)
Received-SPF: pass (google.com: domain of sshtylyov@mvista.com designates 10.205.129.137 as permitted sender) client-ip=10.205.129.137;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sshtylyov@mvista.com designates 10.205.129.137 as permitted sender) smtp.mail=sshtylyov@mvista.com
Received: from mr.google.com ([10.205.129.137])
        by 10.205.129.137 with SMTP id hi9mr803173bkc.131.1330080990753 (num_hops = 1);
        Fri, 24 Feb 2012 02:56:30 -0800 (PST)
Received: by 10.205.129.137 with SMTP id hi9mr668368bkc.131.1330080990560;
        Fri, 24 Feb 2012 02:56:30 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-85-203.pppoe.mtu-net.ru. [91.79.85.203])
        by mx.google.com with ESMTPS id ey8sm7975326bkb.1.2012.02.24.02.56.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Feb 2012 02:56:29 -0800 (PST)
Message-ID: <4F476C93.2000304@mvista.com>
Date:   Fri, 24 Feb 2012 14:55:15 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V2 11/14] NET: MIPS: lantiq: convert etop driver to clkdev
 api
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org> <1330012993-13510-11-git-send-email-blogic@openwrt.org>
In-Reply-To: <1330012993-13510-11-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkGbSpcjSlVgvFfEMd5HDltmIsCIjHtPVS1IS3ygryd3Qyx1LM/hC+OPBon4GmycpqoU+69
X-archive-position: 32545
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
> Cc: netdev@vger.kernel.org
[...]

> diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
> index e5ec8b1..6b2e4b4 100644
> --- a/drivers/net/ethernet/lantiq_etop.c
> +++ b/drivers/net/ethernet/lantiq_etop.c
[...]
> @@ -886,6 +903,22 @@ ltq_etop_probe(struct platform_device *pdev)
>   	priv->pdev = pdev;
>   	priv->pldata = dev_get_platdata(&pdev->dev);
>   	priv->netdev = dev;
> +
> +	priv->clk_ppe = clk_get(&pdev->dev, NULL);
> +	if (!priv->clk_ppe)
> +		return -ENOENT;
> +	if (ltq_has_gbit()) {
> +		priv->clk_switch = clk_get(&pdev->dev, "switch");
> +		if (!priv->clk_switch)

    clk_get() doesn't retirn NULL, it returns error code.

> +			return -ENOENT;
> +	}
> +	if (ltq_is_ase()) {
> +		priv->clk_ephy = clk_get(&pdev->dev, "ephy");
> +		priv->clk_ephycgu = clk_get(&pdev->dev, "ephycgu");
> +		if (!priv->clk_ephy || !priv->clk_ephycgu)

    Same here.

WBR, Sergei
