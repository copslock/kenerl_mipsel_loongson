Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:26:27 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:51064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993865AbdFHN0T6ygyT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:26:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NvzecS4fpo+E3s6xhgn5rzrKuRscKSmuWzJ8aThXoGM=; b=aqs7Sbwj0XD38B5w/HAxdg7o/
        Cj+Z248TYtX+eT1XkaxpGHfgTazmR+f8Uf2XjjhDr324+rmzH/JIUMy6MWC7g6gbPzK/v0znBnQri
        A9opUpVVTA0B0Vlkb5aD/gRDwg9oCnp4GnKteGNqk35fzRe/hF6/Gml2rZDXjsLyWrnaeXjqyigqu
        JhF6cIoaVt4r2TkeeChjKMwFlkSqN1ZUb2S8cEhtFubpFC3REaBg4vjTOrtqj4ZQeCd+KgWCBWOWM
        QV83rfgCXutGBekxr4Ko4s+E/emT0Xxkcdx147TaS9drENu5ZSIcwXFBHMOFsGrruqhcEEx8xnYmw
        d4JLDmvMA==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxS1-0004mm-Ok; Thu, 08 Jun 2017 13:26:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: clean up and modularize arch dma_mapping interface
Date:   Thu,  8 Jun 2017 15:25:25 +0200
Message-Id: <20170608132609.32662-1-hch@lst.de>
X-Mailer: git-send-email 2.11.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58309
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

Hi all,

for a while we have a generic implementation of the dma mapping routines
that call into per-arch or per-device operations.  But right now there
still are various bits in the interfaces where don't clearly operate
on these ops.  This series tries to clean up a lot of those (but not all
yet, but the series is big enough).  It gets rid of the DMA_ERROR_CODE
way of signaling failures of the mapping routines from the
implementations to the generic code (and cleans up various drivers that
were incorrectly using it), and gets rid of the ->set_dma_mask routine
in favor of relying on the ->dma_capable method that can be used in
the same way, but which requires less code duplication.

Btw, we don't seem to have a tree every-growing amount of common dma
mapping code, and given that I have a fair amount of all over the tree
work in that area in my plate I'd like to start one.  Any good reason
to that?  Anyone willing to volunteer as co maintainer?

The whole series is also available in git:

    git://git.infradead.org/users/hch/misc.git dma-map

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-map
