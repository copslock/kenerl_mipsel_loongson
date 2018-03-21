Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 23:32:18 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:47498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993945AbeCUWcJmh0S6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Mar 2018 23:32:09 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3F24217D8;
        Wed, 21 Mar 2018 22:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F24217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 21 Mar 2018 22:31:57 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, john@phrozen.org, dev@kresin.me,
        linux-mips@linux-mips.org, martin.blumenstingl@googlemail.com
Subject: Re: [PATCH v2 0/3] MIPS: lantiq: fixes for clocks and Amazon SE
Message-ID: <20180321223156.GA13126@saruman>
References: <20180316202730.598-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20180316202730.598-1-hauke@hauke-m.de>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2018 at 09:27:27PM +0100, Hauke Mehrtens wrote:
> This fixes multiple bugs which were introduced when changing the driver
> for the reset controller unit. The mid term plan is to move these SoCs
> to the common clock framework and replace most of the code in sysctrl.c.
>=20
> Mathias Kresin (3):
>   MIPS: lantiq: fix Danube USB clock
>   MIPS: lantiq: enable AHB Bus for USB
>   MIPS: lantiq: ase: Enable MFD_SYSCON

Applied for 4.16

Thanks
James

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqy3VwACgkQbAtpk944
dnqd4Q/9Hj7NMOGPtwhro0oBLMGl0+6jYhWYlxv1aGS29L9H6cInMK9OQg0nQBt8
VKtVX8G7FDaOiO79ACES0esoRY07EC6pLdEsQKo8O/pPV/e4X3CjCdnQaaH+hHom
Zo36YrKER6WVSuuVxjxMe5V5qcHwn6edSSIVp8qJmaLElMVTF8fB/gpuY0nDb4NP
MITHNfaorOfiyu8sj5XdMyTmXc+soVM9TtjLi6nVnd/TVnn9laFSVZADuRGPyifW
YI624mKGCBy3asZChOYaOnqaS3uRw3JOJL1ncugJSwIbWcEUkaHzl4xi2SEY0/Ad
UfY+IumRdP6uexrOsNjDEWkR1K1fbXs/cEZT/zN8RBOboNvEFeadN6kdPJjcJQ1X
HQB4MdA0DtGbbwxh/WHCOZ4JUdnLtJcQchizGBVibV+Xe6+ddnohd7gYjut1DVl3
xqx68Os+uL3RPfCwmweVzKOH3/VdEv1c2g7LSPXc9npXIs5sCvIJASnqPNPDdUoe
E3g3r0keJgKdIrqLGnQg38vdSiqfedqHAeoTccY1QRae5PJEpIeB3OQJMgsAc6x8
Bxa/pJDadG0baEOBjoWOfZOg6hcAHv1vsHTPn5ximW4BM5DLDB5SUv0OUgayZulp
U2bipcPU4PPTGpeW8aNNU2EhkSoRyD3c34KPHQwXbTbGkybDo8E=
=X8Sl
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
