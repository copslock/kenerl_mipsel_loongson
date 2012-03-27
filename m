Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2012 17:57:29 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:57807 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903562Ab2C0P5N convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Mar 2012 17:57:13 +0200
Received: by ghbf11 with SMTP id f11so69001ghb.36
        for <linux-mips@linux-mips.org>; Tue, 27 Mar 2012 08:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7UMyFS7feulmbE/LVAshHExcnMk9kpMfxNPvO20Vg1U=;
        b=HIrqPRb/C7iGyrn5uipv1v8Z92am7A4wuAUS3MNKLo2ltb1IJk9X2//m1hUreuk1qp
         +V4naLXUkfZtD+Nem0zdseFP3+sjYG8pBhaZkDPsnGOq2ra54Fg4nmtRUA/bOmbrH6J8
         Ns5Fb5pAsBjCbg7ldHNoCNrf0+5OSjyKDwdVEdd1w1v6cAAI2R4aDOhHWXuM/9CpbgCG
         D0ou7rt2XcUa2RXr++Q+2G7Wb8AMKpZh1O+hARLMWwUqVQFwqDgp7H2293M/o6C2PnSC
         4zROMHEWLibvap91wJG9UWAlOXg9MEJwLm30ciCUKZBmBoR7T8HgwJBDsBr4T1ycES14
         kgZw==
Received: by 10.68.194.3 with SMTP id hs3mr63335887pbc.119.1332863824005; Tue,
 27 Mar 2012 08:57:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.191.229 with HTTP; Tue, 27 Mar 2012 08:56:43 -0700 (PDT)
