Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Nov 2011 10:51:55 +0100 (CET)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36616 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903562Ab1KYJvv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Nov 2011 10:51:51 +0100
Received: from katana.hi.pengutronix.de ([2001:6f8:1178:2:221:70ff:fe71:1890] helo=pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.72)
        (envelope-from <w.sang@pengutronix.de>)
        id 1RTsRc-0002V2-Tq; Fri, 25 Nov 2011 10:51:44 +0100
Date:   Fri, 25 Nov 2011 10:51:44 +0100
From:   Wolfram Sang <w.sang@pengutronix.de>
To:     zhao zhang <zhzhl555@gmail.com>
Cc:     rtc-linux@googlegroups.com, a.zummo@towertech.it,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, keguang.zhang@gmail.com, wuzhangjin@gmail.com,
        r0bertz@gentoo.org
Subject: Re: [rtc-linux] [PATCH V1] MIPS: Add RTC support for loongson1B
Message-ID: <20111125095144.GC2535@pengutronix.de>
References: <1322189527-4761-1-git-send-email-zhzhl555@gmail.com>
 <20111125091311.GB2535@pengutronix.de>
 <CANY2MLJ6e02--f6D5yAK0Q6C57QGo5gqyBjWGmvCGhNr0XajJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <CANY2MLJ6e02--f6D5yAK0Q6C57QGo5gqyBjWGmvCGhNr0XajJQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:221:70ff:fe71:1890
X-SA-Exim-Mail-From: w.sang@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
X-archive-position: 31995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21318


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 25, 2011 at 05:49:04PM +0800, zhao zhang wrote:
>    I have checked carefully,
>    1:the au1xx used one register but loongon1B used two 32bit registers
>    (write0/write1 and read0/read1) to represent time.
>    2:the data organization are also different.=A0
>    so, it's hard to reuse.

Fair enough, thanks for checking.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7PZTAACgkQD27XaX1/VRvTuQCcC8O7fpDjulCrLAuvz5GBno22
QuEAoLnV4x0EZGQNA0XOAYIfy16IFnrf
=SRqo
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
