Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 May 2013 17:17:00 +0200 (CEST)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:58345 "EHLO
        cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827526Ab3EYPQ6fdfZh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 May 2013 17:16:58 +0200
Received: from dhcp107-18-111-72.hil-torhi.det.wayport.net ([107.18.111.72] helo=finisterre)
        by cassiel.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1UgGD8-0007Nl-JJ; Sat, 25 May 2013 16:16:50 +0100
Received: from broonie by finisterre with local (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1UgGD5-0007vc-NB; Sat, 25 May 2013 11:16:43 -0400
Date:   Sat, 25 May 2013 11:16:43 -0400
From:   Mark Brown <broonie@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Message-ID: <20130525151643.GI7660@sirena.org.uk>
References: <1369341387-19147-1-git-send-email-lars@metafoo.de>
 <1369341387-19147-6-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fmvA4kSBHQVZhkR6"
Content-Disposition: inline
In-Reply-To: <1369341387-19147-6-git-send-email-lars@metafoo.de>
X-Cookie: If you can read this, you're too close.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 107.18.111.72
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 5/6] ASoC: jz4740: Use the generic dmaengine PCM driver
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on cassiel.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36595
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


--fmvA4kSBHQVZhkR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 23, 2013 at 10:36:26PM +0200, Lars-Peter Clausen wrote:
> Since there is a dmaengine driver for the jz4740 DMA controller now we can use
> the generic dmaengine PCM driver instead of a custom one.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--fmvA4kSBHQVZhkR6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRoNXYAAoJELSic+t+oim9VGsP/RwD3GHud0wg1TAOTr4i0QN1
CRJuK0puIfPvHg6RIhjj6q6PJ5BIwPxL4Ci50vVPeJ6WVsgvXpdqFVV0omxhSEY0
zsXdLabYw8FlsnyHfCQ9GnPBqS4uvoghpYma5/8/HNLFc6JoDHKU6k+DaoHudq1q
8Agkl13iaC3Q3qWBb/k5a+fvb9IdPCxEhEtW51WydsNvr5LWZ6ENYTN2wSYg/Hbu
LUX3479GOUMJpAdIwvbsJ7/P43PoTqIF5iQL1MB/IupnUwCRMNoRAUwmW2tY2WzF
8eS5VQLB5S9qEuMpoUiH0NAXlrKqTtugPUU24EQRLuCUR1b7XyOq3FDsFO6aimq+
ge1VbeILlw8kAUzM/9avNULZf6HnfOckOzoqXcfJvetw6Wjwk0bbooTlAUYPSHk1
OdLHuxkAQMubaldN+msRANImpomGkPsmzkwHid07IWBB9BhBodG2H0agxEk/Y03W
1gvmPfpvGAnrR2xVYBf0An27DxkH+/7BGkqV5jFinOjDlEbolp/inVNS8c6Ifj1J
KwRkXZdlvifk71WyXAlW3eefUODYrnIaaN24dKzru9xKi4J/YfEY6oy23RtUVgIc
VFKx5rikxnz6Gf4ZqLlUeG0R7rSnDIvV8iuZfaWMDuiFdpwkgHEo5a1b8U1DeQzd
bY5n8pdykGomdZ+epJNt
=L8pi
-----END PGP SIGNATURE-----

--fmvA4kSBHQVZhkR6--
