Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2008 21:53:09 +0100 (BST)
Received: from server.drzeus.cx ([85.8.24.28]:56497 "EHLO smtp.drzeus.cx")
	by ftp.linux-mips.org with ESMTP id S28577396AbYHFUxB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Aug 2008 21:53:01 +0100
Received: from mjolnir.drzeus.cx (gateway.teknikservice.nu [::ffff:213.134.106.48])
  (AUTH: LOGIN drzeus, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by smtp.drzeus.cx with esmtp; Wed, 06 Aug 2008 22:52:45 +0200
  id 0000000000130003.00000000489A0F1E.000058A8
Date:	Wed, 6 Aug 2008 22:52:29 +0200
From:	Pierre Ossman <drzeus@drzeus.cx>
To:	"Kevin Hickey" <khickey@rmicorp.com>
Cc:	"Manuel Lauss" <mano@roarinelk.homelinux.net>,
	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH v2] au1xmmc: raise segment size limit.
Message-ID: <20080806225229.7914d736@mjolnir.drzeus.cx>
In-Reply-To: <1218052355.3808.4.camel@kh-ubuntu.razamicroelectronics.com>
References: <20080729081049.GB3908@roarinelk.homelinux.net>
	<1218052355.3808.4.camel@kh-ubuntu.razamicroelectronics.com>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.13.5; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-22696-1218055969-0001-2"
Return-Path: <drzeus@drzeus.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drzeus@drzeus.cx
Precedence: bulk
X-list: linux-mips

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-22696-1218055969-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Aug 2008 12:52:35 -0700
"Kevin Hickey" <khickey@rmicorp.com> wrote:

> On Tue, 2008-07-29 at 10:10 +0200, Manuel Lauss wrote:
> > ---=20
> >=20
> > Raise the DMA block size limit from 2048 bytes to the maximum supported
> > by the DMA controllers on the chip (64KB on Au1100, 4MB on Au1200).
> >=20
> > This gives a very small performance boost and apparently fixes an oops
> > when MMC-DMA and network traffic are active at the same time.
> >=20
> > Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> I tested this in conjunction with "Alchemy: register platform device for
> db1200..." successfully.
>=20
> Acked-by: Kevin Hickey <khickey@rmicorp.com>

You're about a week too late ;)

--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-22696-1218055969-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkiaDxAACgkQ7b8eESbyJLj2iwCgky1fYPgGVlFjn5Wiv3sGJxZF
J74AnjHo4SjnoQynD1MHQ3bVYgxv6SZq
=+HL8
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-22696-1218055969-0001-2--
