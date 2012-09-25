Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2012 21:34:30 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:47595 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903818Ab2IYTeZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Sep 2012 21:34:25 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q8PJXxq9000578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 25 Sep 2012 15:33:59 -0400
Received: from random.random (ovpn-116-77.ams2.redhat.com [10.36.116.77])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q8PJXvb1011874;
        Tue, 25 Sep 2012 15:33:57 -0400
Date:   Tue, 25 Sep 2012 21:33:57 +0200
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Alex Shi <alex.shu@intel.com>,
        Jan Beulich <jbeulich@novell.com>,
        Robert Richter <robert.richter@amd.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v4 0/8] Avoid cache trashing on clearing huge/gigantic
 page
Message-ID: <20120925193356.GX7620@redhat.com>
References: <1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com>
 <20120913160506.d394392a.akpm@linux-foundation.org>
 <20120914055210.GC9043@gmail.com>
 <20120925142703.GA1598@otc-wbsnb-06>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120925142703.GA1598@otc-wbsnb-06>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-archive-position: 34550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aarcange@redhat.com
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

Hi Kirill,

On Tue, Sep 25, 2012 at 05:27:03PM +0300, Kirill A. Shutemov wrote:
> On Fri, Sep 14, 2012 at 07:52:10AM +0200, Ingo Molnar wrote:
> > Without repeatable hard numbers such code just gets into the 
> > kernel and bitrots there as new CPU generations come in - a few 
> > years down the line the original decisions often degrade to pure 
> > noise. We've been there, we've done that, we don't want to 
> > repeat it.
> 
> <sorry, for late answer..>
> 
> Hard numbers are hard.
> I've checked some workloads: Mosbench, NPB, specjvm2008. Most of time the
> patchset doesn't show any difference (within run-to-run deviation).
> On NPB it recovers THP regression, but it's probably not enough to make
> decision.
> 
> It would be nice if somebody test the patchset on other system or
> workload. Especially, if the configuration shows regression with
> THP enabled.

If the only workload that gets a benefit is NPB then we've the proof
this is too hardware dependend to be a conclusive result.

It may have been slower by an accident, things like cache
associativity off by one bit, combined with the implicit coloring
provided to the lowest 512 colors could hurts more if the cache
associativity is low.

I'm saying this because NPB on a thinkpad (Intel CPU I assume) is the
benchmark that shows the most benefit among all benchmarks run on that
hardware.

http://www.phoronix.com/scan.php?page=article&item=linux_transparent_hugepages&num=2

I've once seen certain computations that run much slower with perfect
cache coloring but most others runs much faster with the page
coloring. Doesn't mean page coloring is bad per se. So the NPB on that
specific hardware may have been the exception and not the interesting
case. Especially considering the effect of cache-copying is opposite
on slightly different hw.

I think the the static_key should be off by default whenever the CPU
L2 cache size is >= the size of the copy (2*HPAGE_PMD_SIZE). Now the
cache does random replacement so maybe we could also allow cache
copies for twice the size of the copy (L2size >=
4*HPAGE_PMD_SIZE). Current CPUs have caches much larger than 2*2MB...

It would make a whole lot more sense for hugetlbfs giga pages than for
THP (unlike for THP, cache trashing with giga pages is guaranteed),
but even with giga pages, it's not like they're allocated frequently
(maybe once per OS reboot) so that's also sure totally lost in the
noise as it only saves a few accesses after the cache copy is
finished.

It's good to have tested it though.

Thanks,
Andrea
