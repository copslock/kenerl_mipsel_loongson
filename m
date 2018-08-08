Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2018 22:22:16 +0200 (CEST)
Received: from sauhun.de ([88.99.104.3]:59246 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994735AbeHHUWLwR9OD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Aug 2018 22:22:11 +0200
Received: from localhost (p54B334CC.dip0.t-ipconnect.de [84.179.52.204])
        by pokefinder.org (Postfix) with ESMTPSA id 562B16DC2E4;
        Wed,  8 Aug 2018 22:22:11 +0200 (CEST)
Date:   Wed, 8 Aug 2018 22:22:10 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v3 1/6] i2c: designware: use generic table matching
Message-ID: <20180808202210.qkocl4hckqla7exe@ninjato>
References: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
 <20180806185412.7210-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qebv7hyem3d6rgy2"
Content-Disposition: inline
In-Reply-To: <20180806185412.7210-2-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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


--qebv7hyem3d6rgy2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 06, 2018 at 08:54:07PM +0200, Alexandre Belloni wrote:
> Switch to device_get_match_data in probe to match the device specific data
> instead of using the acpi specific function.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Andy, you happy with this patch?


--qebv7hyem3d6rgy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltrUPIACgkQFA3kzBSg
KbaIaxAAglFXoMQYzEDtLC4xW5R2IY/3q0HtEncf4ExyKGuclwPtfaEN0ECDPC14
96nZJednR4FDHm25y5ThZtGyllbm4YNomkQzSJgoplSNCuMZdnEmAOC5+XJilbTH
oLwxhVrc/txYTAzRVbFgfCGReziyHPzBJjOw1jd8cmjFlTSjBwzS5FtzFYnVd+Fi
yddQjjAJsvj/WFa8KdQ41Nmq6mUYosldUFQYfQ4kXREj1Kk9f0cdsF0Re6fjkC9S
ZrFQI7zeooRVE+Tas5l9umdg0aIPJDdyVEKGLAGOU/HpyB4R5nvr3KHDvGaqqlAt
/SE3vTuf2s0fJdR28vjxkekwMSZawFlcQ8vOhUtDOWJUzJdsTRiXHkBRb6wOY+wx
dYLN1mWx6yq5TDnIYSf3JCi2m4uz8y/7q0P3l6Wcs8Z1LYJo0xNTMrCWzrrxCMGO
1cA4qpJ1S7LqMFIS/scDO83TEpsOkKunozNBqElNGRdnMyTgZznysFAPn9dKiBx3
BQS2xfGl/rlWsXZaKaqoKjrIk2rl2pP1BbMtDi3dB3C7lLfLlCLkd8bzL1t/+CFN
tugPZcQJwVMeIYnjR6hK89RiupqPRtqs1UH1bnCie6P2kTubOd2Wvt4UaQ57alTj
BWwI/55tMlFCGldsGApZao/0vJ36jwNZVmM9x743o094tAN7HtM=
=t7TX
-----END PGP SIGNATURE-----

--qebv7hyem3d6rgy2--
