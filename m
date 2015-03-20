Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2015 14:28:28 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40286 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008505AbbCTN21RE4Db (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2015 14:28:27 +0100
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1YYwyO-00078r-Hg; Fri, 20 Mar 2015 13:28:24 +0000
Received: from broonie by debutante with local (Exim 4.84)
        (envelope-from <broonie@sirena.org.uk>)
        id 1YYwyL-0004Uh-Lc; Fri, 20 Mar 2015 13:28:21 +0000
Date:   Fri, 20 Mar 2015 13:28:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Message-ID: <20150320132821.GL2869@sirena.org.uk>
References: <1426853793-24454-1-git-send-email-bert@biot.com>
 <1426853793-24454-3-git-send-email-bert@biot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qMyE1nnBIN65x+Vj"
Content-Disposition: inline
In-Reply-To: <1426853793-24454-3-git-send-email-bert@biot.com>
X-Cookie: Wanna buy a duck?
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 2/2] spi: Add driver for the CPLD chip on Mikrotik RB4xx
 boards
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46476
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


--qMyE1nnBIN65x+Vj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2015 at 01:16:33PM +0100, Bert Vermeulen wrote:
> The CPLD is connected to the NAND flash chip and five LEDs. Access to
> those devices goes via this driver.

None of this driver looks like a SPI controller - this appears to be a
MFD so should have a core in drivers/mfd with function drivers for the
individual features in the relevant subsystem directories.

--qMyE1nnBIN65x+Vj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDCB0AAoJECTWi3JdVIfQoMAH/2Ixc3w+dFlBJNP3qwbpTWUs
VLNcRdoK5jURRp0eGap/7MQa1edVMF4SGF3iiIp9yoAjPu89FK7P7PrODjWjRMIx
y86O0p3qlhM/aoE3VyLLGnKv6MDWlu6tBRCj+IlxSG2V8onZKAGO3LNsXX3hkstm
aB4ZHRv3I81oNafOjf3pQBSkn3c3EW+iDTahOrcwowj3HUIIRYp7gwkolUlZJXNC
AXRKFDnsKJdIbPkbwAAYEm8OdVdZEfOoDI+I/LpdDLtzyWh2+WarpllfSp5n6o6g
31/ZW6j1/8sR+vqyQhyaPCpImTq26Vf/VUpFN3zGl+mIoCBfMa0KkmsFWnbZIlU=
=kbUp
-----END PGP SIGNATURE-----

--qMyE1nnBIN65x+Vj--
