Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 12:20:58 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:17672 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225239AbTEHLU4>; Thu, 8 May 2003 12:20:56 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 34D874AB98; Thu,  8 May 2003 13:20:53 +0200 (CEST)
Date: Thu, 8 May 2003 13:20:53 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Message-ID: <20030508112052.GT27494@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <BAY1-F62WlX0MGOV6T000004f80@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/tCzywT4ru0wuIhW"
Content-Disposition: inline
In-Reply-To: <BAY1-F62WlX0MGOV6T000004f80@hotmail.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--/tCzywT4ru0wuIhW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-05-08 03:09:53 -0700, Michael Anburaj <michaelanburaj@hotmail.=
com>
wrote in message <BAY1-F62WlX0MGOV6T000004f80@hotmail.com>:
> Hi all,
>=20
> Finally I got the Atlas 4Kc board running YAMON to talk to Host PC runnin=
g=20
> RedHat Linux 9 & download vmlinux.rec throught tftp. I have set-up NFS=20
> export in the same PC under /export/RedHat7.1
>=20
> After the vmlinux.rec got downloaded, I issued the following command on t=
he=20
> YAMON (MIPS tartget) prompt to start the downloaded linux kernel:
>=20
> go . nsfroot=3D4.42.102.7:/export/RedHat7.1
                                           ^^^^^^^

I think the box doesn't have an IP address, nor has it been told to pick
one. You should add 'ip=3Dbootp' or 'ip=3Ddhcp' to your command line.

> Protect your PC - get McAfee.com VirusScan Online =20
> http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3D3963

Protecting a PeeCee is more an act of not shooting one's own feet by
running known-bad software...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--/tCzywT4ru0wuIhW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+uj2UHb1edYOZ4bsRAsVnAJ97Air0mXDemeh/ibno99tBwQ6dPQCbBH37
cozPrwBsIn1nT1u3L0W7RXE=
=oRVZ
-----END PGP SIGNATURE-----

--/tCzywT4ru0wuIhW--
