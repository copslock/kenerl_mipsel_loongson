Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2016 18:03:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39191 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991346AbcJFQDJbkvBp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Oct 2016 18:03:09 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id D7BA441F8D64;
        Thu,  6 Oct 2016 17:03:00 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 06 Oct 2016 17:03:00 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 06 Oct 2016 17:03:00 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id A980EC92E00AA;
        Wed,  5 Oct 2016 16:56:53 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 5 Oct 2016
 16:56:54 +0100
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 5 Oct
 2016 16:56:54 +0100
Date:   Wed, 5 Oct 2016 16:56:54 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/9] MIPS: traps: 64bit kernels should read CP0_EBase
 64bit
Message-ID: <20161005155653.GG15578@jhogan-linux.le.imgtec.org>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
 <e826225b15736539cd96a1b6b2a99e2bb2b4eb87.1472747205.git-series.james.hogan@imgtec.com>
 <20160921130852.GA10899@linux-mips.org>
 <73eede89-af68-eb17-b0b3-2537084da819@imgtec.com>
 <alpine.LFD.2.20.1610021038190.25303@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WkfBGePaEyrk4zXB"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1610021038190.25303@eddie.linux-mips.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1cc78754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55355
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

--WkfBGePaEyrk4zXB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

On Sun, Oct 02, 2016 at 11:30:13AM +0100, Maciej W. Rozycki wrote:
> On Wed, 21 Sep 2016, Matt Redfearn wrote:
>=20
> > > > When reading the CP0_EBase register containing the WG (write gate) =
bit,
> > > > the ebase variable should be set to the full value of the register,=
 i.e.
> > > > on a 64-bit kernel the full 64-bit width of the register via
> > > > read_cp0_ebase_64(), and on a 32-bit kernel the full 32-bit width
> > > > including bits 31:30 which may be writeable.
> > > How about changing the definition of read/write_c0_ebase to
> > >
> > > #define read_c0_ebase()         __read_ulong_c0_register($15, 1)
> > > #define write_c0_ebase(val)     __write_ulong_c0_register($15, 1, val)
> >=20
> > James added the {read,write}_c0_ebase_64 functions in
> > 37fb60f8e3f011c25c120081a73886ad8dbc42fd, because performing a 64bit ac=
cess to
> > 32bit cp0 registers (like ebase on 32bit cpus) was an undefined operati=
on
> > pre-r6, so we can't always access them as longs.
>=20
>  Well, `long' is 32-bit with 32-bit processors, however in older (as in:=
=20
> before 3.50) architecture revisions EBase was 32-bit even with 64-bit=20
> processors,
> so I take it you meant "like ebase on 64bit cpus", right?
>=20
> > > or using a new variant like
> > >
> > > #define read_c0_ebase_ulong()         __read_ulong_c0_register($15, 1)
> > > #define write_c0_ebase_ulong(val)     __write_ulong_c0_register($15, =
1, val)
> > >
> > > to avoid the ifdefery?  This could also make this bit
> > >
> > >                  ebase =3D cpu_has_mips64r6 ? read_c0_ebase_64()
> > > : (s32)read_c0_ebase();
> >=20
> > This relies on being able to determine a 64bit value for ebase, either =
by
> > reading it in its entirety on a 64bit cpu (including on a 32bit kernel)=
 or sign
> > extending it from a 32bit read.
>=20
>  This does look wrong to me, as I noted above EBase is 64-bit with MIPS64=
=20
> processors as from architecture revision 3.50.  Also I don't think we wan=
t=20

MIPS64 PRA (I'm looking at r5 and r6) seems to allow for write-gate not
to be implemented, in which case the register is only 32-bits.

Cheers
James

--WkfBGePaEyrk4zXB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX9SLFAAoJEGwLaZPeOHZ6RVUP/11hsK4w45xvj68msYCJEZWG
yKY1l+jN3E9FMdNb3xhnfqKypOoIQV9RrTtB16ITJrWeDN6NEarq/mMc1WJZnFCX
gt7XYvxKhKn348LtKbW4WkVZz5jsETQuEgTPXCUzgC2A2ZsACuz9ycJlVxyHti7o
uvEhOro474V+FLhJeQ7K4ZkyJcXZUYvugfgxZPKmGOgId74GgRXjtiGIQJaAUEAt
ENQdVuWoKcEs1QGMBA7iOuyTh4bJoxAJUtLsTKzKjabAKYgWfl1hJLM4zgX+iHYY
CizHy91i7AAmSbjTBRgD/YQYIHwMaqPPXjXcUyKzDJdr+DVN8iJThbjYrXqxGdpP
frSaqMRs6AVXzFCxGzoF2BNzBobf9oczd56bgkwgOGy6jUVzummsN6zfWxQUgmux
L53NeH94D2T60UXi3w9E1SsaTA99y8wrvefpVCNq+Pt9hNK1HaneWPZ8o3I5EAox
gVoQEL54/KG1YdAuETyiciv2kO8VtaaETzp/nYz2RJF63usegF1iBVZx8blejmQr
mIelg6J19JqgfgsyrVda8wBK5ZDpF6aymnDMiHIZB0ShHVlHxCryzOhCx3FLkls7
qQLb94M7bvzhFKfAa2vTjbZt+IZbI0I65Ym6oCxpfMXtcNqzugGjPtyzZntty2T8
MrEA5g7uArluzgCyS90E
=jcTF
-----END PGP SIGNATURE-----

--WkfBGePaEyrk4zXB--