In-Reply-To: <1332855768-32583-7-git-send-email-m.szyprowski@samsung.com>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com> <1332855768-32583-7-git-send-email-m.szyprowski@samsung.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Tue, 27 Mar 2012 11:56:43 -0400
Message-ID: <CAEdQ38H6xJsHDZh2LJA4NZOQJ0AEtYLKK2i7w=+98TXCCRxEQw@mail.gmail.com>
Subject: Re: [PATCHv2 06/14] Alpha: adapt for dma_map_ops changes
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dezhong Diao <dediao@cisco.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 32790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Mar 27, 2012 at 9:42 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
>
> Adapt core Alpha architecture code for dma_map_ops changes: replace
> alloc/free_coherent with generic alloc/free methods.
>
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/alpha/include/asm/dma-mapping.h |   18 ++++++++++++------
>  arch/alpha/kernel/pci-noop.c         |   10 ++++++----
>  arch/alpha/kernel/pci_iommu.c        |   10 ++++++----
>  3 files changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/arch/alpha/include/asm/dma-mapping.h b/arch/alpha/include/asm/dma-mapping.h
> index 4567aca..dfa32f0 100644
> --- a/arch/alpha/include/asm/dma-mapping.h
> +++ b/arch/alpha/include/asm/dma-mapping.h
> @@ -12,16 +12,22 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
>
>  #include <asm-generic/dma-mapping-common.h>
>
> -static inline void *dma_alloc_coherent(struct device *dev, size_t size,
> -                                      dma_addr_t *dma_handle, gfp_t gfp)
> +#define dma_alloc_coherent(d,s,h,f)    dma_alloc_attrs(d,s,h,f,NULL)
> +
> +static inline void *dma_alloc_attrs(struct device *dev, size_t size,
> +                                   dma_addr_t *dma_handle, gfp_t gfp,
> +                                   struct dma_attrs *attrs)
>  {
> -       return get_dma_ops(dev)->alloc_coherent(dev, size, dma_handle, gfp);
> +       return get_dma_ops(dev)->alloc(dev, size, dma_handle, gfp, attrs);
>  }
>
> -static inline void dma_free_coherent(struct device *dev, size_t size,
> -                                    void *vaddr, dma_addr_t dma_handle)
> +#define dma_free_coherent(d,s,c,h) dma_free_attrs(d,s,c,h,NULL)
> +
> +static inline void dma_free_attrs(struct device *dev, size_t size,
> +                                 void *vaddr, dma_addr_t dma_handle,
> +                                 struct dma_attrs *attrs)
>  {
> -       get_dma_ops(dev)->free_coherent(dev, size, vaddr, dma_handle);
> +       get_dma_ops(dev)->free(dev, size, vaddr, dma_handle, attrs);
>  }
>
>  static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
> diff --git a/arch/alpha/kernel/pci-noop.c b/arch/alpha/kernel/pci-noop.c
> index 04eea48..df24b76 100644
> --- a/arch/alpha/kernel/pci-noop.c
> +++ b/arch/alpha/kernel/pci-noop.c
> @@ -108,7 +108,8 @@ sys_pciconfig_write(unsigned long bus, unsigned long dfn,
>  }
>
>  static void *alpha_noop_alloc_coherent(struct device *dev, size_t size,
> -                                      dma_addr_t *dma_handle, gfp_t gfp)
> +                                      dma_addr_t *dma_handle, gfp_t gfp,
> +                                      struct dma_attrs *attrs)
>  {
>        void *ret;
>
> @@ -123,7 +124,8 @@ static void *alpha_noop_alloc_coherent(struct device *dev, size_t size,
>  }
>
>  static void alpha_noop_free_coherent(struct device *dev, size_t size,
> -                                    void *cpu_addr, dma_addr_t dma_addr)
> +                                    void *cpu_addr, dma_addr_t dma_addr,
> +                                    struct dma_attrs *attrs)
>  {
>        free_pages((unsigned long)cpu_addr, get_order(size));
>  }
> @@ -174,8 +176,8 @@ static int alpha_noop_set_mask(struct device *dev, u64 mask)
>  }
>
>  struct dma_map_ops alpha_noop_ops = {
> -       .alloc_coherent         = alpha_noop_alloc_coherent,
> -       .free_coherent          = alpha_noop_free_coherent,
> +       .alloc                  = alpha_noop_alloc_coherent,
> +       .free                   = alpha_noop_free_coherent,
>        .map_page               = alpha_noop_map_page,
>        .map_sg                 = alpha_noop_map_sg,
>        .mapping_error          = alpha_noop_mapping_error,
> diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
> index 4361080..cd63479 100644
> --- a/arch/alpha/kernel/pci_iommu.c
> +++ b/arch/alpha/kernel/pci_iommu.c
> @@ -434,7 +434,8 @@ static void alpha_pci_unmap_page(struct device *dev, dma_addr_t dma_addr,
>    else DMA_ADDRP is undefined.  */
>
>  static void *alpha_pci_alloc_coherent(struct device *dev, size_t size,
> -                                     dma_addr_t *dma_addrp, gfp_t gfp)
> +                                     dma_addr_t *dma_addrp, gfp_t gfp,
> +                                     struct dma_attrs *attrs)
>  {
>        struct pci_dev *pdev = alpha_gendev_to_pci(dev);
>        void *cpu_addr;
> @@ -478,7 +479,8 @@ try_again:
>    DMA_ADDR past this call are illegal.  */
>
>  static void alpha_pci_free_coherent(struct device *dev, size_t size,
> -                                   void *cpu_addr, dma_addr_t dma_addr)
> +                                   void *cpu_addr, dma_addr_t dma_addr,
> +                                   struct dma_attrs *attrs)
>  {
>        struct pci_dev *pdev = alpha_gendev_to_pci(dev);
>        pci_unmap_single(pdev, dma_addr, size, PCI_DMA_BIDIRECTIONAL);
> @@ -952,8 +954,8 @@ static int alpha_pci_set_mask(struct device *dev, u64 mask)
>  }
>
>  struct dma_map_ops alpha_pci_ops = {
> -       .alloc_coherent         = alpha_pci_alloc_coherent,
> -       .free_coherent          = alpha_pci_free_coherent,
> +       .alloc                  = alpha_pci_alloc_coherent,
> +       .free                   = alpha_pci_free_coherent,
>        .map_page               = alpha_pci_map_page,
>        .unmap_page             = alpha_pci_unmap_page,
>        .map_sg                 = alpha_pci_map_sg,
> --
> 1.7.1.569.g6f426
>

Acked-by: Matt Turner <mattst88@gmail.com>
