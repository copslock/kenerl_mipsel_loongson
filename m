Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2013 15:08:58 +0100 (CET)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:53557 "EHLO
        cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867282Ab3LDOIzwm5vy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Dec 2013 15:08:55 +0100
Received: from cpc11-sgyl31-2-0-cust68.sgyl.cable.virginm.net ([94.175.92.69] helo=debutante.sirena.org.uk)
        by cassiel.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1VoD8H-00040S-Os; Wed, 04 Dec 2013 14:08:55 +0000
Received: from broonie by debutante.sirena.org.uk with local (Exim 4.82)
        (envelope-from <broonie@sirena.org.uk>)
        id 1VoD8H-0007Jh-76; Wed, 04 Dec 2013 14:08:53 +0000
Date:   Wed, 4 Dec 2013 14:08:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-spi@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>
Message-ID: <20131204140853.GU29268@sirena.org.uk>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
 <1385811726-6746-6-git-send-email-jogo@openwrt.org>
 <20131204133823.GS29268@sirena.org.uk>
 <CAOiHx==utbmYUS4BLoSaaGi91Kw5voQ2vFiA97GLmwn8yU19Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Nx8xdmI2KD3LNVVP"
Content-Disposition: inline
In-Reply-To: <CAOiHx==utbmYUS4BLoSaaGi91Kw5voQ2vFiA97GLmwn8yU19Dw@mail.gmail.com>
X-Cookie: It's clever, but is it art?
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 94.175.92.69
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 5/5] spi: add bcm63xx HSSPI driver
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on cassiel.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38637
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


--Nx8xdmI2KD3LNVVP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 03:04:48PM +0100, Jonas Gorski wrote:
> On Wed, Dec 4, 2013 at 2:38 PM, Mark Brown <broonie@kernel.org> wrote:

> > This ought to be disable_unprepare().  It would also be better to move
> > this to runtime PM (you can set auto_runtime_pm to have the core manage
> > the enable and disable for you) since that will save a bit of power.

> I already set auto_runtime_pm to true. I basically copied what's
> currently in spi-bcm63xx.c *coughs*. Is there anything else needed
> besides what you mentioned?

You'll need to call pm_runtime_enable() and so on to turn on runtime PM
in probe() and reverse that in remove() but otherwise no, just adding
the runtime callbacks should be fine.

--Nx8xdmI2KD3LNVVP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnzdxAAoJELSic+t+oim9HHUP/R4Et3NLLUEWaC6wSjLjwXtB
ZTEGcgHZ5qsIcpgFhI95vPiZex/sHQ1+tse7UNgQ1c8R+x7nF0NwZIjj3vlkXPtl
2wF3jXErw3kBpLfp3mbUzxIel7hRpOb+tPyojlxWMQrULL+mfrO23cdafCLf5mD7
E9NuHDZy58k7xlKyJv1iAX8Yb8Ka/7gvhxBg4oEshuMj68ij7t5F1QdvBY+MXcZq
bqCSrId+OdTDNFo8dbJp+Ul9ViDVOsRpDmNC3N+OJWhAZXyvas/82Jeo9jyefuqn
WZX8V2Mbwg6GyzKvvLpoq5/BRQ2D6YVDQvTuDQBhLzo5Z+cniBvMb4y/qyaG7oz1
gzfcafEZRTqiHQg6/2mYcwn/hXmoLsQ6Vcp+M3AzzUIQEby4n096V21OuNC/hvX2
z0obJyYGXyWDwY6cmqHFRNFoZoggcSeLDL/MHoV2yWf3R8xyHZD7dJU+SEZzTHtq
G62UfxLCWyLBTystXKkMPpVDwcW3TeDV3LLrkuPelkwY+zJoyQ1d93YgaXFzbbGV
xqm2FEOGxBEuJafVAr3Ecajin2ECShO++dmuezf7nUBq4CZi0xVzOzOiowrru+hn
4uv6AloQY8p19X6lbX8yjfIUd0JRyEjDgK1SrTqBZXdKMyvGTOGCoO41nmdHykm+
OcBssvzaoPelLPWjWDQw
=sJcT
-----END PGP SIGNATURE-----

--Nx8xdmI2KD3LNVVP--
