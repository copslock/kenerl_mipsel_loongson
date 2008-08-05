Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 16:24:15 +0100 (BST)
Received: from chilli.pcug.org.au ([203.10.76.44]:11708 "EHLO smtps.tip.net.au")
	by ftp.linux-mips.org with ESMTP id S20021987AbYHEPYK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2008 16:24:10 +0100
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id A8A7436800E;
	Wed,  6 Aug 2008 01:24:03 +1000 (EST)
Date:	Wed, 6 Aug 2008 01:23:57 +1000
From:	Stephen Rothwell <sfr@canb.auug.org.au>
To:	Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:	LKML <linux-kernel@vger.kernel.org>,
	v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: v4l/mips build problem
Message-Id: <20080806012357.55625daf.sfr@canb.auug.org.au>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__6_Aug_2008_01_23_57_+1000_i2JVJ6yLmX47_gw6"
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
Precedence: bulk
X-list: linux-mips

--Signature=_Wed__6_Aug_2008_01_23_57_+1000_i2JVJ6yLmX47_gw6
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Linus' current tree gets the following error during a mips allmodconfig
build:

drivers/media/video/vino.c:4364: error: implicit declaration of function `v=
ideo_usercopy'

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Aug_2008_01_23_57_+1000_i2JVJ6yLmX47_gw6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEARECAAYFAkiYcI0ACgkQjjKRsyhoI8wamgCgkcSKgbNYkPosFeczVlj/wZ4I
GQsAl3J1/Z+woSBs6uTe8k2rPPfAD+0=
=HFni
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Aug_2008_01_23_57_+1000_i2JVJ6yLmX47_gw6--
