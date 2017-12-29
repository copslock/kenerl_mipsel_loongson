Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 11:52:40 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53668 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990412AbdL2KwdRP6Fj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 11:52:33 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA4DD80D;
        Fri, 29 Dec 2017 02:52:25 -0800 (PST)
Received: from [10.1.78.28] (unknown [10.1.78.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E963A3F318;
        Fri, 29 Dec 2017 02:52:21 -0800 (PST)
Subject: Re: consolidate direct dma mapping and swiotlb support
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
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
References: <20171229081911.2802-1-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <23fee3bb-61ce-1735-b264-3acc0109c858@arm.com>
Date:   Fri, 29 Dec 2017 10:52:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <vladimir.murzin@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vladimir.murzin@arm.com
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

On 29/12/17 08:18, Christoph Hellwig wrote:
> Almost every architecture supports a direct dma mapping implementation,
> where no iommu is used and the device dma address is a 1:1 mapping to
> the physical address or has a simple linear offset.  Currently the
> code for this implementation is most duplicated over the architectures,
> and the duplicated again in the swiotlb code, and then duplicated again
> for special cases like the x86 memory encryption DMA ops.
> 
> This series takes the existing very simple dma-noop dma mapping
> implementation, enhances it with all the x86 features and quirks, and
> creates a common set of architecture hooks for it and the swiotlb code.
> 
> It then switches a large number of architectures to this generic
> direct map implement and the new generic swiotlb dma_map ops.
> 
> Note that for now this only handles architectures that do cache coherent
> DMA, but a similar consolidation for non-coherent architectures is in the
> work for later merge windows.

Is it available in your dma-mapping.git or somewhere else?

Cheers
Vladimir

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
