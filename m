Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARElHN18219
	for linux-mips-outgoing; Tue, 27 Nov 2001 06:47:17 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAREl6o18200
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 06:47:06 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 63A058BE; Tue, 27 Nov 2001 14:47:00 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3484D3F47; Tue, 27 Nov 2001 13:54:49 +0100 (CET)
Date: Tue, 27 Nov 2001 13:54:49 +0100
From: Florian Lohoff <flo@rfc822.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>, linux-mips@oss.sgi.com,
   karel@sparta.research.kpn.com, algernon@debian.org
Subject: Re: Decstation /150 kernel (cvs) problems
Message-ID: <20011127135449.B7022@paradigm.rfc822.org>
References: <20011127115903.E27987@paradigm.rfc822.org> <Pine.GSO.3.96.1011127125241.440B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1011127125241.440B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2001 at 01:07:09PM +0100, Maciej W. Rozycki wrote:
> On Tue, 27 Nov 2001, Florian Lohoff wrote:
>=20
> > Ok - this fixes the problem by not only ignoring "length 0" sections but
> > also sections with address 0=20
>=20
>  Huh?  You should be dealing with segments and not sections (as you are
> loading and not linking the image) and then only LOADable ones.  I believe

I waded through the sections list copieng all sections which are of
type PROGBITS which is basically the same. Also i cleared all NOBITS
sections. The problem was a progbits section with length > 0 and addr
=3D 0 which is IMHO bogus.

>  If in doubt, just see how I'm loading ELF images in mopd.  Or ask me a
> question.=20

I'll look into that one...

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8A40ZUaz2rXW+gJcRAuCtAKCBvyzuLTjSnS3OmRRR3z+davOCOQCgkNUq
zca1UHbSM5LUjXAhUkocfSQ=
=3jmy
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
