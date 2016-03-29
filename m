Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2016 21:36:21 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.13]:51482 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025627AbcC2TgTrT1wh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Mar 2016 21:36:19 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0MCIHB-1acV2o0pgf-00984F; Tue, 29 Mar
 2016 21:32:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org,
        Denys Vlasenko <dvlasenk@redhat.com>
Cc:     Konrad Rzeszutek Wilk <konrad@kernel.org>,
        Sinan Kaya <okaya@codeaurora.org>, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Huacai Chen <chenhc@lemote.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jisheng Zhang <jszhang@marvell.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Michael Ellerman <mpe@ellerman.id.au>, timur@codeaurora.org,
        X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Akinobu Mita <akinobu.mita@gmail.com>, cov@codeaurora.org,
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
        Robin Murphy <robin.murphy@arm.com>, nwatters@codeaurora.org
Subject: Re: [PATCH 2/3] swiotlb: prefix dma_to_phys and phys_to_dma functions
Date:   Tue, 29 Mar 2016 21:32:07 +0200
Message-ID: <6420021.rzhE3kJKJP@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CACJDEmrzKOExg-Rchjy2hfVzkzbCZ=WNn4Bu3EVgim748VvRig@mail.gmail.com>
References: <1458252137-24497-1-git-send-email-okaya@codeaurora.org> <56EC1805.5060207@codeaurora.org> <CACJDEmrzKOExg-Rchjy2hfVzkzbCZ=WNn4Bu3EVgim748VvRig@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:tqnwciplf3N9FU4xAL9BHpvbwDqN+UQyVwaClxmX7+x/D+pFWTw
 WpXRc87/OqIzDIez85/3q/B73zeQYFX3q8eZrfrcDUI5y2VpQLaFnIOAuBKi78wIbyqQRTb
 mXfAAioky2HsrLnoMi+xnjTZTEKXTid8UMurmgn+dB7LEO9A52Uk4+T+L7zarXB/N5auT7q
 B2rjZqjDFmzfSCH2zW0NA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mjFFRkxZ4e0=:wgDPle4R7k5GpQmxJ1cQpa
 OEApsS/XivD39HUjsNwAZW16PGy7/w98rxeEGdjTQKcDEKhVCIK8fWEzD3CWtajfnlZePQUho
 4EDWzMO9H7TwuRwmmnw5B2s3qd3l9RWEobAwQu02VJSt1s720w+KrhOEb7Qkn7AsqRN3+XgLR
 EEV73dEL7Jv2+XgcrDEcp0qcHPUtDu6pEK33LwWVfODASn9R0htXa/4aP2EctphjMk2ERIeNS
 rZEiloYHbhAmT7Vg3cXUIbZxwkzQ9YKDJ8UtR8AsxAFR/82PvM+nm4Kgfb93h2gGQmAgRcqZO
 b0+t+euf9zsGZBUsymJWK4Im6nQ6z8+r2voVgIKA6m0Ay46WbMW2o45hFvZLgZ+aZuVZBLs21
 8KqX7gYUH7VDSU5TPU5ni9sjAQ/6F8A3HJ2O8+NIzIoTIcS06PwDkNyme6Ug7RTkfj7ZcFJSU
 vxHuYWWQ8cQ8DBlw0aawhBn8K7TQ9Qsym25wvjwDKvF2eSkKcuYZc8FSD08hUgqgJSFZaiBGj
 YhjW7Iy9kx3dwIlUp1cWxrOAVbabhV7K98ZpKNEgU7+MwOENjDhhaeZGQYAgx2ZUq+5Phya8P
 SYKqUHYjvWRx+9PmLj/C3GhT5TlZ5qGWemInQEwo4v7cl4AisWRdt0WbqaoO2BzKpNMzAU8no
 v+6LIcwIatbUDYumGo/GFrFGEcTJ08z4UpvgwvZsPrW4Z1MKjslaM3Xf70sclObnGkscK/PJq
 6DJTFXJMKKBhRhCp
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Monday 28 March 2016 14:29:29 Konrad Rzeszutek Wilk wrote:
> > diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> > index ada00c3..8c0f66b 100644
> > --- a/arch/arm64/mm/dma-mapping.c
> > +++ b/arch/arm64/mm/dma-mapping.c
> > @@ -29,6 +29,14 @@
> >
> >  #include <asm/cacheflush.h>
> >
> > +/*
> > + * If you are building a system without IOMMU, then you are using SWIOTLB
> > + * library. The ARM64 adaptation of this library does not support address
> > + * translation and it assumes that physical address = dma address for such
> > + * a use case. Please don't build a platform that violates this.
> > + */
> 
> Why not just expand the ARM64 part to support address translation?

Because so far all hardware we have is relatively sane. We only
need to implement this if someone accidentally puts their DMA
space at the wrong address.

There is at least one platform that could in theory use this because
their RAM starts at an address that is outside of the reach of 32-bit
devices, and a static IOMMU mapping (created by firmware) could be
used to map the start of RAM into DMA address zero, to avoid having
to use an IOMMU all the time, but it was considered not worth the
effort to implement that.

	Arnd
