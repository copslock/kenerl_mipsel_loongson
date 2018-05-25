Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 17:41:53 +0200 (CEST)
Received: from vm1.sequanux.org ([188.165.36.56]:34871 "EHLO vm1.sequanux.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990423AbeEYPlqjzZYC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 May 2018 17:41:46 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm1.sequanux.org (Postfix) with ESMTP id 34EEA1081F7;
        Fri, 25 May 2018 17:41:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm1.sequanux.org
Received: from vm1.sequanux.org ([127.0.0.1])
        by localhost (vm1.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K5ZCu4gm4ee5; Fri, 25 May 2018 17:41:44 +0200 (CEST)
Received: from localhost (softwrestling.org [188.165.144.248])
        by vm1.sequanux.org (Postfix) with ESMTPSA id 8862810812B;
        Fri, 25 May 2018 17:41:44 +0200 (CEST)
Date:   Fri, 25 May 2018 17:41:44 +0200
From:   Simon Guinot <simon.guinot@sequanux.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-mips@linux-mips.org
Subject: i2c-gpio and boards conversions to GPIO descriptors
Message-ID: <20180525154144.GC19100@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <simon.guinot@sequanux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon.guinot@sequanux.org
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


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

I think your patch b2e63555592f "i2c: gpio: Convert to use descriptors"
may have broken i2c-gpio support for some boards using old fashion
platform_device declarations.

Indeed when an "i2c-gpio" platform_device is registered with a fixed id
e.g. 0, then I think the device name becomes "i2c-gpio.0". And then this
won't match a lookup table registered with an "i2c-gpio" dev_id.

Please double check this :)

Simon

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAlsILrgACgkQzyg/RDPm
szpd/hAAoE3d2/3Q8y9kg82qGUp8uGanKE61aRL0FSngbTfVsI1Yx4i+Am4urNvo
D8Bs/g3/w0TxecAY1FMfb8NALIN5+pgErORE+28gtzm1jFW2dIZealUu8yw2oahO
7DfMNNRwI3em2ZljYqnqUzknIaA28wwTyxrxYQoqmflr8ygZatrpvYkOjFzCIZAB
Ym/iBuaJVl7ACbjHew3QJZcqiXpEYxdJG37vlhLtFzU3nynrct9vXXCtK1IwexbI
YzYOWOYtEjxYuP6a2SC63WyGz9Q8St3cnawoYrFm7OLaUCgskHrX8/H6JDrSf2n4
BQ2UwpVYGr6PU19xYYVLRTuLZ+CFsZnoy2KU5BMWvOO7wqlUG4qOnRFLKCgezXAP
kmrO3zVQOdGihN1VYWppR4VqbHDZBF6HVaxtIoebMZFXP8Ecw1Pa2LVBJzOtDgYw
rfgJQH5eAEnyKyajCdRwuqedE9cOlv5XpQ0FurPUCl3OSnl0w+109gcDrG7dpEQ+
m4V/Gy6MWjZCbZVUJTGnKypk65Gv3J4yUQ2iu+twb18Zhi80aQFCc53Bf/puixcX
lg1omjg/MaHa1HjmsPtZwdqeDCVdoifLqaGegCvgzDmqCG02kwzbIu/ckzgqcsD8
SkjFL9xFD6fuiuWuLj+sblXl+lbG4ON66aH2quC1CsWOM7kL5j8=
=ngPR
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
