Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 11:43:53 +0200 (CEST)
Received: from mail-qk0-x232.google.com ([IPv6:2607:f8b0:400d:c09::232]:36086
        "EHLO mail-qk0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990778AbdEaJnptS6C3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 11:43:45 +0200
Received: by mail-qk0-x232.google.com with SMTP id u75so7251660qka.3
        for <linux-mips@linux-mips.org>; Wed, 31 May 2017 02:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rnI8WGvNA/Wqu5ytCiEowZ+0eMVd+eExPL7NSW3PbyE=;
        b=T3gJ13ScRSccdgX6MuRByUJ3sMEi70Mq5ow2CX1PxhF2Q6gbvbRwSUvHhPRjl5oRE6
         Ik2ivom6MLlcpj8gLG8XhOZgOxwqBFFQTXUctFPAWn1spJVxtA3IZOEoBQe3j0JlgAHu
         jLunKR9OB9bIS8h9qwIIWCaqpDwfYavEreamc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rnI8WGvNA/Wqu5ytCiEowZ+0eMVd+eExPL7NSW3PbyE=;
        b=Gn50ZzoPrJ8ze4QhXXlzqyFAgZ/gVNAOMEeAc18hJ2sNB3n/XZRJlBA/xIJ2QNLJSA
         Nz1yNhbS9b1gvCAtYz1eAalCfAUtXIB+1P1iLmndyCLprW7aWEuxBe5nPicRwyJkI37E
         0XAp3FQazqkm+VIqUQ0nMwybtXiEUdHlpZZuhahuXoU2ar4yYxzI/lgCkWT3WI9CgIq4
         oZuztpXfJystvI8bPGJNmxomMpbSmtlKJqCQDR1sB5FhgyYtdrL7WLK2WyfwzR1XO/8R
         Ju7f9bpeHQwDv0VTFtZubiP58kusqoRtmmbRXbQm1LkNagbvyZISSYsGX6KfCuT6DU7P
         Cj2Q==
X-Gm-Message-State: AODbwcBKOx/l8F94CEmncGd5QjJFGdnIlI5HAd6SX5CnomhOUgR3IvUs
        S4q6/uFSlyO4H7lAzf3haQ==
X-Received: by 10.55.121.196 with SMTP id u187mr26713278qkc.91.1496223819917;
        Wed, 31 May 2017 02:43:39 -0700 (PDT)
Received: from [10.176.68.189] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id t198sm4225716qke.30.2017.05.31.02.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 May 2017 02:43:39 -0700 (PDT)
Subject: Re: [PATCH] bcm47xx: fix build regression
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
References: <20170530112027.3983554-1-arnd@arndb.de>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <7b6903a2-ce54-44f9-18ed-a14bd32069ce@broadcom.com>
Date:   Wed, 31 May 2017 11:43:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170530112027.3983554-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <arend.vanspriel@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend.vanspriel@broadcom.com
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

On 5/30/2017 1:20 PM, Arnd Bergmann wrote:
> An unknown change in the kernel headers caused a build regression
> in an MTD partition driver:
> 
> In file included from drivers/mtd/bcm47xxpart.c:12:0:
> include/linux/bcm47xx_nvram.h: In function 'bcm47xx_nvram_init_from_mem':
> include/linux/bcm47xx_nvram.h:27:10: error: 'ENOTSUPP' undeclared (first use in this function)
> 
> Clearly we want to include linux/errno.h here.

unfortunate that you did not find the commit that caused this build 
regression. You could produce preprocessor output when it was working to 
see where errno.h got implicitly included and start looking there for 
git history.

Regards,
Arend

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   include/linux/bcm47xx_nvram.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
> index 2793652fbf66..a414a2b53e41 100644
> --- a/include/linux/bcm47xx_nvram.h
> +++ b/include/linux/bcm47xx_nvram.h
> @@ -8,6 +8,7 @@
>   #ifndef __BCM47XX_NVRAM_H
>   #define __BCM47XX_NVRAM_H
>   
> +#include <linux/errno.h>
>   #include <linux/types.h>
>   #include <linux/kernel.h>
>   #include <linux/vmalloc.h>
> 
