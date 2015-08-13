Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 17:21:15 +0200 (CEST)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:49888 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011300AbbHMPVONPwGv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 17:21:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=28x4Dmsvx0Uh4eLhj9hWpzvPfliwmHrXttLUXrAv6X0=;
        b=TOMMw43hCb9ttmecBhy49gLND43pS4fn5UAbYywjfow9paB2z5J67ebxg8GxDL+scxmZctCPFxRVN8UZ+x2HM6EeSV+BvQpxarTrbJKlEnmeY2EYRfeTNLCpt8YHNqOcxCTmXyk4zBv2CfeYAnDwNANjNS60Jb6eZJrdC7j9g8k=;
Received: from n2100.arm.linux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:52855)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1ZPuJ9-0008EY-W9; Thu, 13 Aug 2015 16:20:44 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1ZPuJ6-0006rA-Pj; Thu, 13 Aug 2015 16:20:40 +0100
Date:   Thu, 13 Aug 2015 16:20:40 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     akpm@linux-foundation.org, arnd@arndb.de, catalin.marinas@arm.com,
        will.deacon@arm.com, ysato@users.sourceforge.jp, monstr@monstr.eu,
        jonas@southpole.se, cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dma-mapping: consolidate dma_{alloc,free}_noncoherent
Message-ID: <20150813152040.GQ7557@n2100.arm.linux.org.uk>
References: <1439478248-15183-1-git-send-email-hch@lst.de>
 <1439478248-15183-3-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1439478248-15183-3-git-send-email-hch@lst.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Thu, Aug 13, 2015 at 05:04:05PM +0200, Christoph Hellwig wrote:
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 2ae3424..ab521d5 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -175,21 +175,6 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>  	return dma_addr == DMA_ERROR_CODE;
>  }
>  
> -/*
> - * Dummy noncoherent implementation.  We don't provide a dma_cache_sync
> - * function so drivers using this API are highlighted with build warnings.
> - */

I'd like a similar comment to remain after this patch explaining that we
don't support non-coherent allocations and that it'll be highlighted by
the lack of dma_cache_sync, otherwise I'm sure we'll start to get patches
to add the thing.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
