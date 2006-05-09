Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 01:29:19 +0200 (CEST)
Received: from godel.catalyst.net.nz ([202.78.240.40]:52947 "EHLO
	mail1.catalyst.net.nz") by ftp.linux-mips.org with ESMTP
	id S8133882AbWEIX3L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 May 2006 01:29:11 +0200
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=pkunk.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtps (SSL 3.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50)
	id 1Fdbdc-0004z0-IJ
	for linux-mips@linux-mips.org; Wed, 10 May 2006 11:29:08 +1200
Subject: Re: "Badness in local_bh_enable at kernel/softirq.c:140" - sgiseeq
	and conntrack?
From:	Sam Cannell <sam@catalyst.net.nz>
To:	linux-mips@linux-mips.org
In-Reply-To: <1147217122.20432.14.camel@pkunk.wgtn.cat-it.co.nz>
References: <1147217122.20432.14.camel@pkunk.wgtn.cat-it.co.nz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8x+rN4crMdDDZTOsQsq1"
Date:	Wed, 10 May 2006 11:29:07 +1200
Message-Id: <1147217347.20432.17.camel@pkunk.wgtn.cat-it.co.nz>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Return-Path: <sam@catalyst.net.nz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@catalyst.net.nz
Precedence: bulk
X-list: linux-mips


--=-8x+rN4crMdDDZTOsQsq1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Sorry .. should have said - I'm running 2.6.16.11.

On Wed, 2006-05-10 at 11:25 +1200, Sam Cannell wrote:
> [4294795.111000] Badness in local_bh_enable at kernel/softirq.c:140
> [4294795.111000] Call Trace:
> [4294795.111000]  [<8802cfdc>] local_bh_enable+0x78/0xa0
> [4294795.111000]  [<c007a70c>] destroy_conntrack+0xdc/0x178
> [ip_conntrack]

--=-8x+rN4crMdDDZTOsQsq1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEYSXDzjWM3BBT1QARAmr1AJ4jlPRuKyFQPOj6jTmwYLlT25drlQCaA1SJ
VyrTGpLIQeYqielzRvSVu/s=
=EQqU
-----END PGP SIGNATURE-----

--=-8x+rN4crMdDDZTOsQsq1--
