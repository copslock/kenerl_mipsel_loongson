Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2008 10:27:37 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:40061 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20026684AbYEMJ1e (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 May 2008 10:27:34 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 3A4443EC9; Tue, 13 May 2008 02:27:29 -0700 (PDT)
Message-ID: <48295EFC.9090508@ru.mvista.com>
Date:	Tue, 13 May 2008 13:27:24 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 1.5.0.14 (Windows/20071210)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] au1xmmc: remove db1x00 board-specific functions from
 driver
References: <20080508080040.GA24383@roarinelk.homelinux.net> <20080508080301.GD24383@roarinelk.homelinux.net>
In-Reply-To: <20080508080301.GD24383@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:
> Remove the DB1200 board-specific functions (card present, read-only
> methods) and instead add platform data which is passed to the driver.
> This allows for platforms to implement other carddetect schemes
> (e.g. dedicated irq) without having to pollute the driver code.
> The poll timer (used for pb1200) is kept for compatibility.
>
> With the board-specific stuff gone, the driver no longer needs to know
> how many physical controllers the silicon actually has; every device
> can be registered as needed, update the code to reflect that.
>
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
[...]
> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
> index cc5f7bc..8660f86 100644
> --- a/drivers/mmc/host/au1xmmc.c
> +++ b/drivers/mmc/host/au1xmmc.c
[...]
> +static int __devinit au1xmmc_probe(struct platform_device *pdev)
> +{
> +	struct mmc_host *mmc;
> +	struct au1xmmc_host *host;
> +	struct resource *r;
> +	int ret;
> +
> +	mmc = mmc_alloc_host(sizeof(struct au1xmmc_host), &pdev->dev);
> +	if (!mmc) {
> +		dev_err(&pdev->dev, "no memory for mmc host\n");
> +		ret = -ENOMEM;
> +		goto out0;
> +	}
>  
> -		if (!mmc) {
> -			printk(DRIVER_NAME "ERROR: no mem for host %d\n", i);
> -			au1xmmc_hosts[i] = 0;
> -			continue;
> -		}
> +	host = mmc_priv(mmc);
> +	host->mmc = mmc;
> +	host->platdata = pdev->dev.platform_data;
> +	host->pdev = pdev;
>  
> -		mmc->ops = &au1xmmc_ops;
> +	ret = -ENODEV;
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r) {
> +		dev_err(&pdev->dev, "no mmio defined\n");
> +		goto out1;
> +	}
>   

   I forgot to mention that the driver should be calling 
request_mem_region() here...

WBR, Sergei
