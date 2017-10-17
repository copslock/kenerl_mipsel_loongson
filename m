Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 10:14:31 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:48624 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990505AbdJQIOZF9eG7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Oct 2017 10:14:25 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3DC5568D00; Tue, 17 Oct 2017 10:14:22 +0200 (CEST)
Date:   Tue, 17 Oct 2017 10:14:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound
        traffic
Message-ID: <20171017081422.GA19475@lst.de>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com> <1507761269-7017-6-git-send-email-jim2101024@gmail.com> <589c04cb-061b-a453-3188-79324a02388e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <589c04cb-061b-a453-3188-79324a02388e@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60419
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

Just took a quick look over this and I basically agree with the comments
from Robin.

What I don't understand is why you're even trying to do all these
hacky things.

It seems like the controller should simply set dma_pfn_offset for
each device hanging off it, and all the supported architectures
should be updated to obey that if they don't do so yet, and
you're done without needing this giant mess.
