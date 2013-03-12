Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Mar 2013 12:18:19 +0100 (CET)
Received: from mail-la0-f51.google.com ([209.85.215.51]:33869 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825737Ab3CLLSSTlce- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Mar 2013 12:18:18 +0100
Received: by mail-la0-f51.google.com with SMTP id fo13so5068666lab.10
        for <linux-mips@linux-mips.org>; Tue, 12 Mar 2013 04:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=XgChmKg11C+YFy7dSvGjQ87EFKAN8PfPYh/dNFz8p9g=;
        b=IoANCe7F4Jp+a1pj7JxX8zi02e8bb5YL9k+L9zn2r6EXokmO51XhPhxZH4VIfB6OUs
         rZRS6ix7mO3e403uzOwO7Ue3eAl+qBFHh3tLkBT7Y5g/qu69ebaj6u/8EEnmdwVQVoI9
         nAd12Mfa+Pne08gU9Jsdp4mDieVfkrZktabFBRqWftoHJjxeOPi0RBd9DINVzU88XQVc
         D7DlXjZmp/FrIMpiFis9otF2PiBUb57ZTe+YaaQRypNDVTx8ts5wVOk9kQizCl2tHEGy
         n+9eo3RGoRDdpSzBEDAHmNBrAzVI6sESO9ZVJqccjeY1Fc11YoxXvvgrGeebZaMed/xm
         TaxA==
X-Received: by 10.112.16.106 with SMTP id f10mr5896093lbd.117.1363087092511;
        Tue, 12 Mar 2013 04:18:12 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-69-164.pppoe.mtu-net.ru. [91.79.69.164])
        by mx.google.com with ESMTPS id k15sm5574126lbd.6.2013.03.12.04.18.10
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 04:18:11 -0700 (PDT)
Message-ID: <513F0EC8.60709@cogentembedded.com>
Date:   Tue, 12 Mar 2013 15:17:28 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
MIME-Version: 1.0
To:     Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org, juhosg@openwrt.org,
        blogic@openwrt.org, kaloz@openwrt.org, xsecute@googlemail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: convert to devm_ioremap_resource()
References: <1363073281-9939-1-git-send-email-silviupopescu1990@gmail.com>
In-Reply-To: <1363073281-9939-1-git-send-email-silviupopescu1990@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQl9Mn7Rsl3Az/tCfEKgm8wzEN/TOoR5yiuYqi9gGQ2PjBuK7Mvn9smXZBR4Oz90+irl78+E
X-archive-position: 35872
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 12-03-2013 11:28, Silviu-Mihai Popescu wrote:

> Convert all uses of devm_request_and_ioremap() to the newly introduced
> devm_ioremap_resource() which provides more consistent error handling.

> devm_ioremap_resource() provides its own error messages so all explicit
> error messages can be removed from the failure code paths.

    There were no error messages as far as I could see, so this passage seems 
superfluous...

> Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
> ---
>   arch/mips/pci/pci-ar71xx.c |    6 +++---
>   arch/mips/pci/pci-ar724x.c |   18 +++++++++---------
>   2 files changed, 12 insertions(+), 12 deletions(-)

> diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
> index 412ec02..18517dd 100644
> --- a/arch/mips/pci/pci-ar71xx.c
> +++ b/arch/mips/pci/pci-ar71xx.c
> @@ -366,9 +366,9 @@ static int ar71xx_pci_probe(struct platform_device *pdev)
>   	if (!res)
>   		return -EINVAL;
>
> -	apc->cfg_base = devm_request_and_ioremap(&pdev->dev, res);
> -	if (!apc->cfg_base)
> -		return -ENOMEM;
> +	apc->cfg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(apc->cfg_base))
> +		return PTR_ERR(apc->cfg_base);
>
>   	apc->irq = platform_get_irq(pdev, 0);
>   	if (apc->irq < 0)
> diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
> index 8a0700d..65ec032 100644
> --- a/arch/mips/pci/pci-ar724x.c
> +++ b/arch/mips/pci/pci-ar724x.c
> @@ -365,25 +365,25 @@ static int ar724x_pci_probe(struct platform_device *pdev)
>   	if (!res)
>   		return -EINVAL;
>
> -	apc->ctrl_base = devm_request_and_ioremap(&pdev->dev, res);
> -	if (apc->ctrl_base == NULL)
> -		return -EBUSY;
> +	apc->ctrl_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(apc->ctrl_base))
> +		return PTR_ERR(apc->ctrl_base);
>
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg_base");
>   	if (!res)
>   		return -EINVAL;
>
> -	apc->devcfg_base = devm_request_and_ioremap(&pdev->dev, res);
> -	if (!apc->devcfg_base)
> -		return -EBUSY;
> +	apc->devcfg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(apc->devcfg_base))
> +		return PTR_ERR(apc->devcfg_base);
>
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "crp_base");
>   	if (!res)
>   		return -EINVAL;
>
> -	apc->crp_base = devm_request_and_ioremap(&pdev->dev, res);
> -	if (apc->crp_base == NULL)
> -		return -EBUSY;
> +	apc->crp_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(apc->crp_base))
> +		return PTR_ERR(apc->crp_base);
>
>   	apc->irq = platform_get_irq(pdev, 0);
>   	if (apc->irq < 0)

WBR, Sergei
