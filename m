Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2003 11:30:15 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:18184 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225278AbTEJKaN>; Sat, 10 May 2003 11:30:13 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 4835D4ABBB; Sat, 10 May 2003 12:30:10 +0200 (CEST)
Date: Sat, 10 May 2003 12:30:10 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Message-ID: <20030510103009.GF27494@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <BAY1-F45jlKqwWil63h0000a6fd@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EhL9IO3QiJLbitD/"
Content-Disposition: inline
In-Reply-To: <BAY1-F45jlKqwWil63h0000a6fd@hotmail.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--EhL9IO3QiJLbitD/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-05-09 21:57:46 -0700, Michael Anburaj <michaelanburaj@hotmail.=
com>
wrote in message <BAY1-F45jlKqwWil63h0000a6fd@hotmail.com>:
>=20
> Warning: unable to open an initial console.
> Kernel panic: No init found.  Try passing init=3D option to kernel.
>=20
> in src/linux/init/main.c
>=20
> open("/dev/console", O_RDWR, 0) is returning a negative value. I don't ha=
ve=20
> a video device on board., required? Will /dev/console open a UART port=20
> (/dev/ttyS0 or /dev/tty0)? Why am I getting this error?

/dev/console (within your NFS root) should be a char device with 0x05 as
major and 0x01 as minor.

If you want so use serial console, you need to pass "console=3D/dev/ttyS0"
(or similar if your serial devices use a different naming scheme) along
with kernel's command line.

"init" is another thing. Your NFS root should include a /sbin/init or
or /etc/init or /bin/init or /bin/sh. If none of those exists, you
loose. Somewhere, you told that you get -5 as error code. This is EIO
IIRC so maybe your network card's driver is buggy. For debugging this,
you should use tcpdump (or ethereal) as well as userspace NFS server and
attach a strace to it:)

> 1. Is the kernel not build properly (did not include console driver)?

You need serial drivers compiled in and you need to configure them as
console drivers (serial console). Additionally, you need to pass
"console=3DttyS0" as kernel command line option.

> 2. Should I pass init=3Dblablabla as a parameter? <but nothing like that =
is=20
> specified in the doc.>.

In normal cases, you don't need to pass that. Kernel should just pick
/sbin/init and execute it. /sbin/init will then start everything needed.
Could you please do this:

$ cd /path/to/nfsroot
$ file sbin/inint

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--EhL9IO3QiJLbitD/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+vNSxHb1edYOZ4bsRAhM+AJ9G9Ksz9aNWsGz48mYZ/TmjFrxwiwCdG31a
44xZ42+81I+pzNqxPPId1cI=
=gBm4
-----END PGP SIGNATURE-----

--EhL9IO3QiJLbitD/--
