Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jun 2015 16:57:13 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:41684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007865AbbFSO5KfdLqv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Jun 2015 16:57:10 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7A17FAAB4;
        Fri, 19 Jun 2015 14:57:09 +0000 (UTC)
Date:   Fri, 19 Jun 2015 16:57:08 +0200
From:   Michal Hocko <mhocko@suse.cz>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RESEND PATCH V2 1/3] Add mmap flag to request pages are locked
 after page fault
Message-ID: <20150619145708.GG4913@dhcp22.suse.cz>
References: <1433942810-7852-1-git-send-email-emunson@akamai.com>
 <1433942810-7852-2-git-send-email-emunson@akamai.com>
 <20150618152907.GG5858@dhcp22.suse.cz>
 <20150618203048.GB2329@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150618203048.GB2329@akamai.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mhocko@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@suse.cz
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

On Thu 18-06-15 16:30:48, Eric B Munson wrote:
> On Thu, 18 Jun 2015, Michal Hocko wrote:
[...]
> > Wouldn't it be much more reasonable and straightforward to have
> > MAP_FAULTPOPULATE as a counterpart for MAP_POPULATE which would
> > explicitly disallow any form of pre-faulting? It would be usable for
> > other usecases than with MAP_LOCKED combination.
> 
> I don't see a clear case for it being more reasonable, it is one
> possible way to solve the problem.

MAP_FAULTPOPULATE would be usable for other cases as well. E.g. fault
around is all or nothing feature. Either all mappings (which support
this) fault around or none. There is no way to tell the kernel that
this particular mapping shouldn't fault around. I haven't seen such a
request yet but we have seen requests to have a way to opt out from
a global policy in the past (e.g. per-process opt out from THP). So
I can imagine somebody will come with a request to opt out from any
speculative operations on the mapped area in the future.

> But I think it leaves us in an even
> more akward state WRT VMA flags.  As you noted in your fix for the
> mmap() man page, one can get into a state where a VMA is VM_LOCKED, but
> not present.  Having VM_LOCKONFAULT states that this was intentional, if
> we go to using MAP_FAULTPOPULATE instead of MAP_LOCKONFAULT, we no
> longer set VM_LOCKONFAULT (unless we want to start mapping it to the
> presence of two MAP_ flags).  This can make detecting the MAP_LOCKED +
> populate failure state harder.

I am not sure I understand your point here. Could you be more specific
how would you check for that and what for?

From my understanding MAP_LOCKONFAULT is essentially
MAP_FAULTPOPULATE|MAP_LOCKED with a quite obvious semantic (unlike
single MAP_LOCKED unfortunately). I would love to also have
MAP_LOCKED|MAP_POPULATE (aka full mlock semantic) but I am really
skeptical considering how my previous attempt to make MAP_POPULATE
reasonable went.

> If this is the preferred path for mmap(), I am fine with that. 

> However,
> I would like to see the new system calls that Andrew mentioned (and that
> I am testing patches for) go in as well. 

mlock with flags sounds like a good step but I am not sure it will make
sense in the future. POSIX has screwed that and I am not sure how many
applications would use it. This ship has sailed long time ago.

> That way we give users the
> ability to request VM_LOCKONFAULT for memory allocated using something
> other than mmap.

mmap(MAP_FAULTPOPULATE); mlock() would have the same semantic even
without changing mlock syscall.
 
> > > This patch introduces the ability to request that pages are not
> > > pre-faulted, but are placed on the unevictable LRU when they are finally
> > > faulted in.
> > > 
> > > To keep accounting checks out of the page fault path, users are billed
> > > for the entire mapping lock as if MAP_LOCKED was used.
> > > 
> > > Signed-off-by: Eric B Munson <emunson@akamai.com>
> > > Cc: Michal Hocko <mhocko@suse.cz>
> > > Cc: linux-alpha@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-mips@linux-mips.org
> > > Cc: linux-parisc@vger.kernel.org
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > Cc: sparclinux@vger.kernel.org
> > > Cc: linux-xtensa@linux-xtensa.org
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-arch@vger.kernel.org
> > > Cc: linux-api@vger.kernel.org
> > > ---
[...]
-- 
Michal Hocko
SUSE Labs
