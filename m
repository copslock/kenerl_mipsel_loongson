Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jan 2018 09:49:37 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:37887 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990418AbeADItahyHGB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Jan 2018 09:49:30 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5F40868C8A; Thu,  4 Jan 2018 09:49:30 +0100 (CET)
Date:   Thu, 4 Jan 2018 09:49:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, x86@kernel.org,
        linux-snps-arc@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 16/67] powerpc: rename dma_direct_ to dma_nommu_
Message-ID: <20180104084930.GB3251@lst.de>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-17-hch@lst.de> <878tdgtwzp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878tdgtwzp.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61896
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

On Tue, Jan 02, 2018 at 08:45:30PM +1100, Michael Ellerman wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > We want to use the dma_direct_ namespace for a generic implementation,
> > so rename powerpc to the second best choice: dma_nommu_.
> 
> I'm not a fan of "nommu". Some of the users of direct ops *are* using an
> IOMMU, they're just setting up a 1:1 mapping once at init time, rather
> than mapping dynamically.
> 
> Though I don't have a good idea for a better name, maybe "1to1",
> "linear", "premapped" ?

It seems like a nice counter part to the dma_iommu_ops used just about
anywhere else in ppc.

But I'll happily take any maintainer bike shed decision for the next
series.  Remember that in a merge window or two it will hopefully
go away in favor of the new generic dma_direct ops.
