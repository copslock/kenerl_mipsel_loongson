Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2005 20:52:36 +0100 (BST)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:33757 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8225929AbVC2TwU>;
	Tue, 29 Mar 2005 20:52:20 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id 4A625190117; Tue, 29 Mar 2005 21:52:08 +0200 (CEST)
Date:	Tue, 29 Mar 2005 21:52:08 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: 64bit compile of tulip driver
Message-ID: <20050329195208.GH17725@lug-owl.de>
Mail-Followup-To: Jim Gifford <maillist@jg555.com>,
	Linux MIPS List <linux-mips@linux-mips.org>
References: <4249A5EE.9070006@jg555.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline
In-Reply-To: <4249A5EE.9070006@jg555.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-29 11:01:02 -0800, Jim Gifford <maillist@jg555.com>
wrote in message <4249A5EE.9070006@jg555.com>:
> Under 32bit the tulip driver works fine, but under 64 bit it gives me a=
=20
> lot of grief.
>=20
> First off it continually sends data out the network interface and never=
=20
> negotiates is speed and duplex.
> Second in the log files all I see is an uninformative message=20
> 0000:00:07.0: tulip_stop_rxtx() failed
>=20
> Here is all the bootup information differences I can find on the driver
> 64 bit
> Dec 31 16:01:29 lfs tulip0: ***WARNING***: No MII transceiver found!
> Dec 31 16:01:29 lfs tulip1: ***WARNING***: No MII transceiver found!
> 32 bit
> Dec 31 16:01:16 lfs tulip0:  MII transceiver #1 config 1000 status 7809=
=20
> advertising 01e1
> Dec 31 16:01:16 lfs tulip1:  MII transceiver #1 config 1000 status 7809=
=20
> advertising 01e1.

That's all wrongly wrapped around. However, where's the patch?

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCSbHoHb1edYOZ4bsRAoMmAKCR24AHvDJRK7KiTaqtqM1uMFrHfQCfaAza
kVh06hcandAZ1hLEAn4EGVg=
=sdbG
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--
