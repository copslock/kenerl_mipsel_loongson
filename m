Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jan 2018 22:18:29 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:38588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992521AbeAVVSUbqSyu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Jan 2018 22:18:20 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E18E2064D;
        Mon, 22 Jan 2018 21:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E18E2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 22 Jan 2018 21:18:07 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: Watch: Avoid duplication of bits in
 mips_read_watch_registers
Message-ID: <20180122211806.GC22211@saruman>
References: <1514892682-30328-1-git-send-email-matt.redfearn@mips.com>
 <1514892682-30328-2-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <1514892682-30328-2-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62272
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


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2018 at 11:31:22AM +0000, Matt Redfearn wrote:
> Currently the bits to be masked when watchhi is read is defined inline
> for each register. To avoid this, define the bits once and mask each
> register with that value.
>=20
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

> ---
>=20
>  arch/mips/kernel/watch.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/mips/kernel/watch.c b/arch/mips/kernel/watch.c
> index 329d2209521d..0e61a5b7647f 100644
> --- a/arch/mips/kernel/watch.c
> +++ b/arch/mips/kernel/watch.c
> @@ -48,21 +48,19 @@ void mips_read_watch_registers(void)
>  {
>  	struct mips3264_watch_reg_state *watches =3D
>  		&current->thread.watch.mips3264;
> +	unsigned int watchhi_mask =3D MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW;
> +
>  	switch (current_cpu_data.watch_reg_use_cnt) {
>  	default:
>  		BUG();
>  	case 4:
> -		watches->watchhi[3] =3D (read_c0_watchhi3() &
> -				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
> +		watches->watchhi[3] =3D (read_c0_watchhi3() & watchhi_mask);
>  	case 3:
> -		watches->watchhi[2] =3D (read_c0_watchhi2() &
> -				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
> +		watches->watchhi[2] =3D (read_c0_watchhi2() & watchhi_mask);
>  	case 2:
> -		watches->watchhi[1] =3D (read_c0_watchhi1() &
> -				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
> +		watches->watchhi[1] =3D (read_c0_watchhi1() & watchhi_mask);
>  	case 1:
> -		watches->watchhi[0] =3D (read_c0_watchhi0() &
> -				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
> +		watches->watchhi[0] =3D (read_c0_watchhi0() & watchhi_mask);
>  	}
>  	if (current_cpu_data.watch_reg_use_cnt =3D=3D 1 &&
>  	    (watches->watchhi[0] & MIPS_WATCHHI_IRW) =3D=3D 0) {
> --=20
> 2.7.4
>=20
>=20

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpmVQ4ACgkQbAtpk944
dnqo6g/8CbaPULgS8HCTmbYE8tUU0g2iDg8NV9eSJbUSYOYzt+D8v1/0uh6Yt3vv
VqYa7HZfUbbbVJGKmNdrFwb/UYBEYQJsrHOHNNmY2pa02cSfy1lP/E/WNuSsKE5W
ZWCA/pVbH5pl+rDErgiMsRNIB53Dmi++ZD0f+7Q2WHraf6+7Sb9zLPjRccFlVQmv
dx1VoE00YYbz7TizgsvUb6HAh8dI1q2MR46ly7DTXQ1CI75eOCTGhiIF1xjUrFA7
c71WEr7N3B4vT1YYkPrVdOrTC0rMDBEtKg0zZ6pb6JR8Qb2NDIUKGNd5SadwqvmL
sfOdNyGwxJi3Ci+mt9ZL9dkywg3hJLKJVE1qiIr3HE9oNmijUnPvfnhVS/5A18I8
Yx7stzMo00Pmpu4wr3WAbYM3/EzzBKmCHuiQFzR9ojsVq0McwEEQmSMSLwNoZY8h
gydBreT7BQKhhWiQSAMaUY4+ic5vDalqZrZnXHRaIPjUlVgiqUykcxoPFpv1RY4V
xjNw808xTWyFHE3kTW+TkozXgkUlEvzjM8L0J9e7cthIIR++eNEcmCAIuN5qiEuM
ntsmhxdN2on/qSfExVZnsK5h/wc80gDRNt2ne6IpNtD4k4J/xUQCeUqCaKEl8zG7
gbVFQ6O/5NLclV7srIQLEiDTRSQ/BqugwvFkOnX3IB/9F9GB23A=
=NOSo
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
