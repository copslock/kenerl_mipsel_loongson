Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2015 21:21:38 +0200 (CEST)
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:52411 "EHLO
        prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008051AbbFKTVhL0ylx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Jun 2015 21:21:37 +0200
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 0E1522879E;
        Thu, 11 Jun 2015 19:21:31 +0000 (GMT)
Received: from prod-mail-relay07.akamai.com (prod-mail-relay07.akamai.com [172.17.121.112])
        by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id E065A28616;
        Thu, 11 Jun 2015 19:21:30 +0000 (GMT)
Received: from [172.28.12.164] (bos-lp6ds.kendall.corp.akamai.com [172.28.12.164])
        by prod-mail-relay07.akamai.com (Postfix) with ESMTP id DA08B8008D;
        Thu, 11 Jun 2015 19:21:30 +0000 (GMT)
Message-ID: <5579DFBA.80809@akamai.com>
Date:   Thu, 11 Jun 2015 15:21:30 -0400
From:   Eric B Munson <emunson@akamai.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shuah Khan <shuahkh@osg.samsung.com>,
        Michal Hocko <mhocko@suse.cz>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RESEND PATCH V2 0/3] Allow user to request memory to be locked
 on page fault
References: <1433942810-7852-1-git-send-email-emunson@akamai.com> <20150610145929.b22be8647887ea7091b09ae1@linux-foundation.org>
In-Reply-To: <20150610145929.b22be8647887ea7091b09ae1@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: emunson@akamai.com
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/10/2015 05:59 PM, Andrew Morton wrote:
> On Wed, 10 Jun 2015 09:26:47 -0400 Eric B Munson
> <emunson@akamai.com> wrote:
> 
>> mlock() allows a user to control page out of program memory, but
>> this comes at the cost of faulting in the entire mapping when it
>> is
> 
> s/mapping/locked area/

Done.

> 
>> allocated.  For large mappings where the entire area is not
>> necessary this is not ideal.
>> 
>> This series introduces new flags for mmap() and mlockall() that
>> allow a user to specify that the covered are should not be paged
>> out, but only after the memory has been used the first time.
> 
> The comparison with MCL_FUTURE is hiding over in the 2/3 changelog.
>  It's important so let's copy it here.
> 
> : MCL_ONFAULT is preferrable to MCL_FUTURE for the use cases
> enumerated : in the previous patch becuase MCL_FUTURE will behave
> as if each mapping : was made with MAP_LOCKED, causing the entire
> mapping to be faulted in : when new space is allocated or mapped.
> MCL_ONFAULT allows the user to : delay the fault in cost of any
> given page until it is actually needed, : but then guarantees that
> that page will always be resident.

Done

> 
> I *think* it all looks OK.  I'd like someone else to go over it
> also if poss.
> 
> 
> I guess the 2/3 changelog should have something like
> 
> : munlockall() will clear MCL_ONFAULT on all vma's in the process's
> VM.

Done

> 
> It's pretty obvious, but the manpage delta should make this clear
> also.

Done

> 
> 
> Also the changelog(s) and manpage delta should explain that
> munlock() clears MCL_ONFAULT.

Done

> 
> And now I'm wondering what happens if userspace does 
> mmap(MAP_LOCKONFAULT) and later does munlock() on just part of
> that region.  Does the vma get split?  Is this tested?  Should also
> be in the changelogs and manpage.
> 
> Ditto mlockall(MCL_ONFAULT) followed by munlock().  I'm not sure
> that even makes sense but the behaviour should be understood and
> tested.

I have extended the kselftest for lock-on-fault to try both of these
scenarios and they work as expected.  The VMA is split and the VM
flags are set appropriately for the resulting VMAs.

> 
> 
> What's missing here is a syscall to set VM_LOCKONFAULT on an
> arbitrary range of memory - mlock() for lock-on-fault.  It's a
> shame that mlock() didn't take a `mode' argument.  Perhaps we
> should add such a syscall - that would make the mmap flag unneeded
> but I suppose it should be kept for symmetry.

Do you want such a system call as part of this set?  I would need some
time to make sure I had thought through all the possible corners one
could get into with such a call, so it would delay a V3 quite a bit.
Otherwise I can send a V3 out immediately.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVed+3AAoJELbVsDOpoOa9eHwP+gO8QmNdUKN55wiTLxXdFTRo
TTm62MJ3Yk45+JJ+8xI1POMSUVEBAX7pxnL8TpNPmwp+UF6IQT/hAnnEFNud8/aQ
5bAxU9a5fRO6Q5533woaVpYfXZXwXAla+37MGQziL7O0VEi2aQ9abX7AKnkjmXwq
e1Fc3vutAycNCzSxg42GwZxqHw83TYztyv3C4Cc7lShbCezABYvaDvXcUZkGwhjG
KJxSPYS2E0nv0MEy995P0L0H1A/KHq6mCOFFKQw6aVbPDs8J/0RhvQIlp/BBCPMV
TqDVxMBpTpdWs6reJnUZpouKBTA11KTvUA2HBVn5B14u2V7Np+NBpLKH2DUqAP2v
Gyg4Nj0MknqB1rutaBjHjI0ZefrWK5o+zWAVKZs+wtq9WkmCvTYWp505XnlJO+qo
1CEnab2kX8P74UYcsJUrJxAtxc94t6oLh305KnJheQUdcx/ZNKboB2vl1+np10jj
oZLmP2RfajZoPojPZ/bI6mj9Ffqf/Ptau+kLQ56G1IuVmQRi4ZgQ9D1+BILXyKHi
uycKovcHVffiQ+z1Ama2b4wP1t5yjNdxBH0oV1KMeScCxfyYHPFuDBe36Krjo8FO
dDMyibNIRJMX6SeYNIRni40Eafon5h21I95/yWxUaq0FGBZ1NuuSTofxAA53wJJz
f0FUI7f53Oxk9EKk8nfg
=gfVJ
-----END PGP SIGNATURE-----
