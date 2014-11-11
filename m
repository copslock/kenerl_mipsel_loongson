Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 12:11:53 +0100 (CET)
Received: from resqmta-ch2-04v.sys.comcast.net ([69.252.207.36]:46902 "EHLO
        resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013353AbaKKLLvoZ29S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 12:11:51 +0100
Received: from resomta-ch2-14v.sys.comcast.net ([69.252.207.110])
        by resqmta-ch2-04v.sys.comcast.net with comcast
        id EBBi1p0022PT3Qt01BBlPn; Tue, 11 Nov 2014 11:11:45 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-ch2-14v.sys.comcast.net with comcast
        id EBBk1p00C0gJalY01BBknG; Tue, 11 Nov 2014 11:11:45 +0000
Message-ID: <5461EEEC.2040303@gentoo.org>
Date:   Tue, 11 Nov 2014 06:11:40 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
CC:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
References: <54582A91.8040401@gmail.com> <20141105160945.GB13785@linux-mips.org> <545C9D4D.4090501@gentoo.org> <545D0FC4.7020205@gmail.com> <545EB09C.40006@gentoo.org> <5460636A.5090401@gentoo.org> <20141110105106.GA4302@linux-mips.org> <20141110112039.GA7294@alpha.franken.de> <5460CA1D.9060907@gentoo.org> <5460EDED.3030600@gmail.com> <20141110170357.GB11091@linux-mips.org>
In-Reply-To: <20141110170357.GB11091@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1415704305;
        bh=/eA5OQZiMZO73nMTlUycYO72PJNF4wqezie+OX/USRM=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=TIO7fLfkZTA7vJjixiqK1AZuSLAwBSyubSIqAZ2Z8o72QVMq7oYUeOA5ZpTCxkri1
         xDO32EKcA58Pol6g4m0CMtF6EpSU1bJoXCqjfeEcHBB4Fys5VVndq9RC9HQxOZXW+s
         ejIiW28YL8pq++JZKcPxsAI0tNSzXCfIyJ4MvEXIGSOAKmf6xwkmnGRvW7aArYCp+O
         QQCuT1bjdLziVj0qxcRcxJ8e2GOgP41JbUL5DI4nV9vjGtP6l+7rkE3p6MFNriO2kL
         E8UE99f566qig9Lw6xUxKMeziESJApBEx4HJyLCRV9enddkeobVjaHWSHzhhV+v4hz
         Q2qxZuOpABNqA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 11/10/2014 12:03, Ralf Baechle wrote:
> On Mon, Nov 10, 2014 at 08:55:09AM -0800, David Daney wrote:
> 
>> Yes, you may be on to something here.  Certianly basic huge TLB support must
>> be in place for TRANSPARENT_HUGEPAGE to work.
>>
>> It could be that the Kconfig symbols for the various portions of huge page
>> support are missing the required dependencies.
>>
>> FWIW, I always build with a huge page Kconfig options set.
>>
>> I have:
>> $ grep HUGE .config
>> CONFIG_SYS_SUPPORTS_HUGETLBFS=y
>> CONFIG_MIPS_HUGE_TLB_SUPPORT=y
>> CONFIG_CPU_SUPPORTS_HUGEPAGES=y
>> CONFIG_TRANSPARENT_HUGEPAGE=y
>> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
>> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
>> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
>> CONFIG_HUGETLBFS=y
>> CONFIG_HUGETLB_PAGE=y
>>
>> I suspect that you may not need CONFIG_HUGETLBFS, but CONFIG_HUGETLB_PAGE is
>> probably essential.
> 
> IP27 also has NUMA as the only in-tree MIPS system - and it's NUMA support
> is not in the best support state to say the least.  Just an observation -
> at this point in time there is no obvious connection between either
> 
>   R10000 <-> transparent huge page
> 
> or
> 
>   NUMA <-> transparent huge page
> 
>   Ralf

I briefly tried NUMA on the Onyx2, and it failed to load init.  init actually
spat out its --help info and quit, which panicked the kernel.  So I didn't test
that too much more.  I am also booting an 'M' kernel, not an 'N'.

That said, I went back to playing around with the Octane, which also seems to
have issues when CONFIG_TRANSPARENT_HUGEPAGE is present.  I now think that it's
not hugepages support at all, but something in the code covered by
CONFIG_MIGRATION.

Booting a 3.17.2 kernel on the Octane with CONFIG_TRANSPARENT_HUGEPAGES but
without CONFIG_HUGETLBFS (and, consequently, without CONFIG_HUGETLB_PAGE),
didn't immediately trigger my instruction bus errors upon loading init, despite
multiple cold reboots.  It took several tries before I could get 3.17.2 to
trigger it.

Backtracking to 3.16, I found out that I could trigger the problem virtually
every single cold boot on 3.16.4, but NOT 3.16.5.  Going through 3.16.5's
changelog, I tried backing out several commits that dealt with transparent
hugepages, jiffies calculation, and finally hit on this one:
http://git.linux-mips.org/?p=ralf/linux.git;a=commit;h=e9203e7b4019370e6d8f69cbf71c052aad22ced7

"""
commit d3cb8bf6081b8b7a2dabb1264fe968fd870fa595 upstream.

A migration entry is marked as write if pte_write was true at the time the
entry was created. The VMA protections are not double checked when migration
entries are being removed as mprotect marks write-migration-entries as
read. It means that potentially we take a spurious fault to mark PTEs write
again but it's straight-forward. However, there is a race between write
migrations being marked read and migrations finishing. This potentially
allows a PTE to be write that should have been read. Close this race by
double checking the VMA permissions using maybe_mkwrite when migration
completes.
"""

CONFIG_MIGRATION is enabled by default when you select
CONFIG_TRANSPARENT_HUGEPAGE, and when I backed that patch out of 3.16.5, the
frequency of a cold boot resulting in IBE's upon loading init increased -- 6
out of 7 reboots in one test run.

Leaving that patch backed out, I enabled CONFIG_HUGETLBFS and
CONFIG_HUGETLB_PAGE, and so far, out of five cold boots, all boot up fine.
This mirrors the behavior on the IP27 machine where CONFIG_HUGETLBFS seems to
fix problems.  I tried backing the migration patch out on the IP27 kernel and
it doesn't seem to have an effect there.

This seems to suggest that CONFIG_MIGRATION plays a part somehow, but only if
CONFIG_HUGETLB_PAGE is left out.  Doesn't look like CONFIG_HUGETLBFS matters,
as I haven't mounted that filesystem anywhere.

The symptoms on each systems are different -- I only get IBE's on Octane,
sometimes mixed with DBE's, and usually when init loads.  If by luck, init
loads, the IBE's are not likely to happen and the machine seems to run fine.  I
also confirmed that the R12K module on Octane suffers the same problem -- seems
to be a bit more resilient, though.

IP27 only ever gets DBE's, and not usually while loading init, but when
executing other userland programs, like Gentoo's emerge (written in Python).

It also looks like turning on CONFIG_HUGETLBFS and CONFIG_HUGETLB_PAGE fixed my
problems on Octane w/ PAGE_SIZE_16K/PAGE_SIZE_64K triggering random
sigbus/sigsegv signals, too (if anyone remembers that mail thread form a few
months ago).

So I'm curious why CONFIG_HUGETLB_PAGE is hidden and selected only with
CONFIG_HUGETLBFS?  It does cause arch/mips/mm/hugetlbpage.c to get built, so
maybe that's the critical part?  If so, it seems then for MIPS, that should be
in the the 'Kernel type' menu w/ CONFIG_TRANSPARENT_HUGEPAGE, and not invisibly
hidden away deep the 'File systems' submenu.

--J
