Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2011 12:10:05 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:33835 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491050Ab1FHKKC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jun 2011 12:10:02 +0200
Received: by wyb28 with SMTP id 28so297878wyb.36
        for <multiple recipients>; Wed, 08 Jun 2011 03:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=+FZfwqk3Vf3l+NBjW/fLN/awIRpNms37Srr5EhUKCdk=;
        b=rL65kiiU8isyWaTz4yKCbCHv2ZAS1DlpOICJjMyA0ej5fUqOQHtpE/2Pp1t6gZ2UnG
         08ITojJOOBScpg8WbvL6dRiDk6fp41PghHglf1CSAqjiCDPi7d0hMGy/FVqG7ykCErHZ
         VnYka/UclMQpq68LOPiUZw/eR6V5q54NcT2S8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=pulszT3574QWz2kw6u5pllZFrGryhrOi1CxpskfmrZEicozke8SYTIubu3763fb/PP
         P7JgVFOPRvp/KqFhYCRo6Iqa6PkQvIOdW9L+qJGzSlA2DWWBWk2mpQbw3LUDyadmBr0j
         GNVOnYJIKETQD7JcepBnXe/ZsIxCh9RYeUUSw=
Received: by 10.227.131.31 with SMTP id v31mr7446636wbs.19.1307527796994;
        Wed, 08 Jun 2011 03:09:56 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id en1sm284715wbb.35.2011.06.08.03.09.55
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 03:09:56 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH] MIPS: bcm63xx: remove duplicate PERF_IRQSTAT_REG definition
Date:   Wed, 8 Jun 2011 12:14:16 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <1307527382-23623-1-git-send-email-jonas.gorski@gmail.com>
In-Reply-To: <1307527382-23623-1-git-send-email-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201106081214.16538.florian@openwrt.org>
X-archive-position: 30295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6674

On Wednesday 08 June 2011 12:03:02 Jonas Gorski wrote:
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h index 85fd275..0ed5230
> 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> @@ -89,7 +89,6 @@
> 
>  /* Interrupt Mask register */
>  #define PERF_IRQMASK_REG		0xc
> -#define PERF_IRQSTAT_REG		0x10
> 
>  /* Interrupt Status register */
>  #define PERF_IRQSTAT_REG		0x10
