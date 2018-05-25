Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:21:25 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:50460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990509AbeEYJVSiXVxA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:21:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FWywTzzgSWWTWyLEM7xdYj7tUYkb0lCNQ4SS8LSBN90=; b=WERnr39GF/MqlRoz+q3DOQsy6
        pjN97m64hJmmqTFNfVcGH7I+CBb3IGWUXWJzC8wDVmCvI+5sLZGsIeWDwrPTosNFRH9cZsMTuYNL4
        W/Lfg0CNm2C+ZGSyZi7Z6clvDyM/aZPaswfnceNeEjrJZzlFeOia2gYz8r78W4jxyDbbB6rUbMNVl
        WFHOsEME/pqlt9WU0fVhtTQxUNAdgLk/0QQEiJoEWLuOI2bks3N+KccS6ZFa2glJLF2lSMexldRa5
        KtCLUxeKri/nxcEY5uPAL9bQr6q0wvSzeC9i+Fzrm81mc0pUiwboQLrZQULWCXJHNO5VgkLK52XOV
        ZfDJTjBSg==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8uQ-0001cr-2w; Fri, 25 May 2018 09:21:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [RFC] switch mips to use the generic dma map ops
Date:   Fri, 25 May 2018 11:20:46 +0200
Message-Id: <20180525092111.18516-1-hch@lst.de>
X-Mailer: git-send-email 2.17.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64013
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
