Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Sep 2009 17:48:13 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47445 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493070AbZISPsG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 19 Sep 2009 17:48:06 +0200
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <wsa@pengutronix.de>)
	id 1Mp2AH-0004t9-Sf; Sat, 19 Sep 2009 17:47:57 +0200
Received: from wsa by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <wsa@pengutronix.de>)
	id 1Mp2AF-0002qa-99; Sat, 19 Sep 2009 17:47:55 +0200
Date:	Sat, 19 Sep 2009 17:47:55 +0200
From:	Wolfram Sang <w.sang@pengutronix.de>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org,
	linux-pcmcia@lists.infradead.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: BCM63xx: Add PCMCIA & Cardbus support.
Message-ID: <20090919154755.GA27704@pengutronix.de>
References: <1253272891.1627.284.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <1253272891.1627.284.camel@sakura.staff.proxad.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: wsa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <wsa@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, Maxime,

On Fri, Sep 18, 2009 at 01:21:31PM +0200, Maxime Bizon wrote:

> It seems Dominik is busy, and you're the one acking pcmcia patch at the
> moment so I'm sending this to you.

I can't make it for 2.6.32, but will try to get it queued for 2.6.33. What
about the second FIXME in the driver BTW?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkq0/SsACgkQD27XaX1/VRvkJACgkEHn15VkqwUJJWZb6oqgBp1+
QcQAn06yTBgPiL2LaXpME/Tard5ZSATG
=1cc6
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
