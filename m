Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2004 03:54:27 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:25484
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8224947AbULVDyU>; Wed, 22 Dec 2004 03:54:20 +0000
Received: from gren.infostations.net (gren.infostations.net [71.4.40.32])
	by mail-relay.infostations.net (Postfix) with ESMTP id AA8E0F83D5;
	Wed, 22 Dec 2004 03:53:37 +0000 (Local time zone must be set--see zic manual page)
Received: from host-69-19-151-19.rev.o1.com ([69.19.151.19])
	by gren.infostations.net with esmtp (Exim 4.42 #1 (Gentoo))
	id 1CgxbQ-0005C0-Qw; Tue, 21 Dec 2004 19:55:59 -0800
Subject: Re: Problems with PCMCIA on AMD dbau1100
From: Josh Green <jgreen@users.sourceforge.net>
To: Eric DeVolder <eric.devolder@amd.com>
Cc: Pete Popov <ppopov@embeddedalley.com>, linux-mips@linux-mips.org
In-Reply-To: <41C8B1B3.9080201@amd.com>
References: <1103628665.22113.16.camel@SillyPuddy.localdomain>
	 <41C8536E.5060507@embeddedalley.com>
	 <1103671370.30276.8.camel@SillyPuddy.localdomain>
	 <41C8B1B3.9080201@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-F9doOXMwJAsq4pZAtmIC"
Date: Tue, 21 Dec 2004 19:53:47 -0800
Message-Id: <1103687627.12558.11.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-F9doOXMwJAsq4pZAtmIC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-12-21 at 17:28 -0600, Eric DeVolder wrote:
> cardbus isn't supported....and i'm not sure if the pcmcia slots are
> even electrically compatible (meaning i hope your card/db1100 isn't
> damaged).
>=20

Ahh, thanks for that bit of insight.  I wasn't aware that 32 bit cardbus
was not supported.  I have a compact flash to PCMCIA adapter which I
have a 128MB compact flash card installed in, it was detected fine (no
damage seems to have occurred with either the card or au1100 PCMCIA
slots).  That solves that problem.

At first I was rather disappointed when I read this reply, but then I
looked up the wireless card I want to use (Senao NL-2511 Plus EXT2, a
Prism 2.5 based card) and it is PCMCIA Type II 16-bit which I suppose
should work using the hostap driver.

Thanks again for pointing this out!  Cheers.
	Josh Green


--=-F9doOXMwJAsq4pZAtmIC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD4DBQBByO/KRoMuWKCcbgQRAowsAKCdIt2Gl42U7DD1rrP/uiica6+SmwCXZ1NU
82JPc46+FbpKwTvceLZnVw==
=v8Qj
-----END PGP SIGNATURE-----

--=-F9doOXMwJAsq4pZAtmIC--
