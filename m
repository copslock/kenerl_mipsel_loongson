Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 17:54:23 +0100 (CET)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:50368 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012148AbaJ2QyQCB8rW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 17:54:16 +0100
Received: by mail-pa0-f45.google.com with SMTP id lf10so3542620pab.4
        for <multiple recipients>; Wed, 29 Oct 2014 09:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oJyfagWHQwys9maJtUYRIe66QpLfsUk8GDYjreSJQuU=;
        b=xuWlUoAmNOGJDOP7MzfJNMPPniusWUbq1UOyg6oi7U1AC+jycZs9Zd2qXghDHP6m1R
         TkEgImCiKM2sVyWMEw8Nnx0eNyjiLmodxQZgM8HHQ8XMvlJSC2FpONBLZSPyOTEnHPIk
         CRoGT1tMRsjNsGqj2gAbUlTX3J7+oml4KAkYsGWexJ5HptF77qQt5+GBgRRsHo32jDot
         0+cr7spxyIAXijeSyk8czyaQegcBGDrenJQ/q3XUaOgyvAkPgiNoXZVHoWBgefN1xU3X
         ohU5j0KqFX2d/4GXZ1+l3WqXIwobtmyOp4vp40MBjatZDY6tzL7bureUCZWSZrNcqY2+
         aAGA==
X-Received: by 10.68.98.99 with SMTP id eh3mr11748556pbb.64.1414601649642;
        Wed, 29 Oct 2014 09:54:09 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id qh7sm4835112pab.48.2014.10.29.09.54.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 09:54:08 -0700 (PDT)
Message-ID: <54511B96.4000304@gmail.com>
Date:   Wed, 29 Oct 2014 09:53:42 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 04/11] irqchip: Remove ARM dependency for bcm7120-l2 and
 brcmstb-l2
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-4-git-send-email-cernekee@gmail.com>
In-Reply-To: <1414555138-6500-4-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 10/28/2014 08:58 PM, Kevin Cernekee wrote:
> This can compile for MIPS (or anything else) now.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/irqchip/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 6f0e80b..6a03c65 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -53,7 +53,6 @@ config ATMEL_AIC5_IRQ
>  
>  config BRCMSTB_L2_IRQ
>  	bool
> -	depends on ARM
>  	select GENERIC_IRQ_CHIP
>  	select IRQ_DOMAIN
>  
> 
