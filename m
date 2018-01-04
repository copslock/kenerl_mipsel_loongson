Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jan 2018 09:52:12 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:37928 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990418AbeADIwFt30dB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Jan 2018 09:52:05 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5C80568C8A; Thu,  4 Jan 2018 09:52:05 +0100 (CET)
Date:   Thu, 4 Jan 2018 09:52:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
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
Subject: Re: [PATCH 27/67] dma-direct: add dma address sanity checks
Message-ID: <20180104085205.GC3251@lst.de>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-28-hch@lst.de> <CAMuHMdWg3PnTXezMCcr3oGf-83-cjvcj4wGiPk7j2pY1Tgzo9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWg3PnTXezMCcr3oGf-83-cjvcj4wGiPk7j2pY1Tgzo9Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

On Fri, Dec 29, 2017 at 03:12:25PM +0100, Geert Uytterhoeven wrote:
> > +check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
> > +               const char *caller)
> > +{
> > +       if (unlikely(dev && !dma_capable(dev, dma_addr, size))) {
> > +               if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
> > +                       dev_err(dev,
> > +                               "%s: overflow %llx+%zu of device mask %llx\n",
> 
> Please use "%pad" to format dma_addr_t ...
> 
> > +                               caller, (long long)dma_addr, size,
> 
> ... and use &dma_addr.
> 
> > +                               (long long)*dev->dma_mask);
> 
> This cast is not needed, as u64 is unsigned long long in kernelspace on
> all architectures.

Thanks, fixed.
