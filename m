Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Feb 2005 06:05:37 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:30391
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8224953AbVBVGFV>; Tue, 22 Feb 2005 06:05:21 +0000
Received: from seriyu.infostations.net (seriyu.infostations.net [71.4.40.35])
	by mail-relay.infostations.net (Postfix) with ESMTP id E5DC79F842;
	Mon, 21 Feb 2005 22:05:21 -0800 (PST)
Received: from host-66-81-130-156.rev.o1.com ([66.81.130.156])
	by seriyu.infostations.net with esmtp (Exim 4.41 #1)
	id 1D3TAb-0007HC-Pi; Mon, 21 Feb 2005 22:05:18 -0800
Subject: Re: Fixes to MTD flash driver on AMD Alchemy db1100 board
From:	Josh Green <jgreen@users.sourceforge.net>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1109030275.13988.21.camel@SillyPuddy.localdomain>
References: <1108962105.6611.24.camel@SillyPuddy.localdomain>
	 <200502211144.58470.eckhardt@satorlaser.com>
	 <1109030275.13988.21.camel@SillyPuddy.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kF94/OSAb9oDK4NZfMbc"
Date:	Mon, 21 Feb 2005 22:06:52 -0800
Message-Id: <1109052412.20045.6.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-kF94/OSAb9oDK4NZfMbc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-02-21 at 15:57 -0800, Josh Green wrote:
>=20
> I've also got jffs2 working on the User FS partition, but I get a whole
> bunch of errors when it boots (regardless it still seems to function).
> I'll post these in another thread if I can't get it resolved.
>=20

Just to complete this thread, I did figure out what my trouble was.  I
erroneously thought that I didn't need the mtd0-3 dev support, but I
ended up needing it for the flash_erase (sometimes called just "erase")
command, which was what I had to run before my jffs2 errors went away.
Things seem to be working fine now :)  Make sure to erase the partition
using the correct count, I had to do:

flash_erase /dev/mtd0 0 0xe0

The first parameter is the offset, the second is the number of "erase
size" blocks to erase (likely different for your case).  This can be
found from your total flash size divided by the erase size
(cat /proc/mtd for this info).  Gee, funny how things work when you do
it right :)  I must say documentation is lacking for the mtd tools
though, I had to look at the code, sheesh, ha ha.  Cheers.
	Josh Green


--=-kF94/OSAb9oDK4NZfMbc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCGsv8RoMuWKCcbgQRAuHDAJ9GOOCDN6mIenwDcgRorf9GLaoGRQCgldeA
dXMKnAlEJAJTXJnrUfTkMNE=
=vdxD
-----END PGP SIGNATURE-----

--=-kF94/OSAb9oDK4NZfMbc--
