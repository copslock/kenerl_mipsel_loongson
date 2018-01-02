Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 11:40:04 +0100 (CET)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:33745
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992105AbeABKjzyo5l7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 11:39:55 +0100
Received: by mail-qt0-x243.google.com with SMTP id e2so62206044qti.0
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 02:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bofI8PcQCHnmusltUZTV5tVsBokWJosZLHL/vzg7zaA=;
        b=hYj1F23vF5d2IS0dvD822AsVUIAwfM+eWWgHgMD0tdOFKeqPFg46ScRMoGd8JIV/wL
         nu4ItykJpSAJYwAgJP6e+RdT9Cw5iBsqK9tVEa5V6DtO9zUDrIaweWTHB/mpUFV5iVKh
         Brgtq7/+MRT3ORyHD8typT/aFe9GzUF+W5GWz4pRB66+pKT7NKBpV+tDvRDt1pdjZc/w
         l0LyLxpIn4v4tenthA/WfJ1es1ErbLo1dnrDsWauYFGBXZ8DMXsvUjdGEBhuGNhptFni
         M/bYUsqaLwuMk7AoliGopVeP/+ZjYxw1UbFnpQaQenx0sc5muU2waZIqoDRoXXGCo7Ie
         TcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bofI8PcQCHnmusltUZTV5tVsBokWJosZLHL/vzg7zaA=;
        b=D7taUr2/gTRVLdFMzlqzyNNa3YkYjf+rBV5Zh3j2j4Wc2ztKW6RKmVhaW2ODZwOkdv
         qXyEBay7sjMU9FaEKYGawFOlFh+LgF5Wj07+r8RO6FRnaNvBoYx0ifEm3vSAHakrPyrQ
         b76A00qYpgxb8wUUIQRuxyQqqKUXRswCkw2/ma34YR00VdUQr7Gpz3aA8Wd5pgxnuVQb
         ooa+pJozJmpWxuqTVTfpmXh+Q5ig83fkLq+92FcFe9Xm2rPvYdKdjoJ/vHlIhp7zuVWM
         RCqYdUzw49lINDH0VLwGSqDpTndO8YsNDIFNTwWdWFFWeyjnaw3za/SPvxhqX2w2cU6R
         9yGQ==
X-Gm-Message-State: AKGB3mIz84/iAH7DluNshAvQQSbIvohhgKE9yUaR+TFkTm1JS7ZLiZlY
        Rlne5QWdRN1D7cVz6lDRjlSy+E10VO7GfajSBWs=
X-Google-Smtp-Source: ACJfBosbPf1Yas1w0doWFFPhYv/dxaO8Y5oj6sMJCS/OdhydME461aF/AAOtbRFWi2fribE/19DF5LjoYZJWOLxrkJs=
X-Received: by 10.200.54.20 with SMTP id m20mr58123977qtb.83.1514889590137;
 Tue, 02 Jan 2018 02:39:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.44.66 with HTTP; Tue, 2 Jan 2018 02:39:49 -0800 (PST)
In-Reply-To: <20171229081911.2802-6-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-6-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Jan 2018 11:39:49 +0100
X-Google-Sender-Auth: 8eFgU5k_epvRzr9SK7eeV23oz5c
Message-ID: <CAMuHMdV2oT9G3yOjx-oaw06nw27zF_Y34quYf--u13xjKs3dJQ@mail.gmail.com>
Subject: Re: [PATCH 05/67] dma-mapping: replace PCI_DMA_BUS_IS_PHYS with a
 flag in struct dma_map_ops
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        patches@groups.riscv.org,
        "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Cris <linux-cris-kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> The current PCI_DMA_BUS_IS_PHYS decided if a dma implementation is bound
> by the dma mask in the device because it directly maps to a physical
> address range (modulo an offset in the device), or if it is virtualized
> by an iommu and can map any address (that includes virtual iommus like
> swiotlb).  The problem with this scheme is that it is per-architecture and
> not per dma_ops instance, and we are growing more and more setups that
> have multiple different dma operations in use on a single system, for
> which this scheme can't provide a correct answer.  Depending on the
> architecture that means we either get a false positive or false negative
> at the moment.
>
> This patch instead extents the is_phys flag in struct dma_map_ops that
> is currently only used by a few architectures to be used tree wide.
>
> Note that this means that we now need a struct device parent in the
> Scsi_Host or netdevice.  Every modern driver has these, but there might
> still be a few outdated legacy drivers out there, which now won't make
> an intelligent decision.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
