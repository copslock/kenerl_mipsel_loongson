Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2018 16:32:13 +0200 (CEST)
Received: from sauhun.de ([88.99.104.3]:44612 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993973AbeEQOcGoCNVg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 May 2018 16:32:06 +0200
Received: from localhost (p54B3345A.dip0.t-ipconnect.de [84.179.52.90])
        by pokefinder.org (Postfix) with ESMTPSA id 7BEC73640A7;
        Thu, 17 May 2018 16:32:03 +0200 (CEST)
Date:   Thu, 17 May 2018 16:32:03 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-omap@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH 0/7] i2c: clean up include/linux/i2c-*
Message-ID: <20180517143202.vzwmqkemlqxj2xgu@ninjato>
References: <20180419200015.15095-1-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2am76ftu5fuftxje"
Content-Disposition: inline
In-Reply-To: <20180419200015.15095-1-wsa@the-dreams.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63986
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


--2am76ftu5fuftxje
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 10:00:06PM +0200, Wolfram Sang wrote:
> Move all plain platform_data includes to the platform_data-dir
> (except for i2c-pnx which can be moved into the driver itself).
>=20
> My preference is to take these patches via the i2c tree. I can provide an
> immutable branch if needed. But we can also discuss those going in via
> arch-trees if dependencies are against us.

All applied to for-next!

The immutable branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/platform_da=
ta-immutable

Thanks,

   Wolfram


--2am76ftu5fuftxje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr9kmIACgkQFA3kzBSg
KbZKxw/+JSU2lxyogS2eTiaKLZ+5KEMXeB/xFcc1vSljvMU6dkspqQUo7QJHZW8Q
AsIJtMO1XLfKODlsmidF4yhhOy2cninfK+MQbmZOsuReUF5eEf9DnUxs6YE1YKmJ
3MuoIHqmKXDEYUjL+0xJeU5g8lsPbXVyML+AJ+96THHEDkUf0MeAFApESAoplIWa
/+B+A465tDedkI1MCSrNNtwiNUUfkMFyS9G6UFIT3ovjbofNN8xoyNP+5aYqwd2S
DtVRPNaBg8kYzZur7na3n9+ARxGHGFPOLpx+Z5E67IEfJlS5uYLFuZBhQyXyKLBx
qhhOB6/lHP5hW7vU2EyUjHvpHS55SP0kIQltV85krPlOvmrV3aBp+ucL87NM2BfQ
OTIUTLZdo49bY1gmPo2FfKtPuPgK9T6t82LOrO/IBx7PkaXSNxhw9HL6+kRyxHBI
ELISIMIDIrUG27qhrbBT5ttdTJkAKDvviW/e7vy5VHcEHztrK3L0oz/PMDmlzIvL
YFts1pN6v61jRyr/J7Dv3MYk1bk+B/n94kuZgnTrUws+6Zbv9MBw5l28kOClOp3N
grELJFSGl5PPSiGp7lntGVSt46iEhJToQzwNRbJHL2Ks19rFPlzBbQCRxY3VtJAj
jZ7YVZnaWnmDyRUvedNP+YeiTW351d6OQeJAeK6s+9iCz0GjpX4=
=vxpG
-----END PGP SIGNATURE-----

--2am76ftu5fuftxje--
