Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 May 2004 17:11:52 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:3818 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225204AbUEVQGi>; Sat, 22 May 2004 17:06:38 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 0A3FA4B662; Sat, 22 May 2004 18:06:36 +0200 (CEST)
Date:	Sat, 22 May 2004 18:06:35 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	linux-mips@linux-mips.org
Subject: Re: Socket problem?
Message-ID: <20040522160635.GV1912@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <000001c43fd3$2c25a350$2000a8c0@gillpc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r6hKzN7r4zkbhieJ"
Content-Disposition: inline
In-Reply-To: <000001c43fd3$2c25a350$2000a8c0@gillpc>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--r6hKzN7r4zkbhieJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-05-22 09:02:48 +0100, Gill <gill.robles@exterity.co.uk>
wrote in message <000001c43fd3$2c25a350$2000a8c0@gillpc>:
> Hi -
>=20
> Has anyone come across a socket problem where the user app calls select()=
 on
> a set of sockets, which returns, indicating that data is waiting...then
> subsequent recvfrom() call returns -1 indicating that there's nothing
> there??

Read the select() manpage again. Upon successful return, it's guaranteed
that the very next read() on a file descriptor contained in the result
set won't block. Typically, it's the case after data arrived, but
returning -1 *immediately* (with no blocking) is okay, too.

> I'm using linux v2.4.2, IPv4, and the ethernet driver is pcnet32.  We're
> receiving a UDP stream.

Quite aged version, though perfectly correct on select() behaviour.

> I'm trying to check for dropped packets.  /proc/net/snmp indicates a numb=
er
> of UDP InErrors (~1 per second).  However, not yet sure whether this is a
> consequence of the problem above, or cause of it.

Neither - nor. You've got a small thinko in your application. Albeit
that: update your kernel version... It most probably contains a number
of known root exploits.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--r6hKzN7r4zkbhieJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAr3qLHb1edYOZ4bsRAgUjAJ0dckbFgNuYl3Ve3R6as3N89e06RwCeOFpl
Mx5LFma3X21zwHgkwgNLPNA=
=/QbY
-----END PGP SIGNATURE-----

--r6hKzN7r4zkbhieJ--
