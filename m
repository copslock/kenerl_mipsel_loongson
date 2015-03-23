Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2015 22:25:06 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:58195 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008858AbbCWVZFIR0zx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Mar 2015 22:25:05 +0100
Received: from [12.104.145.3] (helo=soju)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1Ya9qA-0005DW-6x; Mon, 23 Mar 2015 21:24:54 +0000
Received: from broonie by soju with local (Exim 4.84)
        (envelope-from <broonie@sirena.org.uk>)
        id 1Ya9qe-0002Nj-UB; Mon, 23 Mar 2015 14:25:24 -0700
Date:   Mon, 23 Mar 2015 14:25:24 -0700
From:   Mark Brown <broonie@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     kernel-build-reports@lists.linaro.org,
        linaro-kernel@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-mips@linux-mips.org
Message-ID: <20150323212524.GU14954@sirena.org.uk>
References: <E1YZyoN-00019n-50@debutante>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="niUlcCfh/sMBwTxc"
Content-Disposition: inline
In-Reply-To: <E1YZyoN-00019n-50@debutante>
X-Cookie: Dental health is next to mental health.
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 12.104.145.3
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: next-20150323 build: 1 failures 23 warnings (next-20150323)
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46502
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


--niUlcCfh/sMBwTxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2015 at 09:38:19AM +0000, Build bot for Mark Brown wrote:

In current -next the bgmac driver does not compile in an ARM
allmodconfig:

> 	arm-allmodconfig
> ../drivers/net/ethernet/broadcom/bgmac.c:20:27: fatal error: bcm47xx_nvram.h: No such file or directory

because this include file is only present on MIPS.  This looks at first
glance to have happened in the merge commit edb15d83a875a1f4 from the
MIPS tree though I think that needs a bit more investigation.

--niUlcCfh/sMBwTxc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEITEAAoJECTWi3JdVIfQwTIH/2bbM8JuRg/ySSgKEFWm1wK+
1UkTKAOyh8+FfoOFvbuDZyYHxNBygG0nNm1vnCHq4uwipv7qMNv9FCt+GdyR9sCI
hA6eAxEyqoqhgV3fMayVO5W1YD/NjMTR2gYDFVRkGP5OC1GSU61yuBWHgcI+NQqy
QuGzuRQj9CpuuQsnOVGkYN4C2nQMBmuzSI7/I1lX++5hZW3za1qlsLJmjvIIft09
u6N0AaSxgW6pYsp2Jkl7SzAw5A/cAqYVptJx1enUTTZWqNC0NqnjcAiUzxpY523j
IRZbVP/DpfCsuMOR6KAemvpCubVhQRbwUom8zNp+NyNZuUxZl5bfOPZU1NJjVdg=
=rG9K
-----END PGP SIGNATURE-----

--niUlcCfh/sMBwTxc--
