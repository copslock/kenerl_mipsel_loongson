Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 07:57:37 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:3535 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225296AbTJVG5f>; Wed, 22 Oct 2003 07:57:35 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 62B124B412; Wed, 22 Oct 2003 08:57:33 +0200 (CEST)
Date: Wed, 22 Oct 2003 08:57:33 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: module dependency files
Message-ID: <20031022065732.GP20846@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <1066771519.3289.45.camel@localhost.localdomain> <Pine.GSO.4.44.0310211814340.14473-100000@ares.mmc.atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VC+1dD9mx8z5dlPH"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310211814340.14473-100000@ares.mmc.atmel.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--VC+1dD9mx8z5dlPH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-21 18:15:56 -0400, David Kesselring <dkesselr@mmc.atmel.com>
wrote in message <Pine.GSO.4.44.0310211814340.14473-100000@ares.mmc.atmel.c=
om>:
> That's what I did. I defined INSTALL_MOD_PATH as $(TOPDIR)/modules. The
> modules get put there but depmod fails.

depmod works on it's own architecture and I don't recall a way that
would make it work on cross-compiled modules. Maybe you should just copy
over the modules (INSTALL_MOD_PATH is a good start here) and execute
depmod on the target system...

Apart from that, insmod (instead of modprobe) should always work,
though...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--VC+1dD9mx8z5dlPH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lipcHb1edYOZ4bsRAul4AJwOqa6JI+ZKcLzgE3pFQqyqGXlGzwCfdn55
/qo86ST6py2ySZLLc2TdxTw=
=ydTk
-----END PGP SIGNATURE-----

--VC+1dD9mx8z5dlPH--
