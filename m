Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 May 2004 18:11:34 +0100 (BST)
Received: from [IPv6:::ffff:81.187.251.134] ([IPv6:::ffff:81.187.251.134]:53265
	"EHLO getyour.pawsoff.org") by linux-mips.org with ESMTP
	id <S8225319AbUEPRLd>; Sun, 16 May 2004 18:11:33 +0100
Received: by getyour.pawsoff.org (Postfix, from userid 1000)
	id 87C3338212C; Sun, 16 May 2004 18:11:30 +0100 (BST)
Date: Sun, 16 May 2004 18:11:30 +0100
To: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040516171130.GA14878@getyour.pawsoff.org>
References: <20040513183059.GA25743@getyour.pawsoff.org> <40A478B0.3070005@bitbox.co.uk> <20040516113622.GA14049@getyour.pawsoff.org> <20040516152113.GA9390@convergence.de> <20040516170445.GA4793@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20040516170445.GA4793@linux-mips.org>
User-Agent: Mutt/1.5.6i
From: kieran@pawsoff.org (Kieran Fulke)
Return-Path: <kieran@pawsoff.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kieran@pawsoff.org
Precedence: bulk
X-list: linux-mips


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 16, 2004 at 07:04:45PM +0200, Ralf Baechle wrote:

>=20
> Sharing the timer interrupt with something else isn't impossible but seems
> a less than bright thing to do.  Somebody with production hw to test
> should compare this interrupt dispatch function with old working code
> from 2.2 or 2.4 ...
>=20

what exactly do you mean by test? as far as the dvb drivers go, they=20
work without any problem (with in the same box / hardware) under 2.4. if=20
you can suggest some test cases / methods, i'll happily run them ...

regards,
Kieran.

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAp6DCOWPbH1PXZ18RAoBSAJ96Z2v/4OUmb4z9V1uaQmAgiknYwACgjB96
UbdrkIuXbI0oVwqdFkSzmds=
=wHvt
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
