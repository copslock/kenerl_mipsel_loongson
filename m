Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Oct 2004 19:32:27 +0100 (BST)
Received: from mailout10.sul.t-online.com ([IPv6:::ffff:194.25.134.21]:1669
	"EHLO mailout10.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225224AbUJWScW>; Sat, 23 Oct 2004 19:32:22 +0100
Received: from fwd03.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1CLQgQ-0006ts-04; Sat, 23 Oct 2004 20:32:06 +0200
Received: from null (TEXpKZZLoedBrbLOahbpMLCyiKWBywl47ro8tcctoolw3UJv4GUL4A@[217.81.124.185]) by fwd03.sul.t-online.com
	with esmtp id 1CLQgN-1WOiwa0; Sat, 23 Oct 2004 20:32:03 +0200
From: 520066427640-0001@t-online.de (Bruno Randolf)
To: ppopov@embeddedalley.com
Subject: Re: Hi-Speed USB controller and au1500
Date: Sat, 23 Oct 2004 20:25:50 +0200
User-Agent: KMail/1.7
Cc: linux-mips@linux-mips.org, 'Eric DeVolder' <eric.devolder@amd.com>
References: <20041023173352.90595.qmail@web81006.mail.yahoo.com>
In-Reply-To: <20041023173352.90595.qmail@web81006.mail.yahoo.com>
Organization: 4G Systems
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1126946.67eXT1MMeK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410232025.57107.bruno.randolf@4g-systems.biz>
X-ID: TEXpKZZLoedBrbLOahbpMLCyiKWBywl47ro8tcctoolw3UJv4GUL4A
X-TOI-MSGID: ea35307a-5d8a-4c13-8c0b-d378993e515e
Return-Path: <520066427640-0001@t-online.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: 520066427640-0001@t-online.de
Precedence: bulk
X-list: linux-mips

--nextPart1126946.67eXT1MMeK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 23 October 2004 19:33, Pete Popov wrote:
> > maybe not everything ist fixed in AD stepping... we
> > have observed that on our
> > Au1500 AD board the internal USB host only works
> > when we set CONFIG_NONCOHERENT_IO=3Dy.
>
> Is this with 2.4 or 2.6? I haven't changed the
> coherency defaults in 2.4.=20

this is with 2.4.24 and with 2.4.27
have not tried it with 2.6 yet.

> Which board do you have,=20
> Db1500?

we have custom boards, called "mtx-1", marketed as "meshcube" or "access cu=
be"

> Does usb storage work for you with NONCOHERENT_IO set?

yes, USB host works fine with CONFIG_NONCOHERENT_IO=3Dy

bruno

--nextPart1126946.67eXT1MMeK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBeqI1fg2jtUL97G4RAsd9AJ9aJaOXXIl9WAchAdfW+KVEb/mklQCbBkoY
ZGQCfF9+x4t8lVMsiKnaRk4=
=qqT6
-----END PGP SIGNATURE-----

--nextPart1126946.67eXT1MMeK--
