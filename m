Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 12:55:02 +0100 (CET)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:43352 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012277AbaJ3LzBWnAzc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 12:55:01 +0100
Received: by mail-lb0-f174.google.com with SMTP id z11so2126951lbi.5
        for <linux-mips@linux-mips.org>; Thu, 30 Oct 2014 04:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=xk/zmTe8jjuMHtyEIavyw2iN8+CAAbbmkvWhogUo7LM=;
        b=Y9icLFbq/rWNHgY05wgKfFBKMLuBLaiKqgLscLeHjhxQJpWyl0YQHQrnHzd7IVZbUm
         Bud5mvdj5R1CAv3FjyD5scC0sFJYFp9Gnv9sPPeXIZCiTdSzv1sjzyL7pkX3oBNDcupy
         c7/JvyOgPNqHIxynyzQSnRtl1sI9c0yKmzyS8kE3/ATVv2WilXP3b5AzFfbvJZRmfaBE
         ZRp2WvT1hTypvofdIXb5YFlN0ttKoitVRUESkbd6IgKOpZgSscVK7Df8msoET8tA8hV7
         BtEExi1nctv414Lug44cyIkYyGv/TpAdg+V2ElIuqEQ2qREqIuzvjElPx8DfOrJZ1pye
         8Ptw==
X-Gm-Message-State: ALoCoQlLQWBXpEnlKZPUjVmksYEQGBjCpL5iCtSMHNqJpe3DS7Voim5OVZgb696NPeXjKwPYpekb
X-Received: by 10.112.159.229 with SMTP id xf5mr18158722lbb.64.1414669702375;
        Thu, 30 Oct 2014 04:48:22 -0700 (PDT)
Received: from [192.168.2.5] (ppp21-199.pppoe.mtu-net.ru. [81.195.21.199])
        by mx.google.com with ESMTPSA id q7sm3107689laq.32.2014.10.30.04.48.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Oct 2014 04:48:21 -0700 (PDT)
Message-ID: <54522584.2030102@cogentembedded.com>
Date:   Thu, 30 Oct 2014 14:48:20 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Kevin Cernekee <cernekee@gmail.com>, f.fainelli@gmail.com,
        tglx@linutronix.de, jason@lakedaemon.net, ralf@linux-mips.org,
        lethal@linux-sh.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH V2 09/15] irqchip: Remove ARM dependency for bcm7120-l2
 and brcmstb-l2
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com> <1414635488-14137-10-git-send-email-cernekee@gmail.com> <54521CA6.1000802@cogentembedded.com> <3334166.jta5WKHbUO@wuerfel>
In-Reply-To: <3334166.jta5WKHbUO@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 10/30/2014 2:24 PM, Arnd Bergmann wrote:

>>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>>> index b21f12f..09c79d1 100644
>>> --- a/drivers/irqchip/Kconfig
>>> +++ b/drivers/irqchip/Kconfig
>>> @@ -50,7 +50,6 @@ config ATMEL_AIC5_IRQ
>>>
>>>    config BRCMSTB_L2_IRQ
>>>        bool
>>> -     depends on ARM

>>      How about the following?

>>          depends on ARM || MIPS || COMPILE_TEST

> Makes no sense when the driver isn't user-selectable.

    Ah, I was just blind. :-/

> 	Arnd

WBR, Sergei
