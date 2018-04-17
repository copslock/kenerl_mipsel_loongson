Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2018 21:55:00 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:47565 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994647AbeDQTyyOODle (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Apr 2018 21:54:54 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DD67468CF1; Tue, 17 Apr 2018 21:55:29 +0200 (CEST)
Date:   Tue, 17 Apr 2018 21:55:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Miller <davem@davemloft.net>
Cc:     khandual@linux.vnet.ibm.com, hch@lst.de, konrad.wilk@oracle.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/12] iommu-common: move to arch/sparc
Message-ID: <20180417195529.GA31335@lst.de>
References: <20180415145947.1248-1-hch@lst.de> <20180415145947.1248-2-hch@lst.de> <f0305a92-b206-1567-3c25-67fbd194047d@linux.vnet.ibm.com> <20180416.095833.969403163564136309.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416.095833.969403163564136309.davem@davemloft.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63592
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

On Mon, Apr 16, 2018 at 09:58:33AM -0400, David Miller wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Date: Mon, 16 Apr 2018 14:26:07 +0530
> 
> > On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
> >> This code is only used by sparc, and all new iommu drivers should use the
> >> drivers/iommu/ framework.  Also remove the unused exports.
> >> 
> >> Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Right, these functions are used only from SPARC architecture. Simple
> > git grep confirms it as well. Hence it makes sense to move them into
> > arch code instead.
> 
> Well, we put these into a common location and used type friendly for
> powerpc because we hoped powerpc would convert over to using this
> common piece of code as well.
> 
> But nobody did the powerpc work.
> 
> If you look at the powerpc iommu support, it's the same code basically
> for entry allocation.

I could also introduce a new config symbol and keep it in common code,
but it has been there for a while without any new user.

Right now it just means we built the code for everyone who selects
CONFIG_IOMMU_HELPER, which is just about anyone these days.
