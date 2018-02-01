Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 12:58:17 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:36096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994828AbeBAL6KROiON (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Feb 2018 12:58:10 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 358BD21799;
        Thu,  1 Feb 2018 11:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358BD21799
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 1 Feb 2018 11:57:34 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Daniel Sabogal <dsabogalcc@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix vmlinuz build when ZBOOT is selected
Message-ID: <20180201115733.GF7637@saruman>
References: <20180116032954.13722-1-dsabogalcc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline
In-Reply-To: <20180116032954.13722-1-dsabogalcc@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62392
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


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 10:29:54PM -0500, Daniel Sabogal wrote:
> vmlinuz is not built by default for platforms using
> COMPRESSION_FNAME (e.g. Malta) due to an erroneous
> check on ZBOOT
>=20
> Signed-off-by: Daniel Sabogal <dsabogalcc@gmail.com>

I've already applied this to my 4.16 branch,

Thanks
James

> ---
>  arch/mips/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 9f6a26d72f9f..0f20f84de53b 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -228,7 +228,7 @@ libs-y				+=3D arch/mips/fw/lib/
>  #
>  # Kernel compression
>  #
> -ifdef SYS_SUPPORTS_ZBOOT
> +ifdef CONFIG_SYS_SUPPORTS_ZBOOT
>  COMPRESSION_FNAME		=3D vmlinuz
>  else
>  COMPRESSION_FNAME		=3D vmlinux
> --=20
> 2.15.0
>=20
>=20

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpzAK0ACgkQbAtpk944
dnpb0A//VXAzlQfYJCJuSaaeb/DoJVHvk33KW9RQ4jPj1hgl0L6W57vqsLTRKa2f
G9zfXimJ3jnL+Fpsz2pSbgQLRbjLcB1BCOLfHtN2Z1HuUhQBpMbYI/hEa1VzOPP6
AzmEynn3AU4Y3pS9tv3WzylyrHQqRfqUENKBsDGP39QiDa0Rk5g/FoTvDeKPzT0N
v5FEnYhBvEG0jLI7n5Tad3fDj3PXmHzJhbl64Ek1cdW0RKcZ0+DmW3rdziDFxStv
7RY/qqiqkoXq5FskU2YBJ5mSFGh8YC7a3lkB87gGQ8XMD7lF/3Jy2/CDe2TaqcTU
YYxAkDGKr62ft8/SFIg1Pyb3Df4CQKI8NrAwNb2VU88BTtBEMUp6ypSRIGZ3rpIv
8AOxB1WdoVqm4ScLwaR7CpsPLoHRPhq/9UmlI7glzD/0IsjaY79Z4qvy7HGk0TQG
TRSZo3rHNvIDyWFtLlqzTORGDe5/IKa3cYx4pu8bAV39uVAKOlpTc4uUj/Z/AKEb
jdTx79FTBsT669b0n00HRWLEFzE4HOFAXWt9GIy/mtsmLsg3eOf1RJ+dA8fSpc+z
NyLWe49L64UqBCdEsj0zBJm5k7815KXb6L5HAdi7lpu2IFgUuwOCvQbxWkJ4FAdm
oNJyuZN6LKHveb2TYD4sP0Xvy+D4ecAWy3+0Ry2gcIJgK3mfsOw=
=nlrV
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--
