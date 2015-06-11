Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2015 21:34:34 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37023 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008088AbbFKTecgPY0y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Jun 2015 21:34:32 +0200
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 45974ABF;
        Thu, 11 Jun 2015 19:34:25 +0000 (UTC)
Date:   Thu, 11 Jun 2015 12:34:24 -0700
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
Message-Id: <20150611123424.4bb07cffd0e5bb146cc92231@linux-foundation.org>
In-Reply-To: <5579DFBA.80809@akamai.com>
References: <1433942810-7852-1-git-send-email-emunson@akamai.com>
        <20150610145929.b22be8647887ea7091b09ae1@linux-foundation.org>
        <5579DFBA.80809@akamai.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47931
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

On Thu, 11 Jun 2015 15:21:30 -0400 Eric B Munson <emunson@akamai.com> wrote:

> > Ditto mlockall(MCL_ONFAULT) followed by munlock().  I'm not sure
> > that even makes sense but the behaviour should be understood and
> > tested.
>
> I have extended the kselftest for lock-on-fault to try both of these
> scenarios and they work as expected.  The VMA is split and the VM
> flags are set appropriately for the resulting VMAs.

munlock() should do vma merging as well.  I *think* we implemented
that.  More tests for you to add ;)

How are you testing the vma merging and splitting, btw?  Parsing
the profcs files?

> > What's missing here is a syscall to set VM_LOCKONFAULT on an
> > arbitrary range of memory - mlock() for lock-on-fault.  It's a
> > shame that mlock() didn't take a `mode' argument.  Perhaps we
> > should add such a syscall - that would make the mmap flag unneeded
> > but I suppose it should be kept for symmetry.
> 
> Do you want such a system call as part of this set?  I would need some
> time to make sure I had thought through all the possible corners one
> could get into with such a call, so it would delay a V3 quite a bit.
> Otherwise I can send a V3 out immediately.

I think the way to look at this is to pretend that mm/mlock.c doesn't
exist and ask "how should we design these features".

And that would be:

- mmap() takes a `flags' argument: MAP_LOCKED|MAP_LOCKONFAULT.

- mlock() takes a `flags' argument.  Presently that's
  MLOCK_LOCKED|MLOCK_LOCKONFAULT.

- munlock() takes a `flags' arument.  MLOCK_LOCKED|MLOCK_LOCKONFAULT
  to specify which flags are being cleared.

- mlockall() and munlockall() ditto.


IOW, LOCKED and LOCKEDONFAULT are treated identically and independently.

Now, that's how we would have designed all this on day one.  And I
think we can do this now, by adding new mlock2() and munlock2()
syscalls.  And we may as well deprecate the old mlock() and munlock(),
not that this matters much.

*should* we do this?  I'm thinking "yes" - it's all pretty simple
boilerplate and wrappers and such, and it gets the interface correct,
and extensible.

What do others think?
