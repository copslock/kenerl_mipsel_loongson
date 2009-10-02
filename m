Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Oct 2009 12:59:16 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41007 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493080AbZJBK7K (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Oct 2009 12:59:10 +0200
Received: from [2001:6f8:1178:2:221:70ff:fe71:1890] (helo=pengutronix.de)
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <w.sang@pengutronix.de>)
	id 1Mtfqp-0006lE-VY; Fri, 02 Oct 2009 12:59:03 +0200
Date:	Fri, 2 Oct 2009 12:59:03 +0200
From:	Wolfram Sang <w.sang@pengutronix.de>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	linux-pcmcia <linux-pcmcia@lists.infradead.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] Alchemy: XXS1500 PCMCIA driver rewrite
Message-ID: <20091002105903.GC3179@pengutronix.de>
References: <1254250236-18130-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
In-Reply-To: <1254250236-18130-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:221:70ff:fe71:1890
X-SA-Exim-Mail-From: w.sang@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <w.sang@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Rewritten XXS1500 PCMCIA socket driver, standalone (doesn't
> depend on au1000_generic.c) and added carddetect IRQ support.

I am not familiar with the details here. Why did you choose to drop the gen=
eric
au1000-part for this and the other driver?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrF3PcACgkQD27XaX1/VRt2BwCeOFZsajeUyZLnB76UQcDN9hTc
6zYAni04Z9F1asrIMmaG9t/kXKtSDtIN
=aOhh
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
