Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Apr 2013 14:42:39 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56396 "EHLO
        opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817387Ab3DHMmilarma (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Apr 2013 14:42:38 +0200
Received: from finisterre.wolfsonmicro.main (unknown [87.246.78.26])
        by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id 7D99911068A;
        Mon,  8 Apr 2013 13:42:32 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.80)
        (envelope-from <broonie@opensource.wolfsonmicro.com>)
        id 1UPBP5-0003o7-Ts; Mon, 08 Apr 2013 13:42:32 +0100
Date:   Mon, 8 Apr 2013 13:42:31 +0100
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] spi/bcm63xx: remove unused speed_hz variable
Message-ID: <20130408124231.GK9243@opensource.wolfsonmicro.com>
References: <1365247137-19050-1-git-send-email-jogo@openwrt.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FnOKg9Ah4tDwTfQS"
Content-Disposition: inline
In-Reply-To: <1365247137-19050-1-git-send-email-jogo@openwrt.org>
X-Cookie: Your love life will be... interesting.
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <broonie@opensource.wolfsonmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
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


--FnOKg9Ah4tDwTfQS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 06, 2013 at 01:18:57PM +0200, Jonas Gorski wrote:
> speed_hz is a write only member, so we can safely remove it and its
> generation. Also fixes the missing clk_put after getting the periph
> clock.

Applied, thanks.

--FnOKg9Ah4tDwTfQS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRYrsqAAoJELSic+t+oim95JkP/iMP5axnqQPTO8x0znaWaPtm
7MK1rTNX7lHN0mWJbYHNGI0JDw/5SDs5+HE7zn78bx1yI4TI02l1JEOxmwNbmFb0
C3kTeJgs5Vf5eJT807DKPbK6tjrBCIe56xjUFX1g7KCpiSSR/Kd/2WZDZ2/nuP1y
ZPS/wks9ANpGLJynKhDMto5pgVVSF+D4WHXJ2wYPL1GiacKiQZqqS/NE3fodOBON
NzDV0N20hL8xEuJFlroKmZy9/jba8pO6ttsB3CbNNrBNLtvw/bOZhfSLR+JvWHxY
obB82iXejTgCwQwHuZ9l+I7tG50P9IIuI2a0ENiFN9BP/iDs0SJ4tsHzJqlsgIhE
lB5hapW88d7MQqRQbvSA/mFs1eeQeqbPohOxUYeLbdHUTDEQyLDcRB9yyefDl+TK
k9APN9pA2INZnvAERJBE8kv5yCYuemSHC4nKKg76JmfjmEZdjswZM+3nmAd9V4Fs
rE6YE5VZqM+K447oTj9NJHK68jwtiiksFoKD81xjGPYH1NC3w8fGec5M7bEz/H8z
UisUyKP9+ryKQiTAmoGKTpOdnpsfevWri4e9/dfNNerd9/C7eHmfCXUk+iAq+zwS
uxq0JY6tPkSQglLQzRZoDTSFidRZPKgmwrxfnr5v8PNIqUeMGACGS8OwQCMeNxdu
YRaHQDgpWB7PMRORZBTT
=ey2Y
-----END PGP SIGNATURE-----

--FnOKg9Ah4tDwTfQS--
