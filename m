Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jul 2015 12:03:36 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:48061 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009642AbbGVKDeFhRrU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Jul 2015 12:03:34 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 58F34AAC1;
        Wed, 22 Jul 2015 10:03:33 +0000 (UTC)
Message-ID: <55AF6A73.1080500@suse.cz>
Date:   Wed, 22 Jul 2015 12:03:31 +0200
From:   Vlastimil Babka <vbabka@suse.cz>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Eric B Munson <emunson@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V4 4/6] mm: mlock: Introduce VM_LOCKONFAULT and add mlock
 flags to enable it
References: <1437508781-28655-1-git-send-email-emunson@akamai.com> <1437508781-28655-5-git-send-email-emunson@akamai.com>
In-Reply-To: <1437508781-28655-5-git-send-email-emunson@akamai.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vbabka@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbabka@suse.cz
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

On 07/21/2015 09:59 PM, Eric B Munson wrote:
> The cost of faulting in all memory to be locked can be very high when
> working with large mappings.  If only portions of the mapping will be
> used this can incur a high penalty for locking.
>
> For the example of a large file, this is the usage pattern for a large
> statical language model (probably applies to other statical or graphical
> models as well).  For the security example, any application transacting
> in data that cannot be swapped out (credit card data, medical records,
> etc).
>
> This patch introduces the ability to request that pages are not
> pre-faulted, but are placed on the unevictable LRU when they are finally
> faulted in.  This can be done area at a time via the
> mlock2(MLOCK_ONFAULT) or the mlockall(MCL_ONFAULT) system calls.  These
> calls can be undone via munlock2(MLOCK_ONFAULT) or
> munlockall2(MCL_ONFAULT).
>
> Applying the VM_LOCKONFAULT flag to a mapping with pages that are
> already present required the addition of a function in gup.c to pin all
> pages which are present in an address range.  It borrows heavily from
> __mm_populate().
>
> To keep accounting checks out of the page fault path, users are billed
> for the entire mapping lock as if MLOCK_LOCKED was used.

Hi,

I think you should include a complete description of which transitions 
for vma states and mlock2/munlock2 flags applied on them are valid and 
what they do. It will also help with the manpages.
You explained some to Jon in the last thread, but I think there should 
be a canonical description in changelog (if not also Documentation, if 
mlock is covered there).

For example the scenario Jon asked, what happens after a 
mlock2(MLOCK_ONFAULT) followed by mlock2(MLOCK_LOCKED), and that the 
answer is "nothing". Your promised code comment for apply_vma_flags() 
doesn't suffice IMHO (and I'm not sure it's there, anyway?).

But the more I think about the scenario and your new VM_LOCKONFAULT vma 
flag, it seems awkward to me. Why should munlocking at all care if the 
vma was mlocked with MLOCK_LOCKED or MLOCK_ONFAULT? In either case the 
result is that all pages currently populated are munlocked. So the flags 
for munlock2 should be unnecessary.

I also think VM_LOCKONFAULT is unnecessary. VM_LOCKED should be enough - 
see how you had to handle the new flag in all places that had to handle 
the old flag? I think the information whether mlock was supposed to 
fault the whole vma is obsolete at the moment mlock returns. VM_LOCKED 
should be enough for both modes, and the flag to mlock2 could just 
control whether the pre-faulting is done.

So what should be IMHO enough:
- munlock can stay without flags
- mlock2 has only one new flag MLOCK_ONFAULT. If specified, pre-faulting 
is not done, just set VM_LOCKED and mlock pages already present.
- same with mmap(MAP_LOCKONFAULT) (need to define what happens when both 
MAP_LOCKED and MAP_LOCKONFAULT are specified).

Now mlockall(MCL_FUTURE) muddles the situation in that it stores the 
information for future VMA's in current->mm->def_flags, and this 
def_flags would need to distinguish VM_LOCKED with population and 
without. But that could be still solvable without introducing a new vma 
flag everywhere.
