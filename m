Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 12:10:54 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33584 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010687AbcA0LKvfAREM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 12:10:51 +0100
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1aONzg-0006wo-W3; Wed, 27 Jan 2016 11:10:37 +0000
Received: from broonie by debutante with local (Exim 4.86)
        (envelope-from <broonie@sirena.org.uk>)
        id 1aONzd-0003a4-Nu; Wed, 27 Jan 2016 11:10:33 +0000
Date:   Wed, 27 Jan 2016 11:10:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Simon Arlott <simon@fire.lp0.eu>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20160127111033.GI6042@sirena.org.uk>
Mail-Followup-To: Jonas Gorski <jogo@openwrt.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Simon Arlott <simon@fire.lp0.eu>, Arnd Bergmann <arnd@arndb.de>
References: <1453848410-24949-1-git-send-email-broonie@kernel.org>
 <1453848410-24949-2-git-send-email-broonie@kernel.org>
 <56A7FE3F.5090909@gmail.com>
 <CAOiHx=kk06ythGn=a3UGs-BBUUYxdm7zLsNtBFiCiwxF5m6VxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline
In-Reply-To: <CAOiHx=kk06ythGn=a3UGs-BBUUYxdm7zLsNtBFiCiwxF5m6VxA@mail.gmail.com>
X-Cookie: Brain fried -- Core dumped
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH RFC 2/2] MIPS: dt: Explicitly specify native endian
 behaviour for syscon
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51472
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


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 27, 2016 at 11:33:37AM +0100, Jonas Gorski wrote:

> > -                       little-endian;
> > +                       native-endian;

> But native-endian == big-endian usually for bcm63xx, so is this
> actually a bugfix?

Yes, it's buggy - in v4.5-rc1 we respect the endianness so big endian
just won't work, prior to that this was a hack around another bug which
was done rather than reporting it so it "just" results in a DT that's
obviously incorrect.  This local hack has been causing a lot of
problems.

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqKWoAAoJECTWi3JdVIfQItwH/i09FZw6qyDER7R2OC7Lc2Az
kUHwoVfaUIMBe7YYZWh/TKz8TWTQRITgZEV9I1kNlqedQ/uQ6w1+dXQZesOcILst
gWJgbrcnmMYuOW5TN7VsQGVRwtrTZWRaPWjBOAu5l58duXQuqIEyQocK4xHcI1HV
YaAd3kdpz+pT7A8ryliaI+MJApA7EJzZ6f8g32RTrFWAG27f757wenzKiKIxBnG8
QnA2e7HLUxT2shOupXaRygf+f2dnarGXIa8kzRp6DaGC+liDxI1KwCHeJ8joQAkh
wO7o+QpGRLI72TkkjZq2F3ajY+1CTJqueJjrk26YzSdZFkaxisr+jV1VZcxoqBE=
=M5e+
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
