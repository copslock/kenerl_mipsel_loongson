Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 17:07:06 +0100 (BST)
Received: from chilli.pcug.org.au ([203.10.76.44]:11477 "EHLO smtps.tip.net.au")
	by ftp.linux-mips.org with ESMTP id S20022066AbYHEQG6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2008 17:06:58 +0100
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id CD2D7368003;
	Wed,  6 Aug 2008 02:06:52 +1000 (EST)
Date:	Wed, 6 Aug 2008 02:06:47 +1000
From:	Stephen Rothwell <sfr@canb.auug.org.au>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	Mauro Carvalho Chehab <mchehab@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: v4l/mips build problem
Message-Id: <20080806020647.2cf11a2b.sfr@canb.auug.org.au>
In-Reply-To: <20080805154122.GC22895@cs181140183.pp.htv.fi>
References: <20080806012357.55625daf.sfr@canb.auug.org.au>
	<20080805154122.GC22895@cs181140183.pp.htv.fi>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__6_Aug_2008_02_06_47_+1000_hXNUOzlXW0oxCw40"
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
Precedence: bulk
X-list: linux-mips

--Signature=_Wed__6_Aug_2008_02_06_47_+1000_hXNUOzlXW0oxCw40
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Aug 2008 18:41:22 +0300 Adrian Bunk <bunk@kernel.org> wrote:
>
> On Wed, Aug 06, 2008 at 01:23:57AM +1000, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Linus' current tree gets the following error during a mips allmodconfig
> > build:
> >=20
> > drivers/media/video/vino.c:4364: error: implicit declaration of functio=
n `video_usercopy'
>=20
> Andrew fixed it with drivers-media-video-vinoc-needs-v4l2-ioctlh.patch=20
> in -mm.

Maybe we should send that one Linusward ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Aug_2008_02_06_47_+1000_hXNUOzlXW0oxCw40
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiYepcACgkQjjKRsyhoI8wMRgCggFHLNyfoQrKrKjpkSIGfIEcX
F1oAoIERan3FacdwFgwxh5JPDSswWwkm
=olAO
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Aug_2008_02_06_47_+1000_hXNUOzlXW0oxCw40--
