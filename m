Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 18:04:01 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51618 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013248AbaKJRD77dzQs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Nov 2014 18:03:59 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAAH3w3i011444;
        Mon, 10 Nov 2014 18:03:58 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAAH3wVn011443;
        Mon, 10 Nov 2014 18:03:58 +0100
Date:   Mon, 10 Nov 2014 18:03:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
Message-ID: <20141110170357.GB11091@linux-mips.org>
References: <54582A91.8040401@gmail.com>
 <20141105160945.GB13785@linux-mips.org>
 <545C9D4D.4090501@gentoo.org>
 <545D0FC4.7020205@gmail.com>
 <545EB09C.40006@gentoo.org>
 <5460636A.5090401@gentoo.org>
 <20141110105106.GA4302@linux-mips.org>
 <20141110112039.GA7294@alpha.franken.de>
 <5460CA1D.9060907@gentoo.org>
 <5460EDED.3030600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5460EDED.3030600@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43963
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

On Mon, Nov 10, 2014 at 08:55:09AM -0800, David Daney wrote:

> Yes, you may be on to something here.  Certianly basic huge TLB support must
> be in place for TRANSPARENT_HUGEPAGE to work.
> 
> It could be that the Kconfig symbols for the various portions of huge page
> support are missing the required dependencies.
> 
> FWIW, I always build with a huge page Kconfig options set.
> 
> I have:
> $ grep HUGE .config
> CONFIG_SYS_SUPPORTS_HUGETLBFS=y
> CONFIG_MIPS_HUGE_TLB_SUPPORT=y
> CONFIG_CPU_SUPPORTS_HUGEPAGES=y
> CONFIG_TRANSPARENT_HUGEPAGE=y
> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> 
> I suspect that you may not need CONFIG_HUGETLBFS, but CONFIG_HUGETLB_PAGE is
> probably essential.

IP27 also has NUMA as the only in-tree MIPS system - and it's NUMA support
is not in the best support state to say the least.  Just an observation -
at this point in time there is no obvious connection between either

  R10000 <-> transparent huge page

or

  NUMA <-> transparent huge page

  Ralf
