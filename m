Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Apr 2004 21:22:22 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:35274 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225208AbUDOUWU>; Thu, 15 Apr 2004 21:22:20 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id CCBC24B65F; Thu, 15 Apr 2004 22:22:18 +0200 (CEST)
Date: Thu, 15 Apr 2004 22:22:18 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: questions about keyboard
Message-ID: <20040415202218.GI630@lug-owl.de>
Mail-Followup-To: Linux/MIPS Development <linux-mips@linux-mips.org>
References: <F71A246055866844B66AFEB10654E7860F1B10@riv-exchb6.echostar.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4YfhVOqjnG2FJTMT"
Content-Disposition: inline
In-Reply-To: <F71A246055866844B66AFEB10654E7860F1B10@riv-exchb6.echostar.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--4YfhVOqjnG2FJTMT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-04-15 14:08:54 -0600, Xu, Jiang <Jiang.Xu@echostar.com>
wrote in message <F71A246055866844B66AFEB10654E7860F1B10@riv-exchb6.echosta=
r.com>:
> Thanks for the reply, I did some testing and found some interesting thing=
s:
>=20
> 1.  Everytime I push the key on the keyboard, I can see something out from
> /dev/input/event0 by "cat /dev/input/event0".
> However, I don't see a directory named "proc/input", did I miss configure
> something in the kernel?

Maybe your kernel isn't configured with CONFIG_PROC_FS=3Dy ?
Maybe it's not mounted?

> 2.  read() does work and is a blocking read.  However, if I use select, t=
hen
> it does not work.
> Select() never detects the state change.
> Here is the sample code I am using:
> {
>    int test_fd =3D -1;

No need to initialize - you're assigning a value before accessing it.

>    fd_set rfds;
>    struct timeval tv;
>  =20
>    tv.tv_sec =3D 1;
>    tv.tv_usec =3D 0;

tv_* need to be set before *every* select () invocation, not only once.

>    test_fd =3D open("/dev/input/event0", O_RDONLY);=20
>    if( test_fd < 0 )
>      exit(0);
>   =20
>    while( 1 )
>    {=09
> 	FD_ZERO(&rfds);
> 	FD_SET(test_fd, &rfds);
>       retval =3D select( 1, &rfds, NULL, NULL, &tv );

That's wrong. The "1" should be "fd + 1".

>       if( retval )
>          printf("\nDetects something....");

A negative retval would also be !=3D 0 ...

>    }
> }
>=20
> What could be wrong?

Most probably it's the hardcoded "1" with the select. That is, select
only looks at all fd's which are smaller than one, so only fd=3D0 would be
testes, but this one isn't in the set, so...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--4YfhVOqjnG2FJTMT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAfu76Hb1edYOZ4bsRAi9xAKCSP9oll0gcfiozDmwAZFX3jEFRMwCfd01l
+wjn2UcvlkkyjTv+n2mBgRU=
=HFCE
-----END PGP SIGNATURE-----

--4YfhVOqjnG2FJTMT--
