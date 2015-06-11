Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2015 21:55:57 +0200 (CEST)
Received: from prod-mail-xrelay07.akamai.com ([72.246.2.115]:16764 "EHLO
        prod-mail-xrelay07.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008088AbbFKTzyCj5Gy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Jun 2015 21:55:54 +0200
Received: from prod-mail-xrelay07.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 14340487AF;
        Thu, 11 Jun 2015 19:55:48 +0000 (GMT)
Received: from prod-mail-relay06.akamai.com (prod-mail-relay06.akamai.com [172.17.120.126])
        by prod-mail-xrelay07.akamai.com (Postfix) with ESMTP id F261B4873B;
        Thu, 11 Jun 2015 19:55:47 +0000 (GMT)
Received: from [172.28.12.164] (bos-lp6ds.kendall.corp.akamai.com [172.28.12.164])
        by prod-mail-relay06.akamai.com (Postfix) with ESMTP id E6FA8203B;
        Thu, 11 Jun 2015 19:55:47 +0000 (GMT)
Message-ID: <5579E7C3.2020601@akamai.com>
Date:   Thu, 11 Jun 2015 15:55:47 -0400
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
References: <1433942810-7852-1-git-send-email-emunson@akamai.com>       <20150610145929.b22be8647887ea7091b09ae1@linux-foundation.org>  <5579DFBA.80809@akamai.com> <20150611123424.4bb07cffd0e5bb146cc92231@linux-foundation.org>
In-Reply-To: <20150611123424.4bb07cffd0e5bb146cc92231@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47932
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

On 06/11/2015 03:34 PM, Andrew Morton wrote:
> On Thu, 11 Jun 2015 15:21:30 -0400 Eric B Munson
> <emunson@akamai.com> wrote:
> 
>>> Ditto mlockall(MCL_ONFAULT) followed by munlock().  I'm not
>>> sure that even makes sense but the behaviour should be
>>> understood and tested.
>> 
>> I have extended the kselftest for lock-on-fault to try both of
>> these scenarios and they work as expected.  The VMA is split and
>> the VM flags are set appropriately for the resulting VMAs.
> 
> munlock() should do vma merging as well.  I *think* we implemented 
> that.  More tests for you to add ;)

I will add a test for this as well.  But the code is in place to merge
VMAs IIRC.

> 
> How are you testing the vma merging and splitting, btw?  Parsing 
> the profcs files?

To show the VMA split happened, I dropped a printk in mlock_fixup()
and the user space test simply checks that unlocked pages are not
marked as unevictable.  The test does not parse maps or smaps for
actual VMA layout.  Given that we want to check the merging of VMAs as
well I will add this.

> 
>>> What's missing here is a syscall to set VM_LOCKONFAULT on an 
>>> arbitrary range of memory - mlock() for lock-on-fault.  It's a 
>>> shame that mlock() didn't take a `mode' argument.  Perhaps we 
>>> should add such a syscall - that would make the mmap flag
>>> unneeded but I suppose it should be kept for symmetry.
>> 
>> Do you want such a system call as part of this set?  I would need
>> some time to make sure I had thought through all the possible
>> corners one could get into with such a call, so it would delay a
>> V3 quite a bit. Otherwise I can send a V3 out immediately.
> 
> I think the way to look at this is to pretend that mm/mlock.c
> doesn't exist and ask "how should we design these features".
> 
> And that would be:
> 
> - mmap() takes a `flags' argument: MAP_LOCKED|MAP_LOCKONFAULT.
> 
> - mlock() takes a `flags' argument.  Presently that's 
> MLOCK_LOCKED|MLOCK_LOCKONFAULT.
> 
> - munlock() takes a `flags' arument.
> MLOCK_LOCKED|MLOCK_LOCKONFAULT to specify which flags are being
> cleared.
> 
> - mlockall() and munlockall() ditto.
> 
> 
> IOW, LOCKED and LOCKEDONFAULT are treated identically and
> independently.
> 
> Now, that's how we would have designed all this on day one.  And I 
> think we can do this now, by adding new mlock2() and munlock2() 
> syscalls.  And we may as well deprecate the old mlock() and
> munlock(), not that this matters much.
> 
> *should* we do this?  I'm thinking "yes" - it's all pretty simple 
> boilerplate and wrappers and such, and it gets the interface
> correct, and extensible.
> 
> What do others think?
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVeefAAAoJELbVsDOpoOa9930P/j32OhsgPdxt8pmlYddpHBJg
PJ4EOYZLoNJ0bWAoePRAQvb9Rd0UumXukkQKVdFCFW72QfMPkjqyMWWOA5BZ6dYl
q3h3FTzcnAtVHG7bqFheV+Ie9ZX0dplTmuGlqTZzEIVePry9VXzqp9BADbWn3bVR
ucq1CFikyEB2yu8pMtykJmEaz4CO7fzCHz6oB7RNX5oHElWmi9AieuUr5eAw6enQ
6ofuNy/N3rTCwcjeRfdL7Xhs6vn62u4nw1Jey6l9hBQUx/ujMktKcn4VwkDXIYCi
+h7lfXWruqOuC+lspBRJO7OL2e6nRdedpDWJypeUGcKXokxB2FEB25Yu31K9sk/8
jDfaKNqmcfgOseLHb+DjJqG6nq9lsUhozg8C17SJpT8qFwQ8q7iJe+1GhUF1EBsL
+DpqLU56geBY6fyIfurOfp/4Hsx2u1KzezkEnMYT/8LkbGwqbq7Zj4rquLMSHCUt
uG5j0MuhmP8/Fuf8OMsIHHUMjBHRjH4rTyaCKxNj3T8uSuLfcnIqEZiJu2qaSA8l
PxpQ6yy2szw9lDxPvxLnh8Rkx+SGEc1ciamyppDTI4LQRiCjMQ7bHAKo0RwAaPJL
ZSHrdlDnUHrYTnd0EZwg0peh8AgkROgxna/pLpfQTeW1g3erqPfbI0Ab8N0cu5j0
8+qA5C+DeSjaMAoMskTG
=82B8
-----END PGP SIGNATURE-----
