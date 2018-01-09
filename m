Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jan 2018 16:53:40 +0100 (CET)
Received: from bastet.se.axis.com ([195.60.68.11]:35368 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990427AbeAIPx1p6rSz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Jan 2018 16:53:27 +0100
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 37659183E8;
        Tue,  9 Jan 2018 16:53:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 1j9dfNq2IT8E; Tue,  9 Jan 2018 16:53:19 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 3727F183C3;
        Tue,  9 Jan 2018 16:53:18 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D76B1E074;
        Tue,  9 Jan 2018 16:53:18 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ECAB1E070;
        Tue,  9 Jan 2018 16:53:18 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Tue,  9 Jan 2018 16:53:18 +0100 (CET)
Received: from lnxjespern3.se.axis.com (lnxjespern3.se.axis.com [10.88.4.8])
        by thoth.se.axis.com (Postfix) with ESMTP id F34382DFD;
        Tue,  9 Jan 2018 16:53:17 +0100 (CET)
Received: by lnxjespern3.se.axis.com (Postfix, from userid 363)
        id EDE55800EF; Tue,  9 Jan 2018 16:53:17 +0100 (CET)
Date:   Tue, 9 Jan 2018 16:53:17 +0100
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
Subject: Re: [PATCH 34/67] cris: use dma-direct
Message-ID: <20180109155317.GN32368@axis.com>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-35-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171229081911.2802-35-hch@lst.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
Return-Path: <jesper.nilsson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61960
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

On Fri, Dec 29, 2017 at 09:18:38AM +0100, Christoph Hellwig wrote:
> cris currently has an incomplete direct mapping dma_map_ops implementation
> is PCI support is enabled.  Replace it with the fully feature generic
> dma-direct implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For CRIS:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  arch/cris/Kconfig                       |  4 ++
>  arch/cris/arch-v32/drivers/pci/Makefile |  2 +-
>  arch/cris/arch-v32/drivers/pci/dma.c    | 78 ---------------------------------
>  arch/cris/include/asm/Kbuild            |  1 +
>  arch/cris/include/asm/dma-mapping.h     | 20 ---------
>  5 files changed, 6 insertions(+), 99 deletions(-)
>  delete mode 100644 arch/cris/arch-v32/drivers/pci/dma.c
>  delete mode 100644 arch/cris/include/asm/dma-mapping.h
> 

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
