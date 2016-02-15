Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 11:35:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33750 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010629AbcBOKffVaXTj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 11:35:35 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 1E61616427DDC
        for <linux-mips@linux-mips.org>; Mon, 15 Feb 2016 10:35:27 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 15 Feb 2016 10:35:29 +0000
Received: from [192.168.154.116] (192.168.154.116) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 15 Feb
 2016 10:35:28 +0000
Subject: Re: [PATCH] MIPS: Use CPHYSADDR to implement mips32 __pa
To:     <linux-mips@linux-mips.org>
References: <1455477626-30988-1-git-send-email-paul.burton@imgtec.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <56C1A9F0.90706@imgtec.com>
Date:   Mon, 15 Feb 2016 10:35:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1455477626-30988-1-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi Paul,

On 14/02/16 19:20, Paul Burton wrote:
> Use CPHYSADDR to implement the __pa macro converting from a virtual to a
> physical address for MIPS32, much as is already done for MIPS64 (though
> without the complication of having both compatibility & XKPHYS
> segments).
>
> This allows for __pa to work regardless of whether the address being
> translated is in kseg0 or kseg1, unlike the previous subtraction based
> approach which only worked for addresses in kseg0. Working for kseg1
> addresses is important if __pa is used on addresses allocated by
> dma_alloc_coherent, where on systems with non-coherent I/O we provide
> addresses in kseg1. If this address is then used with
> dma_map_single_attrs then it is provided to virt_to_page, which in turn
> calls virt_to_phys which is a wrapper around __pa. The result is that we
> end up with a physical address 0x20000000 bytes (ie. the size of kseg0)
> too high.
>
> In addition to providing consistency with MIPS64 & fixing the kseg1 case
> above this has the added bonus of generating smaller code for systems
> implementing MIPS32r2 & beyond, where a single ext instruction can
> extract the physical address rather than needing to load an immediate
> into a temp register & subtract it. This results in ~1.3KB savings for a
> boston_defconfig kernel adjusted to set CONFIG_32BIT=y.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>
>   arch/mips/include/asm/page.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index 21ed715..35c1222 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -169,8 +169,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
>       __x < CKSEG0 ? XPHYSADDR(__x) : CPHYSADDR(__x);			\
>   })
>   #else
> -#define __pa(x)								\
> -    ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
> +#define __pa(x)		CPHYSADDR(x)
>   #endif
>   #define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
>   #include <asm/io.h>
I have tested this patch on an EVA Interaptiv and confirmed that it 
fixes previous regressions.

Tested-by: Matt Redfearn <matt.redfearn@imgtec.com>

Thanks,
Matt
