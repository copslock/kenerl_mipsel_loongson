Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2012 07:02:37 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.10]:62442 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901165Ab2IKFC3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2012 07:02:29 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
        id 0M34gJ-1TRJSo3mPH-00sCro; Tue, 11 Sep 2012 07:02:18 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 2D4452A282DE;
        Tue, 11 Sep 2012 07:02:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AWE1yohhOmSg; Tue, 11 Sep 2012 07:02:15 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id 3F4CB2A280F5;
        Tue, 11 Sep 2012 07:02:15 +0200 (CEST)
Date:   Tue, 11 Sep 2012 07:02:11 +0200
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: [PATCH v2 3/3] pwm: Add Ingenic JZ4740 support
Message-ID: <20120911050211.GA23771@avionic-0098.mockup.avionic-design.de>
References: <1347278719-15276-1-git-send-email-thierry.reding@avionic-design.de>
 <1347278719-15276-4-git-send-email-thierry.reding@avionic-design.de>
 <504E60F4.9010309@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <504E60F4.9010309@metafoo.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:7ul+BrP8/wvk6OrYOTddx8xmo41Rh5GiacLv3LzLEQJ
 sSqMEFnnBjI0YhoFwoV9fH3TFbfEQNC9WRfcU6Hol1j1KlvN7A
 CNudZbMpA4kdXWyzijNcWz2gLaMRXyHro6i0yI538FpdHG3Ym6
 u1wXGdMUwpMVnHs1kgaaOKjvCu+R3UDquk90JbrLV9qhBm7BOe
 SnDj1fv3aqQf5/YlcE/B9Z1OM+DmoyPQFlvlkeomIds3dOXn6e
 hfxkK4ZY9POqDzMTmnHc0vW/p0emeGTgSuK1sKL0/C2tWrCeDQ
 JLdW4YwJB+L7uLYbTydLLF9ctjCWgSeDwtKrSbG9/kA0RMuCL1
 oHU1cPPXub3CkA+HRyhPVCpx5qtDn/1+5Yhs0k0bF0TlWvOy4u
 F/5Qdwb053ZBP6CitOCiQ4wZjPgKUO7E2JHevxm+36chCTcHr5
 GtVPS
X-archive-position: 34463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@avionic-design.de
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


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2012 at 11:51:48PM +0200, Lars-Peter Clausen wrote:
> On 09/10/2012 02:05 PM, Thierry Reding wrote:
> > This commit moves the driver to drivers/pwm and converts it to the new
> > PWM framework.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>=20
> Seems to work, thanks a lot. This one and patch 2:
>=20
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> Tested-by: Lars-Peter Clausen <lars@metafoo.de>
>=20
> But I noticed a different problem. Some drivers using the pwm API depend =
on
> HAVE_PWM (e.g. the pwm beeper driver), but the generic PWM framework does=
 not
> select HAVE_PWM, so I couldn't select the pwm beeper driver. Imo the gene=
ric
> PWM framework should select HAVE_PWM

Does it also work if you add || PWM to the PWM beeper driver's depends?
I thought I had done something similar for pwm-backlight, but looking at
the logs I didn't. The reason was that it also uses the new APIs
introduced by the PWM subsystem. For pwm-beeper the situation is
different because it only uses the legacy API and therefore can work
with both the legacy and new frameworks.

I think selecting HAVE_PWM won't work properly because it isn't provided
by all architectures. So you might end up with PWM enabled on PowerPC,
which doesn't define HAVE_PWM and will probably give you Kconfig
warnings and will still not let you select pwm-beeper.

Thierry

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQTsXTAAoJEN0jrNd/PrOhZi4P/R390gRh2p7kvHME3Zk2amYN
FEOVvtlGpvOrIZE8rUhOX3gkdQNScNrVPDfru2ZH8r0DMzIGAhE3LV5O/HxKa8yg
eNREkWzlEIGtgS61SGnqjnuDzC1FHMlT0/qDV6/4IT+3H4rPaSHvM5+8g/wwrmVX
3jqC3QDxHNi5SVGTzZUv4cYG5IFPOzV7oN339CAF6+3dTxHKfSHWgVxetUppyblz
yQQ6NnLj24fI7s77f7ri8It6lZyEes/3fjY/XjLcMTdXJ/gOIVYq+kqeJYAECvkM
gzFC/Rc0Wgtuqzaez3pE6i/+4ef8Gl5GXLv4GbgADDlJqKe8Vs7iARm9bdMpOiYx
e8JLMqn5ivZDWIr2igRKQZsv3eFx1HHxyKJpAJhSR1MtBemGYmp5A052chjxvnQn
n/LxblyknDSdDM0jq2sjjNDxnQ4W7A3x0vaeKlrkRq0Ku61zlSYpo7AovqXI4n1s
GlRJYyEx+ZOqGsGbWlvtRVD1+0vLPRLUBkYCqgsyECPNVeAJdV/MwKCIlYfdXrAI
XbZbLvlUkuR8FSOIYP7AV3tIQwXPdvIO4qCIkeL7l1eTf3UAk6M5SbC9Lia4CeBZ
KWUkBP65ourncCuIdNvqOGsdbTBRPbtrjyQSlgrqn5MQZYDz7jH6EqJ8X6qIFNQe
zJ4DZj4o+jlQlY0Ax52f
=qAec
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
