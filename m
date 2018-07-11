Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 14:47:03 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:54785 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993514AbeGKMq4PtFyi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2018 14:46:56 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 11 Jul 2018 12:46:41 +0000
Received: from [10.20.78.104] (10.20.78.104) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Wed, 11
 Jul 2018 05:46:47 -0700
Date:   Wed, 11 Jul 2018 13:46:31 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-mips@linux-mips.org>, <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH 12/25] MIPS: loongson: untangle dma implementations
In-Reply-To: <20180525092111.18516-13-hch@lst.de>
Message-ID: <alpine.DEB.2.00.1807110407510.30992@tp.orcam.me.uk>
References: <20180525092111.18516-1-hch@lst.de> <20180525092111.18516-13-hch@lst.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.104]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1531313201-637137-20727-323700-1
X-BESS-VER: 2018.8-r1807031532
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: maciej.rozycki@uk.mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.195474
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: hch@lst.de,ralf@linux-mips.org,jhogan@kernel.org,cernekee@gmail.com,f.fainelli@gmail.com,chenhc@lemote.com,jiaxun.yang@flygoat.com,david.daney@cavium.com,tsbogend@alpha.franken.de,linux-mips@linux-mips.org,iommu@lists.linux-foundation.org
X-BESS-BRTS-Status: 1
Return-Path: <maciej.rozycki@uk.mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

On Fri, 25 May 2018, Christoph Hellwig wrote:

> Only loongson-3 is DMA coherent and uses swiotlb.  So move the dma
> address translations stubs directly to the loongson-3 code, and remove
> a few Kconfig indirections.

 SiByte should too though, at least for those boards, such as the SWARM 
and the BigSur, that can have DRAM over 4GiB (and 32-bit PCI devices 
plugged).

 I never got to have the wiring of swiotlb completed for these boards as 
I got distracted with getting set up to debug a DRAM controller issue 
observed in the form of memory data corruption with the banks fully 
populated (which might have to do something with the parameters of bank 
interleaving enabled in such a configuration, as replacing a single 
module with a smaller-sized one and therefore disabling interleaving, 
which can only work with all modules being the same size, makes the 
problem go away).

 FWIW,

  Maciej
