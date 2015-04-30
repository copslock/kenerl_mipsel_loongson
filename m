Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2015 05:30:03 +0200 (CEST)
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35439 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006211AbbD3DaBRdZ-Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2015 05:30:01 +0200
Received: by oign205 with SMTP id n205so38175613oig.2;
        Wed, 29 Apr 2015 20:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=aVPuEcTRYCccgeIKRVpzJ6x73HyCupSwNarA9xTVXW0=;
        b=SeJB5jZjvebNDGj/FVxA+onXEsVe5mQw6AQiazlXRvP+X5TU1RvWRLperLIvUU3qox
         41PSKDiFMUCO60n+6gw++T1qauFoTJKbn6gSQ6DHipWDyMSrtLhQSA67wde4fAqiJZ1d
         XztrufwIqR91IAa/bAamCe//IPh6nrYD2Hn3D4G4AEwevh1CkBtmneWHJYxNmZ5+0T+M
         eC2yhBGiovwag4OETRf3GMzBl/Yw1u1vVq3zxEhpq92lmEcPUNJlZP19xiQkFz/DFwM2
         9GJBHYqZJ+GfOttlSQuM06aACHl4iOeLwWxtW9cDuFdM+wB8BZv5QJuQewjkSGbZ+BDD
         C4/A==
X-Received: by 10.60.177.73 with SMTP id co9mr1784683oec.5.1430364597142;
        Wed, 29 Apr 2015 20:29:57 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:a107:27cc:b4e6:3d07? ([2001:470:d:73f:a107:27cc:b4e6:3d07])
        by mx.google.com with ESMTPSA id x17sm705803oif.1.2015.04.29.20.29.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2015 20:29:56 -0700 (PDT)
Message-ID: <5541A1B3.6050404@gmail.com>
Date:   Wed, 29 Apr 2015 20:29:55 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@chromium.org>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org, valentinrothberg@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: BMIPS: Delete unused Kconfig symbol
References: <1430243570-6143-1-git-send-email-cernekee@chromium.org>
In-Reply-To: <1430243570-6143-1-git-send-email-cernekee@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47167
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

Le 04/28/15 10:52, Kevin Cernekee a écrit :
> This was left over from an earlier iteration of the BMIPS irqchip changes.
> It doesn't actually have an effect, so let's nuke it.
> 
> Reported-by: Valentin Rothberg <valentinrothberg@gmail.com>
> Signed-off-by: Kevin Cernekee <cernekee@chromium.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
> 
> 
> Ralf - could you please pull this for 4.1?
> 
> 
>  arch/mips/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index f5016656494f..19e5d40fdf40 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -147,7 +147,6 @@ config BMIPS_GENERIC
>  	select BCM7120_L2_IRQ
>  	select BRCMSTB_L2_IRQ
>  	select IRQ_CPU
> -	select RAW_IRQ_ACCESSORS
>  	select DMA_NONCOHERENT
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
> 


-- 
Florian
