Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jul 2015 20:43:52 +0200 (CEST)
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:60595 "EHLO
        prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011666AbbGVSnuX6Bzz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Jul 2015 20:43:50 +0200
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 554B529103;
        Wed, 22 Jul 2015 18:43:44 +0000 (GMT)
Received: from prod-mail-relay06.akamai.com (prod-mail-relay06.akamai.com [172.17.120.126])
        by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id 2C728290FC;
        Wed, 22 Jul 2015 18:43:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1437590624; bh=RWwBvnK4smTrl0iM8EZdYXZdIKcF4Cpucjzvo92LYIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjBHu2f8iETUj8yx3pV/jM6pvddE71BfzzypVlVOEU+pnvcqdlruDlf81KMYQDe3m
         4xkUwdBwVIyBnKdghlK7IK4wUyV01xaG/rk8ItX3zXgTtAtjqkkPBwu6b9V4IURU/I
         n5WSv3KAxw+hl4mSK3JSAMe/7CS12owhn9eK919Q=
Received: from akamai.com (lappy-486.kendall.corp.akamai.com [172.28.12.253])
        by prod-mail-relay06.akamai.com (Postfix) with ESMTP id 7ACA12027;
        Wed, 22 Jul 2015 18:43:43 +0000 (GMT)
Date:   Wed, 22 Jul 2015 14:43:43 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH V4 4/6] mm: mlock: Introduce VM_LOCKONFAULT and add mlock
 flags to enable it
Message-ID: <20150722184343.GA2351@akamai.com>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-5-git-send-email-emunson@akamai.com>
 <55AF6A73.1080500@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <55AF6A73.1080500@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48387
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


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jul 2015, Vlastimil Babka wrote:

> On 07/21/2015 09:59 PM, Eric B Munson wrote:
> >The cost of faulting in all memory to be locked can be very high when
> >working with large mappings.  If only portions of the mapping will be
> >used this can incur a high penalty for locking.
> >
> >For the example of a large file, this is the usage pattern for a large
> >statical language model (probably applies to other statical or graphical
> >models as well).  For the security example, any application transacting
> >in data that cannot be swapped out (credit card data, medical records,
> >etc).
> >
> >This patch introduces the ability to request that pages are not
> >pre-faulted, but are placed on the unevictable LRU when they are finally
> >faulted in.  This can be done area at a time via the
> >mlock2(MLOCK_ONFAULT) or the mlockall(MCL_ONFAULT) system calls.  These
> >calls can be undone via munlock2(MLOCK_ONFAULT) or
> >munlockall2(MCL_ONFAULT).
> >
> >Applying the VM_LOCKONFAULT flag to a mapping with pages that are
> >already present required the addition of a function in gup.c to pin all
> >pages which are present in an address range.  It borrows heavily from
> >__mm_populate().
> >
> >To keep accounting checks out of the page fault path, users are billed
> >for the entire mapping lock as if MLOCK_LOCKED was used.
>=20
> Hi,
>=20
> I think you should include a complete description of which
> transitions for vma states and mlock2/munlock2 flags applied on them
> are valid and what they do. It will also help with the manpages.
> You explained some to Jon in the last thread, but I think there
> should be a canonical description in changelog (if not also
> Documentation, if mlock is covered there).
>=20
> For example the scenario Jon asked, what happens after a
> mlock2(MLOCK_ONFAULT) followed by mlock2(MLOCK_LOCKED), and that the
> answer is "nothing". Your promised code comment for
> apply_vma_flags() doesn't suffice IMHO (and I'm not sure it's there,
> anyway?).

I missed adding that comment to the code, will be there in V5 along with
the description in the changelog.

>=20
> But the more I think about the scenario and your new VM_LOCKONFAULT
> vma flag, it seems awkward to me. Why should munlocking at all care
> if the vma was mlocked with MLOCK_LOCKED or MLOCK_ONFAULT? In either
> case the result is that all pages currently populated are munlocked.
> So the flags for munlock2 should be unnecessary.

Say a user has a large area of interleaved MLOCK_LOCK and MLOCK_ONFAULT
mappings and they want to unlock only the ones with MLOCK_LOCK.  With
the current implementation, this is possible in a single system call
that spans the entire region.  With your suggestion, the user would have
to know what regions where locked with MLOCK_LOCK and call munlock() on
each of them.  IMO, the way munlock2() works better mirrors the way
munlock() currently works when called on a large area of interleaved
locked and unlocked areas.

