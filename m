Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jul 2015 15:49:50 +0200 (CEST)
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:33957 "EHLO
        prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011453AbbG1NtswXUoX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Jul 2015 15:49:48 +0200
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id E13ED290C8;
        Tue, 28 Jul 2015 13:49:42 +0000 (GMT)
Received: from prod-mail-relay06.akamai.com (prod-mail-relay06.akamai.com [172.17.120.126])
        by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id B6792290C4;
        Tue, 28 Jul 2015 13:49:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1438091382; bh=mUw44tXHXXEKV3H7onqe74qU+yrX73SUZR0iMh+j2Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKsuTosQaTbzMQJukfYec4KPUVt39HxU56gOsB6enixYC5/vEUJBg/ykULXGYVCWp
         w/BV8kGaU6cFpQl/31H+C+VIquRDghCRsmrSRy2wMuPQUdPcnwMPNQ8FpF7kZ7dj30
         j5+lrZYPD3KeR0/KZR+14MXkAdf/L5eBb6cZY/zE=
Received: from akamai.com (lappy-486.kendall.corp.akamai.com [172.28.12.253])
        by prod-mail-relay06.akamai.com (Postfix) with ESMTP id AE1FB202C;
        Tue, 28 Jul 2015 13:49:42 +0000 (GMT)
Date:   Tue, 28 Jul 2015 09:49:42 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH V5 0/7] Allow user to request memory to be locked on page
 fault
Message-ID: <20150728134942.GB2407@akamai.com>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <55B5F4FF.9070604@suse.cz>
 <20150727133555.GA17133@akamai.com>
 <55B63D37.20303@suse.cz>
 <20150727145409.GB21664@akamai.com>
 <20150728111725.GG24972@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <20150728111725.GG24972@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48488
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


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jul 2015, Michal Hocko wrote:

> [I am sorry but I didn't get to this sooner.]
>=20
> On Mon 27-07-15 10:54:09, Eric B Munson wrote:
> > Now that VM_LOCKONFAULT is a modifier to VM_LOCKED and
> > cannot be specified independentally, it might make more sense to mirror
> > that relationship to userspace.  Which would lead to soemthing like the
> > following:
>=20
> A modifier makes more sense.
> =20
> > To lock and populate a region:
> > mlock2(start, len, 0);
> >=20
> > To lock on fault a region:
> > mlock2(start, len, MLOCK_ONFAULT);
> >=20
> > If LOCKONFAULT is seen as a modifier to mlock, then having the flags
> > argument as 0 mean do mlock classic makes more sense to me.
> >=20
> > To mlock current on fault only:
> > mlockall(MCL_CURRENT | MCL_ONFAULT);
> >=20
> > To mlock future on fault only:
> > mlockall(MCL_FUTURE | MCL_ONFAULT);
> >=20
> > To lock everything on fault:
> > mlockall(MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT);
>=20
> Makes sense to me. The only remaining and still tricky part would be
> the munlock{all}(flags) behavior. What should munlock(MLOCK_ONFAULT)
> do? Keep locked and poppulate the range or simply ignore the flag an
> just unlock?
>=20
> I can see some sense to allow munlockall(MCL_FUTURE[|MLOCK_ONFAULT]),
> munlockall(MCL_CURRENT) resp. munlockall(MCL_CURRENT|MCL_FUTURE) but
> other combinations sound weird to me.
>=20
> Anyway munlock with flags opens new doors of trickiness.

In the current revision there are no new munlock[all] system calls
introduced.  munlockall() unconditionally cleared both MCL_CURRENT and
MCL_FUTURE before the set and now unconditionally clears all three.
munlock() does the same for VM_LOCK and VM_LOCKONFAULT.  If the user
wants to adjust mlockall flags today, they need to call mlockall a
second time with the new flags, this remains true for mlockall after
this set and the same behavior is mirrored in mlock2.  The only
remaining question I have is should we have 2 new mlockall flags so that
the caller can explicitly set VM_LOCKONFAULT in the mm->def_flags vs
locking all current VMAs on fault.  I ask because if the user wants to
lock all current VMAs the old way, but all future VMAs on fault they
have to call mlockall() twice:

	mlockall(MCL_CURRENT);
	mlockall(MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT);

This has the side effect of converting all the current VMAs to
VM_LOCKONFAULT, but because they were all made present and locked in the
first call, this should not matter in most cases.  The catch is that,
like mmap(MAP_LOCKED), mlockall() does not communicate if mm_populate()
fails.  This has been true of mlockall() from the beginning so I don't
know if it needs more than an entry in the man page to clarify (which I
will add when I add documentation for MCL_ONFAULT).  In a much less
likely corner case, it is not possible in the current setup to request
all current VMAs be VM_LOCKONFAULT and all future be VM_LOCKED.


--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVt4h2AAoJELbVsDOpoOa9oHIQAIcQd4UyZvk7S3Gk5qbrOB18
DBwAWsh9b5MmgjqQJ6VY9tveNG54UTtmGIt5ToxjkoJdN+y7i0Bcen7t5sh0ZJpY
cm7qGFkP9Mz+zp0cnwNi6SxjhmNdPZbFgcq7JPD4eXG73Guha/ov1yKGUCaE9I8z
NhWJEDf2QaXAeTYZMAp3QsZUE2A2vGtpVvgqXfVsoFiTXdO59wFfj7ZWs7Tvd8tA
7gFjWP2gUd3F5CxKVx7W7CujDyjqPYqjGe6GRq4RXvjgKlnzn19Dz71XM40WlQfy
mK1jm7TyXcFLT7oxcCJfzdiy72ViZ3n+lv6QbshOBkrmbTKk+WkPcmoY84Gg05mz
GyR0BeJ02Q/QWMPlCHTq8E+iBgRYrGXQxC7/0zjXizRCUxMoNtMbzYmEo63jHIUS
BpiaDFIS4b48qznxLcKn1zeG6I1tiRgVcYVLWOieVBFgKG5g0ae7Gsy5FhTHwohn
TFbs8PMRs+bZcLrY8dFFsS7/l7EBx/KZmA2Zcpj+Lcdr/LdwokV8rDN/R23spu1a
NVMoBoBXxXuDqA1pUTVCoBimDF2U5GArsy0yjHnVWzjZNqQSh1+eTEEZp+lu6eeC
briVmyabn8fCItemDJrAK/6RdvzbqHHri7Ny2d3GSyMPO36aM/lVN1wlF1qMZ3GA
9sHKsbhENoi90n42sc8Q
=YK5t
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
