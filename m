Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Dec 2012 15:06:49 +0100 (CET)
Received: from 8bytes.org ([85.214.48.195]:43795 "EHLO mail.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823252Ab2LBOGsONhOy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 2 Dec 2012 15:06:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.8bytes.org (Postfix) with SMTP id 9F7F912AFB8
        for <linux-mips@linux-mips.org>; Sun,  2 Dec 2012 15:06:47 +0100 (CET)
Received: by mail.8bytes.org (Postfix, from userid 1000)
        id 1CED212AF14; Sun,  2 Dec 2012 15:06:45 +0100 (CET)
Date:   Sun, 2 Dec 2012 15:06:45 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     shuah.khan@hp.com, a-jacquiot@ti.com, fenghua.yu@intel.com,
        catalin.marinas@arm.com, lethal@linux-sh.org,
        benh@kernel.crashing.org, ralf@linux-mips.org, tony.luck@intel.com,
        davem@davemloft.net, msalter@redhat.com, monstr@monstr.eu,
        Ming Lei <ming.lei@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
        shuahkhan@gmail.com
Subject: Re: [PATCH 0/9] dma_debug: add debug_dma_mapping_error support to
 architectures that support DMA_DEBUG_API
Message-ID: <20121202140644.GP30633@8bytes.org>
References: <1353706142.5270.93.camel@lorien2>
 <50B34B0F.3080204@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50B34B0F.3080204@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-DSPAM-Result: Whitelisted
X-DSPAM-Processed: Sun Dec  2 15:06:47 2012
X-DSPAM-Confidence: 0.9989
X-DSPAM-Probability: 0.0000
X-DSPAM-Signature: 50bb607722971091017827
X-archive-position: 35166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joro@8bytes.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Marek,
 
On Mon, Nov 26, 2012 at 11:57:19AM +0100, Marek Szyprowski wrote:

> I've took all the patches to the next-dma-debug branch in my tree, I sorry
> that You have to wait so long for it. My branch is based on Joerg's
> dma-debug branch and I've included it for testing in linux-next branch.

The patches are now two times in next. One version from my tree and one
from yours. Please remove the version from your tree, the patches should
go upstream via my dma-debug branch.


	Joerg
