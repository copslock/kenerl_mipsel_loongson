Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jul 2013 11:07:15 +0200 (CEST)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:36757 "EHLO
        cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822674Ab3GaJHJooJm6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Jul 2013 11:07:09 +0200
Received: from cpc11-sgyl31-2-0-cust68.sgyl.cable.virginmedia.com ([94.175.92.69] helo=finisterre)
        by cassiel.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1V4SMy-0007O5-2G; Wed, 31 Jul 2013 10:06:57 +0100
Received: from broonie by finisterre with local (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1V4SMx-0007Ka-Iw; Wed, 31 Jul 2013 10:06:55 +0100
Date:   Wed, 31 Jul 2013 10:06:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        Manuel Lauss <manuel.lauss@gmail.com>,
        linux-mips@linux-mips.org
Message-ID: <20130731090655.GE9858@sirena.org.uk>
References: <20130731081519.GA18756@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FIYk/R+LCB1TX+kR"
Content-Disposition: inline
In-Reply-To: <20130731081519.GA18756@linux-mips.org>
X-Cookie: You will be awarded some great honor.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 94.175.92.69
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH] SOUND: au1x: Fix build
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on cassiel.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37406
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


--FIYk/R+LCB1TX+kR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2013 at 10:15:19AM +0200, Ralf Baechle wrote:
> d8b51c11ff5a70244753ba60abfd47088cf4dcd4 [ASoC: ac97c: Use
> module_platform_driver()] broke the build:

Applied.  Please do try to use subject lines appropriate for the
subsystem.

--FIYk/R+LCB1TX+kR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+NOsAAoJELSic+t+oim92FsP/0DWKlYmPmIs+JEDPqSkX4Mm
WUk1oPAiIpWjeOH/hIt22UWFmGWTTDojuLCrigpvfcchLiLet1GchnmylYWQg59Z
FVgLY/nO7VivXbiPfzoORgxC92fFHnlOn9yYjUtLwTO2ZhjhHDOC5UXQGHmb55lp
jOrtFFjq46pWIpyDGIX3fH6Of1H7lNOvUT/CHkXA5oX39oJkGM8JpNQz/H+JH+qc
4m6UTiEfk3s9D5Pp2VjpHV3YVTNLjMIxYrNy9jTUSPeyweQj97CFZdI6F+sd/ZGz
R4nV1vUMDf1bb4o7KPSYg/F3fcAo/2Jk+FYa+tiCI9T0KB0PVb/M4S+ADZWB78hE
Ap0SvKnEoolERoj2sZSvTROeEl2eRli8FJ4j9cqiCKx5RSpix4rziuuiL0OWl/Aj
dZQFYZXwho0zWl1ADJovfsgEappfANGEzLkTZXNbO30NkojnpC6v8/5wq58yqjQx
dfE1B7lB/dLW7M37qPhJKHg5NlbHhxJesvHq1iVViMUsw2d1CVs3TEQnlME/VdRf
2RMz3zc2CGYzpQ4sSImQ0W5n9gVv/BAlbaVUf8cIyru+RNYcno6+jrdWyPx39Z+I
2Il83YrtfaBHhODrfbbjKYTfLSFMhfdrBMt6DnbNGoCcEQsd5xcK52Zu12Lv6XGk
FWxgqUBmpkj9mFSuMMEr
=w5Dy
-----END PGP SIGNATURE-----

--FIYk/R+LCB1TX+kR--
