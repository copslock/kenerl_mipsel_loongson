Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2013 15:35:55 +0100 (CET)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:55319 "EHLO
        cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815989Ab3LDOfxIBecW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Dec 2013 15:35:53 +0100
Received: from cpc11-sgyl31-2-0-cust68.sgyl.cable.virginm.net ([94.175.92.69] helo=debutante.sirena.org.uk)
        by cassiel.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1VoDYD-0004HG-2m; Wed, 04 Dec 2013 14:35:42 +0000
Received: from broonie by debutante.sirena.org.uk with local (Exim 4.82)
        (envelope-from <broonie@sirena.org.uk>)
        id 1VoDYC-0002CE-Jc; Wed, 04 Dec 2013 14:35:40 +0000
Date:   Wed, 4 Dec 2013 14:35:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-spi@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>
Message-ID: <20131204143540.GX29268@sirena.org.uk>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
 <1385811726-6746-6-git-send-email-jogo@openwrt.org>
 <20131204133823.GS29268@sirena.org.uk>
 <CAOiHx==utbmYUS4BLoSaaGi91Kw5voQ2vFiA97GLmwn8yU19Dw@mail.gmail.com>
 <20131204140853.GU29268@sirena.org.uk>
 <CAOiHx==Lp7FFCCWaSiohvdAyzErBuz5n7sUVs1+A4S1axD9qCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6B5oiwbC31sfIr4n"
Content-Disposition: inline
In-Reply-To: <CAOiHx==Lp7FFCCWaSiohvdAyzErBuz5n7sUVs1+A4S1axD9qCA@mail.gmail.com>
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
X-archive-position: 38639
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


--6B5oiwbC31sfIr4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 03:28:25PM +0100, Jonas Gorski wrote:
> On Wed, Dec 4, 2013 at 3:08 PM, Mark Brown <broonie@kernel.org> wrote:

> > You'll need to call pm_runtime_enable() and so on to turn on runtime PM
> > in probe() and reverse that in remove() but otherwise no, just adding
> > the runtime callbacks should be fine.

> I see. Looks like I just copied your oversight from
> 5355d96d6fb56507761f261a23c0831f67fa0e0f ("spi/bcm63xx: Convert to
> core runtime PM") :P I'll add that to my list of things to fix.

The driver was already broken there - the requirement to enable runtime
PM is a part of the core runtime PM API.  All that change did was factor
out the enable and disable calls.

> Grepping through drivers/spi, I see a few drivers not calling
> pm_runtime_enable(), but setting auto_runtime_pm to true, and a few
> doing the opposite. These should probably aligned, too.

Not using the core runtime PM is fine, there may be reasons the driver
wants to do this by hand.  Things not enabling runtime PM are definitely
buggy though.

--6B5oiwbC31sfIr4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnz25AAoJELSic+t+oim9e+EQAIRuEYdZlzhj3sQ0P6ZkN4DA
8F6QyGXOPXsLv17eD3tw5GEEtSLL3nDqZW6mIHrNLLk8Au5mrk0DoNzlH3nU+HPG
OT7VjFTwkibN70XANLxheXjF0bgFWf4j9lX2Mm5Yuil6EYqfy8ergfndO7dU+/4Q
GXolvEQBoBrwarzwrVSf5VC10WJ5HfhvqmaWh4aHFA2oWZm0WqtUy03SNpghSH6d
ee3jswIMD+0Yvyj7mtx/lqAo9fynmw2b0hlhEj2gwOOYTqL0N6bR/p7lSRyZYvWX
IztrHZ1bxcfq3RRbEW5G/MhTmWFwOtQTCpaLwtuIWHOcPClQIvZlORiBbi7FwfHP
eWOSYBrSmlvctJbU41EXYdgUOPye81Unxw7cdzHjroUHHx+apGjYeGPtasVIMcw1
JyUeAWe9yNl8P54XmFYcIDWvoviEwE7CpFy5NgzrNx827eLA2oBI/vcVz7OhAE1S
jQVtlGDhUjlC2pxYDRoeuJ/j9fJl8Uc+OTsdkpvqOyPw9uL9M9+u+11nEYUsrLTe
2OIQYySwUoFwT+CwiPjBROdhjjvh6GkQKJNpairKBkxBP5DcvzbvDVM2fwABvhRY
/yfRTKbUsfVAsjMo3EtH7IHhg2IwO7CykR63G0QUosmzI9IbYkxUa1GX38uXsURS
OIS18va8vmTpya9Vd4DT
=ZQMj
-----END PGP SIGNATURE-----

--6B5oiwbC31sfIr4n--
