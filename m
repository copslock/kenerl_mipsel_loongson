Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Oct 2009 14:54:37 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37286 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492284AbZJBMyb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Oct 2009 14:54:31 +0200
Received: from [2001:6f8:1178:2:221:70ff:fe71:1890] (helo=pengutronix.de)
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <w.sang@pengutronix.de>)
	id 1MtheR-0005lB-Hc; Fri, 02 Oct 2009 14:54:23 +0200
Date:	Fri, 2 Oct 2009 14:54:23 +0200
From:	Wolfram Sang <w.sang@pengutronix.de>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	linux-pcmcia <linux-pcmcia@lists.infradead.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] Alchemy: XXS1500 PCMCIA driver rewrite
Message-ID: <20091002125423.GD3179@pengutronix.de>
References: <1254250236-18130-1-git-send-email-manuel.lauss@gmail.com> <20091002105903.GC3179@pengutronix.de> <f861ec6f0910020415j5125295fn6b5dff7db4bf170e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <f861ec6f0910020415j5125295fn6b5dff7db4bf170e@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:221:70ff:fe71:1890
X-SA-Exim-Mail-From: w.sang@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <w.sang@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> Rewritten XXS1500 PCMCIA socket driver, standalone (doesn't
> >> depend on au1000_generic.c) and added carddetect IRQ support.
> >
> > I am not familiar with the details here. Why did you choose to drop the=
 generic
> > au1000-part for this and the other driver?
>=20
> I want to get rid of au1000_generic.[ch] eventually or at least all of its
> contents except the static mapping and resource allocation functions, whi=
ch
> are board- independent.  On the other hand these are so short that I opte=
d to
> just duplicate them into the xxs1500_ss.c and db1xxx_ss.c (other patch)
> files.  The db1xxx_ss (for the Alchemy demoboards) is supposed to be an
> example on how to set up PCMCIA on Alchemy SoCs.

Yeah, I saw that you want to remove it, still I don't know why :) Is it fea=
ture
incomplete and updating is impossible? Is the concept outdated? Could you
enlighten me on that?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrF9/8ACgkQD27XaX1/VRurwQCfQAr6lgI3A9GAKmatR/nhjVRz
rkEAoIoEwntfjG6YcwP4JKjdi+V/XKI8
=qhq4
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
