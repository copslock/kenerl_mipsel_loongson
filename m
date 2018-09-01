Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Sep 2018 14:44:22 +0200 (CEST)
Received: from sauhun.de ([88.99.104.3]:59818 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990471AbeIAMoR0CYPN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 1 Sep 2018 14:44:17 +0200
Received: from localhost (mue-88-130-111-030.dsl.tropolys.de [88.130.111.30])
        by pokefinder.org (Postfix) with ESMTPSA id 40DD036488B;
        Sat,  1 Sep 2018 14:44:17 +0200 (CEST)
Date:   Sat, 1 Sep 2018 14:44:16 +0200
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
        Allan Nielsen <allan.nielsen@microchip.com>
Subject: Re: [PATCH v5 5/7] i2c: designware: add MSCC Ocelot support
Message-ID: <20180901124416.GC1196@kunai>
References: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
 <20180831151114.25739-6-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <20180831151114.25739-6-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65843
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


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +int dw_i2c_of_configure(struct platform_device *pdev)

I made this 'static' as well.


--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluKiaAACgkQFA3kzBSg
KbYlpQ/8Dpz1rwpriPCRczKfGEpM49wx/FAypJOs0rSQQEjDcMgpYjRhUGZOHdL/
o/chajkvs1hyXilHjudAb99SuEqZyHk9cOJIoSurborwizJfsVRnZ0NIdb3BuWVb
XN8+eZ7CrEbWCOwv/PPC3glB9hkysLMOSU1xk4QPhTtAn1jv7LKd0ZN2HcALb6Ux
gTqjOxw26USwhuxswSP2LPO53SfHvdu83skDAtJSIcyDFRbDoXJELJBUzLvDS+LH
WuVNBSfUVKRGPK0GH/wB3ZQly5te0GDrMO6k1NQeJ8swGasTapDU9seEKAfcN0JO
NRsDDY0eJ/XcFMS2ew2+EH7B59rEhLuvNuZm6KvCf1xMcVeH01qGapOt17pQFkL7
1Aswcr/R512cI37O+HtwZY941lHX4f2/8nJ0LXnerxxJFZT1AnmBtoIuJRfCN+HV
EqezURSkVhHH6XhUxmsPPcG0L5IcHbu0RHbPaHa1AAVREk0anYXFyIY1JogrUHqs
XXowZch8YpIGsqLcussrU+noU49VCMuyllLr7K8pQHBvggTsuE3XFhGK9zTG5EFP
a0H3rHKDCCMH46F9s11MhvlCvRbjKd6vDKzzHCV/yU7qVP4h4sGcGEmjk2p8+pGq
n9MCZAfkMuoMpAwoACOP2TzGQonf0ZDMIzuPqux/+zMBE3foM0M=
=0MVY
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
