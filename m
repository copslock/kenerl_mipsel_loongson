Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2018 09:47:44 +0200 (CEST)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:35301
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993961AbeGJHrey7tbm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Jul 2018 09:47:34 +0200
Received: by mail-lf0-x244.google.com with SMTP id f18-v6so1349662lfc.2;
        Tue, 10 Jul 2018 00:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=brez9X33y1AterNHq7JRaWyWV5IlwR9Mgh20hYDRQ5M=;
        b=oqpZ05pt5xiBfqnZA/yS27zyA49Xcdn7+4RwJzWiT9SQIuKhnsBv03qbSAhDywPM9o
         jzzp7wSW6pZrPiDYgOB+IDKFF7214BAQtbEoHkB36tE86iNQDNcuSNt1lgFsEs6XYnNI
         65z/KTXNclIAaw4M5GHxDOShj+5RxrcchTeQ3HrevPr/NQ2H0xUwKWaJBvK8odi+PpzK
         VQRE6IuH/JG7FNiq7rhcBF6JOAF3aDbKnfJzDTtrvnCFZ2XV275bvChGhnEXDo4gpohR
         DRgvmDsaOK1bzNMHFjQ07R9rW1zidGbN5iihvS+fN674tYqLA6C8E4AxGaNbYPpxNPS+
         f9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=brez9X33y1AterNHq7JRaWyWV5IlwR9Mgh20hYDRQ5M=;
        b=HuD4mLr2ujjzC3c8VGbIkFFZ04ccrhm4nckhVyxR36y5mVlGxiRbHpPj05C5R0OoNG
         QAhe6IC1LQXDN3XWSyN3Jprvx3LYC06iB/TIrVTW8ExAaTyqdCuZ7qACxAu74NBhb0pM
         5BkzBbRFJhCPmsyaFkzlMWxwOxhZmqn9lvaiTgAl+yO96zrZpZi+RHr16HGsSjFbhQxK
         Adct2MoK8GKQfQZmHbiR/ROAoGfo2ll5Ss1OcK4R6ucQqbDhJmEZv4Cf1X5Wpfq+7USz
         sLG1B99SUb865a93CiDo6IDVO5is1cgHn/YmQ4aB56WWvrMdB0CkeU9sqMY9m2dQYr/U
         /q3A==
X-Gm-Message-State: APt69E2XZjCjb+UhadyWiLaic5tjpKfPeHO4V2G6u/zHzGTEHphU1mLC
        D4YmyzStQVmCIJPBeyrf23o=
X-Google-Smtp-Source: AAOMgpdWd3O8XlDkZ/6XKr+oWmb4fD3MATb0rPxE7JSNvZuKvKK70ds9fSv5N/rfY0W1B6sqV8gLxw==
X-Received: by 2002:a19:17c2:: with SMTP id 63-v6mr1858648lfx.112.1531208849349;
        Tue, 10 Jul 2018 00:47:29 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id g22-v6sm1382726lja.14.2018.07.10.00.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 00:47:28 -0700 (PDT)
Date:   Tue, 10 Jul 2018 10:48:15 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, okaya@codeaurora.org,
        chenhc@lemote.com, Sergey.Semin@t-platforms.ru,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# v4 . 11" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated()
 method
Message-ID: <20180710074815.GA30235@mobilestation>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
 <20180709135713.8083-2-fancer.lancer@gmail.com>
 <CA+7wUsxDfBdiGt5tZ7dxb63oMd=3Ry4s1Xysed8RSHJi35=VxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+7wUsxDfBdiGt5tZ7dxb63oMd=3Ry4s1Xysed8RSHJi35=VxQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

On Tue, Jul 10, 2018 at 09:15:17AM +0200, Mathieu Malaterre <malat@debian.org> wrote:
> '
> On Mon, Jul 9, 2018 at 3:57 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Adaptive ioremap_wc() method is now available (see "mips: mm:
> > Create UCA-based ioremap_wc() method" commit). We can use it for
> > UCA-featured MMIO transactions in the kernel, so we don't need
> > it platform clone ioremap_uncached_accelerated() being declard.
> > Seeing it is also unused anywhere in the kernel code, lets remove
> > it from io.h arch-specific header then.
> >
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > Singed-off-by: Paul Burton <paul.burton@mips.com>
> 
> nit: 'Signed' (on both patches)
> 

Good catch! Thanks. Didn't notice the typo. Should have copy-pasted
both the signature and the e-mail from another letter.

I'll fix it if there will be a second version of the patchset. Otherwise
I suppose it would be easier for the integrator to do this.

Regards,
-Sergey

> > Cc: James Hogan <jhogan@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/mips/include/asm/io.h | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> > index babe5155a..360b7ddeb 100644
> > --- a/arch/mips/include/asm/io.h
> > +++ b/arch/mips/include/asm/io.h
> > @@ -301,15 +301,11 @@ static inline void __iomem * __ioremap_mode(phys_addr_t offset, unsigned long si
> >         __ioremap_mode((offset), (size), boot_cpu_data.writecombine)
> >
> >  /*
> > - * These two are MIPS specific ioremap variant.         ioremap_cacheable_cow
> > - * requests a cachable mapping, ioremap_uncached_accelerated requests a
> > - * mapping using the uncached accelerated mode which isn't supported on
> > - * all processors.
> > + * This is a MIPS specific ioremap variant. ioremap_cacheable_cow
> > + * requests a cachable mapping with CWB attribute enabled.
> >   */
> >  #define ioremap_cacheable_cow(offset, size)                            \
> >         __ioremap_mode((offset), (size), _CACHE_CACHABLE_COW)
> > -#define ioremap_uncached_accelerated(offset, size)                     \
> > -       __ioremap_mode((offset), (size), _CACHE_UNCACHED_ACCELERATED)
> >
> >  static inline void iounmap(const volatile void __iomem *addr)
> >  {
> > --
> > 2.12.0
> >
> >
