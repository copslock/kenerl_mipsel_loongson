Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 19:45:59 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:64486 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491849Ab1EMRp4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 19:45:56 +0200
Received: by wyb28 with SMTP id 28so2676410wyb.36
        for <linux-mips@linux-mips.org>; Fri, 13 May 2011 10:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=0YbpKfI6Gs+b8MORfOu6R3cMawQfFWQ1J2nAFESqdJ0=;
        b=CKveLk37XFyL6zPvo4Gue3gcmjt6+v95K1xjbIb3FuGzWaankWhQ4lvC4Kjosg4/96
         rb2W13luA/QnnObeDKNgGGjFDotvifIgXrPx8oQRhvKeYtpSc+Eok1y2LG9D3II4Guwo
         DJuKeyXx6cSxQY9cp5g2NG9TO+kxj8dpgOUmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=lfTkiVYtQUM/xAJ/V/sBbSgRtH9eCpn7V+VYxq3jRDn5JXAwaMoSL6W3iblxrJ9/Bm
         6fcC2mvCWv2408PmdKewF5tO3EL/HtjD8s98FsnYEbvFAbW6QOf6/JcyQbRBmpaPLbHq
         Sy4e36IwT3SH+7HXUaVzX7QMzCUWppB4HmnOI=
Received: by 10.216.239.67 with SMTP id b45mr512150wer.44.1305301693224;
        Fri, 13 May 2011 08:48:13 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id m14sm1213108wes.14.2011.05.13.08.48.11
        (version=SSLv3 cipher=OTHER);
        Fri, 13 May 2011 08:48:11 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH] MIPS: AR7: Fix GCC 4.6.0 build error.
Date:   Fri, 13 May 2011 17:52:42 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org
References: <20110513152855.GM25017@chipmunk>
In-Reply-To: <20110513152855.GM25017@chipmunk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201105131752.42505.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hello Alexander,

On Friday 13 May 2011 17:28:55 Alexander Clouter wrote:
>   CC      arch/mips/ar7/gpio.o
> arch/mips/ar7/gpio.c: In function 'ar7_gpio_init':
> arch/mips/ar7/gpio.c:318:11: error: variable 'size' set but not used
> [-Werror=unused-but-set-variable] cc1: all warnings being treated as
> errors
> 
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  arch/mips/ar7/gpio.c |   12 ++----------
>  1 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
> index 425dfa5..6917427 100644
> --- a/arch/mips/ar7/gpio.c
> +++ b/arch/mips/ar7/gpio.c
> @@ -314,16 +314,8 @@ static void titan_gpio_init(void)
>  int __init ar7_gpio_init(void)
>  {
>  	int ret;
> -	struct ar7_gpio_chip *gpch;
> -	unsigned size;
> -
> -	if (!ar7_is_titan()) {
> -		gpch = &ar7_gpio_chip;
> -		size = 0x10;
> -	} else {
> -		gpch = &titan_gpio_chip;
> -		size = 0x1f;
> -	}
> +	struct ar7_gpio_chip *gpch = (!ar7_is_titan())
> +		? &ar7_gpio_chip : &titan_gpio_chip;
> 
>  	gpch->regs = ioremap_nocache(AR7_REGS_GPIO,
>  					AR7_REGS_GPIO + 0x10);

From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] AR7: fix gpio register size for Titan variant.

The 'size' variable contains the correct register size for both AR7
and Titan, but we never used it to ioremap the correct register size.
This problem only shows up on Titan.

Reported-by: Alexander Clouter <alex@digriz.org.uk>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
index 425dfa5..a8aa1b4 100644
--- a/arch/mips/ar7/gpio.c
+++ b/arch/mips/ar7/gpio.c
@@ -326,7 +326,7 @@ int __init ar7_gpio_init(void)
 	}
 
 	gpch->regs = ioremap_nocache(AR7_REGS_GPIO,
-					AR7_REGS_GPIO + 0x10);
+					AR7_REGS_GPIO + size);
 
 	if (!gpch->regs) {
 		printk(KERN_ERR "%s: failed to ioremap regs\n",
-- 
1.7.4.1
