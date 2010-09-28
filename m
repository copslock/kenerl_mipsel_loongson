Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 02:12:28 +0200 (CEST)
Received: from sh.osrg.net ([192.16.179.4]:60388 "EHLO sh.osrg.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491938Ab0I1AMZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Sep 2010 02:12:25 +0200
Received: from localhost (rose.osrg.net [10.76.0.1])
        by sh.osrg.net (8.14.3/8.14.3/OSRG-NET) with ESMTP id o8S0CHWQ001323;
        Tue, 28 Sep 2010 09:12:17 +0900
Date:   Tue, 28 Sep 2010 09:12:17 +0900
To:     ddaney@caviumnetworks.com
Cc:     fujita.tomonori@lab.ntt.co.jp, linux-mips@linux-mips.org,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] MIPS: Convert DMA to use dma-mapping-common.h
From:   FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <4CA0D5D3.3040700@caviumnetworks.com>
References: <1285281496-24696-6-git-send-email-ddaney@caviumnetworks.com>
        <20100927142628X.fujita.tomonori@lab.ntt.co.jp>
        <4CA0D5D3.3040700@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20100928090805M.fujita.tomonori@lab.ntt.co.jp>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (sh.osrg.net [192.16.179.4]); Tue, 28 Sep 2010 09:12:18 +0900 (JST)
X-Virus-Scanned: clamav-milter 0.96.1 at sh
X-Virus-Status: Clean
X-archive-position: 27835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fujita.tomonori@lab.ntt.co.jp
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 21846

On Mon, 27 Sep 2010 10:35:15 -0700
David Daney <ddaney@caviumnetworks.com> wrote:

> >> diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
> >> index 18fbf7a..9a4c307 100644
> >> --- a/arch/mips/include/asm/dma-mapping.h
> >> +++ b/arch/mips/include/asm/dma-mapping.h
> >> @@ -5,51 +5,67 @@
> >>   #include<asm/cache.h>
> >>   #include<asm-generic/dma-coherent.h>
> >>
> >> -void *dma_alloc_noncoherent(struct device *dev, size_t size,
> >> -			   dma_addr_t *dma_handle, gfp_t flag);
> >> +struct mips_dma_map_ops {
> >> +	struct dma_map_ops dma_map_ops;
> >> +	dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
> >> +	phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
> >> +};
> >
> > The above code doesn't look great but we don't want to add phys_to_dma
> > and dma_to_phys to dma_map_ops struct, and these functions on MIPS
> > looks too complicated for ifdef. So I guess that we need to live with
> > the above code.
> >
> 
> I think you have a point here.  I will attempt to move these two into a 
> chip specific operations vector, and leave the more generic MIPS version 
> with the simplified static definition.

Yeah, that sounds a better (cleaner) approach.
