Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARMNBq00754
	for linux-mips-outgoing; Tue, 27 Nov 2001 14:23:11 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARMN3o00747
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 14:23:03 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A465497A; Tue, 27 Nov 2001 22:22:57 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 5F31F3F47; Tue, 27 Nov 2001 17:39:21 +0100 (CET)
Date: Tue, 27 Nov 2001 17:39:21 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Karsten Merker <karsten@excalibur.cologne.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: Status RM200
Message-ID: <20011127173921.A11918@paradigm.rfc822.org>
References: <20011126204509.A10341@paradigm.rfc822.org> <20011126213450.B943@excalibur.cologne.de> <20011126231737.B13081@paradigm.rfc822.org> <20011126233548.D26510@finlandia.infodrom.north.de> <20011127071800.A292@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20011127071800.A292@excalibur.cologne.de>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2001 at 07:18:10AM +0100, Karsten Merker wrote:
> On Mon, Nov 26, 2001 at 11:35:48PM +0100, Martin Schulze wrote:
>=20
> > > How can the RM200 port be wrong endianess - The RM200 is bi-endian
> > > thus any endianess would be ok (As long as the port does not assume
> > > a specific endianess except the prom stuff).
>=20
> Unfortunately the firmware functions are different between little- and
> big-endian firmware and there are quite some parts in the RM200 support
> which currently do not work (and some even do not compile) on a big-endian
> machine due to missing (correct) definitions. Another problem regarding=
=20
> the big endian firmware is that nobody seems to have documentation about
> it, not even a function vector table.

I compiled a kernel yesterday - The only thing comlaining is a
header file for some definitions.

> > As I remember, you can't switch to "the right" endianess without a supp=
ort
> > drivers f*ckup disk - which hasn't appeared on the stage yet.
>=20
> Right - Ralf had asked around for some disks to convert his LE RM200C to
> BE firmware for further development,  but nobody had yet been able to
> come up with some. Additionally, AFAICS these disks are different for
> different machine types and possibly even for different CPU types
> (RM200 EISA vs. RM200C PCI and R4k vs R5k). If anybody knows more about
> these issues, any help is welcome.

They are - The disk type can be determined by the PartNo.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8A8G5Uaz2rXW+gJcRAo1SAJ4kvH4BMey/5F24d5ac6SIZducc3gCcCR+0
SfXm4wtOyABOOXmiLcHo0d4=
=PNyu
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
