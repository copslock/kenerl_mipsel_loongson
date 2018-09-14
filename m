Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 11:58:27 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:47552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeINJ6YiCmaI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2018 11:58:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5nXA/hHUO0A19w4qcEUepqG2LtudD+S0SQEZjFE/eCQ=; b=BwmtMJuEf+S2fisZZhmhrH3A2
        KpRlKFzcO61nfARMjUIhTdk7BaydewlFBjOc7iC/Rx/+MY6LNno41dhGiUpMUuZZv9ex3Dn160p+I
        5DFBiwmdrui8zsxidJ43+baJu6TGLny7L8RkkuPuZtk7PWBBDLv1TKqok6YpcyJwhO2WcKCZWlILX
        oxXJWujvTgJjJ0nKyXzMkSIlBMhpGXuE2BzNacuX9htz+7NV8qsb5A9R9tC90KItJU307oxbCV765
        KgzZ0g/C5q455L8YOYUOatK6Fffdpe6vyYQgpfCmgOXbXyCerbua3VGk7Uv8Wfrd+z+/xL8zkbYMr
        QBEidK6dA==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0krc-0000NR-IY; Fri, 14 Sep 2018 09:58:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: merge dma_direct_ops and dma_noncoherent_ops v3
Date:   Fri, 14 Sep 2018 11:58:02 +0200
Message-Id: <20180914095808.22202-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+df237881911bfff71047+5500+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66249
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

While most architectures are either always or never dma coherent for a
given build, the arm, arm64, mips and soon arc architectures can have
different dma coherent settings on a per-device basis.  Additionally
some mips builds can decide at boot time if dma is coherent or not.

I've started to look into handling noncoherent dma in swiotlb, and
moving the dma-iommu ops into common code [1], and for that we need a
generic way to check if a given device is coherent or not.  Moving
this flag into struct device also simplifies the conditionally coherent
architecture implementations.

These patches are also available in a git tree given that they have
a few previous posted dependencies:

    git://git.infradead.org/users/hch/misc.git dma-direct-noncoherent-merge

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-noncoherent-merge

Changes since v2:
 - return bool from dev_is_dma_coherent

Changes since v1:
 - rebased to the latest Linus' tree which includes coherent dma support
   for arc
 - a couple tidyups suggested by Paul Burton
