Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jul 2010 19:10:49 +0200 (CEST)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:53056 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492159Ab0GKRKp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Jul 2010 19:10:45 +0200
Received: by wwe15 with SMTP id 15so2413974wwe.0
        for <multiple recipients>; Sun, 11 Jul 2010 10:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=Wcdtoqa6H9UmmcGKKgbPUhyDEFAcMAZEiRX7AHEFshs=;
        b=qnFXwx7KSqP/u2oMSlr9baof/o9Te7xZEKsFKfbCU/DJlFKP9G7oxtEBUc+joMZrsX
         M5eGtn+Y+7Rv/2N9qKvjUty9W0NyFmsyCuGelBpVa76wrjYAUWhzakuYgHazbk6n1uDp
         o3yleFXLPjC9CTbgxlXxm4DNPq/cx9xcS917c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=o8qNe566WA5pKXeVhDAtXNigLahypb5iz3O3FP2ubfM94W+AXDTiBgv9DpJFJ2jJlS
         ijZNFda3whvlpEaRRylm1g8vy5Zdhv0t5xpltsU9ORPXw+HfbV+0aKoVng1MlxUXkxpS
         nfCHpfIe1idzWNeOA9PvHd7gZHthXKFiS0tzc=
Received: by 10.216.236.146 with SMTP id w18mr2324377weq.19.1278868238874;
        Sun, 11 Jul 2010 10:10:38 -0700 (PDT)
Received: from lenovo.localnet (147.199.66-86.rev.gaoland.net [86.66.199.147])
        by mx.google.com with ESMTPS id o11sm1207862wej.45.2010.07.11.10.10.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 10:10:38 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:     Bruno Randolf <randolf.bruno@googlemail.com>
Subject: Re: [PATCH 2/2] MIPS: MTX-1: cleanup and comments
Date:   Sun, 11 Jul 2010 19:11:01 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.34-1-amd64; KDE/4.4.4; x86_64; ; )
Cc:     linux-mips@linux-mips.org, manuel.lauss@googlemail.com,
        ralf@linux-mips.org
References: <20100711154028.29863.74414.stgit@void> <20100711154038.29863.23111.stgit@void>
In-Reply-To: <20100711154038.29863.23111.stgit@void>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <201007111911.02200.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Sunday 11 July 2010 17:40:38, Bruno Randolf a écrit :
> Add some comments about mtx1_pci_idsel() and remove a dead block of old
> code.
> 
> Signed-off-by: Bruno Randolf <br1@einfach.org>

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>  arch/mips/alchemy/mtx-1/board_setup.c |   12 ++++--------
>  1 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/alchemy/mtx-1/board_setup.c
> b/arch/mips/alchemy/mtx-1/board_setup.c index 52d883d..3cf2fa2 100644
> --- a/arch/mips/alchemy/mtx-1/board_setup.c
> +++ b/arch/mips/alchemy/mtx-1/board_setup.c
> @@ -105,14 +105,10 @@ void __init board_setup(void)
>  int
>  mtx1_pci_idsel(unsigned int devsel, int assert)
>  {
> -#define MTX_IDSEL_ONLY_0_AND_3 0
> -#if MTX_IDSEL_ONLY_0_AND_3
> -	if (devsel != 0 && devsel != 3) {
> -		printk(KERN_ERR "*** not 0 or 3\n");
> -		return 0;
> -	}
> -#endif
> -
> +	/* This function is only necessary to support a proprietary Cardbus
> +	 * adapter on the mtx-1 "singleboard" variant. It triggers a custom
> +	 * logic chip connected to EXT_IO3 (GPIO1) to suppress IDSEL signals.
> +	 */
>  	if (assert && devsel != 0)
>  		/* Suppress signal to Cardbus */
>  		alchemy_gpio_set_value(1, 0);	/* set EXT_IO3 OFF */
