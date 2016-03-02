Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 15:24:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23676 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010043AbcCBOYKhDkYC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 15:24:10 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id A86D52101E0BE;
        Wed,  2 Mar 2016 14:23:59 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 2 Mar 2016 14:24:02 +0000
Received: from localhost (10.100.200.136) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Wed, 2 Mar
 2016 14:24:01 +0000
Date:   Wed, 2 Mar 2016 14:24:01 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <ddaney@caviumnetworks.com>, <linux-mips@linux-mips.org>,
        "Lars Persson" <lars.persson@axis.com>, "stable # v4 . 1+"
        <stable@vger.kernel.org>, "Steven J. Hill" <Steven.Hill@imgtec.com>, David
 Daney <david.daney@cavium.com>, Huacai Chen <chenhc@lemote.com>, Aneesh Kumar
 K.V <aneesh.kumar@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>, Jerome Marchand
        <jmarchan@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 4/4] MIPS: Sync icache & dcache in set_pte_at
Message-ID: <20160302142401.GA10198@NP-P-BURTON>
References: <1456799879-14711-1-git-send-email-paul.burton@imgtec.com>
 <1456799879-14711-5-git-send-email-paul.burton@imgtec.com>
 <56D5CDB3.80407@caviumnetworks.com>
 <20160301171940.GA26791@NP-P-BURTON>
 <20160302141203.GB18341@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20160302141203.GB18341@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.136]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Wed, Mar 02, 2016 at 03:12:03PM +0100, Ralf Baechle wrote:
> On Tue, Mar 01, 2016 at 05:19:40PM +0000, Paul Burton wrote:
> 
> > > >+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> > > >+			      pte_t *ptep, pte_t pteval)
> > > >+{
> > > >+	extern void __update_cache(unsigned long address, pte_t pte);
> > > >+
> > > >+	if (!pte_present(pteval))
> > > >+		goto cache_sync_done;
> > > >+
> > > >+	if (pte_present(*ptep) && (pte_pfn(*ptep) == pte_pfn(pteval)))
> > > >+		goto cache_sync_done;
> > > >+
> > > >+	__update_cache(addr, pteval);
> > > >+cache_sync_done:
> > > >+	set_pte(ptep, pteval);
> > > >+}
> > > >+
> > > 
> > > This seems crazy.
> > 
> > Perhaps, but also correct...
> > 
> > > I don't think any other architecture does this type of work in set_pte_at().
> > 
> > Yes they do. As mentioned in the commit message see arm, ia64 or powerpc
> > for architectures that all do the same sort of thing in set_pte_at.
> > 
> > > Can you look into finding a better way?
> > 
> > Not that I can see.
> 
> FYI, this is the original commit message adding set_pte_at().  The commit
> predates Linus' git history but is in the various history trees, for example
> https://git.kernel.org/cgit/linux/kernel/git/tglx/history.git/commit/?id=ae3d0a847f4b38812241e4a5dc3371965c752a8c
> 
> Or for your convenience:
> 
> commit ae3d0a847f4b38812241e4a5dc3371965c752a8c
> Author: David S. Miller <davem@nuts.davemloft.net>
> Date:   Tue Feb 22 23:42:56 2005 -0800
> 
>     [MM]: Add set_pte_at() which takes 'mm' and 'addr' args.
>     
>     I'm taking a slightly different approach this time around so things
>     are easier to integrate.  Here is the first patch which builds the
>     infrastructure.  Basically:
>     
>     1) Add set_pte_at() which is set_pte() with 'mm' and 'addr' arguments
>        added.  All generic code uses set_pte_at().
>     
>        Most platforms simply get this define:
>         #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
>     
>        I chose this method over simply changing all set_pte() call sites
>        because many platforms implement this in assembler and it would
>        take forever to preserve the build and stabilize things if modifying
>        that was necessary.
>     
>        Soon, with platform maintainer's help, we can kill of set_pte() entirely.
>        To be honest, there are only a handful of set_pte() call sites in the
>        arch specific code.
>     
>        Actually, in this patch ppc64 is completely set_pte() free and does not
>        define it.
>     
>     2) pte_clear() gets 'mm' and 'addr' arguments now.
>        This had a cascading effect on many ptep_test_and_*() routines.  Specifically:
>        a) ptep_test_and_clear_{young,dirty}() now take 'vma' and 'address' args.
>        b) ptep_get_and_clear now take 'mm' and 'address' args.
>        c) ptep_mkdirty was deleted, unused by any code.
>        d) ptep_set_wrprotect now takes 'mm' and 'address' args.
>     
>     I've tested this patch as follows:
>     
>     1) compile and run tested on sparc64/SMP
>     2) compile tested on:
>        a) ppc64/SMP
>        b) i386 both with and without PAE enabled
>     
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> Which doesn't specify if the function is meant for cache management nor
> is it documented in Documentation/cachetlb.txt.
> 
>   Ralf

Hi Ralf,

It is, however, used in such a way by others & seems to me like the only
correct way to implement the lazy cache flushing. The alternative would
be to adjust all generic code to ensure flush_icache_page gets called
before set_pte_at, which is far more invasive.

Since you mention Documentation/cachetlb.txt that does indicate that
flush_icache_page should be removed some time & prior to this patch
we're making use of it, so I hardly think the content of that document
can be taken as defining what's acceptable.

Thanks,
    Paul
