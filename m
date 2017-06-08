Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 16:23:51 +0200 (CEST)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:34386
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993983AbdFHOXPIJ6N4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 16:23:15 +0200
Received: by mail-qt0-x244.google.com with SMTP id o21so8444787qtb.1
        for <linux-mips@linux-mips.org>; Thu, 08 Jun 2017 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4uonwkxSEgvudvLO+jctb2nX3UCb5m45J7B3TyghA6c=;
        b=ChiJjlMnld43ds+BKnr1dFta8e2/BZXkM6j2w5U2eVSmOPUGuoQ0cJwr0SlAlSw7kW
         y1qR0kk5fmRZ4iWKjYS9EvUy2KMRzXiEUlN0FPn4hC3ak6ueDIHltnnOoZcv0BbMfABd
         5V5SNIatGsI5IkDy6ASar/4YHzYiJwGvQ4pEfiGZ4rV6eJsB02hftaGV0KBmb9RtiWez
         boVrNudJzHHFQg4gFAriEZ68uNPdPAIRNKs+cZ3LEbLrUyxQGBzVxuJDjd7RHtRs07mu
         gJ1DWcJvh6/EHQnrUJDI5Vgb9emO0ysRvWs3eHP4PJzc+lDnyKnR9Yr1XjhO6uW7zhht
         aKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4uonwkxSEgvudvLO+jctb2nX3UCb5m45J7B3TyghA6c=;
        b=V2xP2lXs88zHWz4ruwhswwS7Bd0ieIWLEccysGZX6bM3qP93j5bMEUTVxThcB3SuPN
         IOpDNpJXvPVf+tNZgJfKTRhIOvJibp7XBPF1icyIzoZ/4ilYgSnFLu7qrLtOTsgjaU51
         2CvdO+CSswZDH3v27n0DFJ+5jAdmrbZ5ltRwnhD9U17cTTWLh8Z1+/iMHF8tWZSYiLH5
         4NlJj//xYBStKQVVdeZwab+NWsNMwyXEh3PU7CMygVji7UuvWonJM+LNOz3K3Ljgz1CR
         /Dr58Zyyo5wHqq3/EGJlUREQEjlfcLAuW8Kae4A45iZphNtrgOagK2Qj0o/85XSbR2im
         p4XQ==
X-Gm-Message-State: AKS2vOzgPPrfBk9UmIeMEBpxSL8eqV5VLDVS90KM7iqCtsNXBPL4bGpK
        6zvD4CmpGJavg21Q7C76sL2GihHYvA==
X-Received: by 10.55.100.213 with SMTP id y204mr41314038qkb.87.1496931789363;
 Thu, 08 Jun 2017 07:23:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.71 with HTTP; Thu, 8 Jun 2017 07:22:48 -0700 (PDT)
In-Reply-To: <20170608132609.32662-29-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de> <20170608132609.32662-29-hch@lst.de>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Fri, 9 Jun 2017 00:22:48 +1000
Message-ID: <CAGRGNgUJ3J_LEwhJ1rFHuzZ_J4OnTV9-DekcuT=N5z1pBKcb3A@mail.gmail.com>
Subject: Re: [PATCH 28/44] sparc: remove arch specific dma_supported implementations
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <julian.calaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julian.calaby@gmail.com
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

Hi Christoph,

On Thu, Jun 8, 2017 at 11:25 PM, Christoph Hellwig <hch@lst.de> wrote:
> Usually dma_supported decisions are done by the dma_map_ops instance.
> Switch sparc to that model by providing a ->dma_supported instance for
> sbus that always returns false, and implementations tailored to the sun4u
> and sun4v cases for sparc64, and leave it unimplemented for PCI on
> sparc32, which means always supported.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/sparc/include/asm/dma-mapping.h |  3 ---
>  arch/sparc/kernel/iommu.c            | 40 +++++++++++++++---------------------
>  arch/sparc/kernel/ioport.c           | 22 ++++++--------------
>  arch/sparc/kernel/pci_sun4v.c        | 17 +++++++++++++++
>  4 files changed, 39 insertions(+), 43 deletions(-)
>
> diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
> index dd081d557609..12894f259bea 100644
> --- a/arch/sparc/kernel/ioport.c
> +++ b/arch/sparc/kernel/ioport.c
> @@ -401,6 +401,11 @@ static void sbus_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>         BUG();
>  }
>
> +static int sbus_dma_supported(struct device *dev, u64 mask)
> +{
> +       return 0;
> +}
> +

I'm guessing there's a few places that have DMA ops but DMA isn't
actually supported. Why not have a common method for this, maybe
"dma_not_supported"?

>  static const struct dma_map_ops sbus_dma_ops = {
>         .alloc                  = sbus_alloc_coherent,
>         .free                   = sbus_free_coherent,
> @@ -410,6 +415,7 @@ static const struct dma_map_ops sbus_dma_ops = {
>         .unmap_sg               = sbus_unmap_sg,
>         .sync_sg_for_cpu        = sbus_sync_sg_for_cpu,
>         .sync_sg_for_device     = sbus_sync_sg_for_device,
> +       .dma_supported          = sbus_dma_supported,
>  };
>
>  static int __init sparc_register_ioport(void)

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
