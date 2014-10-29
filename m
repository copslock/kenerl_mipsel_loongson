Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 18:37:00 +0100 (CET)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:58717 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011831AbaJ2Rg7XhooT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 18:36:59 +0100
Received: by mail-pd0-f174.google.com with SMTP id p10so3369335pdj.5
        for <multiple recipients>; Wed, 29 Oct 2014 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FehaPKOVYO+yXr7rtELS2t/qzGpJFtYylk2AaznMNcg=;
        b=ocSJhPlytzQz8cONhwq0VFXOLHLCw4gH6uo3rK5zIW99oilIMaXl6CC+MZvgUoys/e
         +I5aSQJwR9sQDyNIoQbQRTw5KzWUZ7C/uc/tmqLWRcOBQ9BqHsf/D8i3a8xr4AEQ7v9g
         +Y6bDwdRdsp5yPDiEKN9XF4azhzHvr9LdPnafPMdKZuOE3JwreUA2QGRD6zzcG+ostGx
         r82do7yAw8WLFfIulkedoRHYLfnueYmsgszeengU1vQu/GLbe7gt+SlLnkTCQxqnP12S
         wcjHBB/tmD90pbX3MOKx7LFx57JR9xO6XYl/Aosq1PLcJ1s1n6fsJBxIk1zBjjl1PFDm
         kAkw==
X-Received: by 10.70.39.35 with SMTP id m3mr11820661pdk.70.1414604212870;
        Wed, 29 Oct 2014 10:36:52 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id tv4sm4909666pab.28.2014.10.29.10.36.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 10:36:52 -0700 (PDT)
Message-ID: <54512599.4080500@gmail.com>
Date:   Wed, 29 Oct 2014 10:36:25 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@arndb.de>, Kevin Cernekee <cernekee@gmail.com>
CC:     tglx@linutronix.de, jason@lakedaemon.net, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 01/11] irqchip: Allow irq_reg_{readl,writel} to use __raw_{readl_writel}
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <11255905.1JsQYcArO7@wuerfel>
In-Reply-To: <11255905.1JsQYcArO7@wuerfel>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43715
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

On 10/29/2014 12:43 AM, Arnd Bergmann wrote:
> On Tuesday 28 October 2014 20:58:48 Kevin Cernekee wrote:
>>
>> +#ifdef CONFIG_RAW_IRQ_ACCESSORS
>> +
>> +#ifndef irq_reg_writel
>> +# define irq_reg_writel(val, addr)     __raw_writel(val, addr)
>> +#endif
>> +#ifndef irq_reg_readl
>> +# define irq_reg_readl(addr)           __raw_readl(addr)
>> +#endif
>> +
>> +#else
>> +
> 
> No, this is just wrong: registers almost always have a fixed endianess
> indenpent of CPU endianess, so if you use __raw_writel, it will be
> broken on one or the other.

Our brcmstb platforms had an endian strap settings for MIPS-based
platforms, and for most peripherals this would be just completely
transparent, as the HW always will do the internal swapping, such that
host CPU does read/writes in its native endianess regardless of the
actual strap settings.

AFAICT bcm3384, a MIPS-based Cable Modem platform has only one endianess
setting: BE, and the HW only supports that specific endianess.

> 
> If you have a machine that uses big-endian registers in the interrupt
> controller, you need to find a way to use the correct accessors
> (e.g. iowrite32be) and use them independent of what endianess the CPU
> is running.
> 
> As this code is being used on all sorts of platforms, you can't assume
> that they all use the same endianess, which makes it rather tricky.

I think the more general problem with the use of readl_*() I/O accessors
is that they just happen to work fine on most platforms out there: ARM
Little-endian, because this nicely matches the endianess expected by the
HW and that does not enforce an audit of whether your actual peripheral
expects little-endian writes to be done.

The other problem is that readl() on ARM implies a barrier, which is not
necesarily true/necessary for some other platforms such as some MIPS
processors.

> 
> As the first step, you can probably introduce a new Kconfig symbol
> GENERIC_IRQ_CHIP_BE, and then make that mutually exclusive with the
> existing users that all use little-endian registers:
> 
> #if defined(CONFIG_GENERIC_IRQ_CHIP) && !defined(CONFIG_GENERIC_IRQ_CHIP_BE)
> #define irq_reg_writel(val, addr)     writel(val, addr)
> #else if defined(CONFIG_GENERIC_IRQ_CHIP_BE) && !defined(CONFIG_GENERIC_IRQ_CHIP)
> #define irq_reg_writel(val, addr)     iowrite32be(val, addr)
> #else
> /* provoke a compile error when this is used */
> #define irq_reg_writel(val, addr)	irq_reg_writel_unknown_endian(val, addr)
> #endif
> 
> and
> 
> --- a/kernel/irq/Makefile
> +++ b/kernel/irq/Makefile
> @@ -1,5 +1,6 @@
>  
>  obj-y := irqdesc.o handle.o manage.o spurious.o resend.o chip.o dummychip.o devres.o
> +obj-$(CONFIG_GENERIC_IRQ_CHIP_BE) += generic-chip.o
>  obj-$(CONFIG_GENERIC_IRQ_CHIP) += generic-chip.o
>  obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
>  obj-$(CONFIG_IRQ_DOMAIN) += irqdomain.o
> 
> Note that you might also have a case where you have more than
> one generic irqchip driver built into the kernel, which require
> different endianess. We can't really support that case without
> changing the generic-chip implementation.
> 
> 	Arnd
> 
