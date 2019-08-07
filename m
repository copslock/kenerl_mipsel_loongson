Return-Path: <SRS0=iKbu=WD=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6150DC32754
	for <linux-mips@archiver.kernel.org>; Wed,  7 Aug 2019 06:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA902086D
	for <linux-mips@archiver.kernel.org>; Wed,  7 Aug 2019 06:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cqMrr/Gp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfHGGQY (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:16:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59020 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfHGGQX (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 7 Aug 2019 02:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rCYQCC3TGNYTbnGKL+NdUWUb7Cy3tCnvUbcf422Cqo8=; b=cqMrr/GpDS/ONJa2adLCzijXQ
        nhlDPhMwkhB8TMArgr+DXtiNpRuxaX4gIqfxBbgl2R2TMWBoHU7VjEkm6RgE/+hCjg1dpL5y5tNnn
        s81dLleKt6cPO7tG7ZK9StKoDepTYW/tT9J067lzaDoQk6auHE9prR7gJdA8jeIE8iAdNaUWoQLLx
        5oI96/Ezmcy2PeCA7PjtVpiiBDbYQItbGaFbynb2bTc8fnQCF14c6deoNq/mqUscZaHFzLM2BsYZj
        FJlvl6Vl3KkD6RjJREk7K8QQlAh3eMZFXr+SckdnYDGTzmN798A2lIndyBa1/n1ZhMi6XMaJ5XCDf
        9ggljiyAA==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvFEy-0007do-No; Wed, 07 Aug 2019 06:16:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Shawn Anastasio <shawn@anastas.io>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: fix default dma_mmap_* pgprot v3
Date:   Wed,  7 Aug 2019 09:16:00 +0300
Message-Id: <20190807061602.31217-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi all,

As Shawn pointed out we've had issues with the dma mmap pgprots ever
since the dma_common_mmap helper was added beyong the initial
architectures - we default to uncached mappings, but for devices that
are DMA coherent, or if the DMA_ATTR_NON_CONSISTENT is set (and
supported) this can lead to aliasing of cache attributes.  This patch
fixes that.  My explanation of why this hasn't been much of an issue
is that the dma_mmap_ helpers aren't used widely and mostly just in
architecture specific drivers.

Changes since v2:
 - fix m68knommu compile by inlining dma_prprot helper and providing
   a stub for !CONFIG_MMU
 - fix various typos in the commit messages

Changes since v1:
 - fix handling of DMA_ATTR_NON_CONSISTENT where it is a no-op
   (which is most architectures)
 - remove DMA_ATTR_WRITE_COMBINE on mips, as it seem dangerous as-is
