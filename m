Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2012 13:51:17 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:36485 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903702Ab2DJLvJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Apr 2012 13:51:09 +0200
Received: by bkcjk13 with SMTP id jk13so5431339bkc.36
        for <linux-mips@linux-mips.org>; Tue, 10 Apr 2012 04:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=X/UZ8D8XeS/WPoDA5nQw2FXBIPzc7X/zGIGhrADU5Fw=;
        b=W12dePVotUkq0w0xwHG6rHP6FhwOaBROJ1RTaAmod4/cG/WYHVLTojL1VBgtB0EPJf
         BsGx9vdw3ZXd1xXgEWuUdttIhw6vFPobVLuwAU3oA61JonLP3WerAwuMflsOISMELlOa
         eWMN1iy67WEugO2LsYGtncBvVvJiJZZLfrS873nW06fS4tFXGcK7S6KcGGHQX2+4V9zX
         E+KqwHcf6H8HeyaSgktBmbA1QKeL/fm6a5RhQjuXEC3kdITIw5AHY1lCTrt/UtePHwOF
         pRmVkLhx+eOU9wfYgARBoJ9hPzeAXPaTyGy7PrdHTyN30y8jtbH0pjRpd67n/1o6QIOm
         Xmaw==
Received: by 10.204.154.66 with SMTP id n2mr4743509bkw.77.1334058664414;
        Tue, 10 Apr 2012 04:51:04 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-84-232.pppoe.mtu-net.ru. [91.79.84.232])
        by mx.google.com with ESMTPS id gu12sm28458379bkc.1.2012.04.10.04.51.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 04:51:03 -0700 (PDT)
Message-ID: <4F841E48.7000104@mvista.com>
Date:   Tue, 10 Apr 2012 15:49:28 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Leonid Yegoshin <yegoshin@mips.com>
Subject: Re: [PATCH] Add MIPS64R2 core support.
References: <1333987461-822-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1333987461-822-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnPj+oYE0u+AZ3uTF1Dg7ej+5iBe5ZjdLvRW9cGZtH88nRDDqzZBavm3awdMWePMMsquF1u
X-archive-position: 32922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 09-04-2012 20:04, Steven J. Hill wrote:

> From: "Steven J. Hill"<sjhill@mips.com>

> Signed-off-by: Leonid Yegoshin<yegoshin@mips.com>
> Signed-off-by: Steven J. Hill<sjhill@mips.com>
> ---
>   arch/mips/Kconfig            |   29 +++++++++++++++++++++++------
>   arch/mips/include/asm/cpu.h  |    2 +-
>   arch/mips/kernel/cpu-probe.c |    4 ++++
>   arch/mips/kernel/traps.c     |    1 +
>   4 files changed, 29 insertions(+), 7 deletions(-)

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 991de91..fae33f3 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -282,6 +282,7 @@ config MIPS_MALTA
>   	select SYS_HAS_CPU_MIPS32_R1
>   	select SYS_HAS_CPU_MIPS32_R2
>   	select SYS_HAS_CPU_MIPS64_R1
> +	select SYS_HAS_CPU_MIPS64_R2
>   	select SYS_HAS_CPU_NEVADA
>   	select SYS_HAS_CPU_RM7000
>   	select SYS_HAS_EARLY_PRINTK
> @@ -1761,6 +1762,22 @@ config 64BIT
>
>   endchoice
>
> +config 64BIT_PHYS_ADDR
> +	bool "Kernel supports 64 bit physical addresses" if EXPERIMENTAL
> +	depends on 64BIT

    This option is selected on 32-bit CPUs like Alchemy, which has 36-bit 
physical address. It will cause a warning about unmet direct dependencies then.

> +	help
> +	  Defines 64 bit physical addresses in kernel.
> +	  Increases page table sizes.
> +
> +	  It is an alternative for HIGHMEM usage of huge physical memory.
> +	  Requires 64bit capable CPU  and 64 bit kernel code model.

    No, it really doesn't.

> +	  Note: without this option kernel can support up to 4GB physical
> +	  memory for 4KB pages and up to 64GB for 64KB pages.
> +
> +config ARCH_PHYS_ADDR_T_64BIT
> +       def_bool 64BIT_PHYS_ADDR
> +
>   choice
>   	prompt "Kernel page size"
>   	default PAGE_SIZE_4KB

WBR, Sergei
