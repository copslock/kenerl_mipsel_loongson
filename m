Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 May 2017 05:05:54 +0200 (CEST)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:36732
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbdEYDFqh9dcv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 May 2017 05:05:46 +0200
Received: by mail-oi0-x242.google.com with SMTP id w138so35615086oiw.3
        for <linux-mips@linux-mips.org>; Wed, 24 May 2017 20:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e8X2v65CAl8B82RfrE2rkWBFM4hpjrQTRNpI8YfbESs=;
        b=c8qcpNswVelOENvzoBJOPjvlXDK+Loap0UDQX/+Usfe5t64NTaj2NMHwKHjzX+9KHz
         edhzRobzUwys1UQSkmL8UIzGd1+g/NAJNNEpqFtxVzvbdTn5L/35YfsxGiLQa9Nelj/X
         0tzkftIO91NEvmd9YkhnN75XsTPHvEPlv2PoraVEWyqNvcpjXyIpoWx8GLA+ZkRx4iC6
         A3c6vI/0Zldn0BSf8+nO4JCxTrU80e9Dv06DJ1bbhp+k+jFEkTO3nhXBc7x09QgDP6NQ
         CcNSamwAO8V75yMVGSpUFU6yn/hTbE9l2gRxLbpGXNwNOiRHfTT6M4vX7FUlhuagwj5E
         XAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e8X2v65CAl8B82RfrE2rkWBFM4hpjrQTRNpI8YfbESs=;
        b=ScEdsG0HHIjXRQnDIqR8aJSYiAbsAdgFrxYHwTTem+vVV3yqTxkL5B5XMpNwLqUUzv
         k9BPx9KiEiBXLkB6LdH7voPHrHa1H/mfuzA+2dXbqD7YJDid2XISChqSFzpgTp2vkKVa
         d1Bml0Nhc4J9MFmUepOa/FpQZZTVRc9Y83sxyeH8/vmyaTifb8rJBBRaAb4XCDNeXnse
         utqNRbonU70QBON1dAqd10Di9DWmRXHzNiVYNxOebGsEinyV3Uc/eam/kAchP8VKG//R
         pLryg1EMTqPUapMYVyD8Gc0xtmaAU6pynMg+dtJuom0VZxrJXpvBhqDEsrz835h7XMCx
         qvow==
X-Gm-Message-State: AODbwcAqsoFnfif2l7qoSajgF8EDOlaRjrboInROf0p8gPJel8CxKQD+
        q25p7WFEw6azAg==
X-Received: by 10.157.67.174 with SMTP id t46mr5951106ote.70.1495681540589;
        Wed, 24 May 2017 20:05:40 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:15f0:fac3:3f28:6e44? ([2001:470:d:73f:15f0:fac3:3f28:6e44])
        by smtp.googlemail.com with ESMTPSA id u14sm2796974oie.19.2017.05.24.20.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 May 2017 20:05:39 -0700 (PDT)
Subject: Re: [PATCH 1/1] BMIPS: Enable HARDIRQS_SW_RESEND
To:     justinpopo6@gmail.com, linux-mips@linux-mips.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justin.chen@broadcom.com>
References: <20170524175516.13849-1-justinpopo6@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <39a04edb-626b-2987-9945-bb25a5ca2c7c@gmail.com>
Date:   Wed, 24 May 2017 20:05:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170524175516.13849-1-justinpopo6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57998
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

Le 05/24/17 à 10:55, justinpopo6@gmail.com a écrit :
> From: Justin Chen <justin.chen@broadcom.com>
> 
> HW interrupts triggered when irq_disable() were being ignored. Enable
> resending HW interrupts as SW interrupts.
> 
> This was causing an issue where the interrupts waking the system up from
> a suspend state were not calling their interrupt handlers.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  arch/mips/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 2828ecde133d..349f9bdb655b 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -230,6 +230,7 @@ config BMIPS_GENERIC
>  	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
>  	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
>  	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
> +	select HARDIRQS_SW_RESEND
>  	help
>  	  Build a generic DT-based kernel image that boots on select
>  	  BCM33xx cable modem chips, BCM63xx DSL chips, and BCM7xxx set-top
> 


-- 
Florian
