Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2012 13:03:48 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35325 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903613Ab2EOLDl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2012 13:03:41 +0200
Received: by lbbgg6 with SMTP id gg6so5048893lbb.36
        for <linux-mips@linux-mips.org>; Tue, 15 May 2012 04:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=PSu5RAJsGFP7BK/LAMxW5XBNSbiAGeZF4me/46X4j7M=;
        b=iq2FYMcT/MSczC7oD74zi/4pqPrOEQ69/Ln5sxi3yYgt6NMWtbXpJDSLHaMDC7kTcT
         BJvf+0q7b1mtSaiqgjE3aFSXsilvyLR3v9/9ukhYu9cn0L5Uv7IzfBXbBFm+ipTMYQda
         l8JJdin5v19q5kFYl0Zyr1NIPWs1KtaGSwaRy2+HSuoSmU/Osh6xsg42fO6Y6G9OuL/e
         CzKUoIdqB1sloSaZ1Uz1CJc/s+tZAT7lEkcd/FUZs9riLvIWRLyMUDevT+jNPeFm+yRf
         oNp0zSJ84TsfiGWwMbkzQD4pNHKLXSsbEE0+UQjUnfXq/pUdMx79vuLcykD8soDhdjoY
         K6Yg==
Received: by 10.152.132.166 with SMTP id ov6mr12812088lab.35.1337079814855;
        Tue, 15 May 2012 04:03:34 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-80-113.pppoe.mtu-net.ru. [91.79.80.113])
        by mx.google.com with ESMTPS id k4sm28094014lbb.12.2012.05.15.04.03.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 May 2012 04:03:33 -0700 (PDT)
Message-ID: <4FB237EE.5010502@mvista.com>
Date:   Tue, 15 May 2012 15:03:10 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RESEND PATCH V2 06/17] MIPS: lantiq: convert dma to platform
 driver
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org> <1337017363-14424-6-git-send-email-blogic@openwrt.org>
In-Reply-To: <1337017363-14424-6-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkVNQGN/s24ihdLme5T3Hw/DLVee/yk7gZRU8ZTvwC9zDCgzD6LK+jeUaB/h36k1hJLnyQS
X-archive-position: 33324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 14-05-2012 21:42, John Crispin wrote:

> Add code to make the dma driver load as a platform device from the devicetree.

> Signed-off-by: John Crispin<blogic@openwrt.org>
> ---
>   arch/mips/lantiq/xway/dma.c |   65 ++++++++++++++++++++++++++++--------------
>   1 files changed, 43 insertions(+), 22 deletions(-)

> diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
> index b210e93..0dffb94 100644
> --- a/arch/mips/lantiq/xway/dma.c
> +++ b/arch/mips/lantiq/xway/dma.c
[...]
> +int __init
> +dma_init(void)
> +{
> +	int ret = platform_driver_register(&dma_driver);
> +
> +	if (ret)
> +		pr_info("ltq_dma : Error registering platfom driver!");

    You forgot '\n'.

WBR, Sergei
