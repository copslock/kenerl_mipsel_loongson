Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Feb 2005 05:50:09 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:50074
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8224898AbVBBFtx>; Wed, 2 Feb 2005 05:49:53 +0000
Received: from iria.infostations.net (iria.infostations.net [71.4.40.31])
	by mail-relay.infostations.net (Postfix) with ESMTP id 0EC8C9F77E;
	Tue,  1 Feb 2005 21:50:12 -0800 (PST)
Received: from host-69-19-168-166.rev.o1.com ([69.19.168.166])
	by iria.infostations.net with esmtp (Exim 4.41 #1 (Gentoo))
	id 1CwDPF-0006mh-QS; Tue, 01 Feb 2005 21:50:26 -0800
Subject: Re: Problems with PCMCIA on AMD Alchemy DB1100
From:	Josh Green <jgreen@users.sourceforge.net>
To:	"Robin H. Johnson" <robbat2@orbis-terrarum.net>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050202011614.GA31554@curie-int.orbis-terrarum.net>
References: <1107304567.2912.34.camel@SillyPuddy.localdomain>
	 <20050202011614.GA31554@curie-int.orbis-terrarum.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SoQEV7hAIIjw4NVgkwlH"
Date:	Tue, 01 Feb 2005 21:50:35 -0800
Message-Id: <1107323435.15057.4.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-SoQEV7hAIIjw4NVgkwlH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-02-01 at 17:16 -0800, Robin H. Johnson wrote:

<cut>

> For your ksymoops, i find it very useful to build my host binutils (not
> the cross-compiler chain) with '--enable-targets=3Dall' as then it's
> possible to use your regular ksymoops (as of 2.4.10, see the INSTALL
> document for more details, I wrote up 'Building ksymoops for
> cross-debugging only' section ;-) without having to jump thru hoops for
> a cross-ksymoops.
>=20

Thanks for the tip on ksymoops, I'll give that a shot.  I'm also using
gentoo, for my host system, would be nice if there was a USE flag to
enable all targets :)  Cheers.
	Josh Green


--=-SoQEV7hAIIjw4NVgkwlH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCAGoqRoMuWKCcbgQRAp3YAKChpww4FTJVjKhXQA8JuhaXpe5KeACglNsx
xCiJKkSppQaX3C/BKsX0Vsk=
=rz6A
-----END PGP SIGNATURE-----

--=-SoQEV7hAIIjw4NVgkwlH--
