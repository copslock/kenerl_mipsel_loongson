Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Jan 2018 22:41:06 +0100 (CET)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:41940
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992645AbeANVk7H6Kdj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Jan 2018 22:40:59 +0100
Received: by mail-pf0-x242.google.com with SMTP id j3so7169972pfh.8
        for <linux-mips@linux-mips.org>; Sun, 14 Jan 2018 13:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x3RWKwRLvywrAqmAbTKden0sWSnlabUakVfWUcupsR8=;
        b=bohUPOokAT/+7oRbgfaO9bUrT9KBn+tGFqxOIDlFOvRdZMhXf4GaOGpx3zAOKVUCSS
         85NNZL5/MVcuowHxurwoYf9DwtNRUnS1drz8x/VQvG+LU8cVjws2dY2OCSZWshqmu+dO
         tDwsMyQG5WVvivgBMU1zqxlBlJyxHD3J/W7N51r9ELo1w45QvYT9sShkcTv/vyMMJkYo
         OTf8MxPckFLA4M+tymRDzVTf6PamHMBpPC2KOLe3SHQDADOVXVq47bOcWCiq1ClJkwAs
         jP8PcbQn+DyvrRsreRjCtRVVuNzmlzsuvHzr1DnjWVVnAMgYnT26X0P/LaScG3EBJwGM
         POCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x3RWKwRLvywrAqmAbTKden0sWSnlabUakVfWUcupsR8=;
        b=H7qLsozT9C5KLMCZ2VDS57FWCJSMMQhUm5mM3nq+gSnnAPoBj6nRotkupCkglIE8EF
         GOBfD5VGwqiWXpRTcvrDIkEmFRZeOp0BatsOWk9WnMqJaOJUGKlBIEVWKz/Z9osy0DNM
         ItNojYjKctK4JVYOAnhZY+0Rn9OprLMTg39QJTZoA+4WT3KCtDUNWtu614jphB0dbEI+
         ZoFo2lOjdjTCh1ZyWSgfCnKM7ghvXmNeXXYTHOxOgb723ZttdJJ5+rZV3sjexMU6M7Co
         TI6b2GZ7DINH9tFp499bxKUalfeyyFKHH14MIC+EasFKU0+wh64Xxn+2SRWyjf7jMX/I
         P8yQ==
X-Gm-Message-State: AKGB3mJ3kH2rXyPxqelEGm/mqNs7EaYkt4KAPrlSDVayGHdeWfZ5Z/XP
        nPa3sTQNYzqwR5tyC0d58cfzlw==
X-Google-Smtp-Source: ACJfBovDoESYfqqM24pRi96AriOEu1I7oGR3nfoUX9KcVkzZXoINW9srpkTOJji3IAh5YOs//LpYWw==
X-Received: by 10.99.124.24 with SMTP id x24mr24145191pgc.351.1515966052213;
        Sun, 14 Jan 2018 13:40:52 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x17sm11052739pge.50.2018.01.14.13.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jan 2018 13:40:51 -0800 (PST)
Subject: Re: [PATCH] bcma: Fix 'allmodconfig' and BCMA builds on MIPS targets
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        James Hogan <jhogan@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
References: <1515965642-16259-1-git-send-email-linux@roeck-us.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <db5915ed-fc50-292f-c86b-4da7f3f0eddd@roeck-us.net>
Date:   Sun, 14 Jan 2018 13:40:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1515965642-16259-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

[ copying linux-mips ]

On 01/14/2018 01:34 PM, Guenter Roeck wrote:
> Mips builds with BCMA host mode enabled fail in mainline and -next
> with:
> 
> In file included from include/linux/bcma/bcma.h:10:0,
>                   from drivers/bcma/bcma_private.h:9,
> 		 from drivers/bcma/main.c:8:
> include/linux/bcma/bcma_driver_pci.h:218:24: error:
> 	field 'pci_controller' has incomplete type
> 
> Bisect points to commit d41e6858ba58c ("MIPS: Kconfig: Set default MIPS
> system type as generic") as the culprit. Analysis shows that the commmit
> changes PCI configuration and enables PCI_DRIVERS_GENERIC. This in turn
> disables PCI_DRIVERS_LEGACY. 'struct pci_controller' is, however, only
> defined if PCI_DRIVERS_LEGACY is enabled.
> 
> Ultimately that means that BCMA_DRIVER_PCI_HOSTMODE depends on
> PCI_DRIVERS_LEGACY. Add the missing dependency.
> 
> Fixes: d41e6858ba58c ("MIPS: Kconfig: Set default MIPS system type as ...")
> Cc: Matt Redfearn <matt.redfearn@imgtec.com>
> Cc: James Hogan <jhogan@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I am aware that this problem has been reported several times. I have
> not been able to find a fix, but I may have missed it. If so, my
> apologies for the noise.
> 
I should have said "I have not been able to find a patch fixing it".

> Also note that this is not the only fix required; commit d41e6858ba58c,
> as simple as it looks like, does a pretty good job messing up
> "mips:allmodconfig" builds.
> 
... nor did I find patch(es) fixing the other build problem(s) introduced
by d41e6858ba58c.

Guenter

>   drivers/bcma/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
> index 02d78f6cecbb..ba8acca036df 100644
> --- a/drivers/bcma/Kconfig
> +++ b/drivers/bcma/Kconfig
> @@ -55,7 +55,7 @@ config BCMA_DRIVER_PCI
>   
>   config BCMA_DRIVER_PCI_HOSTMODE
>   	bool "Driver for PCI core working in hostmode"
> -	depends on MIPS && BCMA_DRIVER_PCI
> +	depends on MIPS && BCMA_DRIVER_PCI && PCI_DRIVERS_LEGACY
>   	help
>   	  PCI core hostmode operation (external PCI bus).
>   
> 
