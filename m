Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2002 22:21:25 +0200 (CEST)
Received: from noose.gt.owl.de ([62.52.19.4]:40971 "HELO noose.gt.owl.de")
	by linux-mips.org with SMTP id <S1121744AbSI1UVZ>;
	Sat, 28 Sep 2002 22:21:25 +0200
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8C010873; Sat, 28 Sep 2002 22:21:17 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 5B8D93717F; Sat, 28 Sep 2002 22:19:58 +0200 (CEST)
Date: Sat, 28 Sep 2002 22:19:58 +0200
From: Florian Lohoff <flo@rfc822.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] dec_esp.c repair mmu_sglist breakage
Message-ID: <20020928201958.GE18156@paradigm.rfc822.org>
References: <20020928103840.GA23300@linuxtag.org> <Pine.GSO.3.96.1020928203950.10698B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020928203950.10698B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2002 at 08:49:52PM +0200, Maciej W. Rozycki wrote:
> On Sat, 28 Sep 2002, Karsten Merker wrote:
>=20
> > > through the whole issue of the mmu_sglist confusion and the broken
> > > reimplantation of mmu_sglist the dec_esp broke. Here is a fix
> > > to really remove the mmu_sglist and use scatterlist instead. With
> > > this the Decstation on this desk at least finds its partitions
> > > again and does not crash.
> >=20
> > I tested the patch on my DS 5000/150 and it works there, too.
>=20
>  Thanks for the report -- since I have no means to test the SCSI driver I
> was going to ask people for testing to have another confirmation.  I'm not
> sure why it got broken (I'll check the details to find out) as the changes
> were to revert to the original behaviour, but since struct mmu_sglist got

It wasnt reverted - The problem was that the original Framework NCR53C9x
and dec_esp.c used the different structs which were not the same (Order
changed) after the change so it broke.

> deprecated, I'm happy to see an update to struct scatterlist.  Since the
> change works for both of you, I'm checking it in now.=20

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9lg7uUaz2rXW+gJcRAuYAAKDaguL51/GneWibJ9gemWZLGVuFhACfdaOs
IYmUroXaQn4YYeyK+spo3JE=
=7shc
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
