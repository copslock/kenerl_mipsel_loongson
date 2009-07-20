Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jul 2009 22:00:50 +0200 (CEST)
Received: from cpsmtpm-eml102.kpnxchange.com ([195.121.3.6]:49533 "EHLO
	CPSMTPM-EML102.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492976AbZGTUAo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Jul 2009 22:00:44 +0200
Received: from aragorn.fjphome.nl ([84.85.147.182]) by CPSMTPM-EML102.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Mon, 20 Jul 2009 22:00:40 +0200
From:	Frans Pop <elendil@planet.nl>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] au1xmmc: dev_pm_ops conversion
Date:	Mon, 20 Jul 2009 22:00:37 +0200
User-Agent: KMail/1.9.9
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	manuel.lauss@gmail.com
References: <1248115882-20221-1-git-send-email-manuel.lauss@gmail.com>
In-reply-To: <1248115882-20221-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200907202200.39288.elendil@planet.nl>
X-OriginalArrivalTime: 20 Jul 2009 20:00:40.0925 (UTC) FILETIME=[C20208D0:01CA0974]
Return-Path: <elendil@planet.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elendil@planet.nl
Precedence: bulk
X-list: linux-mips

> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Run-tested on Au1200.
>
> �drivers/mmc/host/au1xmmc.c | � 23 +++++++++++------------
> �1 files changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
> index d3f5561..70509c9 100644
> --- a/drivers/mmc/host/au1xmmc.c
> +++ b/drivers/mmc/host/au1xmmc.c
> @@ -1131,13 +1131,12 @@ static int __devexit au1xmmc_remove(struct
> platform_device *pdev) return 0;
> �}
> �
> -#ifdef CONFIG_PM

Won't the removal of this test cause a build failure if CONFIG_PM is not 
set? If the removal of the test is safe, this should IMHO at least be 
explained in the commit message.

The IMO simplest fix would be to restore the #ifdef ...

> -static int au1xmmc_suspend(struct platform_device *pdev, pm_message_t
> state) +static int au1xmmc_suspend(struct device *dev)
> �{
> -�������struct au1xmmc_host *host = platform_get_drvdata(pdev);
> +�������struct au1xmmc_host *host = dev_get_drvdata(dev);
> ��������int ret;
> �
> -�������ret = mmc_suspend_host(host->mmc, state);
> +�������ret = mmc_suspend_host(host->mmc, PMSG_SUSPEND);
> ��������if (ret)
> ����������������return ret;
> �
> @@ -1150,27 +1149,27 @@ static int au1xmmc_suspend(struct
> platform_device *pdev, pm_message_t state) return 0;
> �}
> �
> -static int au1xmmc_resume(struct platform_device *pdev)
> +static int au1xmmc_resume(struct device *dev)
> �{
> -�������struct au1xmmc_host *host = platform_get_drvdata(pdev);
> +�������struct au1xmmc_host *host = dev_get_drvdata(dev);
> �
> ��������au1xmmc_reset_controller(host);
> �
> ��������return mmc_resume_host(host->mmc);
> �}
> -#else
> -#define au1xmmc_suspend NULL
> -#define au1xmmc_resume NULL

... drop the 3 lines above (as you did) ...

> -#endif

... move this #endif to after the new struct below ...

> +
> +static struct dev_pm_ops au1xmmc_pmops = {
> +�������.resume���������= au1xmmc_resume,
> +�������.suspend��������= au1xmmc_suspend,
> +};
> �
> �static struct platform_driver au1xmmc_driver = {
> ��������.probe � � � � = au1xmmc_probe,
> ��������.remove � � � �= au1xmmc_remove,
> -�������.suspend � � � = au1xmmc_suspend,
> -�������.resume � � � �= au1xmmc_resume,
> ��������.driver � � � �= {
> ����������������.name �= DRIVER_NAME,
> ����������������.owner = THIS_MODULE,
> +���������������.pm � �= &au1xmmc_pmops,

... and add an #ifdef CONFIG_PM around the new line above.

> ��������},
> �};

Cheers,
FJP
