Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2011 10:20:16 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:41070 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491072Ab1FVIUN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Jun 2011 10:20:13 +0200
Received: by wyf23 with SMTP id 23so487238wyf.36
        for <linux-mips@linux-mips.org>; Wed, 22 Jun 2011 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=ufABq1Hi1gzdV3w9ksOCe71Esz2sGkknwQB6cd8hLNI=;
        b=wirREyekT2YRoYzY3gr3Ga50xglGcFUp6ba8Vwu+TgPUSDTmCPKPtsvp8H70VYXZKR
         qRQi4Cld1o5cyO48KVy7gIkKz21Vks/vrCMQBh1IvPumhhK6NSv8Dd3Yum5u0fqWoGbd
         b/uo+IMfXRVCFI5KmiIv3NPBg0osaAkbyiTlI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=UnNoKXzWaSthRGXp0IqWZ/iWO6I24fMIl0WCLt4Gd+tUC2xd9hvPXkFCRfVB92QvAF
         NxixblAXY1LuSacug5silrOKdhyk9O/hPJ1JPM/ZaTQheBeM6zMzc3DeIyuo1ZAjsGe7
         qaLA9N+HUS42orrWt8MjmMwCEkRhJX2fC2GaE=
Received: by 10.227.160.11 with SMTP id l11mr419788wbx.1.1308730807684;
        Wed, 22 Jun 2011 01:20:07 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id o19sm242758wbh.21.2011.06.22.01.20.05
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 01:20:05 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 1/5 v3] WATCHDOG: mtx1-wdt: use dev_{err,info} instead of printk()
Date:   Wed, 22 Jun 2011 10:24:20 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Jamie Iles <jamie@jamieiles.com>
References: <201106151915.09729.florian@openwrt.org>
In-Reply-To: <201106151915.09729.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106221024.20485.florian@openwrt.org>
X-archive-position: 30490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17887

On Wednesday 15 June 2011 19:15:09 Florian Fainelli wrote:
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> No changes in v1, v2 and v3

Wim, these are mostly fixes for the driver, do you prefer they get merged with the MIPS tree?

> 
> diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
> index 1479dc4..63df28c 100644
> --- a/drivers/watchdog/mtx-1_wdt.c
> +++ b/drivers/watchdog/mtx-1_wdt.c
> @@ -224,11 +224,11 @@ static int __devinit mtx1_wdt_probe(struct
> platform_device *pdev)
> 
>  	ret = misc_register(&mtx1_wdt_misc);
>  	if (ret < 0) {
> -		printk(KERN_ERR " mtx-1_wdt : failed to register\n");
> +		dev_err(&pdev->dev, "failed to register\n");
>  		return ret;
>  	}
>  	mtx1_wdt_start();
> -	printk(KERN_INFO "MTX-1 Watchdog driver\n");
> +	dev_info(&pdev->dev, "MTX-1 Watchdog driver\n");
>  	return 0;
>  }
