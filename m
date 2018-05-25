Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 19:30:23 +0200 (CEST)
Received: from vm1.sequanux.org ([188.165.36.56]:35354 "EHLO vm1.sequanux.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994765AbeEYRaPWoJzI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 May 2018 19:30:15 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm1.sequanux.org (Postfix) with ESMTP id 4619F1081F7;
        Fri, 25 May 2018 19:30:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm1.sequanux.org
Received: from vm1.sequanux.org ([127.0.0.1])
        by localhost (vm1.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CRFMk0jU92KO; Fri, 25 May 2018 19:30:12 +0200 (CEST)
Received: from localhost (softwrestling.org [188.165.144.248])
        by vm1.sequanux.org (Postfix) with ESMTPSA id BB70B10812B;
        Fri, 25 May 2018 19:30:12 +0200 (CEST)
Date:   Fri, 25 May 2018 19:30:12 +0200
From:   Simon Guinot <simon.guinot@sequanux.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-mips@linux-mips.org,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: i2c-gpio and boards conversions to GPIO descriptors
Message-ID: <20180525173012.GD19100@kw.sim.vm.gnt>
References: <20180525154144.GC19100@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20180525154144.GC19100@kw.sim.vm.gnt>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <simon.guinot@sequanux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64041
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


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 05:41:44PM +0200, Simon Guinot wrote:
> Hi Linus,

Forwarding to some mailing lists I missed in a first place.

>=20
> I think your patch b2e63555592f "i2c: gpio: Convert to use descriptors"
> may have broken i2c-gpio support for some boards using old fashion
> platform_device declarations.
>=20
> Indeed when an "i2c-gpio" platform_device is registered with a fixed id
> e.g. 0, then I think the device name becomes "i2c-gpio.0". And then this
> won't match a lookup table registered with an "i2c-gpio" dev_id.
>=20
> Please double check this :)
>=20
> Simon

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAlsISCQACgkQzyg/RDPm
szrMXw//ZhBPxvbe4iPbi7Q2UPFHrxh43ol1czp7AvQqIAe3WnrYWg3mEu4SLWvc
7EkYL2O4SfiHc+QLSs8ZV8IjjVYwfRZmneRSmfOQjgqDsMulgMq5xRfaLpvXQtpT
aEqc+HwImYCSSiU0FB3L2diHuo4wyGMOikogOzi6cHVdO3SrQNvyXUth1960OfxE
xk471bW1Lt3fzqJnjHzVEzewbPPSDbkNw/MT6+FAJ6ZyUZB+/+Fudneess08f9Je
/m44+zeVB7SfR1JM84Jlt07xYtrLoHLMRSyEk9K92I0yAecMerfbE99XN9euTHxb
XHRaKV4AufQO9F35Os9ak/Yh3XbMlRfE212kNPdIUqti7Tzf++uR4pozczjZuhUu
3IDd//YJSZ1XIG3ZWJ5jmBEVt4TUXeW1VTYkpnZ6JpmrKgG42JtUe0k0EZpkZxwH
XtGrOcU0oP1hwv6y1X5b+bLQWCX2fxKPaWM7pLwQFwsNNATF51iTUjjXhDGmpP9x
jmL295ezX2uNx4KG9IhuWWCeC7X8l4IIzaNpzFBLHRs3QGAh4wR+3M8mEU/3t/T2
HF26HehIlTCJMF1jUItZNSb7aTXEc798WjdCHNq7gAEGDHQ2PRTNRQ15Y8uBCi0F
pxxjGGFMwccVRXFV7QO/rWNqxSFM3bUJg//LlG2jNDpdhpJV14E=
=vti/
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
