Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 07:35:38 +0100 (CET)
Received: from mail-iw0-f183.google.com ([209.85.223.183]:61088 "EHLO
        mail-iw0-f183.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491852Ab0BAGfd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 07:35:33 +0100
Received: by iwn13 with SMTP id 13so252669iwn.20
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2010 22:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=lQ7CVHceWGeOru1CECZ0uuHJX+bNelRNB5k81G4+aeQ=;
        b=WiMzVm1UY3xXREoj1CkEOFQrDaEthR+2H+tw5svfC87a2l/7NiL7yH7AG7ZAFMUYRJ
         nyksI4TMAR71Zxf9K8pLUwWwcm1stntC/7KugD9V8Zmuzc/Ywt0ETY0yF1etQKY/lWJB
         Y+bHdfaqy/o7A/TGoEIeB6ZAB92+mtwEIAe0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=wrdWfZtygx4ykurAyriu/o/qOXY9rtHU2BomiPeQIyb0JWmHKWzgLkZCzopGPbY66g
         sjrb/d/K+697bdxcyeUgI+xdU0/EM3Kqqy/fd4bFHY2emZNEXnuu1pOJ3DK332lHp9RP
         ZrGoN0GI5m/S09bhBsWYBQF/vxbGR/CgSrBpE=
Received: by 10.231.148.83 with SMTP id o19mr279622ibv.39.1265006125863;
        Sun, 31 Jan 2010 22:35:25 -0800 (PST)
Received: from ?192.168.2.212? ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm5141367iwn.10.2010.01.31.22.35.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 22:35:25 -0800 (PST)
Subject: Re: [PATCH 1/3] MIPS: AR7 whitespace hacking
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Alexander Clouter <alex@digriz.org.uk>
Cc:     linux-mips@linux-mips.org
In-Reply-To: <bq2h37-ch6.ln1@chipmunk.wormnet.eu>
References: <bq2h37-ch6.ln1@chipmunk.wormnet.eu>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 01 Feb 2010 14:29:17 +0800
Message-ID: <1265005758.31984.8.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, 2010-01-31 at 19:38 +0000, Alexander Clouter wrote:
> MIPS: AR7 whitespace hacking
> 
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
[...]
>  void __init prom_free_prom_memory(void)
> diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
> index c591f69..76a358e 100644
> --- a/arch/mips/ar7/platform.c
> +++ b/arch/mips/ar7/platform.c
> @@ -42,39 +42,42 @@
>  #include <asm/mach-ar7/gpio.h>
>  #include <asm/mach-ar7/prom.h>
>  
> +/*****************************************************************************
> + * VLYNQ Bus
> + ****************************************************************************/

Why not simply use:

/* VLYNQ Bus */

You have deleted lots of whitespaces, but added more *.

[...]
> +/*****************************************************************************
> + * Flash
> + ****************************************************************************/
[...]
> +
> +/*****************************************************************************
> + * Ethernet
> + ****************************************************************************/
[...]
> +
> +/*****************************************************************************
> + * USB
> + ****************************************************************************/
> +
[...]
>  
> +/*****************************************************************************
> + * LEDs
> + ****************************************************************************/
[...]
> +/*****************************************************************************
> + * Watchdog
> + ****************************************************************************/
[...]
> +
> +/*****************************************************************************
> + * Init
> + ****************************************************************************/
[...]
>  
> @@ -70,7 +71,6 @@ console_initcall(ar7_init_console);
>   * Initializes basic routines and structures pointers, memory size (as
>   * given by the bios and saves the command line.
>   */
> -
>  void __init plat_mem_setup(void)
>  {
>  	unsigned long io_base;
> @@ -88,6 +88,5 @@ void __init plat_mem_setup(void)
>  	prom_meminit();
>  
>  	printk(KERN_INFO "%s, ID: 0x%04x, Revision: 0x%02x\n",
> -					get_system_type(),
> -		ar7_chip_id(), ar7_chip_rev());
> +			get_system_type(), ar7_chip_id(), ar7_chip_rev());
>  }

Perhaps you can use pr_info() instead of printk(KERN_INFO) too, of
course, if there are more printk(KERN_...), you can replace them by
pr_xxx defined in include/linux/kernel.h

Best Regards,
	Wu Zhangjin
