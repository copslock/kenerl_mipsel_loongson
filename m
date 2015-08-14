Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 06:12:03 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:35945 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006209AbbHNEMBak0Ni (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 06:12:01 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A1B1558C211;
        Thu, 13 Aug 2015 21:11:57 -0700 (PDT)
Date:   Thu, 13 Aug 2015 21:11:55 -0700 (PDT)
Message-Id: <20150813.211155.1774898831276303437.davem@davemloft.net>
To:     James.Bottomley@HansenPartnership.com
Cc:     dan.j.williams@intel.com, hch@lst.de,
        torvalds@linux-foundation.org, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-nvdimm@ml01.01.org,
        dhowells@redhat.com, sparclinux@vger.kernel.org,
        egtvedt@samfundet.no, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org, dwmw2@infradead.org,
        hskinnemoen@gmail.com, linux-xtensa@linux-xtensa.org,
        grundler@parisc-linux.org, realmz6@gmail.com,
        alex.williamson@redhat.com, linux-metag@vger.kernel.org,
        axboe@kernel.dk, monstr@monstr.eu, linux-parisc@vger.kernel.org,
        vgupta@synopsys.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-media@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 29/31] parisc: handle page-less SG entries
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1439524760.8421.23.camel@HansenPartnership.com>
References: <20150813143150.GA17183@lst.de>
        <CAA9_cmcNA__N_yVTKsEqLAKBuoL-hx73t6opdsmb7w-0qKXaWg@mail.gmail.com>
        <1439524760.8421.23.camel@HansenPartnership.com>
X-Mailer: Mew version 6.6 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Aug 2015 21:11:58 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 13 Aug 2015 20:59:20 -0700

> On Thu, 2015-08-13 at 20:30 -0700, Dan Williams wrote:
>> On Thu, Aug 13, 2015 at 7:31 AM, Christoph Hellwig <hch@lst.de> wrote:
>> > On Wed, Aug 12, 2015 at 09:01:02AM -0700, Linus Torvalds wrote:
>> >> I'm assuming that anybody who wants to use the page-less
>> >> scatter-gather lists always does so on memory that isn't actually
>> >> virtually mapped at all, or only does so on sane architectures that
>> >> are cache coherent at a physical level, but I'd like that assumption
>> >> *documented* somewhere.
>> >
>> > It's temporarily mapped by kmap-like helpers.  That code isn't in
>> > this series. The most recent version of it is here:
>> >
>> > https://git.kernel.org/cgit/linux/kernel/git/djbw/nvdimm.git/commit/?h=pfn&id=de8237c99fdb4352be2193f3a7610e902b9bb2f0
>> >
>> > note that it's not doing the cache flushing it would have to do yet, but
>> > it's also only enabled for x86 at the moment.
>> 
>> For virtually tagged caches I assume we would temporarily map with
>> kmap_atomic_pfn_t(), similar to how drm_clflush_pages() implements
>> powerpc support.  However with DAX we could end up with multiple
>> virtual aliases for a page-less pfn.
> 
> At least on some PA architectures, you have to be very careful.
> Improperly managed, multiple aliases will cause the system to crash
> (actually a machine check in the cache chequerboard). For the most
> temperamental systems, we need the cache line flushed and the alias
> mapping ejected from the TLB cache before we access the same page at an
> inequivalent alias.

Also, I want to mention that on sparc64 we manage the cache aliasing
state in the page struct.

Until a page is mapped into userspace, we just record the most recent
cpu to store into that page with kernel side mappings.  Once the page
ends up being mapped or the cpu doing kernel side stores changes, we
actually perform the cache flush.

Generally speaking, I think that all actual physical memory the kernel
operates on should have a struct page backing it.  So this whole
discussion of operating on physical memory in scatter lists without
backing page structs feels really foreign to me.
