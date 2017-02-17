Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2017 12:26:01 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58249 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990552AbdBQLZwzpylv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2017 12:25:52 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B623341F8E07;
        Fri, 17 Feb 2017 12:29:52 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 17 Feb 2017 12:29:52 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 17 Feb 2017 12:29:52 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 6A380FBA9B2B5;
        Fri, 17 Feb 2017 11:25:44 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 17 Feb
 2017 11:25:46 +0000
Date:   Fri, 17 Feb 2017 11:25:46 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Mirko Parthey <mirko.parthey@web.de>
CC:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: bcm47xx: Fix button inversion for Asus WL-500W
Message-ID: <20170217112546.GY24226@jhogan-linux.le.imgtec.org>
References: <20170215223130.GA18959@guitar.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/hzbcv1ZPoZ/SOgH"
Content-Disposition: inline
In-Reply-To: <20170215223130.GA18959@guitar.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--/hzbcv1ZPoZ/SOgH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2017 at 11:31:30PM +0100, Mirko Parthey wrote:
> The Asus WL-500W buttons are active high,
> but the software treats them as active low.
> Fix the inverted logic.
>=20
> Signed-off-by: Mirko Parthey <mirko.parthey@web.de>

Applied (with fixes/stable tag for 3.14 onwards).

Thanks
James

--/hzbcv1ZPoZ/SOgH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYpt2xAAoJEGwLaZPeOHZ6WGYP/3u1PVZ6uDEZ+a1oria1pyHi
aXvSheqbtJxWBrIeARqpehKzsZa/3YV+/xVE4+HBOYpb6xRoGGpCld2qkUhxFnSp
hAm6CQeijdobjhxZVmNt2AN2Y3XY44z6HyJ/iWNJwcoV2warZ2U0D6NMNy7XIHg3
OBESf2MAT8de42yFC4mLKGGMzx11PAG+U4gDpuyvv3ybLkfqqyg9wOgAfu37HAkj
1Wf2MildFJ6jYkr2Vpih0s7vF43nStwqq5BMoJPrdMmx1x83QkoihTTDq0J+3zpE
p8rJnkdkYbk1QlH8VLQNUtuWTAuoKjDAvHiO5ILx3qwDPRl1asAq0lp3fAEPdchz
Syh5whBlCR/WP94bKc7POs/qoE8K1Iz4kWB+dizXVkUzJV6ZIMR39yhaatE/aYU6
lkMt5N5xsnXpA801sTtgebYZrCbuY8h+f1N8Arg6HHTbkZCEPSaYyHdzaU3jHwMA
a2l6/GwjIAyrZ+C6J/4RLmTge6/UY/wlrLr+5jO5mtJiKPYSTDIgRk5B8h+D5go5
KsK1O/T3CrBfhjgriHwhILXOUOseKXEQQF2tAWUctmsArxGfHKHrf6qVcswS1jbB
SOFukvALJEXglvEDTHj/jblJP/5DkxsmV/Sgx9LmiQarQxRt09VePFEq8E0ITU0X
iIbcLW857Y/ckFOBpKOW
=jtqx
-----END PGP SIGNATURE-----

--/hzbcv1ZPoZ/SOgH--
