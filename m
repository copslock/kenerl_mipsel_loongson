Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Jun 2004 11:12:00 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:13966 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8224945AbUFTKLz>; Sun, 20 Jun 2004 11:11:55 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 4EF514B7CD; Sun, 20 Jun 2004 12:11:53 +0200 (CEST)
Date: Sun, 20 Jun 2004 12:11:53 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: Dummy keyboard driver
Message-ID: <20040620101153.GH20632@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040619200923.GA22409@linux-mips.org> <20040619223829.GD20632@lug-owl.de> <20040620000348.GB23498@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RtZTDqy7cLeWP9t+"
Content-Disposition: inline
In-Reply-To: <20040620000348.GB23498@linux-mips.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--RtZTDqy7cLeWP9t+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-06-20 02:03:48 +0200, Ralf Baechle <ralf@linux-mips.org>
wrote in message <20040620000348.GB23498@linux-mips.org>:
> On Sun, Jun 20, 2004 at 12:38:30AM +0200, Jan-Benedict Glaw wrote:
> > On Sat, 2004-06-19 22:09:23 +0200, Ralf Baechle <ralf@linux-mips.org>
> > wrote in message <20040619200923.GA22409@linux-mips.org>:
> > I (vax 2.6.x tree) don't even have that file, and there shouldn't be no
> > need for any kind of dummy keyboard. Either there's at least one
> > keyboard attached (multiple are fine, though), you get input. No
> > keyboard (driver), no input. Simple.
> >=20
> > Just drop it.
>=20
> I don't think the original reason for it still exists and even if it
> was it'd need to be rewritten and moved so I'm removing it now.

Right. Looong ago, you had to have keyboard driver if you had CONFIG_VT
switched on (because tty/vt core then referenced some functions for key
mapping and LED status setting), but those times are gone.

Today's dummy keyboard actually *is* the whole Input API. I think the
"direct" way of pumping data into tty/vt core went away around 2.6.1 (or
around that), when the parisc team ported their HIL and ps2-keyboard
drivers to Input API drivers or serio adaptors.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--RtZTDqy7cLeWP9t+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1WLoHb1edYOZ4bsRAkkKAKCD+QseG8vGz/6YN2Wj6fhJgdsI1gCdGC8E
QauB8edarDyS/cckG3gX6RI=
=5q8n
-----END PGP SIGNATURE-----

--RtZTDqy7cLeWP9t+--
