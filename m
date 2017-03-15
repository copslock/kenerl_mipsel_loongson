Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 16:27:58 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39160 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991867AbdCOP1uhziTV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Mar 2017 16:27:50 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2FDYlj5007671;
        Wed, 15 Mar 2017 14:34:47 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2FDYlqI007670;
        Wed, 15 Mar 2017 14:34:47 +0100
Date:   Wed, 15 Mar 2017 14:34:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org, Alex Belits <alex.belits@cavium.com>
Subject: Re: [PATCH] MIPS: Add 48-bit VA space (and 4-level page tables) for
 4K pages.
Message-ID: <20170315133446.GD5512@linux-mips.org>
References: <20170217012734.19256-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217012734.19256-1-david.daney@cavium.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57292
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

On Thu, Feb 16, 2017 at 05:27:34PM -0800, David Daney wrote:

> From: Alex Belits <alex.belits@cavium.com>
> 
> Some users must have 4K pages while needing a 48-bit VA space size.
> The cleanest way do do this is to go to a 4-level page table for this
> case.  Each page table level using order-0 pages adds 9 bits to the
> VA size (at 4K pages, so for four levels we get 9 * 4 + 12 == 48-bits.
> 
> For the 4K page size case only we add support functions for the PUD
> level of the page table tree, also the TLB exception handlers get an
> extra level of tree walk.
> 
> Signed-off-by: Alex Belits <alex.belits@cavium.com>
> [david.daney@cavium.com] Forward port to v4.10
> Signed-off-by: David Daney <david.daney@cavium.com>

Thanks folks, queued for 4.12.

While the need for 48-bit address space is not so surprising, the need
for the combination of 4K pages and 48-bit address space is!

I had some minor merge conflicts so it would be good if you could take
a look if https://git.linux-mips.org/cgit/ralf/upstream-sfr.git/commit/?id=afba1896993a0b74aa2ad3076d594e455b3af301
looks good.

  Ralf
