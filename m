Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 02:19:24 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:35478 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994800AbdFPATQytnIk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 02:19:16 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 410C160B01; Fri, 16 Jun 2017 00:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497572355;
        bh=fQU5/Db9e/d0j0JLdnOcHlM3zWmlVEOoBCouBt1DvdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOkoSh4MSekLta7Es0PvIh5hw3QpzfarkMCFdb+jzGiQRK62Yfjfk5cj+uYU+q/bv
         CV5iaYyw9WjH8K91OuXw2SNsV1yAZITri1/gtlZfjf2UiB0zb00enPr1iLVRZKSP+I
         gWg1puoaa3rF81+6ux1bfl8wKX5QTq25/BGaJKP0=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkuo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D668560A9A;
        Fri, 16 Jun 2017 00:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497572354;
        bh=fQU5/Db9e/d0j0JLdnOcHlM3zWmlVEOoBCouBt1DvdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lj8V3bbpLFpX/jUw2Tp+r1730h6gU7xXn521P31NqT/v089jA7/PAo3wEogm+FnfW
         l8/cmY5pilMhiavBwHeP62vUQYTiZa4b/3gzphdbOdiLj0W3lN5hDY2H6B8c6S7M1R
         AWDe3Qm+QWZ8eNFPSXr5133Yy2pa9RjWyMwExSfg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D668560A9A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date:   Thu, 15 Jun 2017 19:19:11 -0500
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
Subject: Re: [PATCH 17/44] hexagon: switch to use ->mapping_error for error
 reporting
Message-ID: <20170616001911.GA7343@codeaurora.org>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608132609.32662-18-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <rkuo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58494
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

On Thu, Jun 08, 2017 at 03:25:42PM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/hexagon/include/asm/dma-mapping.h |  2 --
>  arch/hexagon/kernel/dma.c              | 12 +++++++++---
>  arch/hexagon/kernel/hexagon_ksyms.c    |  1 -
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
