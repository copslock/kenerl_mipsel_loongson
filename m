Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2008 22:40:40 +0100 (BST)
Received: from server.drzeus.cx ([85.8.24.28]:53377 "EHLO smtp.drzeus.cx")
	by ftp.linux-mips.org with ESMTP id S28576846AbYHFVkd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Aug 2008 22:40:33 +0100
Received: from mjolnir.drzeus.cx (gateway.teknikservice.nu [::ffff:213.134.106.48])
  (AUTH: LOGIN drzeus, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by smtp.drzeus.cx with esmtp; Wed, 06 Aug 2008 23:40:30 +0200
  id 0000000000130003.00000000489A1A4E.00005A50
Date:	Wed, 6 Aug 2008 23:40:23 +0200
From:	Pierre Ossman <drzeus@drzeus.cx>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH v2] au1xmmc: raise segment size limit.
Message-ID: <20080806234023.4394a790@mjolnir.drzeus.cx>
In-Reply-To: <1218056888.3808.10.camel@kh-ubuntu.razamicroelectronics.com>
References: <20080729081049.GB3908@roarinelk.homelinux.net>
	<1218052355.3808.4.camel@kh-ubuntu.razamicroelectronics.com>
	<20080806225229.7914d736@mjolnir.drzeus.cx>
	<1218056888.3808.10.camel@kh-ubuntu.razamicroelectronics.com>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.13.5; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-23120-1218058831-0001-2"
Return-Path: <drzeus@drzeus.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drzeus@drzeus.cx
Precedence: bulk
X-list: linux-mips

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-23120-1218058831-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 06 Aug 2008 16:08:08 -0500
Kevin Hickey <khickey@rmicorp.com> wrote:

> Has this been applied?  If so, where?  I don't see it in the LMO master
> tree... (though I have been known to experience temporary blindness...)
>=20

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=3De491d230fd398bb730e3c2dd734c5447463b9d38

--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-23120-1218058831-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkiaGksACgkQ7b8eESbyJLip5wCeNcmbbvECTQOBxfxUN/xeCdpU
wDcAoNricAP06Qv6xGUt890bBCnnHrH8
=fNDW
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-23120-1218058831-0001-2--
