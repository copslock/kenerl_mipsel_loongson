Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2012 19:57:55 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:51497 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903249Ab2IGR5p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Sep 2012 19:57:45 +0200
Received: by pbbrq8 with SMTP id rq8so4472358pbb.36
        for <multiple recipients>; Fri, 07 Sep 2012 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=m+oCvsuokBD9Qfz63z0Itd5eKEjREZTff9BEbKI/V4c=;
        b=cbwj9CcChdteR2iqLDLjqVu8jRVp+LF78ON/SRdM61w6/2CkR1U9RzSsJrOGyvGvVf
         L/nME21bPBj1E8WborSr6jCbnjPCxrU/5DkCvrhXc8G120CJHF9aTj9wgpqir8icK0o7
         0R3FoJNZ+3O01ex8XqdnknppXtmHrKiOoS3pAUyz2UgDT1BSUo5VbfMu5dVvohzA4m00
         MozVsy7DYsedT9h2I8A1xCarR2osGDH281GQR+r50YAyYfOebkTSFeZvH46uzHyYV1uG
         DSK2m+GH3mPJcvGTzB0qLJa6yG8nUHcoZ+R9rGlaEO8j5kX8YQloEiSUyilCvdbThZbs
         Pesg==
Received: by 10.68.226.195 with SMTP id ru3mr10534306pbc.149.1347040658711;
        Fri, 07 Sep 2012 10:57:38 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id or1sm3505021pbb.10.2012.09.07.10.57.36
        (version=SSLv3 cipher=OTHER);
        Fri, 07 Sep 2012 10:57:37 -0700 (PDT)
Message-ID: <504A358F.50904@gmail.com>
Date:   Fri, 07 Sep 2012 10:57:35 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     Charles Hardin <ckhardin@exablox.com>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Jeremy Fitzhardinge <jeremy@exablox.com>
Subject: Re: [PATCH] mips/octeon: 16-Bit NOR flash was not being detected
 during boot
References: <1346853293-9166-1-git-send-email-ckhardin@exablox.com>
In-Reply-To: <1346853293-9166-1-git-send-email-ckhardin@exablox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/05/2012 06:54 AM, Charles Hardin wrote:
> The cavium code assumed that all NOR on the boot bus was
> an 8-bit NOR part and hardcoded the bankwidth. The simple
> solution was to add the code that queries the configuration
> register for the width of the bus that has been hardware strapped
> to the Cavium. This allows both 8-bit and 16-bit parts to be
> discovered during boot.
>
> Signed-off-by: Charles Hardin <ckhardin@exablox.com>
>
> diff --git a/arch/mips/cavium-octeon/flash_setup.c b/arch/mips/cavium-octeon/flash_setup.c
> index e44a55b..9e46976 100644
> --- a/arch/mips/cavium-octeon/flash_setup.c
> +++ b/arch/mips/cavium-octeon/flash_setup.c
> @@ -51,7 +51,17 @@ static int __init flash_init(void)
>   		flash_map.name = "phys_mapped_flash";
>   		flash_map.phys = region_cfg.s.base << 16;
>   		flash_map.size = 0x1fc00000 - flash_map.phys;
> -		flash_map.bankwidth = 1;
> +		switch (region_cfg.s.width) {
> +		default:
> +		case 0:
> +			/* 8-bit bus */
> +			flash_map.bankwidth = 1;
> +			break;
> +		case 1:
> +			/* 16-bit bus */
> +			flash_map.bankwidth = 2;
> +			break;
> +		}

A slightly less verbose version of this would be:

-       flash_map.bankwidth = 1;
+       flash_map.bankwidth = region_cfg.s.width + 1;


Can you test that instead?

If it works, Acked-by me.

David Daney
