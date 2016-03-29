Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2016 10:29:20 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43768 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025625AbcC2I3RyYpak (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Mar 2016 10:29:17 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u2T8TEYO012901;
        Tue, 29 Mar 2016 10:29:14 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u2T8TCmZ012900;
        Tue, 29 Mar 2016 10:29:12 +0200
Date:   Tue, 29 Mar 2016 10:29:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Lars Persson <lars.persson@axis.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J. Hill" <sjhill@realitydiluted.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] MIPS: Flush dcache for flush_kernel_dcache_page
Message-ID: <20160329082911.GC11282@linux-mips.org>
References: <1456799879-14711-1-git-send-email-paul.burton@imgtec.com>
 <1456799879-14711-2-git-send-email-paul.burton@imgtec.com>
 <B1BD883F-CC3D-4C02-9C5C-350DB487329B@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1BD883F-CC3D-4C02-9C5C-350DB487329B@axis.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52719
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

On Fri, Mar 04, 2016 at 03:09:00PM +0000, Lars Persson wrote:

> > 1 mars 2016 kl. 03:38 Paul Burton <paul.burton@imgtec.com>:
> > 
> > The flush_kernel_dcache_page function was previously essentially a nop.
> > This is incorrect for MIPS, where if a page has been modified & either
> > it aliases or it's executable & the icache doesn't fill from dcache then
> > the content needs to be written back from dcache to the next level of
> > the cache hierarchy (which is shared with the icache).
> > 
> > Implement this by simply calling flush_dcache_page, treating this
> > kmapped cache flush function (flush_kernel_dcache_page) exactly the same
> > as its non-kmapped counterpart (flush_dcache_page).
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > ---
> > 
> > arch/mips/include/asm/cacheflush.h | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
> > index 723229f..7e9f468 100644
> > --- a/arch/mips/include/asm/cacheflush.h
> > +++ b/arch/mips/include/asm/cacheflush.h
> > @@ -132,6 +132,7 @@ static inline void kunmap_noncoherent(void)
> > static inline void flush_kernel_dcache_page(struct page *page)
> > {
> >    BUG_ON(cpu_has_dc_aliases && PageHighMem(page));
> > +    flush_dcache_page(page);
> 
> Should we use instead __flush_dcache_page() that flushes immediately for mapped pages ? Steven J Hill's old patch set for highmem had done it like this.

Delayed flushing should be ok for lowmem where each page has a permanent
virtual address.  With highmem the temporary address assigned by the kmap_*
function may change so the flush needs to be performed immediately.
Special case highmem without cache aliases - the exact virtual address
doesn't matter, so this should be fine.

Cache flushes are expensive so delaying if possible is always a good thing.

Steven's patches afair were trying to tackle the highmem with aliases case
so an immediately flush was required.

  Ralf
