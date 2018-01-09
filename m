Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jan 2018 16:56:05 +0100 (CET)
Received: from bastet.se.axis.com ([195.60.68.11]:35717 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992956AbeAIPz5AnYfz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Jan 2018 16:55:57 +0100
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id ADB0818095;
        Tue,  9 Jan 2018 16:55:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ylOXaW5dMDoW; Tue,  9 Jan 2018 16:55:50 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id D622D183C3;
        Tue,  9 Jan 2018 16:55:50 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4BE21E070;
        Tue,  9 Jan 2018 16:55:50 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B857E1E077;
        Tue,  9 Jan 2018 16:55:50 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Tue,  9 Jan 2018 16:55:50 +0100 (CET)
Received: from lnxjespern3.se.axis.com (lnxjespern3.se.axis.com [10.88.4.8])
        by seth.se.axis.com (Postfix) with ESMTP id A8DF52D94;
        Tue,  9 Jan 2018 16:55:50 +0100 (CET)
Received: by lnxjespern3.se.axis.com (Postfix, from userid 363)
        id A4979800EF; Tue,  9 Jan 2018 16:55:50 +0100 (CET)
Date:   Tue, 9 Jan 2018 16:55:50 +0100
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        x86@kernel.org, linux-snps-arc@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/67] dma-mapping: replace PCI_DMA_BUS_IS_PHYS with a
 flag in struct dma_map_ops
Message-ID: <20180109155550.GP32368@axis.com>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171229081911.2802-6-hch@lst.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
Return-Path: <jesper.nilsson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jesper.nilsson@axis.com
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

On Fri, Dec 29, 2017 at 09:18:09AM +0100, Christoph Hellwig wrote:
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

For the CRIS part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  arch/cris/arch-v32/drivers/pci/dma.c  |  1 +
>  arch/cris/include/asm/pci.h           |  6 ------

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
