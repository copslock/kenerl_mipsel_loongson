Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2003 16:00:40 +0100 (BST)
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:39050
	"HELO gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225252AbTFDPAf>; Wed, 4 Jun 2003 16:00:35 +0100
Received: (qmail 22379 invoked by uid 502); 4 Jun 2003 15:00:26 -0000
Date: Wed, 4 Jun 2003 08:00:25 -0700
From: ilya@theIlya.com
To: linux-mips@linux-mips.org
Subject: Re: [PATCH] vmlinux.lds.S
Message-ID: <20030604150025.GE7624@gateway.total-knowledge.com>
References: <20030604042037.GD7624@gateway.total-knowledge.com> <20030604065216.GN30457@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Content-Disposition: inline
In-Reply-To: <20030604065216.GN30457@lug-owl.de>
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yeap, this is for 2.5.59
Not anything earlier.
Without this patch PROM will tell you there is not enough memory to load th=
e image.
On Wed, Jun 04, 2003 at 08:52:16AM +0200, Jan-Benedict Glaw wrote:
> On Tue, 2003-06-03 21:20:38 -0700, ilya@theIlya.com <ilya@theIlya.com>
> wrote in message <20030604042037.GD7624@gateway.total-knowledge.com>:
> > Without this generated image is weired, and cannot be loaded.
> >=20
> > Index: arch/mips64/vmlinux.lds.S
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > RCS file: /home/cvs/linux/arch/mips64/vmlinux.lds.S,v
> > retrieving revision 1.11
> > diff -u -r1.11 vmlinux.lds.S
> > --- arch/mips64/vmlinux.lds.S   3 Jun 2003 17:04:11 -0000       1.11
> > +++ arch/mips64/vmlinux.lds.S   4 Jun 2003 04:18:05 -0000
> > @@ -46,6 +46,7 @@
> >    __kallsyms : { *(__kallsyms) }
> >    __stop___kallsyms =3D .;
> > =20
> > +  RODATA
> >    . =3D ALIGN(64);
> > =20
> >    /* writeable */
>=20
>=20
> This is for 2.5.x? Maybe that's even what prevents my Indy to boot
> (using a 32bit kernel). I'll test that tonight;)
>=20
> MfG, JBG
>=20
> --=20
>    Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
>    "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Kr=
ieg
>     fuer einen Freien Staat voll Freier B?rger" | im Internet! |   im Ira=
k!
>       ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA=
));



--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+3gmJ7sVBmHZT8w8RAv0aAKCpPMTnoVjIBcT6+KYLd3Aps6FS7gCeMKG2
AIpDE60kWEWBYYuaC6cVCqM=
=Uf8M
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
