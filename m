Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2004 17:32:13 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:52670 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225826AbUFQQcJ>; Thu, 17 Jun 2004 17:32:09 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 208374B6E3; Thu, 17 Jun 2004 18:32:07 +0200 (CEST)
Date: Thu, 17 Jun 2004 18:32:07 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: CVS access
Message-ID: <20040617163206.GQ20632@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <1087486756.3789.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VKuXy7C2ZpXslCZ2"
Content-Disposition: inline
In-Reply-To: <1087486756.3789.4.camel@localhost.localdomain>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--VKuXy7C2ZpXslCZ2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-06-17 08:39:16 -0700, Prasanth Kumar <lunix@comcast.net>
wrote in message <1087486756.3789.4.camel@localhost.localdomain>:
>=20
> [bubba]$ cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs loginLogging
> in to :pserver:cvs@ftp.linux-mips.org:2401/home/cvs
> CVS password:
> cvs login: authorization failed: server ftp.linux-mips.org rejected
> access to /home/cvs for user cvs

pserver seems running (shouldn't it been sho^Wut down due to
vulnerabilities?).

But to help you: You'd rsync the whole CVS repo to a local machine and
then check-out locally. Oh, kernel.org vanilla kernels won't really
compile nor boot, I guess. All development is done here...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--VKuXy7C2ZpXslCZ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0ceGHb1edYOZ4bsRAqPbAJ9bFQAfdZtVfKVrtNUJTR80ccs/9ACeLt5t
+pgzVb7O1uJaRXU3+v2e0Z4=
=3qEr
-----END PGP SIGNATURE-----

--VKuXy7C2ZpXslCZ2--
