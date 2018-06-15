Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 13:09:37 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:49580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993001AbeFOLJKCYMZT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 13:09:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xdqRZuIFHVm12+FbOFnYrkGX0QH9bEXMwQRNUvWy1EY=; b=e2/Hf5SBruqHSR6zXDlhV2eWz
        nVQTYjzI6rDIsPggp9AFD3Nuj8hJF0qz9CoXF060Oa2W/sAnfW9FQ7evSLF7SGoF6KchM73tsYGr6
        UWHSus17wHb72XJis/jPDgEnEfsTQPHO16YeBcM33HyNyEaSC00J7zQ84UVU20A2RspPXVY8CLu9K
        2yBZdfmvrVR2jwoLnp6AXlL/zCMra1ZmsJM37ZxiCGSDZ7Z/zqxcYfIOm1xjQghzQ8vQqPIXdHLxr
        AkBf+VrLkSYAfiQFoKIO6OcczKRHfzL8U185wahPLeVktWd84PWJMLWHBIxk9K+kDJwn9kofE4pqf
        VR7MtL10w==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTmbB-0004gr-J0; Fri, 15 Jun 2018 11:08:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org
Subject: switch mips to use the generic dma map ops v2
Date:   Fri, 15 Jun 2018 13:08:29 +0200
Message-Id: <20180615110854.19253-1-hch@lst.de>
X-Mailer: git-send-email 2.17.1
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64282
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

this huge series does a deep cleaning of the mips dma mapping code and
moves most architectures over to use the generic dma_direct_ops or
dma_noncoherent_ops.  The Jazz architectures grows a new dma_map_ops
tailered to its bare bones iommu implementation, and the swiotlb code
use by Loongson-3 and Octeon is merged into a single implementation,
pending further unification with the generic swiotlb_ops in another
step.
Note that all this has been compile tested only, and I've probably
missed even that for some platforms..

A git tree is available here:

    git://git.infradead.org/users/hch/misc.git mips-direct-ops

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/mips-direct-ops


Changes since v2:
 - addressed review comments from Paul Burton
