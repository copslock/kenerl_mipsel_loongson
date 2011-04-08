Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2011 14:39:54 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:58493 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491073Ab1DHMjv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Apr 2011 14:39:51 +0200
Received: by wwb17 with SMTP id 17so3675792wwb.24
        for <multiple recipients>; Fri, 08 Apr 2011 05:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=2nvSnqx0enimr9pGiLCUl1i+BdkguSTaNu5KUZ36thQ=;
        b=YSyGXsADVTCpRsPm7EyQvJ4081dqk5L6ibKFcJr3y989HsC97McHvQJpmCBvUdd7hW
         q8v6Ko1gSceEdmK8KwSQSXh+i8SrL5aJQXp9ZxVFAwQ/9xO1+OIUjYlZJN9N1LvMNTm2
         pZlStcSJwPJ+pHOjqjafhcZIrDjeUVOiSaOIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=mDQFevq80qdlFEfPVp217B7RbR2wlnOnjUwQQAp+6ZuT8WrTBbvxeDotbu5yVBrvk9
         Mdn5VENfFKUHJQaCbK7TOo6STPma/yCpePmkpfR1/04zF+8NFampUAhOY3NoeK3kLpY0
         Wb4KbYdkscoFIl6siIabB/sui6dlKTzczSKz4=
Received: by 10.216.59.205 with SMTP id s55mr265641wec.72.1302266383123;
        Fri, 08 Apr 2011 05:39:43 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id b20sm1682091wbb.67.2011.04.08.05.39.41
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Apr 2011 05:39:41 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH] MIPS: bcm63xx: Fix header_crc comment in bcm963xx_tag.h
Date:   Fri, 8 Apr 2011 14:41:30 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.35-25-server; KDE/4.5.1; x86_64; ; )
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <1302265935-23802-1-git-send-email-jonas.gorski@gmail.com>
In-Reply-To: <1302265935-23802-1-git-send-email-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201104081441.30827.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

On Friday 08 April 2011 14:32:15 Jonas Gorski wrote:
> The CRC32 actually includes the tag_version.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
> 
> This was already wrong in the original Broadcom sources (and it still
> seems to be).
> 
>  arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h
> b/arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h index 5325084..73c499f
> 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h
> @@ -88,7 +88,7 @@ struct bcm_tag {
>  	char kernel_crc[CRC_LEN];
>  	/* 228-235: Unused at present */
>  	char reserved1[8];
> -	/* 236-239: CRC32 of header excluding tagVersion */
> +	/* 236-239: CRC32 of header excluding last 20 bytes */
>  	char header_crc[CRC_LEN];
>  	/* 240-255: Unused at present */
>  	char reserved2[16];
