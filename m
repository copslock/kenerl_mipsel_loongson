Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2012 21:09:14 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:52934 "EHLO
        opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903648Ab2HVTJK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Aug 2012 21:09:10 +0200
Received: from finisterre.wolfsonmicro.main (unknown [87.246.78.26])
        by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id 2A3A4110700;
        Wed, 22 Aug 2012 20:09:05 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.80)
        (envelope-from <broonie@opensource.wolfsonmicro.com>)
        id 1T4GIa-0003TB-Hy; Wed, 22 Aug 2012 20:09:04 +0100
Date:   Wed, 22 Aug 2012 20:09:04 +0100
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     John Crispin <blogic@openwrt.org>
Cc:     spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
Subject: Re: [PATCH] SPI: MIPS: lantiq: adds spi-xway
Message-ID: <20120822190904.GG7995@opensource.wolfsonmicro.com>
References: <1345103821-12543-1-git-send-email-blogic@openwrt.org>
 <20120822185944.GD7995@opensource.wolfsonmicro.com>
 <50352D58.6040201@openwrt.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GySBzmld1qhwdVCc"
Content-Disposition: inline
In-Reply-To: <50352D58.6040201@openwrt.org>
X-Cookie: If you can read this, you're too close.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34344
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
Return-Path: <linux-mips-bounce@linux-mips.org>


--GySBzmld1qhwdVCc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 22, 2012 at 09:04:56PM +0200, John Crispin wrote:

> is there a equivalent of of_machine_is_compatible for IP ?

I think you're looking for of_device_is_compatible().

--GySBzmld1qhwdVCc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNS4mAAoJEFJkBDiqVpZ4imAQAJj4xtRA4Wic0iHQ6Mz7hbye
jk1sCiA4ckuJkGkdqptnlP2vu9QqKUZGSvxNSsL5ibMvSsrAXDtj389YG/LhQuY5
MdnQZNTRhZ9Vd/mgNhjFDeIINslKlNjS+qI1soGZQ2r/136Ce7y7DGOEc45kwMBm
4pjfyEzlBtwPDoeUFLlharY1SLiAilDY4AWs26Fpzd1PDSt0KU5b2No8vF1phznQ
Cj3dXMafzYs05SCaRRPCe5HyQ1mVdPWA5TXJJCJ7Lianetw0BR7GR9+0XZgp9e5v
Y9938ruq5KSesQfPs9TeJApWLVaPX4Ln30pMBvg8mxhkKWwB/CR0+IXI/7oCb9fA
dsT6CPZER61fcJZVxJZyqLAb/fbR1wp8X2sKzoPSgyZI0aIkDQlpnGxjbQ7XqvYn
6U4SCObj2gIzs7GJlSlqmgqbgYplwrft1wPeZC/RHowgBTRj64AEI7JRuL6Zw5Uk
cb179JCBA6A6xM1RPhWjJvHjXGB7VznT/dP+JNO8QKmxsMElBbgl70Z5zfs+boAj
FwonYcTZ9cST2cT4e0RP5iTRqaG6Evv1JQiTP/d/KUEW8x6gFGfOm80MfSmcSn+S
YdL1A+/QVC7AADyi8PI73vpth8EoDSgGFtMWgziLCE8fykibd0G+/HtRRSoJoQcR
uNa+SfVFZtVbrlZg9oQ+
=wAp8
-----END PGP SIGNATURE-----

--GySBzmld1qhwdVCc--
