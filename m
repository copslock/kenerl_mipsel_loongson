Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2015 23:59:39 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:42621 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008102AbbFJV7hdqV0o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jun 2015 23:59:37 +0200
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 28CE4ACB;
        Wed, 10 Jun 2015 21:59:30 +0000 (UTC)
Date:   Wed, 10 Jun 2015 14:59:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Shuah Khan <shuahkh@osg.samsung.com>,
        Michal Hocko <mhocko@suse.cz>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RESEND PATCH V2 0/3] Allow user to request memory to be locked
 on page fault
Message-Id: <20150610145929.b22be8647887ea7091b09ae1@linux-foundation.org>
In-Reply-To: <1433942810-7852-1-git-send-email-emunson@akamai.com>
References: <1433942810-7852-1-git-send-email-emunson@akamai.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Wed, 10 Jun 2015 09:26:47 -0400 Eric B Munson <emunson@akamai.com> wrote:

> mlock() allows a user to control page out of program memory, but this
> comes at the cost of faulting in the entire mapping when it is

s/mapping/locked area/

> allocated.  For large mappings where the entire area is not necessary
> this is not ideal.
> 
> This series introduces new flags for mmap() and mlockall() that allow a
> user to specify that the covered are should not be paged out, but only
> after the memory has been used the first time.

The comparison with MCL_FUTURE is hiding over in the 2/3 changelog. 
It's important so let's copy it here.

: MCL_ONFAULT is preferrable to MCL_FUTURE for the use cases enumerated
: in the previous patch becuase MCL_FUTURE will behave as if each mapping
: was made with MAP_LOCKED, causing the entire mapping to be faulted in
: when new space is allocated or mapped.  MCL_ONFAULT allows the user to
: delay the fault in cost of any given page until it is actually needed,
: but then guarantees that that page will always be resident.

I *think* it all looks OK.  I'd like someone else to go over it also if
poss.


I guess the 2/3 changelog should have something like

: munlockall() will clear MCL_ONFAULT on all vma's in the process's VM.

It's pretty obvious, but the manpage delta should make this clear also.


Also the changelog(s) and manpage delta should explain that munlock()
clears MCL_ONFAULT.

And now I'm wondering what happens if userspace does
mmap(MAP_LOCKONFAULT) and later does munlock() on just part of that
region.  Does the vma get split?  Is this tested?  Should also be in
the changelogs and manpage.

Ditto mlockall(MCL_ONFAULT) followed by munlock().  I'm not sure that
even makes sense but the behaviour should be understood and tested.


What's missing here is a syscall to set VM_LOCKONFAULT on an arbitrary
range of memory - mlock() for lock-on-fault.  It's a shame that mlock()
didn't take a `mode' argument.  Perhaps we should add such a syscall -
that would make the mmap flag unneeded but I suppose it should be kept
for symmetry.
