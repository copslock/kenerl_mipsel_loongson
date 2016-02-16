Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 18:16:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22265 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011174AbcBPRQmvVS0o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Feb 2016 18:16:42 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 83FE3901BC21B
        for <linux-mips@linux-mips.org>; Tue, 16 Feb 2016 17:16:32 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 16 Feb 2016 17:16:34 +0000
Received: from localhost (10.100.200.63) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 16 Feb
 2016 17:16:32 +0000
Date:   Tue, 16 Feb 2016 09:16:31 -0800
From:   Paul Burton <paul.burton@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Use CPHYSADDR to implement mips32 __pa
Message-ID: <20160216171631.GA2063@NP-P-BURTON>
References: <1455477626-30988-1-git-send-email-paul.burton@imgtec.com>
 <56C1A9F0.90706@imgtec.com>
 <56C2F269.6090905@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <56C2F269.6090905@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.63]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Tue, Feb 16, 2016 at 09:56:57AM +0000, Matt Redfearn wrote:
> Hi Paul,
> 
> On 15/02/16 10:35, Matt Redfearn wrote:
> >Hi Paul,
> >
> >On 14/02/16 19:20, Paul Burton wrote:
> >>Use CPHYSADDR to implement the __pa macro converting from a virtual to a
> >>physical address for MIPS32, much as is already done for MIPS64 (though
> >>without the complication of having both compatibility & XKPHYS
> >>segments).
> >>
> >>This allows for __pa to work regardless of whether the address being
> >>translated is in kseg0 or kseg1, unlike the previous subtraction based
> >>approach which only worked for addresses in kseg0. Working for kseg1
> >>addresses is important if __pa is used on addresses allocated by
> >>dma_alloc_coherent, where on systems with non-coherent I/O we provide
> >>addresses in kseg1. If this address is then used with
> >>dma_map_single_attrs then it is provided to virt_to_page, which in turn
> >>calls virt_to_phys which is a wrapper around __pa. The result is that we
> >>end up with a physical address 0x20000000 bytes (ie. the size of kseg0)
> >>too high.
> >>
> >>In addition to providing consistency with MIPS64 & fixing the kseg1 case
> >>above this has the added bonus of generating smaller code for systems
> >>implementing MIPS32r2 & beyond, where a single ext instruction can
> >>extract the physical address rather than needing to load an immediate
> >>into a temp register & subtract it. This results in ~1.3KB savings for a
> >>boston_defconfig kernel adjusted to set CONFIG_32BIT=y.
> >>
> >>Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> >>---
> >>
> >>  arch/mips/include/asm/page.h | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >>diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> >>index 21ed715..35c1222 100644
> >>--- a/arch/mips/include/asm/page.h
> >>+++ b/arch/mips/include/asm/page.h
> >>@@ -169,8 +169,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
> >>      __x < CKSEG0 ? XPHYSADDR(__x) : CPHYSADDR(__x);            \
> >>  })
> >>  #else
> >>-#define __pa(x)                                \
> >>-    ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
> >>+#define __pa(x)        CPHYSADDR(x)
> >>  #endif
> >>  #define __va(x)        ((void *)((unsigned long)(x) + PAGE_OFFSET -
> >>PHYS_OFFSET))
> >>  #include <asm/io.h>
> >I have tested this patch on an EVA Interaptiv and confirmed that it fixes
> >previous regressions.
> >
> >Tested-by: Matt Redfearn <matt.redfearn@imgtec.com>
> >
> >Thanks,
> >Matt
> >
> Scratch that, I had a messed up .config that did not have EVA enabled in the
> kernel. This patch breaks booting on Malta when CONFIG_EVA is enabled.
> When setting up pcpu_embed_first_chunk(), the memory allocated with
> CONFIG_EVA enabled comes from the physically aliased 0x8XXXXXXX region,
> mapped to virtual space 0x0XXXXXXX. With this patch, when the kernel
> attempts to free some of this memory, the __pa() macro returns an address in
> 0x0XXXXXXX which does not map to any physical memory, and the kernel hits
> the BUG() in mark_bootmem().
> 
> The below patch fixes EVA (on Malta at least - I'm not sure other platforms,
> which don't use the physical aliasing technique, will fall into this hole).
> 
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -169,7 +169,42 @@ typedef struct { unsigned long pgprot; } pgprot_t;
>      __x < CKSEG0 ? XPHYSADDR(__x) : CPHYSADDR(__x);                    \
>  })
>  #else
> +#if def CONFIG_EVA
> +static unsigned long ___pa(unsigned long virt)
> +{
> +       unsigned long segaddr = virt & 0x1fffffffUL;
> +       unsigned long segcfg;
> +
> +       if (virt < 0x40000000) {
> +               segcfg = read_c0_segctl2() >> 16;
> +               return (((segcfg >> MIPS_SEGCFG_PA_SHIFT) & 0x7) << 29) |
> segaddr;
> +       }
> +       else if (virt < 0x80000000) {
> +               segcfg = read_c0_segctl2();
> +               return (((segcfg >> MIPS_SEGCFG_PA_SHIFT) & 0x7) << 29) |
> segaddr;
> +       }
> +       else if (virt < 0xa0000000) {
> +               segcfg = read_c0_segctl1() >> 16;
> +               return (((segcfg >> MIPS_SEGCFG_PA_SHIFT) & 0x7) << 29) |
> segaddr;
> +       }
> +       else if (virt < 0xc0000000) {
> +               segcfg = read_c0_segctl1();
> +               return (((segcfg >> MIPS_SEGCFG_PA_SHIFT) & 0x7) << 29) |
> segaddr;
> +       }
> +       else if (virt < 0xe0000000) {
> +               segcfg = read_c0_segctl0() >> 16;
> +               return (((segcfg >> MIPS_SEGCFG_PA_SHIFT) & 0x7) << 29) |
> segaddr;
> +       }
> +       else {
> +               segcfg = read_c0_segctl0();
> +               return (((segcfg >> MIPS_SEGCFG_PA_SHIFT) & 0x7) << 29) |
> segaddr;
> +       }
> +       return 0;
> +}
> +#define __pa(x)                ___pa((unsigned long)x)
> +#else
>  #define __pa(x)                CPHYSADDR(x)
> +#endif /* CONFIG_EVA */
>  #endif
>  #define __va(x)                ((void *)((unsigned long)(x) + PAGE_OFFSET -
> PHYS_OFFSET))
>  #include <asm/io.h>
> 
> Discuss :-)
> 
> Thanks,
> Matt
> 

Hi Matt,

I think that's a very separate change to my patch. I'll submit a v2 that
just leaves the existing subtraction in place for EVA, the scourge of
kernel development.

Thanks,
    Paul
