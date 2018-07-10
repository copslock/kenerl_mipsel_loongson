Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2018 09:15:45 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33136 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993941AbeGJHPgYxP-s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Jul 2018 09:15:36 +0200
Received: by mail-oi0-f67.google.com with SMTP id c6-v6so40760251oiy.0;
        Tue, 10 Jul 2018 00:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwKrW6mT4u9JAZLluFBYtFh88wVkaqRFNP7pLqPDvSw=;
        b=gZ9ktwOp5a8md9nbQ60sY84Tpg+7qUixtWvspZmvkJIq/3bjRKb8JQJou1TrnxC4F5
         hhJQnWRXM9ZQpkOPK4AnLeZC06Dt8zWnDAeM3JfIHnsW+UbcmzwTK9i6hfKZ3/pAg3Iz
         m3Kp51x8Pcnt41+HTu43az/uR66ZGG8GVctIHYXv86NoxzG8n3I9XTWCanmfqUvfIHmx
         JpIpIsENF+jKjHD8btOTQeT0x1trgrRwrdqBYyb38MfggClWKIsgqYe9sxhWMNGCXydg
         VBW4+k1EXx47uG45ITGaXEu84V2nwPvaGI5NU9ThSqBzmr7ANVUdeKvwLCPLCFPOeHh2
         ETew==
X-Gm-Message-State: APt69E3E2F9iDm+VfqlP3gRbgbec444pZFgSWGzca4DeLTBY9G5UJ2Ca
        l/ygXpZSXdnQIZW5B2NE0nZh7qVk+SAza9UTPcY=
X-Google-Smtp-Source: AAOMgpeb/ovXsMPVl9nZNvQHJMFLUCKwpfMnxiISzdezqDVswi3v60twltm9p8wzsd+8ZtEXC6ydWspX177f6lSdx5c=
X-Received: by 2002:aca:758c:: with SMTP id q134-v6mr28498734oic.334.1531206930180;
 Tue, 10 Jul 2018 00:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180709135713.8083-1-fancer.lancer@gmail.com> <20180709135713.8083-2-fancer.lancer@gmail.com>
In-Reply-To: <20180709135713.8083-2-fancer.lancer@gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 10 Jul 2018 09:15:17 +0200
Message-ID: <CA+7wUsxDfBdiGt5tZ7dxb63oMd=3Ry4s1Xysed8RSHJi35=VxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated() method
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, okaya@codeaurora.org,
        chenhc@lemote.com, Sergey.Semin@t-platforms.ru,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# v4 . 11" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

'
On Mon, Jul 9, 2018 at 3:57 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Adaptive ioremap_wc() method is now available (see "mips: mm:
> Create UCA-based ioremap_wc() method" commit). We can use it for
> UCA-featured MMIO transactions in the kernel, so we don't need
> it platform clone ioremap_uncached_accelerated() being declard.
> Seeing it is also unused anywhere in the kernel code, lets remove
> it from io.h arch-specific header then.
>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> Singed-off-by: Paul Burton <paul.burton@mips.com>

nit: 'Signed' (on both patches)

> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: stable@vger.kernel.org
> ---
>  arch/mips/include/asm/io.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index babe5155a..360b7ddeb 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -301,15 +301,11 @@ static inline void __iomem * __ioremap_mode(phys_addr_t offset, unsigned long si
>         __ioremap_mode((offset), (size), boot_cpu_data.writecombine)
>
>  /*
> - * These two are MIPS specific ioremap variant.         ioremap_cacheable_cow
> - * requests a cachable mapping, ioremap_uncached_accelerated requests a
> - * mapping using the uncached accelerated mode which isn't supported on
> - * all processors.
> + * This is a MIPS specific ioremap variant. ioremap_cacheable_cow
> + * requests a cachable mapping with CWB attribute enabled.
>   */
>  #define ioremap_cacheable_cow(offset, size)                            \
>         __ioremap_mode((offset), (size), _CACHE_CACHABLE_COW)
> -#define ioremap_uncached_accelerated(offset, size)                     \
> -       __ioremap_mode((offset), (size), _CACHE_UNCACHED_ACCELERATED)
>
>  static inline void iounmap(const volatile void __iomem *addr)
>  {
> --
> 2.12.0
>
>
