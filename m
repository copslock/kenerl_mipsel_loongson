Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2014 14:24:17 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49607 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008018AbaLCNYQMdAvZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Dec 2014 14:24:16 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sB3DOC20016664;
        Wed, 3 Dec 2014 14:24:12 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sB3DOBmB016663;
        Wed, 3 Dec 2014 14:24:11 +0100
Date:   Wed, 3 Dec 2014 14:24:11 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Lars Persson <lars.persson@axis.com>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "james.hogan@imgtec.com" <james.hogan@imgtec.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "paul.burton@imgtec.com" <paul.burton@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "manuel.lauss@gmail.com" <manuel.lauss@gmail.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "blogic@openwrt.org" <blogic@openwrt.org>,
        "markos.chandras@imgtec.com" <markos.chandras@imgtec.com>
Subject: Re: [PATCH] Revert "MIPS: Remove race window in page fault handling"
Message-ID: <20141203132411.GA16063@linux-mips.org>
References: <20141203032542.15388.17340.stgit@linux-yegoshin>
 <1417599104.10996.16.camel@lnxlarper.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1417599104.10996.16.camel@lnxlarper.se.axis.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44554
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

On Wed, Dec 03, 2014 at 10:31:44AM +0100, Lars Persson wrote:

> Hi Leonid
> 
> First let me describe the mechanism of this race condition, which was a
> fault in the kernel's MIPS architecture code. Specifically in its
> implementation of lazy dcache flushing. AFAIK, it would only hit on
> systems where the pagein code path writes to the page from the CPU.
> 
> The order of calls is:
> flush_dcache_page() (from the FS's readpage)
> set_pte_at()
> update_mmu_cache()
> 
> The thread number one has executed the set_pte_at() when thread number
> two hits the same page. It finds a valid PTE and proceeds to execute
> code from a page that is not yet flushed to the point of I/D coherency.
> That flush would happen in update_mmu_cache().
> 
> My patch does increase number of cache flushes for CoW yes and there
> could be an optimization opportunity by playing tricks with the pte_t to
> include information about executability of the mapping. 
> 
> Reverting the patch is a big no-no, then we go back to a state of
> undefined CPU behavior.

The performance issues of this patch were fairly obvious when I applied
the patch.  At that time I choose correctness over performance.  But it
needs proper sorting.  Too massive performance impact also is a bug and
Leonid's sledgehammer approach to revoke the patch outright without
anything better to replace it is not the right way either!

  Ralf
