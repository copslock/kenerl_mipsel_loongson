Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2018 14:33:54 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:37516 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993973AbeGJMdoGeaLJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 Jul 2018 14:33:44 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BF4EE68B97; Tue, 10 Jul 2018 14:35:18 +0200 (CEST)
Date:   Tue, 10 Jul 2018 14:35:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 18/25] MIPS: loongson64: use generic dma noncoherent ops
Message-ID: <20180710123518.GA1812@lst.de>
References: <20180615110854.19253-1-hch@lst.de> <20180615110854.19253-19-hch@lst.de> <20180619231925.mgbgc7lfvjqumr7a@pburton-laptop> <20180620072328.GA1675@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620072328.GA1675@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64756
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

On Wed, Jun 20, 2018 at 09:23:28AM +0200, Christoph Hellwig wrote:
> No, this is a mixup.  I hadn't noticed one case was 0x0fffffff and
> the other 0x7fffffff.
> 
> Below is the minimal fixup that keeps things as much as it was before.

IS the rest of the series now ok with you?  Anything else I should
update?
