Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2016 21:10:49 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34649 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013258AbcCCUKrPcddO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Mar 2016 21:10:47 +0100
Received: by mail-pa0-f68.google.com with SMTP id hj7so1829870pac.1;
        Thu, 03 Mar 2016 12:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=W5tsIOTFWjdpRJzgbUtV8ZpUE82iZSyg20k8c/18hIk=;
        b=wF1suTZMSRDQFeyT8A+vIwPs6BOtUEO/3XBbrBexaf6KuWBwA9nvGGentpR8qfOXxz
         qRF+DKoxu9K1g7CDMqvpd8nKWXxZcQhmM+dvJjLzJRJCN/GBVyHkkiJ9y/B5hEEgty3m
         oEwCxgiILvW/srwvehFWkjlbUCxLGwwx9PAHh/YYdSyhur2tDaMSYNFxOAamuoeb5Rhc
         7rxtiR9Ahf+0Doc8SzVM3OoWwvOPHsNFIT0u+jiYmXLs+FjksANhVHv92eGQh3tA2Kj+
         67ApMjZZupyUjCeQivIOIYF+AXcxyY2SLPDvQ0tbMVjPO6c4My3DrYIpCRppoPJJuFNC
         qpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=W5tsIOTFWjdpRJzgbUtV8ZpUE82iZSyg20k8c/18hIk=;
        b=QYHcESfq62+UPfJMRclbQWNr0VGALpE0Nt+0JdFIBIDePzezdcvRWgiEmDA6KAxePs
         noJQQPYfTRMD8E8c/PzL01pqsVT/eEJnOQ5eQWgoRpFHqSFT/k7TEBg0K0wf2tk81Czf
         8y8B0fcEBzddzgGJCal2xHfHVawHeYFd9l7smtQnnPups+y3JVuKt8RP2MOrsIBCTtpc
         SRfJD6OKMl7jE/v2xvOFCS7zRcvx4gYL+sDhYfcemBHamFaOEe6Z0ICeNMv9CoBRCzHi
         eHbUXMIqvSacKQW4eZ4b5Vi+J4LSbZirnlKvRU1pByFCa0PnrUaZBf4myx7G1N5wI5A+
         /pvQ==
X-Gm-Message-State: AD7BkJK/XoXTzydFmRCVxjUaSfSNOZvybR9jyqCD5YpMv1eNKqe1Q9PECXR7fPNOfakiEQ==
X-Received: by 10.66.237.1 with SMTP id uy1mr6489413pac.114.1457035841363;
        Thu, 03 Mar 2016 12:10:41 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id p8sm106086pfi.34.2016.03.03.12.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2016 12:10:40 -0800 (PST)
Subject: Re: [PATCH v2 1/2] bmips: add BCM6358 support
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jogo@openwrt.org, cernekee@gmail.com
References: <1456054881-26787-1-git-send-email-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56D899EB.5050700@gmail.com>
Date:   Thu, 3 Mar 2016 12:09:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1456054881-26787-1-git-send-email-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52436
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

On 21/02/16 03:41, Álvaro Fernández Rojas wrote:
> BCM6358 has a shared TLB which conflicts with current SMP support, so it must
> be disabled for now.
> BCM6358 uses >= 0xfffe0000 addresses for internal registers, which need to be
> remapped (by using a simplified version of BRCM63xx ioremap.h).
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  v2: Use a different approach for remapping internal registers
> 
>  arch/mips/bmips/setup.c                    | 29 +++++++++++++++++------
>  arch/mips/include/asm/mach-bmips/ioremap.h | 37 ++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 7 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-bmips/ioremap.h
> 
> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
> index 3553528..f834a86 100644
> --- a/arch/mips/bmips/setup.c
> +++ b/arch/mips/bmips/setup.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_fdt.h>
>  #include <linux/of_platform.h>
>  #include <linux/smp.h>
> +#include <linux/types.h>
>  #include <asm/addrspace.h>
>  #include <asm/bmips.h>
>  #include <asm/bootinfo.h>
> @@ -35,9 +36,12 @@
>  
>  static const unsigned long kbase = VMLINUX_LOAD_ADDRESS & 0xfff00000;
>  
> +phys_addr_t bmips_internal_registers;
> +
>  struct bmips_quirk {
> -	const char		*compatible;
> -	void			(*quirk_fn)(void);
> +	const char *compatible;
> +	void (*quirk_fn)(void);
> +	const phys_addr_t regs;
>  };

That does not scale very well to having some sort of generic quirk
function here.

>  
>  static void kbase_setup(void)
> @@ -95,17 +99,27 @@ static void bcm6328_quirks(void)
>  		bcm63xx_fixup_cpu1();
>  }
>  
> +static void bcm6358_quirks(void)
> +{
> +	/*
> +	 * BCM6358 needs special handling for its shared TLB, so
> +	 * disable SMP for now
> +	 */
> +	bmips_smp_enabled = 0;
> +}
> +
>  static void bcm6368_quirks(void)
>  {
>  	bcm63xx_fixup_cpu1();
>  }
>  
>  static const struct bmips_quirk bmips_quirk_list[] = {
> -	{ "brcm,bcm3384-viper",		&bcm3384_viper_quirks		},
> -	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
> -	{ "brcm,bcm6328",		&bcm6328_quirks			},
> -	{ "brcm,bcm6368",		&bcm6368_quirks			},
> -	{ "brcm,bcm63168",		&bcm6368_quirks			},
> +	{ "brcm,bcm3384-viper", &bcm3384_viper_quirks, 0 },
> +	{ "brcm,bcm33843-viper", &bcm3384_viper_quirks, 0 },
> +	{ "brcm,bcm6328", &bcm6328_quirks, 0 },
> +	{ "brcm,bcm6358", &bcm6358_quirks, 0xfffe0000 },
> +	{ "brcm,bcm6368", &bcm6368_quirks, 0 },
> +	{ "brcm,bcm63168", &bcm6368_quirks, 0 },
>  	{ },
>  };
>  
> @@ -162,6 +176,7 @@ void __init plat_mem_setup(void)
>  	for (q = bmips_quirk_list; q->quirk_fn; q++) {
>  		if (of_flat_dt_is_compatible(of_get_flat_dt_root(),
>  					     q->compatible)) {
> +			bmips_internal_registers = q->regs;
>  			q->quirk_fn();
>  		}
>  	}
> diff --git a/arch/mips/include/asm/mach-bmips/ioremap.h b/arch/mips/include/asm/mach-bmips/ioremap.h
> new file mode 100644
> index 0000000..5ffca94
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-bmips/ioremap.h
> @@ -0,0 +1,37 @@
> +#ifndef __ASM_MACH_BMIPS_IOREMAP_H
> +#define __ASM_MACH_BMIPS_IOREMAP_H
> +
> +#include <linux/types.h>
> +
> +extern phys_addr_t bmips_internal_registers;
> +
> +static inline phys_addr_t fixup_bigphys_addr(phys_addr_t phys_addr,
> +					     phys_addr_t size)
> +{
> +	return phys_addr;
> +}
> +
> +static inline int is_bmips_internal_registers(phys_addr_t offset)
> +{
> +	if (bmips_internal_registers != 0 && offset >= bmips_internal_registers)
> +		return 1;

Humm, we should probably just use a hardcoded constant here, and just
pick one which works for all SoCs, so the 3368 base address for
instance: 0xfff8_0000 seems like a good candidate, and also works for
other DSL SoCs too.
-- 
Florian
