Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 17:05:48 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([IPv6:2400:8900::f03c:91ff:fedb:4f4]:54924
        "EHLO mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992568AbdHJPFlW7g0H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Aug 2017 17:05:41 +0200
Received: from host86-142-17-160.range86-142.btcentralplus.com ([86.142.17.160] helo=finisterre)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1dfp1U-0005cw-IS; Thu, 10 Aug 2017 15:05:23 +0000
Received: from broonie by finisterre with local (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1dfp1P-0000h8-QW; Thu, 10 Aug 2017 16:05:15 +0100
Date:   Thu, 10 Aug 2017 16:05:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Langer, Thomas" <thomas.langer@intel.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "john@phrozen.org" <john@phrozen.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "Mehrtens, Hauke" <hauke.mehrtens@intel.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Message-ID: <20170810150515.w66ksbfexbcegy6z@sirena.org.uk>
References: <20170808225247.32266-1-hauke@hauke-m.de>
 <20170808225247.32266-4-hauke@hauke-m.de>
 <20170809114421.oo2bunardgw3p4tk@sirena.org.uk>
 <0DAF21CFE1B20740AE23D6AF6E54843F1EA0A385@IRSMSX101.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s6uae5i4hoypg7dc"
Content-Disposition: inline
In-Reply-To: <0DAF21CFE1B20740AE23D6AF6E54843F1EA0A385@IRSMSX101.ger.corp.intel.com>
X-Cookie: Do you like "TENDER VITTLES"?
User-Agent: NeoMutt/20170609 (1.8.3)
X-SA-Exim-Connect-IP: 86.142.17.160
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH v9 03/16] mtd: spi-falcon: drop check of boot select
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: No (on mezzanine.sirena.org.uk); Unknown failure
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@kernel.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


--s6uae5i4hoypg7dc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 02:02:16PM +0000, Langer, Thomas wrote:
> > On Wed, Aug 09, 2017 at 12:52:34AM +0200, Hauke Mehrtens wrote:

> > > Do not check which flash type the SoC was booted from before
> > > using this driver. Assume that the device tree is correct and use this
> > > driver when it was added to device tree. This also removes a build
> > > dependency to the SoC code.

> > Why?  Is this assumption reliably true?

> Yes. We only have one type of flash interface in the device tree, as they=
=20
> are connected to the shared EBU (External Bus Unit).

That sounds board specific but this is a driver for a SoC?  In any case
this needs to end up in the commit log.

--s6uae5i4hoypg7dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmMdioACgkQJNaLcl1U
h9BYlAgAgCDu3huZzBs6oYvZZ+POaY/GV5Cs55enzpxuT8F87rnOrYbTGQw66HzP
+4Foc1xogiJOKDNSs+BpPiuFTo/zvwu+ApKkEE8OeaDOQh4gVhCag/OUKz9z5hAZ
ZvSHQud2xiO1FjFZeLFB1KGEA9jb9ltOjWdJxqdiv1S9mV4ITiVho//mhTNf6HcL
RMiKTeDmSz37Q3X1vgrnQehpTYgqUHYCzr/NjUjsJ3nATLZpr8bLbLhh4YKalxqj
Elnt3lXSauR4/LfcfwpSqRYfeMP/LhWAHMRRJpSMLqFVAyWgndZP9IXm9mP4fXia
R3yhSmQxzNY7qhWMoY1vQAfNsr4hwA==
=HdUK
-----END PGP SIGNATURE-----

--s6uae5i4hoypg7dc--
