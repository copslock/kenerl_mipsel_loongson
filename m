Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 21:01:32 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48031 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025177AbaHVSfxZ2BQc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 20:35:53 +0200
Received: from [208.59.64.2] (helo=finisterre)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1XKB29-00038F-KE; Wed, 20 Aug 2014 18:54:59 +0000
Received: from broonie by finisterre with local (Exim 4.84_RC1)
        (envelope-from <broonie@sirena.org.uk>)
        id 1XKB26-0005l6-Ga; Wed, 20 Aug 2014 13:54:54 -0500
Resent-From: Mark Brown <broonie@sirena.org.uk>
Resent-Date: Wed, 20 Aug 2014 13:54:54 -0500
Resent-Message-ID: <20140820185454.GA22133@sirena.org.uk>
Resent-To: linux-mips@linux-mips.org, markos.chandras@imgtec.com
Date:   Wed, 20 Aug 2014 10:33:54 -0500
From:   Mark Brown <broonie@kernel.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-kernel@vger.kernel.org,
        Himangi Saraogi <himangi774@gmail.com>,
        linux-spi@vger.kernel.org, linux-mips@linux-mips.org
Message-ID: <20140820153354.GZ24407@sirena.org.uk>
References: <1408545613-28348-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="csehs8AeUiGwWnbr"
Content-Disposition: inline
In-Reply-To: <1408545613-28348-1-git-send-email-markos.chandras@imgtec.com>
X-Cookie: If you can read this, you're too close.
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 208.59.64.2
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH] SPI: spi-au1550: Fix build problem in au1550_spi_remove
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@sirena.org.uk
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


--csehs8AeUiGwWnbr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 20, 2014 at 03:40:13PM +0100, Markos Chandras wrote:
> Commit 30670539b867 ("spi: au1550: Fix bug in deallocation of memory")
> switched from release_resource to release_mem_region to release
> memory regions allocated using the request_mem_region. However,
> a build problem was introduced due to 'r' being undefined in that
> function. We fix this by having 'r' being defined as the platform's
> IORESROUCE_MEM region.

A different fix has already been sent for htis issue - please check if
there's anything you want to change with that and resubmit if there's
anything.

--csehs8AeUiGwWnbr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT9L/eAAoJELSic+t+oim9FeYQAIW3Mhf8CpsJ/pa9TioJNU/E
pQEKiO/tYMSevoPRPiYj62YY9lCZNuafWl+rQ3v7xtw3+U0HxoujJiqFb8QqEJvy
2BZkexsiCxMbynEXiekwulBKHYc5v1Tuc+ft09igaHMnBhUTLrSPB2YBf6dcLX51
/tEkyoFxh/0My79a6yq19T4eKDvmluSNc83YqbQpbVkeIWaHpzaGcSG1nYL7bEH6
MYyNn1qP5WImJCFnYeTLvzDiwrtI3JMUhd1Klv9Iit9IOi+9CCBr8+yM6pnEtPcy
1cgOhl0VOzMVl9RrxS0ZFm4v5BmRI9dEefwmAQ7Q3jtEp1KcsTrrekcnR/gUQ6Qn
Kd9Kk1Nb+r46CmezJhKpMxVjHL5cJAx54YTu8pN7Mnp/JWEqt5M+wBb3s5DLsCL4
ZOb8YmHojmZluFPTxXQdmDXCcVgpX2+iNgTc51vgL1vQkrysvDHb+70ds9vTgYSx
ekqdMCYdhJPTupVT2/eWOhcG3tWO+kLsnOHvwgE1Q0lLMMuevtifKDN//PAIRBcN
btyr0z/By3Z2rVZwJQ3K6/VOueVdVyy0zbNgCBYYAycZOp969M59c8lDIGXS7TjF
xVSx6hr6EyjEkJa2wRm+xoiEX+4+MSldYgotYtA57TkBYT/yTn6e4S5VlH/L5cdc
E7xle/z50X6OpP/fAUmB
=hODX
-----END PGP SIGNATURE-----

--csehs8AeUiGwWnbr--
