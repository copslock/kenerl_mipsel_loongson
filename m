Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 13:07:15 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:57287 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491911Ab0KWMHI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Nov 2010 13:07:08 +0100
Received: by eyd9 with SMTP id 9so4504657eyd.36
        for <multiple recipients>; Tue, 23 Nov 2010 04:07:07 -0800 (PST)
Received: by 10.213.9.212 with SMTP id m20mr6575008ebm.11.1290514026792;
        Tue, 23 Nov 2010 04:07:06 -0800 (PST)
Received: from [192.168.2.2] ([91.79.70.65])
        by mx.google.com with ESMTPS id x54sm5739316eeh.23.2010.11.23.04.07.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 04:07:05 -0800 (PST)
Message-ID: <4CEBADFB.7040003@mvista.com>
Date:   Tue, 23 Nov 2010 15:05:15 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     Dmitri Vorobiev <dmitri.vorobiev@movial.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix build failure for IP22
References: <1290511948-10347-1-git-send-email-dmitri.vorobiev@movial.com>
In-Reply-To: <1290511948-10347-1-git-send-email-dmitri.vorobiev@movial.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 23-11-2010 14:32, Dmitri Vorobiev wrote:

> Commit 48e1fd5a81416a037f5a48120bf281102f2584e2 changed the name

    Linus has asled to also specify the commit summary in parens.

> of the MIPS-specific dma_cache_sync() routine by prefixing it with
> `mips_', and removed the export for its symbol. Two drivers, which
> did use dma_cache_sync(), namely, sgiseeq and sgiwd93, were not
> converted to use the new function, which led to build failure for
> the IP22 platform.

> This patch fixes the build failure by fixing the call sites of
> mips_dma_cache_sync() and exporting the symbol for this routine as
> a GPL symbol. While at it, some minor changes to improve Kconfig
> help entries were done.

> Signed-off-by: Dmitri Vorobiev<dmitri.vorobiev@movial.com>
[...]

> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index f6668cd..fe64edc 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -1925,6 +1925,9 @@ config SGISEEQ
>   	  Say Y here if you have an Seeq based Ethernet network card. This is
>   	  used in many Silicon Graphics machines.
>
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called sgiseeq.
> +

    This change is not metioned in the patch description...

> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 8616496..2d868bf 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -390,6 +390,9 @@ config SGIWD93_SCSI
>   	  If you have a Western Digital WD93 SCSI controller on
>   	  an SGI MIPS system, say Y.  Otherwise, say N.
>
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sgiwd93.
> +

    This change is not metioned in the patch description...

> diff --git a/drivers/scsi/sgiwd93.c b/drivers/scsi/sgiwd93.c
> index fef0e3c..be9fc40 100644
> --- a/drivers/scsi/sgiwd93.c
> +++ b/drivers/scsi/sgiwd93.c
> @@ -95,7 +95,7 @@ void fill_hpc_entries(struct ip22_hostdata *hd, struct scsi_cmnd *cmd, int din)
>   	 */
>   	hcp->desc.pbuf = 0;
>   	hcp->desc.cntinfo = HPCDMA_EOX;
> -	dma_cache_sync(hd->dev, hd->cpu,
> +	mips_dma_cache_sync(hd->dev, hd->cpu,
>   		       (unsigned long)(hcp + 1) - (unsigned long)hd->cpu,
>   		       DMA_TO_DEVICE);

    Don't you want to move the aboev 2 lines to the right also? You're 
breaking the existing alignments and leaving alignment spaces intact...

WBR, Sergei
