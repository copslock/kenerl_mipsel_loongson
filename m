Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2003 09:25:36 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:56849 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225073AbTEIIZe>; Fri, 9 May 2003 09:25:34 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 231E84ABA6; Fri,  9 May 2003 10:25:30 +0200 (CEST)
Date: Fri, 9 May 2003 10:25:30 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Message-ID: <20030509082529.GX27494@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <BAY1-F19KkLxFjjBsVV00007bcf@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EEnv9zyGND1dPpWR"
Content-Disposition: inline
In-Reply-To: <BAY1-F19KkLxFjjBsVV00007bcf@hotmail.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--EEnv9zyGND1dPpWR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-05-08 23:31:31 -0700, Michael Anburaj <michaelanburaj@hotmail.=
com>
wrote in message <BAY1-F19KkLxFjjBsVV00007bcf@hotmail.com>:
> more info...
>=20
> clipping from Linux startup messages:
> -----------------------------------------------------
> Root-NFS: Server returned error -13 while mounting /tftpboot/4.42.102.6
>=20
> clipping from /var/log/messages:
> --------------------------------------------
> May  8 19:54:42 localhost rpc.mountd: refused mount request from 4.42.102=
.6=20
> for
> /tftpboot/4.42.102.6 (/): no export entry
>=20
>=20
> Why is Linux (running on the MIPS board) trying '/tftpboot/4.42.102.6'.=
=20
> Should it not try '/export/RedHat7.1'

See ./linux/fs/nfs/nfsroot.c for this. ...and please, answer _under_ an
old email and remove anything you no longer directly reply to.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--EEnv9zyGND1dPpWR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+u2X5Hb1edYOZ4bsRAqmsAJ9JQniqqjjiJXvagWs3wEmJ4ZH4LQCdFpJn
ULk4cLBoelAAkdv5S1FeGv0=
=QRIZ
-----END PGP SIGNATURE-----

--EEnv9zyGND1dPpWR--
