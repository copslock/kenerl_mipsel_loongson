Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Mar 2016 20:29:37 +0200 (CEST)
Received: from mail-ig0-f194.google.com ([209.85.213.194]:36468 "EHLO
        mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025509AbcC1S3fu2eJQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Mar 2016 20:29:35 +0200
Received: by mail-ig0-f194.google.com with SMTP id y4so11101641igt.3;
        Mon, 28 Mar 2016 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=jTXxSHiJKchrv5HRXeNf34JQygg0sTm/+vsF4pCwPdU=;
        b=ZbPm/u82mM0fKwqOF7Xc0FpYFTtRKWhopV90CuwX3dKzE8VxS460LU1DWITtmRxQHp
         o3bmaDLOleRQ4TKye0UiaZEOuiJe1Mz4EH8LLFR62iTRUj2MpTEPOgX7mtHTZ6lxvSO4
         nj6N4IwXwKxr36mYEG5nRvA4x5TgkueW140H/H1ee8b8ckI61vwjaihclvrKj+IGrGX0
         8iHS5IXzxayXrwD3jmir7en/0U0ArCO+EXtaz1fOcNX//nnTfz5QnR3eql3ZBUzlNPwx
         wue88MjG2hQlMgpp5IEHOhOmc46g83IZ4firJig36amE9neYkv42cQgiPSm8zkR2hYSm
         pRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jTXxSHiJKchrv5HRXeNf34JQygg0sTm/+vsF4pCwPdU=;
        b=Wp3zRVazJ2r/YBte4G23p/WNM5V9pl/4kMECNk9D3uvZcdoqJe+4p36QMmr44nkhMU
         ydnu0946pKwDoRdccO7xea1O2rNsh+FcU8hy5v5mxSeJhWgwwhWOiCoE2sQyqXj0ow2F
         qgwDxZoyCfN8P5Vxk+eYuqbx9/ZkdSFXIfaPU68jjqMDLwBWmpqI8tV502rzjViq5+s5
         Lp1Q/I1/JdgBEgvBdp+w7blFB1DvkONpJKIgZBfao3ts1O94Tgori7o6N+4Vh/SJLXTz
         tcpwpy062uRUshhtxGJypW8MUQtkLcQtGnLbvinVrJzkidsAGMIiDhFFWHjPifjVgH6/
         tkvw==
X-Gm-Message-State: AD7BkJIJ5+evhHyL4UbTgSJ3JBkwki8+9pgD9Nn0Gp1bc+l2F+cx5vFPH2voJh3u3j0ui6i7T67CZBXYXU1gwQ==
MIME-Version: 1.0
X-Received: by 10.50.142.37 with SMTP id rt5mr11350385igb.15.1459189769849;
 Mon, 28 Mar 2016 11:29:29 -0700 (PDT)
Received: by 10.36.81.193 with HTTP; Mon, 28 Mar 2016 11:29:29 -0700 (PDT)
In-Reply-To: <56EC1805.5060207@codeaurora.org>
References: <1458252137-24497-1-git-send-email-okaya@codeaurora.org>
        <1458252137-24497-2-git-send-email-okaya@codeaurora.org>
        <56EBF09A.1060503@arm.com>
        <56EC1805.5060207@codeaurora.org>
Date:   Mon, 28 Mar 2016 14:29:29 -0400
X-Google-Sender-Auth: PSJjowJ684DP3gHFgpI9R9xUe_g
Message-ID: <CACJDEmrzKOExg-Rchjy2hfVzkzbCZ=WNn4Bu3EVgim748VvRig@mail.gmail.com>
Subject: Re: [PATCH 2/3] swiotlb: prefix dma_to_phys and phys_to_dma functions
From:   Konrad Rzeszutek Wilk <konrad@kernel.org>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, timur@codeaurora.org,
        cov@codeaurora.org, nwatters@codeaurora.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Huacai Chen <chenhc@lemote.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jisheng Zhang <jszhang@marvell.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Michael Ellerman <mpe@ellerman.id.au>, X86 <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Dean Nelson <dnelson@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ketuzsezr@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: konrad@kernel.org
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

On Fri, Mar 18, 2016 at 11:00 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 3/18/2016 8:12 AM, Robin Murphy wrote:
>> Since we know for sure that swiotlb_to_phys is a no-op on arm64, it might be cleaner to simply not reference it at all. I suppose we could have some private local wrappers, e.g.:
>>
>> #define swiotlb_to_virt(addr) phys_to_virt((phys_addr_t)(addr))
>>
>> to keep the intent of the code clear (and just in case anyone ever builds a system mad enough to warrant switching out that definition, but I'd hope that never happens).
>>
>> Otherwise, looks good - thanks for doing this!
>
> OK. I added this. Reviewed-by?
>
> I'm not happy to submit such a big patch for all different ARCHs. I couldn't
> find a cleaner solution. I'm willing to split this patch into multiple if there
> is a better way.
>
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index ada00c3..8c0f66b 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -29,6 +29,14 @@
>
>  #include <asm/cacheflush.h>
>
> +/*
> + * If you are building a system without IOMMU, then you are using SWIOTLB
> + * library. The ARM64 adaptation of this library does not support address
> + * translation and it assumes that physical address = dma address for such
> + * a use case. Please don't build a platform that violates this.
> + */

Why not just expand the ARM64 part to support address translation?

> +#define swiotlb_to_virt(addr) phys_to_virt((phys_addr_t)(addr))
> +

Adding Stefano here.

>  static pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
>                                  bool coherent)
>  {
> @@ -188,7 +196,7 @@ static void __dma_free(struct device *dev, size_t size,
>                        void *vaddr, dma_addr_t dma_handle,
>                        struct dma_attrs *attrs)
>  {
> -       void *swiotlb_addr = phys_to_virt(swiotlb_dma_to_phys(dev, dma_handle));
> +       void *swiotlb_addr = swiotlb_to_virt(dma_handle);
>
>         size = PAGE_ALIGN(size);
>
> @@ -209,8 +217,7 @@ static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
>
>         dev_addr = swiotlb_map_page(dev, page, offset, size, dir, attrs);
>         if (!is_device_dma_coherent(dev))
> -               __dma_map_area(phys_to_virt(swiotlb_dma_to_phys(dev, dev_addr)),
> -                              size, dir);
> +               __dma_map_area(swiotlb_to_virt(dev_addr), size, dir);
>
>         return dev_addr;
>  }
> @@ -283,8 +290,7 @@ static void __swiotlb_sync_single_for_device(struct device *dev,
>  {
>         swiotlb_sync_single_for_device(dev, dev_addr, size, dir);
>         if (!is_device_dma_coherent(dev))
> -               __dma_map_area(phys_to_virt(swiotlb_dma_to_phys(dev, dev_addr)),
> -                              size, dir);
> +               __dma_map_area(swiotlb_to_virt(dev_addr), size, dir);
>  }
>
>
>
>
> --
> Sinan Kaya
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
