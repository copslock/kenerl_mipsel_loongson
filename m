Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 07:49:52 +0100 (BST)
Received: from pops.net-conex.com ([204.244.176.3]:36792 "EHLO
	mail.net-conex.com") by ftp.linux-mips.org with ESMTP
	id S8133525AbWEDGtm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 07:49:42 +0100
Received: from curie.orbis-terrarum.net (S01060050da688d47.vc.shawcable.net [24.80.100.253])
	by mail.net-conex.com (8.13.4/8.12.11) with ESMTP id k446ndC1017198
	for <linux-mips@linux-mips.org>; Wed, 3 May 2006 23:49:40 -0700
Received: (qmail 27368 invoked by uid 10000); 3 May 2006 23:49:45 -0700
Date:	Wed, 3 May 2006 23:49:45 -0700
From:	"Robin H. Johnson" <robbat2@gentoo.org>
To:	Herbert Valerio Riedel <hvr@gnu.org>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: RFC: au1000_etc.c phylib rewrite
Message-ID: <20060504064945.GE12203@curie-int.vc.shawcable.net>
Mail-Followup-To: Herbert Valerio Riedel <hvr@gnu.org>,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
References: <5.1.0.14.2.20060501144633.025e4e20@205.166.54.3> <1146510542.16643.10.camel@localhost.localdomain> <1146510542.16643.10.camel@localhost.localdomain> <5.1.0.14.2.20060501144633.025e4e20@205.166.54.3> <5.1.0.14.2.20060502095256.01fd4210@205.166.54.3> <1146674056.31241.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="maH1Gajj2nflutpK"
Content-Disposition: inline
In-Reply-To: <1146674056.31241.18.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Return-Path: <robbat2@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robbat2@gentoo.org
Precedence: bulk
X-list: linux-mips


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2006 at 06:34:16PM +0200, Herbert Valerio Riedel wrote:
> while at it, does anyone happen to know what the phy-addr/MAC assignment
> on the XXS1500 is?
Nope.

> but one thing that seems strange to me; CONFIG_BCM5222_DUAL_PHY doesn't
> seem to be defined anywhere; shouldn't that be at least defined in some
> Kconfig file, especially if the XXS1550 board is supposed to make use of
> it?=20
Hmm, I do recall submitting a patch previously that added=20
'select BCM5222_DUAL_PHY' for the XXS1500 unit.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFEWaQJPpIsIjIzwiwRAmnIAJwJWwob8g8a1FGR0B/lRFYpihXchACglqdK
Wgfl2lz8nmJvKy0KPPzPW6M=
=zwe8
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
