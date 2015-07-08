Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 22:35:06 +0200 (CEST)
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:52393 "EHLO
        prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010882AbbGHUfEF2dYt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2015 22:35:04 +0200
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 2ED4628F87;
        Wed,  8 Jul 2015 20:34:57 +0000 (GMT)
Received: from prod-mail-relay06.akamai.com (prod-mail-relay06.akamai.com [172.17.120.126])
        by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id 0344428F7F;
        Wed,  8 Jul 2015 20:34:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1436387697; bh=emYz3NVAe+H1bFvfbzZa842185qLlqw3BIa1mTKfGlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TeAIiwLeI7/xkTTdggdSkzWi5mvh+jFkRp+M2PhZrg6F2+S136KLA7utceZpJzGvX
         Znfuissgm2qxLCIDo0GkfcIYjZN4rA7ZRQc8w+Z9OlP3ClxkZx0R9cRLAMhvFaq94s
         9IVUNc8tlX1b2aSeeMxvu8ewdp/uuJbe3lBdJ+DA=
Received: from akamai.com (lappy-486.kendall.corp.akamai.com [172.28.12.253])
        by prod-mail-relay06.akamai.com (Postfix) with ESMTP id F1C712027;
        Wed,  8 Jul 2015 20:34:56 +0000 (GMT)
Date:   Wed, 8 Jul 2015 16:34:56 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V3 3/5] mm: mlock: Introduce VM_LOCKONFAULT and add mlock
 flags to enable it
Message-ID: <20150708203456.GC4669@akamai.com>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
 <1436288623-13007-4-git-send-email-emunson@akamai.com>
 <20150708132351.61c13db6@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <20150708132351.61c13db6@lwn.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48130
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


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 08 Jul 2015, Jonathan Corbet wrote:

> On Tue,  7 Jul 2015 13:03:41 -0400
> Eric B Munson <emunson@akamai.com> wrote:
>=20
> > This patch introduces the ability to request that pages are not
> > pre-faulted, but are placed on the unevictable LRU when they are finally
> > faulted in.  This can be done area at a time via the
> > mlock2(MLOCK_ONFAULT) or the mlockall(MCL_ONFAULT) system calls.  These
> > calls can be undone via munlock2(MLOCK_ONFAULT) or
> > munlockall2(MCL_ONFAULT).
>=20
> Quick, possibly dumb question: I've been beating my head against these for
> a little bit, and I can't figure out what's supposed to happen in this
> case:
>=20
> 	mlock2(addr, len, MLOCK_ONFAULT);
> 	munlock2(addr, len, MLOCK_LOCKED);
>=20
> It looks to me like it will clear VM_LOCKED without actually unlocking any
> pages.  Is that the intended result?

This is not quite right, what happens when you call munlock2(addr, len,
MLOCK_LOCKED); is we call apply_vma_flags(addr, len, VM_LOCKED, false).
The false argument means that we intend to clear the specified flags.
Here is the relevant snippet:
=2E..
                newflags =3D vma->vm_flags;
                if (add_flags) {
                        newflags &=3D ~(VM_LOCKED | VM_LOCKONFAULT);
                        newflags |=3D flags;
                } else {
                        newflags &=3D ~flags;
                }
=2E..

Note that when we are adding flags, we first clear both VM_LOCKED and
VM_LOCKONFAULT.  This was done to match the behavior found in
mlockall().  When we are remove flags, we simply clear the specified
flag(s).

So in your example the state of the VMAs covered by addr and len would
remain unchanged.

It sounds like apply_vma_flags() needs a comment covering this topic, I
will include that in the set I am working on now.

Eric

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnYlwAAoJELbVsDOpoOa96jQQAMzj+srECYanjQL4rB5HSwhS
jfU2GPE5w8xLHqHEdoPmu/98FKAK7kNvhb4Ytdmssq+sHIS3sHbx2b4SFkMLDnM8
4hTQtkUaD9ti+HnmBvxbDYNfn2MGHlxtfhML88/tA3LPproe9aWWZGtn4xZ+TE96
Qbnb0X4WCKuT2blVmoQ2Uf1zT2eaGJmpWk+QEKrWqlLDtijNcHEXiNn+1odo8WJd
7rr/7tjO+4N6AhC+0NypU9JhFB0L5pxm1Au+U3L3N8Szq8palqGYZ76k7X2cdNrN
7bc3ghWSLnA6p6sw1T4PDcuLhDNnS4zdtodtBJK6aVVR6NmJSzB8xU//HqFb27RA
s+0Z/6U8Z1P58q/IvMay2hsqmNY2hobvpNlm59JJynX+ajMC0IrzYrB0CDAIoO5s
tx5O4LDrMMsU/av92mU0y8yqGZdiGBQsIWfKTklWvq9q6HbDGae/WoSsnV5zX/b8
zHpvJxCmRG92vEwb46mqSbnWbkzK10SVyZRohrTd35hmSkXHpEk2AWwLHriLMtD8
nF/mQYL88FSsXwDKoz2Iw3C6HPVR6lDS8kae5iY4C0umP8FFX7VuBYBXOn29E1U4
mKbYb/wKn9x4iI4IeyHLBN4m+4zY+pqhXNlNKQ3hOR3jgMXPQ2fx7mzoEiRwB40g
4dkKMXOml6uRVob09Ixx
=lbgU
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
