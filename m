Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 11:17:38 +0200 (CEST)
Received: from ozlabs.org ([IPv6:2401:3900:2:1::2]:55301 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991786AbdFNJRbfsp6W (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jun 2017 11:17:31 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 3wngyH6PzWz9s76;
        Wed, 14 Jun 2017 19:17:27 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        Alistair Popple <apopple@au1.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/44] powerpc: implement ->mapping_error
In-Reply-To: <20170608132609.32662-22-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de> <20170608132609.32662-22-hch@lst.de>
User-Agent: Notmuch/0.21 (https://notmuchmail.org)
Date:   Wed, 14 Jun 2017 19:17:27 +1000
Message-ID: <87vanz2ajc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

Christoph Hellwig <hch@lst.de> writes:

> DMA_ERROR_CODE is going to go away, so don't rely on it.  Instead
> define a ->mapping_error method for all IOMMU based dma operation
> instances.  The direct ops don't ever return an error and don't
> need a ->mapping_error method.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/include/asm/dma-mapping.h |  4 ----
>  arch/powerpc/include/asm/iommu.h       |  4 ++++
>  arch/powerpc/kernel/dma-iommu.c        |  6 ++++++
>  arch/powerpc/kernel/iommu.c            | 28 ++++++++++++++--------------
>  arch/powerpc/platforms/cell/iommu.c    |  1 +
>  arch/powerpc/platforms/pseries/vio.c   |  3 ++-
>  6 files changed, 27 insertions(+), 19 deletions(-)

I also see:

  arch/powerpc/kernel/dma.c:const struct dma_map_ops dma_direct_ops = {

Which you mentioned can't fail.

  arch/powerpc/platforms/pseries/ibmebus.c:static const struct dma_map_ops ibmebus_dma_ops = {

Which can't fail.

And:

  arch/powerpc/platforms/powernv/npu-dma.c:static const struct dma_map_ops dma_npu_ops = {
  arch/powerpc/platforms/ps3/system-bus.c:static const struct dma_map_ops ps3_sb_dma_ops = {
  arch/powerpc/platforms/ps3/system-bus.c:static const struct dma_map_ops ps3_ioc0_dma_ops = {

All of which look like they definitely can fail, but return 0 on error
and don't implement ->mapping_error.

So I guess I'm acking this and adding a TODO to fix up the NPU code at
least, the ps3 code is probably better left alone these days.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
