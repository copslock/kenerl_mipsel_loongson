Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2014 10:33:18 +0100 (CET)
Received: from bastet.se.axis.com ([195.60.68.11]:56843 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007196AbaLEJdNWPixd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2014 10:33:13 +0100
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 94154180D8;
        Fri,  5 Dec 2014 10:33:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 5H4AlJ2gRXZn; Fri,  5 Dec 2014 10:33:02 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id CA36318058;
        Fri,  5 Dec 2014 10:33:01 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id B305C133D;
        Fri,  5 Dec 2014 10:33:01 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id A4CDF54A;
        Fri,  5 Dec 2014 10:33:01 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by thoth.se.axis.com (Postfix) with ESMTP id 9CDB634269;
        Fri,  5 Dec 2014 10:33:01 +0100 (CET)
Received: from [10.88.41.1] (10.88.41.1) by xmail2.se.axis.com (10.0.5.74)
 with Microsoft SMTP Server (TLS) id 8.3.342.0; Fri, 5 Dec 2014 10:33:01 +0100
Message-ID: <1417771976.8400.8.camel@lnxlarper.se.axis.com>
Subject: Re: [PATCH] Revert "MIPS: Remove race window in page fault handling"
From:   Lars Persson <lars.persson@axis.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
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
Date:   Fri, 5 Dec 2014 10:32:56 +0100
In-Reply-To: <5481158D.1000409@imgtec.com>
References: <20141203032542.15388.17340.stgit@linux-yegoshin>
         <1417599104.10996.16.camel@lnxlarper.se.axis.com>
         <20141203134226.GC16063@linux-mips.org>
         <1417615394.10198.3.camel@lnxlarper.se.axis.com>
         <5481158D.1000409@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4-3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44580
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

Hi

Our setup includes both a non-DMA block device and a compressing
file-system (UBIFS). A flush_dcache_page() is issued by UBIFS so your
patch fixes another problem that we do not hit.

The stack trace is not available now. Do we need it for any further
analysis ? I think the mechanism of the race window is understood and it
depends on the __flush_dcache_page() deciding that the flush should be
postponed.

- Lars

On Fri, 2014-12-05 at 03:16 +0100, Leonid Yegoshin wrote:
> (repeat mesg, first one went to wrong place)
> 
> Lars,
> 
> Do you have a stack trace or so then you found the second VPE between 
> set_pte_at and update_mmu_cache?
> It would be interesting how it happens - generally, to get a consistent 
> SIGILL in applications due to misbehaviour of memory subsystem, the bug 
> in FS is not enough.
> 
> Hold on - do you use non-DMA file system?
> If so, I advice you to try this simple patch:
> 
>      Author: Leonid Yegoshin <yegoshin@mips.com>
>      Date:   Tue Apr 2 14:20:37 2013 -0700
> 
>      MIPS: (opt) Fix of reading I-pages from non-DMA FS devices for ID 
> cache separation
> 
>      This optional fix provides a D-cache flush for instruction code 
> pages on
>      page faults. In case of non-DMA block device a driver doesn't know 
> that it
>      reads I-page and doesn't flush D-cache generally on systems without
>      cache aliasing. And that takes toll during page fault of 
> instruction pages.
> 
>      It is not a perfect fix, it should be considered as a temporary fix.
>      The permanent fix would track page origin in page cache and flushes 
> D-cache
>      during reception of page from driver only but not at each page fault.
>      It is not done yet.
> 
>      Change-Id: I43f5943d6ce0509729179615f6b81e77803a34ac
>      Author: Leonid Yegoshin <yegoshin@mips.com>
>      Signed-off-by: Leonid Yegoshin <yegoshin@mips.com>(imported from 
> commit 6ebd22eb7a3d9873582ebe990a77094f971652ee)(imported from commit 
> 0caf3b4a1eebb64572e81e4df6fdb3abf12c70
> 
> arch/mips/include/asm/cacheflush.h:
> 
>     @@ -61,6 +61,9 @@ static inline void flush_anon_page(struct 
> vm_area_struct *vma,
>      static inline void flush_icache_page(struct vm_area_struct *vma,
>             struct page *page)
>      {
>     +       if (cpu_has_dc_aliases ||
>     +           ((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc))
>     +               __flush_dcache_page(page);
>      }
> 
>      extern void (*flush_icache_range)(unsigned long start, unsigned 
> long end);
> 
> 
> It fixed crash problems with non-DMA FS in a couple of our customers. 
> Without it the non-DMA root FS crashes are catastrophic in aliasing 
> systems but it is still a problem for I-cache too but much rare.
> 
> Unfortunately, it is also a performance hit, however is less than run a 
> page cache flush at each PTE setup. On 12/03/2014 06:03 AM, Lars Persson 
> wrote:
> > It is the flush_dcache_page() that was called from the file-system
> > reading the page contents into memory.
> >
> > - Lars
> >
> >
> 
