Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Apr 2004 09:36:21 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:30135 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225736AbUDOIgN>; Thu, 15 Apr 2004 09:36:13 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 1647D4B5F1; Thu, 15 Apr 2004 10:36:10 +0200 (CEST)
Date: Thu, 15 Apr 2004 10:36:09 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: questions about keyboard
Message-ID: <20040415083609.GU630@lug-owl.de>
Mail-Followup-To: Linux/MIPS Development <linux-mips@linux-mips.org>
References: <F71A246055866844B66AFEB10654E7860F1B0D@riv-exchb6.echostar.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xbjSOCWVZ1q9zj4g"
Content-Disposition: inline
In-Reply-To: <F71A246055866844B66AFEB10654E7860F1B0D@riv-exchb6.echostar.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--xbjSOCWVZ1q9zj4g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-04-14 14:56:20 -0600, Xu, Jiang <Jiang.Xu@echostar.com>
wrote in message <F71A246055866844B66AFEB10654E7860F1B0D@riv-exchb6.echosta=
r.com>:
> 2.  In the application, how can I know which input/event# the usb keyboard
> connects to?

You don't. You can

	- Hope that your keyboard is the one and only device...
	- Read /proc/bus/input/devices - there should be a "kbd" handler
	  in the "H: " section
	- select() on all event* devices and just only process
	  keypresses generated from "normal" keys.

> 3.  Is there some reference documents about how to read things from
> input/event# ? I mean such as how to read key event?

I don't think there's really good docu available, but it's really
simple. Just open all devices, select() until there's data available (or
just call a blocking read() on it). Something like this should work, but
you'd better add error checking to the open() call...

#include <linux/input.h>

ssize_t ret;
struct input_event my_input;
int fd;

fd =3D open ("/dev/input/event0", O_RDONLY);
for (;;) {
	ret =3D read (fd, &my_input, sizeof (my_input));
	if (ret !=3D sizeof (my_input)
		break;

	if (my_input.type !=3D EV_KEY)
		continue;
	/* my_input.code and my_input.type now contain the key and
	   press/release state; refer to the #defines in linux/input.h
	   for the mapping .code -> ASCII value */
}
close (fd);


--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--xbjSOCWVZ1q9zj4g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAfkl5Hb1edYOZ4bsRAph9AJ9nVPP0TBtiqgmMoma7lwaqcw59SwCggZrv
hBwPnfb9+Hj4tX5v6JpsF20=
=DmoR
-----END PGP SIGNATURE-----

--xbjSOCWVZ1q9zj4g--
