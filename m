Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARGdb723374
	for linux-mips-outgoing; Tue, 27 Nov 2001 08:39:37 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARGdTo23363
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 08:39:29 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id DCB7B849; Tue, 27 Nov 2001 16:39:22 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id CD1F83F47; Tue, 27 Nov 2001 16:36:02 +0100 (CET)
Date: Tue, 27 Nov 2001 16:36:02 +0100
From: Florian Lohoff <flo@rfc822.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>, linux-mips@oss.sgi.com,
   karel@sparta.research.kpn.com, algernon@debian.org
Subject: Re: Decstation /150 kernel (cvs) problems
Message-ID: <20011127163602.C9282@paradigm.rfc822.org>
References: <20011127135449.B7022@paradigm.rfc822.org> <Pine.GSO.3.96.1011127153437.440G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1011127153437.440G-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2001 at 04:08:47PM +0100, Maciej W. Rozycki wrote:
> On Tue, 27 Nov 2001, Florian Lohoff wrote:
>=20
> > >  Huh?  You should be dealing with segments and not sections (as you a=
re
> > > loading and not linking the image) and then only LOADable ones.  I be=
lieve
> >=20
> > I waded through the sections list copieng all sections which are of
> > type PROGBITS which is basically the same. Also i cleared all NOBITS
>=20
>  It's not the same, sorry -- for sections you would need to handle ones
> marked ALLOC in flags.  Of these you need to load ones of type PROGBITS
> and zero-fill ones of type NOBITS.  Others may be discarded.  For Linux
> you may actually skip NOBITS as well, as the head code zero-fills common
> sections itself, but handling them is saner IMO.=20

This is mostly what i do - As the ext2 code loads in the whole file
as a chunk i am loading it after the booloader - Then copy it to the
end of the first 8Megs (Which is the minimum memory on a decstation)
and then copy the chunks marked PROGBITS to their final location.

Not optimal but it worked for all the cases where the ELF is ok.

>  Still using segments is the proper way and it's simpler as well.=20
> Additionally for platforms that use physical (or in any way different)
> addressing upon boot, you may (and should) use segments' physical
> addresses that are not available (assigned) to sections.
>=20
> > sections. The problem was a progbits section with length > 0 and addr
> > =3D 0 which is IMHO bogus.
>=20
>  Not bogus -- the only section which matches your criteria I'm seeing is
> ".pdr":=20

Yep - And that the one where the current copyelf function crashes the
box.

>   [17] .pdr              PROGBITS        00000000 2c4954 034440 00      0=
   0  4

> But it's not marked as allocatable, so it does not belong to the run-time
> image.  See also the "System V Application Binary Interface, Edition 4.1",
> chapter 4 for sections and 5 for segments.=20

;) I am no elf god by far - I was just in the need of a bootloader so
i looked in the elf headers and collected the bits i thought were
usefull.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8A7LiUaz2rXW+gJcRAllaAKDbOrTPVfwnBe79fcrQB63j8CKixACgxgOb
8XowquJbPOYdhVNjsl8IoQ0=
=/rY9
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
