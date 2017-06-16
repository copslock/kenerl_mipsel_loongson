Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 02:20:39 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:36928 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994800AbdFPAU0WHOEk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 02:20:26 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 20A1160ACA; Fri, 16 Jun 2017 00:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497572425;
        bh=WuWNFHi7hiU/mdKf44MyuHbyiyUY4D4v3n20Cfm5WkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ba4FOqmZ/hC/H8HI98uazPzyRCQ4s6X38Qo9MEnuBr+7y+PgfyLwP1rgDh7M3iin+
         I+Uiv+lmUW+Yb8pTXO4bnP08TI3HiLH9/Kwkj0Oih9LMRHmL8EnZnJ77xPKbQ875bt
         EDq8+IuFTzIhQBs4D/pD9PA1a9Owy3Fs3Ej+/Hv8=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkuo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A82C60818;
        Fri, 16 Jun 2017 00:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497572424;
        bh=WuWNFHi7hiU/mdKf44MyuHbyiyUY4D4v3n20Cfm5WkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W58BUEKOpgU8/+q8N/KlcUlUhM4IAF64VQYo9+a+UVbGcK9HluQdDFvSAEVd9ROJf
         XuGsuw4XObEfaMUAY3Aqtr9IoIqIiUcqA9emQI+jHSPxQdQ4L7ebwX/D3OH9zRZSfJ
         zLgAVgnn53cjVMijd9Sxi0oKZbQC55rcddacMJ0U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A82C60818
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date:   Thu, 15 Jun 2017 19:20:16 -0500
From:   Richard Kuo <rkuo@codeaurora.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 31/44] hexagon: remove arch-specific dma_supported
 implementation
Message-ID: <20170616002016.GB7343@codeaurora.org>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-32-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608132609.32662-32-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <rkuo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkuo@codeaurora.org
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

On Thu, Jun 08, 2017 at 03:25:56PM +0200, Christoph Hellwig wrote:
> This implementation is simply bogus - hexagon only has a simple
> direct mapped DMA implementation and thus doesn't care about the
> address.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/hexagon/include/asm/dma-mapping.h | 2 --
>  arch/hexagon/kernel/dma.c              | 9 ---------
>  2 files changed, 11 deletions(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