>=20
> I also think VM_LOCKONFAULT is unnecessary. VM_LOCKED should be
> enough - see how you had to handle the new flag in all places that
> had to handle the old flag? I think the information whether mlock
> was supposed to fault the whole vma is obsolete at the moment mlock
> returns. VM_LOCKED should be enough for both modes, and the flag to
> mlock2 could just control whether the pre-faulting is done.
>=20
> So what should be IMHO enough:
> - munlock can stay without flags
> - mlock2 has only one new flag MLOCK_ONFAULT. If specified,
> pre-faulting is not done, just set VM_LOCKED and mlock pages already
> present.
> - same with mmap(MAP_LOCKONFAULT) (need to define what happens when
> both MAP_LOCKED and MAP_LOCKONFAULT are specified).
>=20
> Now mlockall(MCL_FUTURE) muddles the situation in that it stores the
> information for future VMA's in current->mm->def_flags, and this
> def_flags would need to distinguish VM_LOCKED with population and
> without. But that could be still solvable without introducing a new
> vma flag everywhere.

With you right up until that last paragraph.  I have been staring at
this a while and I cannot come up a way to handle the
mlockall(MCL_ONFAULT) without introducing a new vm flag.  It doesn't
have to be VM_LOCKONFAULT, we could use the model that Michal Hocko
suggested with something like VM_FAULTPOPULATE.  However, we can't
really use this flag anywhere except the mlock code becuase we have to
be able to distinguish a caller that wants to use MLOCK_LOCK with
whatever control VM_FAULTPOPULATE might grant outside of mlock and a
caller that wants MLOCK_ONFAULT.  That was a long way of saying we need
an extra vma flag regardless.  However, if that flag only controls if
mlock pre-populates it would work and it would do away with most of the
places I had to touch to handle VM_LOCKONFAULT properly.

I picked VM_LOCKONFAULT because it is explicit about what it is for and
there is little risk of someone coming along in 5 years and saying "why
not overload this flag to do this other thing completely unrelated to
mlock?".  A flag for controling speculative population is more likely to
be overloaded outside of mlock().

If you have a sane way of handling mlockall(MCL_ONFAULT) without a new
VMA flag, I am happy to give it a try, but I haven't been able to come
up with one that doesn't have its own gremlins.


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVr+RfAAoJELbVsDOpoOa9Lo8QAI2s/hDJgmFpuRrJX30jlPMm
6/tRD97fXS3oYC9RpBus/DHVlQm5yqaa+VJfiJeB8FIyL6PaX/xPgrJc8KzqUYwd
HFPS0U949Rts5j7mmWc72K9piv3aBoC1od4x1cQfAMAMSx9uvChchnA7oGHSmSd1
nyTuCloEBMlvPwKKgkd1nkoNhYWedi1k4/9GuhZkT/p/oKX/1bgMnffMWW+iIGzC
NpUSBxVGlJ6TXYEM2ztigXz1HvP1mk626E+fDSulOUSd/0fq6gBoZRIeuaxYfwKX
OIgDHsdLT0OiLqmZGB6djw1XVahKAl7DH4SIZjSaxk2Uvg8HdSjOKArF56p32jLH
R8hotTHYR2QmyDTw+4+gUYWznEteJ8RbO7QflMVxL9vcBU1EyxZ4U4QbhIbq3fUU
AKGQNJRuLz+jokXp3ONcmqDrUs1KzT2W4+EWV13mVY5Kvq6XQwPfqJGNUCEtM2xn
lWguCi65D1GR9pIc+5WH0OjUhwdkS8WIkjF3Qtc1RHJdAz1e5v7AP3YYq/0d47h8
jPNn0zR5SVGoMEG6qWXxHi+TxM77P3HyOMK0RP8ANGXsTZHSg9NMWGMxG4gsff4Y
TFVjhVV9cmbAIOLESkg38zr7moP7ICyn3iJZ++MMeet2h0OGAIEq9rJ/+YkDL4+o
zwuFDtZuRBDdOMyuJIzY
=z5oU
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
