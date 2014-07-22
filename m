Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 19:00:18 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:42851 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842572AbaGVPMNM0QnY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 17:12:13 +0200
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1X9biz-0001gn-UA; Tue, 22 Jul 2014 15:11:40 +0000
Received: from broonie by debutante with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <broonie@sirena.org.uk>)
        id 1X9biv-0000lr-LN; Tue, 22 Jul 2014 16:11:25 +0100
Date:   Tue, 22 Jul 2014 16:11:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     abdoulaye berthe <berthe.ab@gmail.com>,
        "arm@kernel.org" <arm@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bryan Wu <cooloney@gmail.com>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Michael Buesch <m@bues.ch>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Message-ID: <20140722151125.GS17528@sirena.org.uk>
References: <CACRpkda6mzVdaN0cvOxpbsxWyCv2nGyDXOjZg_5aT8u7SSQeUw@mail.gmail.com>
 <1405197014-25225-1-git-send-email-berthe.ab@gmail.com>
 <1405197014-25225-4-git-send-email-berthe.ab@gmail.com>
 <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="11IAkegDWp8TRrA/"
Content-Disposition: inline
In-Reply-To: <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 3/3] driver:gpio remove all usage of gpio_remove retval
 in driver
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41463
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


--11IAkegDWp8TRrA/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 22, 2014 at 05:08:13PM +0200, Linus Walleij wrote:

> Heads up. Requesting ACKs for this patch or I'm atleast warning that it will be
> applied. We're getting rid of the return value from gpiochip_remove().

Can someone send the patch please?  Splitting it up per-subsystem would
probably be easier...

--11IAkegDWp8TRrA/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzn8aAAoJELSic+t+oim9qWYP/j2SOMQLkG2CavmmSFDKr57D
I8wsXXkl2SzMR1t1T8XQHH4/i1kTxROPWDX81ujrkwpEMcbMvQhM6Mewj+1BHgij
KGTeP2cMT97Oo0b6U2JRsumyLep0kVo/nheFLTUkD78Vp8abIyi1FuRdppKEjYts
Fu+jJIWQJEw/HKcmdZsTaeQawLXmJ4qOUVjB5+X/sspavG0Nji8JtSXN2MHyCr9j
t52GpALDSl4wctfIYg76S/TQxRCd150MKupuUhheMYsVtGfWjqay5fQWd9GACjhC
/74HdiFf1O6nSU2dwbGVntfmU+6CBmkD8XSI0PnyV/4GQR8zofnqzcsHrUXihkzd
TcgtL0CMizQ5kJPONMoZAFIoZwNHBTxmuFJgoUV2ChU/EyXTVsX9xLs6pgUtnd1E
Y7B23ErhwwTuXN0qG3Od6OIg2QhAMGKHzBA7HJgtSFVkvtXq1DdCZyYVfttUo+Xi
KcCZEnXPu/4Ore7cYhQmxqmoeC4Qm86iklGxLgW6jq7u5bRs9Y879NX3c6IZoJuO
6xIzE8ZtOdlMqpkBELCEZw8/1A9batmaMqEBRbtn4hTpyGouH4QUyypPy41kHC1H
uYEOJMmAwo51acA4PNGyNPxGclD+fHd+Y4GAfbjX+OoCFcyJIQ3e46F3BQlNs2bS
da/t3Z8Wx+xtFh0M1tdp
=XaZs
-----END PGP SIGNATURE-----

--11IAkegDWp8TRrA/--
