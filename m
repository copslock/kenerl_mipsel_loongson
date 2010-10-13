Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Oct 2010 09:54:21 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48484 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491059Ab0JMHyS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Oct 2010 09:54:18 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9D7roPj024624;
        Wed, 13 Oct 2010 08:53:51 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9D7rlW2024622;
        Wed, 13 Oct 2010 08:53:47 +0100
Date:   Wed, 13 Oct 2010 08:53:47 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     dediao@cisco.com, ddaney@caviumnetworks.com, dvomlehn@cisco.com,
        sshtylyov@mvista.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] MIPS: HIGHMEM DMA on noncoherent MIPS32 processors
Message-ID: <20101013075346.GA24052@linux-mips.org>
References: <f3f140ca90dc9dac2f645748bc3a0150@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3f140ca90dc9dac2f645748bc3a0150@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 09, 2010 at 06:53:42PM -0700, Kevin Cernekee wrote:

> [v3: Patch has been rebased against linux-queue.git, which uses the new
> dma-mapping-common.h API.]
> 
> The MIPS DMA coherency functions do not work properly (i.e. kernel oops)
> when HIGHMEM pages are passed in as arguments.  This patch uses the PPC
> approach of calling kmap_atomic() with IRQs disabled to temporarily map
> high pages, in order to flush them out to memory.

It's this disabling of interrupts which I don't like.  It's easy to get
around it by having one kmap type for each of process, softirq and
interrupt context.

The good news is that Peter Zijlstra has rewritten kmap to make the need
for manually allocated kmap types go away and his patches are queued to
be merged for 2.6.37.  So I'd like to put this patch on hold until after
his patches are merged.

Does your system have both highmem and cache aliases?

  Ralf
