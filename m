Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Mar 2015 13:04:09 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35947 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014668AbbC0MEF1VnzK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Mar 2015 13:04:05 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2RC45pt007399;
        Fri, 27 Mar 2015 13:04:05 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2RC452w007398;
        Fri, 27 Mar 2015 13:04:05 +0100
Date:   Fri, 27 Mar 2015 13:04:05 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@linux-mips.org, cernekee@gmail.com,
        jaedon.shin@gmail.com
Subject: Re: [PATCH 1/2] MIPS: BMIPS: Flush the readahead cache after DMA
Message-ID: <20150327120405.GP1385@linux-mips.org>
References: <1427345715-16516-1-git-send-email-f.fainelli@gmail.com>
 <1427345715-16516-2-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1427345715-16516-2-git-send-email-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Mar 25, 2015 at 09:55:14PM -0700, Florian Fainelli wrote:

> From: Kevin Cernekee <cernekee@gmail.com>
> 
> BMIPS 3300/435x/438x CPUs have a readahead cache that is separate from
> the L1/L2.  During a DMA operation, accesses adjacent to a DMA buffer
> may cause parts of the DMA buffer to be prefetched into the RAC.  To
> avoid possible coherency problems, flush the RAC upon DMA completion.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/include/asm/bmips.h |  2 +-
>  arch/mips/mm/dma-default.c    | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)

I'm not keen on including platform-specific files that may blow up on
another platform.  So what I suggest instead is something like rewriting
cpu_needs_post_dma_flush() to invoke a platform-specific hook function
plat_post_dma_flush() which would be defined in <asm/dma-coherence.h>
rsp. <mach/dma-coherence.h>.

I'm going to whip up something.

  Ralf
