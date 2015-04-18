Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Apr 2015 14:58:13 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:53436 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006808AbbDRM6LXMCAj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Apr 2015 14:58:11 +0200
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=finisterre)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1YjSJz-0000vO-Vr; Sat, 18 Apr 2015 12:58:08 +0000
Received: from broonie by finisterre with local (Exim 4.84)
        (envelope-from <broonie@sirena.org.uk>)
        id 1YjSJx-0001Oc-0N; Sat, 18 Apr 2015 13:58:05 +0100
Date:   Sat, 18 Apr 2015 13:58:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        andy.shevchenko@gmail.com, jogo@openwrt.org
Message-ID: <20150418125804.GS26185@sirena.org.uk>
References: <1429112632-32153-1-git-send-email-bert@biot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2/Dpz40iF3jpiHxF"
Content-Disposition: inline
In-Reply-To: <1429112632-32153-1-git-send-email-bert@biot.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH v7] spi: Add SPI driver for Mikrotik RB4xx series boards
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46906
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


--2/Dpz40iF3jpiHxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 15, 2015 at 05:43:52PM +0200, Bert Vermeulen wrote:
> This driver mediates access between the connected CPLD and other devices
> on the bus.

Applied, thanks.

--2/Dpz40iF3jpiHxF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMlTcAAoJECTWi3JdVIfQ7dIH/0UkeFmhK+/CE+ph9UK1ziHI
cuzrYy4F64RnEgMzPHf/Dk/THiLGoHA4tTBvx3NIzEQF/8rTTUjfPiBZOPtCvFMi
hdR2w/1NM+PWf4RVJJquNJa3IFIGiMu/l/QRN4wDZyHr4tj0Ff1OtJ1h07bnKp0y
tXt9wCqVkE0mnoOqbgsovtQdCwfEq9MDVtRMtfospvZ0xGjRDcHc/av9POnhW6zM
kKcboZqaslMKngw8SYLtq3zvO6f0kz/G5AMKWy6hLfxVsgsZYd0y7HRhpqqLWn5f
AEExoyNAoMyrDGHwGA+OJiaIRo1FWqNkrAy8j+OAx1dFlnOGZ3hxqJKiO1jSrSA=
=2mNZ
-----END PGP SIGNATURE-----

--2/Dpz40iF3jpiHxF--
