Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQNILH28277
	for linux-mips-outgoing; Mon, 26 Nov 2001 15:18:21 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQNIGo28274
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 15:18:16 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 41584838; Mon, 26 Nov 2001 23:18:11 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id B92963F45; Mon, 26 Nov 2001 23:17:37 +0100 (CET)
Date: Mon, 26 Nov 2001 23:17:37 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Karsten Merker <karsten@excalibur.cologne.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: Status RM200
Message-ID: <20011126231737.B13081@paradigm.rfc822.org>
References: <20011126204509.A10341@paradigm.rfc822.org> <20011126213450.B943@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20011126213450.B943@excalibur.cologne.de>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2001 at 09:34:50PM +0100, Karsten Merker wrote:
> Ralf has at least made the RM200 support compile again while we
> were driving home from Oldenburg :-).
> I do not know if it really works though - wrong endianess...

How can the RM200 port be wrong endianess - The RM200 is bi-endian
thus any endianess would be ok (As long as the port does not assume
a specific endianess except the prom stuff).

AFAIK the RM200 was supported little endian as it was ported to the
Windows NT delivered machines.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Ar+BUaz2rXW+gJcRAt41AJwJjdZ2O95day+L8GHm2tl43CqbcQCgt/dS
nSplbUuq16IaljiIqaFM9tw=
=wgAX
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
