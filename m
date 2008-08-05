Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 17:39:23 +0100 (BST)
Received: from chilli.pcug.org.au ([203.10.76.44]:26781 "EHLO smtps.tip.net.au")
	by ftp.linux-mips.org with ESMTP id S20022440AbYHEQjQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2008 17:39:16 +0100
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 849FE368003;
	Wed,  6 Aug 2008 02:39:11 +1000 (EST)
Date:	Wed, 6 Aug 2008 02:39:06 +1000
From:	Stephen Rothwell <sfr@canb.auug.org.au>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Adrian Bunk <bunk@kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: v4l/mips build problem
Message-Id: <20080806023906.c2f919b4.sfr@canb.auug.org.au>
In-Reply-To: <20080805092650.af88364a.akpm@linux-foundation.org>
References: <20080806012357.55625daf.sfr@canb.auug.org.au>
	<20080805154122.GC22895@cs181140183.pp.htv.fi>
	<20080806020647.2cf11a2b.sfr@canb.auug.org.au>
	<20080805092650.af88364a.akpm@linux-foundation.org>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__6_Aug_2008_02_39_06_+1000_M_RXau64tb.9uS=6"
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
Precedence: bulk
X-list: linux-mips

--Signature=_Wed__6_Aug_2008_02_39_06_+1000_M_RXau64tb.9uS=6
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, 5 Aug 2008 09:26:50 -0700 Andrew Morton <akpm@linux-foundation.org>=
 wrote:
>
> yup, I'll send it in unless it turned up in today's linux-next.

Which I think is unlikely:  the v4l/dvb tree has been unmergable since
29/7 and I haven't heard from Mauro since then.

Thanks.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Aug_2008_02_39_06_+1000_M_RXau64tb.9uS=6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiYgioACgkQjjKRsyhoI8yIwgCgutmaaba2Ti6yX3YpGXHvuIYY
MccAoJz1MWwR6EXHcnjGVClR49Ln2aZL
=Lz21
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Aug_2008_02_39_06_+1000_M_RXau64tb.9uS=6--
