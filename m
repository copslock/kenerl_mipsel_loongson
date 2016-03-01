Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 03:23:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35107 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007810AbcCACXyJeqGz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 03:23:54 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 6F450288FE4BB;
        Tue,  1 Mar 2016 02:23:47 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 1 Mar 2016 02:23:47 +0000
Received: from localhost (10.100.200.88) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 1 Mar
 2016 02:23:46 +0000
Date:   Tue, 1 Mar 2016 02:23:46 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "James Hogan" <james.hogan@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 1/2] MIPS: Add barriers between dcache & icache flushes
Message-ID: <20160301022346.GA12741@NP-P-BURTON>
References: <1456164585-26910-1-git-send-email-paul.burton@imgtec.com>
 <56CB9C32.2010308@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <56CB9C32.2010308@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52374
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

On Mon, Feb 22, 2016 at 06:39:30PM -0500, Joshua Kinard wrote:
> On 02/22/2016 13:09, Paul Burton wrote:
> > Index-based cache operations may be arbitrarily reordered by out of
> > order CPUs. Thus code which writes back the dcache & then invalidates
> > the icache using indexed cache ops must include a barrier between
> > operating on the 2 caches in order to prevent the scenario in which:
> > 
> >   - icache invalidation occurs.
> > 
> >   - icache fetch occurs, due to speculation.
> > 
> >   - dcache writeback occurs.
> > 
> > If the above were allowed to happen then the icache would contain stale
> > data. Forcing the dcache writeback to complete before the icache
> > invalidation avoids this.
> 
> Is there a particular symptom one should look for to check for this issue
> occurring?  I haven't seen any odd effects on my SGI systems that appear to
> relate to this.  I believe the R1x000 family resolves all hazards in hardware,
> so maybe this issue doesn't affect that CPU family?
> 
> If not, let me know what to look or test for so I can check the patch out on my
> systems.
> 
> Thanks!
> 
> --J

Hi Joshua,

It depends upon the implementation of the CPU, but the arch spec (MIPS64
BIS, MD00087, revision 6.02) does say:

> When implementing multiple level of caches and where the hardware maintains
> the smaller cache as a proper subset of a larger cache (every address which is
> resident in the smaller cache is also resident in the larger cache; also known
> as the inclusion property). It is recommended that the CACHE instructions
> which operate on the larger, outer-level cache; must first operate on the
> smaller, inner-level cache. For example, a Hit_Writeback _Invalidate operation
> targeting the Secondary cache, must first operate on the primary data
> cache first. If the CACHE instruction implementation does not follow
> this policy then any software which flushes the caches must mimic this
> behavior. That is, the software sequences must first operate on the
> inner cache then operate on the outer cache. The software must place a
> SYNC instruction after the CACHE instruction whenever there are
> possible writebacks from the inner cache to ensure that the writeback
> data is resident in the outer cache before operating on the outer
> cache. If neither the CACHE instruction implementation nor the
> software cache flush sequence follow this policy, then the inclusion
> property of the caches can be broken, which might be a condition that
> the cache management hardware cannot properly deal with.
>
> When implementing multiple level of caches without the inclusion
> property, the use of a SYNC instruction after the CACHE instruction is
> still needed whenever writeback data has to be resident in the next
> level of memory hierarchy.

If data is to transfer from dcache -> L2 -> icache then it has to be
written back to the L2 which would hit that situation of the data
needing "to be resident in the next level of memory hierarchy" after the
dcache. That is guaranteed by the sync instruction:

> The CACHE instruction and the memory transactions which are sourced by
> the CACHE instruction, such as cache refill or cache writeback, obey
> the ordering and completion rules of the SYNC instruction.

This is more something newer cores that reorder more agressively would
be expected to hit, to the best of my knowledge.

Thanks,
    Paul
