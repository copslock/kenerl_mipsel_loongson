Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 20:46:43 +0200 (CEST)
Received: from a23-79-238-175.deploy.static.akamaitechnologies.com ([23.79.238.175]:31710
        "EHLO prod-mail-xrelay07.akamai.com" rhost-flags-OK-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010241AbbGISqmBryKt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2015 20:46:42 +0200
Received: from prod-mail-xrelay07.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id BD7BB493D8;
        Thu,  9 Jul 2015 18:46:50 +0000 (GMT)
Received: from prod-mail-relay07.akamai.com (prod-mail-relay07.akamai.com [172.17.121.112])
        by prod-mail-xrelay07.akamai.com (Postfix) with ESMTP id A56AE493A7;
        Thu,  9 Jul 2015 18:46:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1436467610; bh=rdNa74iVcvQwSsaK1uoJoryahBfHe2fvC/SAwNXTciM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnbSHLQlFvJsYJrBvadDVPAkX1VM5WEeShgyo9vuOWSwTGeCAsBvziAXw4rJ5L2Nk
         YPi79kueLj/xvSpwkmN0gXXLhZiQooQU0j72mIhh1GTdU37Z6TBV1QX2hPnxo4axVU
         t08HuGmte7WMukl/Zu0TdJYHYJSMW+Ozo475zIHA=
Received: from akamai.com (unknown [172.28.12.253])
        by prod-mail-relay07.akamai.com (Postfix) with ESMTP id E167B80087;
        Thu,  9 Jul 2015 18:46:35 +0000 (GMT)
Date:   Thu, 9 Jul 2015 14:46:35 -0400
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
Message-ID: <20150709184635.GE4669@akamai.com>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
 <1436288623-13007-4-git-send-email-emunson@akamai.com>
 <20150708132351.61c13db6@lwn.net>
 <20150708203456.GC4669@akamai.com>
 <20150708151750.75e65859@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d8Lz2Tf5e5STOWUP"
Content-Disposition: inline
In-Reply-To: <20150708151750.75e65859@lwn.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48165
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


--d8Lz2Tf5e5STOWUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 08 Jul 2015, Jonathan Corbet wrote:

> On Wed, 8 Jul 2015 16:34:56 -0400
> Eric B Munson <emunson@akamai.com> wrote:
>=20
> > > Quick, possibly dumb question: I've been beating my head against thes=
e for
> > > a little bit, and I can't figure out what's supposed to happen in this
> > > case:
> > >=20
> > > 	mlock2(addr, len, MLOCK_ONFAULT);
> > > 	munlock2(addr, len, MLOCK_LOCKED);
> > >=20
> > > It looks to me like it will clear VM_LOCKED without actually unlockin=
g any
> > > pages.  Is that the intended result? =20
> >=20
> > This is not quite right, what happens when you call munlock2(addr, len,
> > MLOCK_LOCKED); is we call apply_vma_flags(addr, len, VM_LOCKED, false).
>=20
> From your explanation, it looks like what I said *was* right...what I was
> missing was the fact that VM_LOCKED isn't set in the first place.  So that
> call would be a no-op, clearing a flag that's already cleared.

Sorry, I misread the original.  You are correct with the addition that
the call to munlock2(MLOCK_LOCKED) is a noop in this case.

>=20
> One other question...if I call mlock2(MLOCK_ONFAULT) on a range that
> already has resident pages, I believe that those pages will not be locked
> until they are reclaimed and faulted back in again, right?  I suspect that
> could be surprising to users.

That is the case.  I am looking into what it would take to find only the
present pages in a range and lock them, if that is the behavior that is
preferred I can include it in the updated series.

>=20
> Thanks,
>=20
> jon

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnsGLAAoJELbVsDOpoOa9fD4P+wfJut0yfq/Eut90zuluJASG
y2/MKnGXk/YAwdE9jVyUs/if3S6y9E+nzr9h10jjiAzl7Ek3fbjvGQGtSJee0nxv
xprvjrX8StCUyubIAdvuvBDAQ2uruWlWPt0/WYlTppmm3Ws7sXk6Rc9uyAaYvO8k
cb/3b2hDUz4X3buHx7rbontLHI+PkJyOMC0wwhlgc/TnIyGAOINbxf4jYR9MTOP1
OjpudgitD2855bIJVi9VnOkbG7tvRqJA5azlVkcwlUBqezjSKz5K+NANc4zL5xQ1
uBN9QJXvbiGBzpKXSjmCgtQYRpUq5fN4hZOjq3lo6nill+E+F6eL415ON/5mpRvR
8JeYOUZt/Gua6W0fxLTscnp3E5cpu4oUrzY43J9jJ5HA34s0W8mj/ssey/lDxUo/
LzoeORqwByyNuESJHtHSYJUB24FDQeQJ1cjMLqoZmpyjlFnUoVgzFox+jdtwZ80P
3LMoWN7h6NyQ6GtQDHF1033vsxAHBQ04x96kch9Ztx3BGoWVZoXO1Lsr6X6EHCIV
DmQW1k8HPLsUbkXtOlGR36opxF1fbdBzAyN7V8rWXnNFiyDCl/ImUtEVKQ/VPp9k
T2FjdgDFkTetH6KHVOztE1Ya08wHX4Yy/qxxFH1sPMfVIHFUE7ATTP+00Oc30E32
vBEzC6L/dMQNWWAIbaEJ
=CLFc
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--
