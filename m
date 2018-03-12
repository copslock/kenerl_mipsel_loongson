Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 23:32:20 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:41862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990422AbeCLWcOAZKyJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Mar 2018 23:32:14 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13C1B204EF;
        Mon, 12 Mar 2018 22:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C1B204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 12 Mar 2018 22:31:39 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: Re: [PATCH v2 11/14] MIPS: dts: jz4780: Add DMA controller node to
 the devicetree
Message-ID: <20180312223139.GE21642@saruman>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
 <20180312215554.20770-12-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
In-Reply-To: <20180312215554.20770-12-ezequiel@vanguardiasur.com.ar>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62946
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


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 06:55:51PM -0300, Ezequiel Garcia wrote:
> From: Ezequiel Garcia <ezequiel@collabora.co.uk>
>=20
> Add the devicetree node to support the DMA controller found
> in JZ480 SoCs.
>=20
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>

Acked-by: James Hogan <jhogan@kernel.org>

Since the majority of the changes seem to be in drivers/mmc/, I'll
assume unless told otherwise that the MIPS patches should go via the MMC
tree with the others.

Thanks
James

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqm/8sACgkQbAtpk944
dnoQ8Q//Uzzmm5lFp7pmucl4TBnY//eGeaCVMxLlkLF48yJRjmaEeVUDCJHHtMkf
9Z0tPZ82OShHrAA8IZo5i1q/uSOtnwgLHTjA65CRfNoNLFnn4ipow65I7Csc1vgS
9G2OrWVmBZP9hSy/kbOjXBv4Qm0bud3aRtdHypoY/j4tJPQykJSFij8MUJesWBbv
adG0IfgVIo5DN+MnOtRoEFVCNiV+wGcFK9+rQ1gakpqthK9rELxVrz4BEv9v5ZST
ZRqv1raceV8rQEzTQq+5yFH9ZxqmkcCUObYLABq/16pJrgBIROkJ5W+s+Daj6Gry
hiEuzjIdYw8VmKtk5WwCCQ0ZiYZtuYMDAGX+7Lo0eHQ5Y7RGhTVYWvnEG26mhm+8
vYGEyQBZOL6AIN8koulrgPFgq4jix4jRa4fjbOzkZKXNunE8S6hvx6DYg4VtQz5p
ZxBShIfgMdsWur0LJ5nYS4H90WUtyEi45OuCx/lpe6vXj6GXu4otaN7VsaxCgUp+
I04Q/iRZFhOjWeRdtj7aQcxlSSNdMbiroq9OZ8JaB2v9gn8cmJykytinXAQneoXv
u382Pc3p3rIbBb4qW/ZRm68rrlwfqAnBE4T+OtQH/ineb8/wi/xZjN7LHuWqyijL
LYUcIo9pybe/ZDZiaxS4nIcPIf6WMjIewsAkwvP3udfHoh1qr5o=
=z9jw
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
