Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2014 10:32:09 +0100 (CET)
Received: from bes.se.axis.com ([195.60.68.10]:38344 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006871AbaLCJcHGIwhj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Dec 2014 10:32:07 +0100
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 638382E2BD;
        Wed,  3 Dec 2014 10:32:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 9L8vWu5bqLEM; Wed,  3 Dec 2014 10:31:58 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id C05992E067;
        Wed,  3 Dec 2014 10:31:57 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id A2A281136;
        Wed,  3 Dec 2014 10:31:57 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id 9610DAC6;
        Wed,  3 Dec 2014 10:31:57 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by seth.se.axis.com (Postfix) with ESMTP id 920183E23F;
        Wed,  3 Dec 2014 10:31:57 +0100 (CET)
Received: from [10.88.41.1] (10.88.41.1) by xmail2.se.axis.com (10.0.5.74)
 with Microsoft SMTP Server (TLS) id 8.3.342.0; Wed, 3 Dec 2014 10:31:57 +0100
Message-ID: <1417599104.10996.16.camel@lnxlarper.se.axis.com>
Subject: Re: [PATCH] Revert "MIPS: Remove race window in page fault handling"
From:   Lars Persson <lars.persson@axis.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "james.hogan@imgtec.com" <james.hogan@imgtec.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "paul.burton@imgtec.com" <paul.burton@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "manuel.lauss@gmail.com" <manuel.lauss@gmail.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "blogic@openwrt.org" <blogic@openwrt.org>,
        "markos.chandras@imgtec.com" <markos.chandras@imgtec.com>
Date:   Wed, 3 Dec 2014 10:31:44 +0100
In-Reply-To: <20141203032542.15388.17340.stgit@linux-yegoshin>
References: <20141203032542.15388.17340.stgit@linux-yegoshin>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4-3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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

Hi Leonid

First let me describe the mechanism of this race condition, which was a
fault in the kernel's MIPS architecture code. Specifically in its
implementation of lazy dcache flushing. AFAIK, it would only hit on
systems where the pagein code path writes to the page from the CPU.

The order of calls is:
flush_dcache_page() (from the FS's readpage)
set_pte_at()
update_mmu_cache()

The thread number one has executed the set_pte_at() when thread number
two hits the same page. It finds a valid PTE and proceeds to execute
code from a page that is not yet flushed to the point of I/D coherency.
That flush would happen in update_mmu_cache().

My patch does increase number of cache flushes for CoW yes and there
could be an optimization opportunity by playing tricks with the pte_t to
include information about executability of the mapping. 

Reverting the patch is a big no-no, then we go back to a state of
undefined CPU behavior.

- Lars


On Wed, 2014-12-03 at 04:25 +0100, Leonid Yegoshin wrote:
> This reverts commit 64f23ab30b1fec86b91a48bf1f088840e5299971
> (commit 2a4a8b1e5d9d343e13ff22e19af7b353f7b52d6f in Linux 'master')
> 
> Unfortunately the original commit effectively kills Imagination MIPS CPUs
> performance because it enforces page cache flush each time then PTE is changed
> for our CPUs. Basically - each CoW, each process start, each library attachment
> or detachment. And it happens even in "fully-coherent" systems (in MIPS sense -
> we have non coherent I-cache). Last tendency for increasing page size to 16K-64K
> even exaggerate the performance loss.
> 
> Original commit discussion says:
> 
>     Kernel call stacks showed one thread handling an illegal instruction
>     exception while another thread was somewhere around the
>     set_pte_at/update_mmu_cache calls for the same page.
> 
> If this is taken correct then it points to a major problem unrelated to MIPS -
> if by chance a first thread hits the page just before set_pte_at then it should
> get a non-present PTE: set_pte_at with _PAGE_PRESENT/_PAGE_VALID flags can be
> used only on "disactivated" PTE, after pte_clear* functions, effectively -
> non-present, non-valid. And application can get SIGSEGV. It is a major race
> condition and kernel should not offer it to applications. And in my
> understanding set_pte_at is used in cases then page is available after kernel
> finishes page handling, at least in theory.
> 
> Test note: I ran MIPS 1004K with 8 VPEs on 4 cores around 1.5 month on SOAK test
> and never seen that problem on 3.10 kernel.
> 
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>  
> 
