Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2009 11:41:27 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:35494 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493142AbZJEJlU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2009 11:41:20 +0200
Received: by fxm21 with SMTP id 21so2316720fxm.33
        for <multiple recipients>; Mon, 05 Oct 2009 02:41:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:organization:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=ITcqckERKJb2FUuD8XBlfYImvg7NcCIKcg4+LY6bRnk=;
        b=x6aRKLYC+83BR3CHxSisdes6dFfWWwKAGSWv8kdqD7UqYdfK0CtWmT63XT/LgBiwhJ
         Cr+DYyAsSQI2YYyweo2BGfNRaiijUzWY72dS/jCECewIn7/q7Tz6O9Zs0IlSmR+Fesl9
         9CIfI8WL7Q9dktjkhMHIs/vXJimEsk/MNFHAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :organization:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QC7rmbD7lpBIF78bsP13qRCyi3eO+fZmC4LcoeDKZGFeIVfx9T4j9UoSNq9B/CMMZt
         lXZqiFwoff0D/1R79CkJOqtkls1a060h3sj8Yvxjs1iEVX7hLmVRiE5ALrSfYoOCnbRK
         x7hXVhoe06cSEEgoVMCOO/XtY8njb4wdKQ5wE=
Received: by 10.86.231.5 with SMTP id d5mr4930319fgh.53.1254735673340;
        Mon, 05 Oct 2009 02:41:13 -0700 (PDT)
Received: from noex.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 4sm6704810fge.29.2009.10.05.02.41.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 05 Oct 2009 02:41:10 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] ar7: register watchdog driver only if enabled in hardware configuration
Date:	Mon, 5 Oct 2009 11:40:50 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.28-15-server; KDE/4.2.2; x86_64; ; )
Cc:	linux-mips@linux-mips.org
References: <200908042309.36721.florian@openwrt.org>
In-Reply-To: <200908042309.36721.florian@openwrt.org>
Organization: OpenWrt
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200910051140.51030.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Ralf,

Any comments on that patch ?

Thanks !

On Tuesday 04 August 2009 23:09:36 Florian Fainelli wrote:
> This patch checks if the watchdog enable bit is set in the DCL
> register meaning that the hardware watchdog actually works and
> if so, register the ar7_wdt platform_device.
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
> index e2278c0..835f3f0 100644
> --- a/arch/mips/ar7/platform.c
> +++ b/arch/mips/ar7/platform.c
> @@ -503,6 +503,7 @@ static int __init ar7_register_devices(void)
>  {
>  	u16 chip_id;
>  	int res;
> +	u32 *bootcr, val;
>  #ifdef CONFIG_SERIAL_8250
>  	static struct uart_port uart_port[2];
>
> @@ -595,7 +596,13 @@ static int __init ar7_register_devices(void)
>
>  	ar7_wdt_res.end = ar7_wdt_res.start + 0x20;
>
> -	res = platform_device_register(&ar7_wdt);
> +	bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
> +	val = *bootcr;
> +	iounmap(bootcr);
> +
> +	/* Register watchdog only if enabled in hardware */
> +	if (val & AR7_WDT_HW_ENA)
> +		res = platform_device_register(&ar7_wdt);
>
>  	return res;
>  }
> diff --git a/arch/mips/include/asm/mach-ar7/ar7.h
> b/arch/mips/include/asm/mach-ar7/ar7.h index de71694..21cbbc7 100644
> --- a/arch/mips/include/asm/mach-ar7/ar7.h
> +++ b/arch/mips/include/asm/mach-ar7/ar7.h
> @@ -78,6 +78,9 @@
>  #define AR7_REF_CLOCK	25000000
>  #define AR7_XTAL_CLOCK	24000000
>
> +/* DCL */
> +#define AR7_WDT_HW_ENA	0x10
> +
>  struct plat_cpmac_data {
>  	int reset_bit;
>  	int power_bit;
