Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 14:43:28 +0100 (BST)
Received: from server.drzeus.cx ([85.8.24.28]:11167 "EHLO smtp.drzeus.cx")
	by ftp.linux-mips.org with ESMTP id S28578785AbYFLNnZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2008 14:43:25 +0100
Received: from mjolnir.drzeus.cx (alcatraz.cendio.se [::ffff:193.12.253.67])
  (AUTH: LOGIN drzeus, TLS: TLS 1.0,256bits,RSA_AES_256_CBC_SHA1)
  by smtp.drzeus.cx with esmtp; Thu, 12 Jun 2008 15:36:47 +0200
  id 0000000000120042.000000004851266F.00004B32
Date:	Thu, 12 Jun 2008 15:42:48 +0200
From:	Pierre Ossman <drzeus@drzeus.cx>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] Alchemy: register mmc platform device for
 db1200/pb1200 boards.
Message-ID: <20080612154248.5c9c5c9d@mjolnir.drzeus.cx>
In-Reply-To: <20080612122646.GA9493@linux-mips.org>
References: <20080609063521.GA8724@roarinelk.homelinux.net>
	<20080609063702.GC8724@roarinelk.homelinux.net>
	<20080612090206.GB21601@linux-mips.org>
	<20080612101839.GC21601@linux-mips.org>
	<20080612121828.GA24603@roarinelk.homelinux.net>
	<20080612122646.GA9493@linux-mips.org>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.13.2; i386-redhat-linux-gnu)
Face:	iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAMAAABg3Am1AAAAAXNSR0IArs4c6QAAADNQTFRFEgwFRSofeTwxZEI1h1lFl1ZHeGBetHZk24VzuZJ43p2GsbKw/Lmg2MTL/NO3/+/Q//fpWFujUwAAAk5JREFUSMeNlVcWnDAMRd0bLux/tVGxiAEzic7hZ+Zd1IU6NtbYdn8daic/cgj52CPqLQ8hOBdjzsD8G2hHsCiPBS2/nTyABi93zvsYUyql1v6KSz30AeUAJLAK1uuDUI94WA7GDsAePtRDfwFRgP7DA8vvwOgQ1R5oYQUKAwOsfwDHDcAcWH+e5xagiooey1SwSAy0L8C7BaDKdgKWoNQtIjYEfHQGzMcKwNgCpLdgBn14ZzXNSPkJWK201vjiHMkXZg7AuQWCA7G2DPTiMSIsLSZxbgEIwlqEjE+9WBu0yaWOHwDLLQE9WmMieCBgtG1IAFgBzo7tlojGtbI3wFljuU4JdL3ghPeO+tFr2QHG0DOBSuN0kofaU302zmKbcTrgAWDUywG0OvXELi6gZScAdq6WnhYgvYDGu0YQjYSZs3ROID0B4y+jjpWyAhjePWkAjKwD5o09xioNBoro/+YQZjzTg8ce1CJtwFvwAMDFBEjv6cgI0P/u0DqtGJOjNSAm4e0jABxsgDYXSADQw2wwsFyzdePCAviE48QexseKNiGcp4jgKNEVAGC7QEwY5+S6Qpf50NzujHrdYgEKH0o8ZJ/AQR8HAGiaugDjG2i4ddZx4wToPwB0gQsEfjyFRKf1M+kLQC8u5iuoX8BhxYCQJPZXQ7LQdDnQR87/BdCpQQSJpREh7EMSQOvpYwJaqbAHgrUXkWehxhmUUjpsQ+IDSHlzEvidywrtDYSpnHVioNbstBLi9o3Dn/WqZ3Nw1pUQy8bN3/QdiPiVUZfpP4cDVEKd2cXEAAAAAElFTkSuQmCC
X-Face:	@{|$W51qEixc&6}dq_38NM^&.vv|'{O)ae?DMZ1%VYxuhN2}5VpQ!'gx[{V+8Xw'+cV5*491_)-SU2YT8s@4`H;@:ELS'/P(@.JxxJi/C8mG0H#A^R<JfS_l?/%fD\D/mFJ8c2M?_kIL;:txa"s`0O*d+}p/4;$lAw@/e&h-nvQ)~q-a("De+&~-{5`:T{9d%0
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-19250-1213277807-0001-2"
Return-Path: <drzeus@drzeus.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drzeus@drzeus.cx
Precedence: bulk
X-list: linux-mips

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-19250-1213277807-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Jun 2008 13:26:46 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

>=20
> Pierre, feel free to merge these MIPS bits into your tree.  The whole
> series should probably go upstream together.
>=20

How's the dependency issue though? Will this series be bisectable in my
tree?

--=_freyr.drzeus.cx-19250-1213277807-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkhRJ90ACgkQ7b8eESbyJLhsOQCeLlzV3KAUtJqFXzPZTvhJZAqg
yVcAmgOzQvwKVDSyY3L0hGHN34OfVr1N
=6jRn
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-19250-1213277807-0001-2--
