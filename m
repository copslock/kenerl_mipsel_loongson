Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2004 10:40:10 +0100 (BST)
Received: from hydra.gt.owl.de ([IPv6:::ffff:195.71.99.218]:47071 "EHLO
	hydra.gt.owl.de") by linux-mips.org with ESMTP id <S8224944AbUIXJkF>;
	Fri, 24 Sep 2004 10:40:05 +0100
Received: by hydra.gt.owl.de (Postfix, from userid 104)
	id 4DC811995B3; Fri, 24 Sep 2004 11:40:04 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 9237B138065; Fri, 24 Sep 2004 11:07:03 +0200 (CEST)
Date: Fri, 24 Sep 2004 11:07:03 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: "Stephen P. Becker" <geoman@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
Message-ID: <20040924090703.GA13468@paradigm.rfc822.org>
References: <4152D58B.608@longlandclan.hopto.org> <4152E4FC.8000408@gentoo.org> <41536765.9000304@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <41536765.9000304@longlandclan.hopto.org>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 24, 2004 at 10:16:37AM +1000, Stuart Longland wrote:
> Ahh yes... sorry, it was after midnight (GMT+10) and my mind must've
> been elsewhere -- I meant o64.  I was planning on moving to either n32
> or n64 userland eventually, but I won't do that unless I can get a
> 64-bit kernel going.

The 64 bit kernel should work so far - With the ip22zilog.c fixes
tsbogend just committed the console begins to work again.

Includeing the patch i sent earlier my R5k Indy boots fine a 64bit
current cvs head and goes into userspace.=20

Using the "soo to be" rtc and statfs64 fixes everything seems to be
fine for o32 userspace.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBU+O3Uaz2rXW+gJcRArAvAJ0ZciX9Ai+hOXdwMJVDVNf3arqx2gCcCJIM
9c2PaWIa6LJUuz1P2pAXfF0=
=J+yq
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
