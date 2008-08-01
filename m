Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2008 18:05:34 +0100 (BST)
Received: from server.drzeus.cx ([85.8.24.28]:43472 "EHLO smtp.drzeus.cx")
	by ftp.linux-mips.org with ESMTP id S28574505AbYHARFc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2008 18:05:32 +0100
Received: from mjolnir.drzeus.cx (wlan248.drzeus.cx [::ffff:10.8.2.248])
  (AUTH: LOGIN drzeus, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by smtp.drzeus.cx with esmtp; Fri, 01 Aug 2008 19:05:24 +0200
  id 0000000000130005.0000000048934254.0000471A
Date:	Fri, 1 Aug 2008 19:05:18 +0200
From:	Pierre Ossman <drzeus@drzeus.cx>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH v2] au1xmmc: raise segment size limit.
Message-ID: <20080801190518.4dbad293@mjolnir.drzeus.cx>
In-Reply-To: <20080729081049.GB3908@roarinelk.homelinux.net>
References: <20080729081049.GB3908@roarinelk.homelinux.net>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.13.5; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-18202-1217610324-0001-2"
Return-Path: <drzeus@drzeus.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drzeus@drzeus.cx
Precedence: bulk
X-list: linux-mips

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-18202-1217610324-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jul 2008 10:10:49 +0200
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> Hello Pierre,=20
>=20
> This is a new version of the previous patch with fixed commit text.
>=20
> Please apply this patch as it fixes an oops when MMC-DMA and network
> traffic are active at the same time;  this seems to be a 2.6.27-only bug
> as the current au1xmmc source work fine on 2.6.26.
>=20
> Thank you,
> 	Manuel Lauss
>=20
> ---=20

applied.

--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-18202-1217610324-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkiTQlEACgkQ7b8eESbyJLhXyQCdFqi6KRGUm8jsozy5jS1FO9XR
CIEAn3GOrSq+7zBWJVai+dECtLAwnVWw
=Gra0
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-18202-1217610324-0001-2--
