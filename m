Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 21:59:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31496 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27028462AbcEIT7oCfvGy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 May 2016 21:59:44 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 9EFBA41F8DDD;
        Mon,  9 May 2016 20:59:38 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 09 May 2016 20:59:38 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 09 May 2016 20:59:38 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id BF331DFFF7BC7;
        Mon,  9 May 2016 20:59:33 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 9 May 2016 20:59:38 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 9 May
 2016 20:59:37 +0100
Date:   Mon, 9 May 2016 20:59:37 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>, Jayachandran C.
        <jchandra@broadcom.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim
 =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: Re: [PATCH 0/7] MIPS: Add extended ASID support
Message-ID: <20160509195937.GF23699@jhogan-linux.le.imgtec.org>
References: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
 <20160509132315.GA28818@linux-mips.org>
 <alpine.DEB.2.00.1605091756520.6794@tp.orcam.me.uk>
 <20160509190442.GC23699@jhogan-linux.le.imgtec.org>
 <alpine.DEB.2.00.1605092041200.6794@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1605092041200.6794@tp.orcam.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: ebfc6934
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2016 at 08:56:51PM +0100, Maciej W. Rozycki wrote:
> On Mon, 9 May 2016, James Hogan wrote:
>=20
> > > > Already PMC-Sierra's RM9000 / E9000 core had an extended ASID field=
, of
> > > > 12 bits for 4096 ASID contexts.  Afaics this was an extension deriv=
ed
> > > > in-house back in the wild days before everything had to be sanction=
ed by
> > > > the architecture folks, so there is nothing in a config register to=
 test
> > > > for it.
> > >=20
> > >  Couldn't you just probe it in EntryHi directly, by writing all-ones,=
=20
> > > reading back and seeing how many bits have stuck?
> >=20
> > Note, the tlbinv feature in recent versions of MIPS32/MIPS64 arch has
> > EHINV bit in bit 10 (if I remember right) of EntryHi, which marks whole
> > tlb entry as invalid, and the small pages feature (for 1k pages) extends
> > VPN field downwards to bit 11.
>=20
>  Yes, but these are not legacy architectures, are they?

Right.

> Since you've got
> bits set across Config registers you don't need to resort to poking at=20
> other registers.  Although there are exceptions like PABITS and SEGBITS=
=20
> (we ought to handle this one day actually, for correct unaligned access=
=20
> emulation -- right now you get a repeated AdEL exception in emulation cod=
e=20
> for what originally was an unaligned out of range kernel XKPHYS access,=
=20
> making it a big pain to debug; I've had a hack for this since 2.4 days,=
=20
> but it should be done properly).
>=20
>  In the old days pretty much nothing was recorded in the single Config=20
> register (very old chips didn't even have that -- you had to size caches=
=20
> manually for example), but stuff could often be determined via other=20
> means, sometimes (like probably here) without detailed checks on PRId.

Cheers
James

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMOwpAAoJEGwLaZPeOHZ6OUMQALqrYeoZEor/ZvSrQrL92g9m
pOuQyexcbesBSbc0HSa13HtB3ClrHNXsZXIXCP6L03daG7e6YJboKgO02AyvZxaM
mHytwg56J1kI7AH0zQ/PJupidmVLTo+rVgHyq/wbZoGP8rCWsuYMz7WAQG1axCg5
q/niNoEqu7nYStSIWbl+5bLl5c0XE3la2tXS1XJ9uw5ufjUS+7H5w353j7A9n1Kd
tH5KoAUeTPf4qoWdXqtkrNzSYzls2rRsRl2ORacLwn2jN55GTUZbUnmOjNvtr1jD
v90qZu6zENRrgn4q1/IFVcP2ts1koRg3SvZkDMtb7Qj/W3FzsCkhW1+qR2YXR6gE
pox8LTBBRfsCeez9YsO9NOHp1T4jt+S9if0TMPqfnm3OfoOvMQYK/ZzS7VPbvpWA
kHXWMWgWjqtyo4gxLRLBN0zzaqx9KQJfEfvrm/p3qWlHP6kFy1Bd6kMDVm3qGkye
5Ksa+RGzGWx3Zh06XXNCuGG9SUEwLXPbdYx3bkon+H3ICNO+tkIe8yBZdgzLjB/l
22+nJDQE0dqSubwTMXHZukgsZEBrqnwxPuAy8WZwOJcD+Ybd1alvSlp194OIt5o8
V5UEMvUGKw2rWo7Xmy4KJZ0KEH4X5aVNWLsFBvQu4O8T7+JCyWzViDI8MKr9F2tL
HXTzVB+tykZ9B8wp1Gz9
=djGN
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
