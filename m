Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4LGnbnC003541
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 21 May 2002 09:49:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4LGnbda003540
	for linux-mips-outgoing; Tue, 21 May 2002 09:49:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4LGnVnC003537
	for <linux-mips@oss.sgi.com>; Tue, 21 May 2002 09:49:32 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B605684F; Tue, 21 May 2002 18:50:22 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 1975C3711D; Tue, 21 May 2002 18:47:30 +0200 (CEST)
Date: Tue, 21 May 2002 18:47:30 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Greg Lindahl <lindahl@keyresearch.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
Message-ID: <20020521164730.GC11618@paradigm.rfc822.org>
References: <20020519123059.E20670@dea.linux-mips.net> <Pine.GSO.3.96.1020520120546.19733B-100000@delta.ds2.pg.gda.pl> <20020520085743.A1748@wumpus.keyresearch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <20020520085743.A1748@wumpus.keyresearch.com>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2002 at 08:57:44AM -0700, Greg Lindahl wrote:
> On Mon, May 20, 2002 at 12:06:45PM +0200, Maciej W. Rozycki wrote:
>=20
> >  Well, the surprise is going to happen in drivers, I'm afraid...
>=20
> Linux drivers as a whole are 64-bit clean; alpha's been around for a
> long time. MIPS-only devices might be dirtier.

Not really true - I just stumbled over the cyclades multiport driver
which says to work on alpha for a long time - But it doesnt on
Sparc64 due to the porters misunderstanding on typedefs for the=20
driver internals. (Alpha and i386 are happy with char irqs e.g.).

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE86nohUaz2rXW+gJcRAksIAKCXalmKjUo17wR6p1b5/SYTEU7TegCfcnvd
R1u7ZoovIDJPi19Xro+SOl8=
=yye5
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
