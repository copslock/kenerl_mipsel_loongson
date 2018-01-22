Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jan 2018 22:17:27 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:38364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992479AbeAVVRNBBq1u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Jan 2018 22:17:13 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C17E2064D;
        Mon, 22 Jan 2018 21:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C17E2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 22 Jan 2018 21:16:59 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: Watch: Avoid duplication of bits in
 mips_install_watch_registers.
Message-ID: <20180122211659.GB22211@saruman>
References: <1514892682-30328-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <1514892682-30328-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62271
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


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2018 at 11:31:21AM +0000, Matt Redfearn wrote:
> Currently the bits to be set in the watchhi register in addition to that
> requested by the user is defined inline for each register. To avoid
> this, define the bits once and or that in for each register.
>=20
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

> ---
>=20
>  arch/mips/kernel/watch.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/mips/kernel/watch.c b/arch/mips/kernel/watch.c
> index 19fcab7348b1..329d2209521d 100644
> --- a/arch/mips/kernel/watch.c
> +++ b/arch/mips/kernel/watch.c
> @@ -18,27 +18,24 @@
>  void mips_install_watch_registers(struct task_struct *t)
>  {
>  	struct mips3264_watch_reg_state *watches =3D &t->thread.watch.mips3264;
> +	unsigned int watchhi =3D MIPS_WATCHHI_G |		/* Trap all ASIDs */
> +			       MIPS_WATCHHI_IRW;	/* Clear result bits */
> +
>  	switch (current_cpu_data.watch_reg_use_cnt) {
>  	default:
>  		BUG();
>  	case 4:
>  		write_c0_watchlo3(watches->watchlo[3]);
> -		/* Write 1 to the I, R, and W bits to clear them, and
> -		   1 to G so all ASIDs are trapped. */
> -		write_c0_watchhi3(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
> -				  watches->watchhi[3]);
> +		write_c0_watchhi3(watchhi | watches->watchhi[3]);
>  	case 3:
>  		write_c0_watchlo2(watches->watchlo[2]);
> -		write_c0_watchhi2(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
> -				  watches->watchhi[2]);
> +		write_c0_watchhi2(watchhi | watches->watchhi[2]);
>  	case 2:
>  		write_c0_watchlo1(watches->watchlo[1]);
> -		write_c0_watchhi1(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
> -				  watches->watchhi[1]);
> +		write_c0_watchhi1(watchhi | watches->watchhi[1]);
>  	case 1:
>  		write_c0_watchlo0(watches->watchlo[0]);
> -		write_c0_watchhi0(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
> -				  watches->watchhi[0]);
> +		write_c0_watchhi0(watchhi | watches->watchhi[0]);
>  	}
>  }
> =20
> --=20
> 2.7.4
>=20
>=20

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpmVMoACgkQbAtpk944
dnrxDxAAujJW+Lx3JIMaaQ9KRVBki7exlMjPWW6+vcenDCDI8lzPgfrtRzxoYLJL
01skU8AgOGu2E0kPwtPbtNQ+J+Q6qpiHXZS2InGh36P4l4yNDu63g1nQ/aY/RToK
O6bGBtO/oe4DwuDm9zhzk6ZJECT2Go1UflxJUyxIPdFboAJulZhA5DPsW7XrELE3
oGk0TB59B2ISSo+4noWS6TWIlWWwf5+oS6mJ8FtFEXUUpw//GkkCKqVAFyEX7NzT
y8Eb8z4xDD/q9UCRxTNkbjVnX+cpiFHKgtDZ5QvtidVMscbv/DnU4WIZWCdA8QkJ
SJRQrYnfZgebVz6SLkA48mIFRssHpFsa9hlOzE2LbEKZF4Azk2ZXRH9gR0KbU83W
q7SJSZWfbtRNsbfCEHwCU58ag46QXDaIrLCE0MhpKxZy99OvGpVGGI/76n/PrReu
KyfM7xxiUBx1SbZJ5k56AWxgfKVHrjJrpMLhCojG86JkakExht4+nPbJfc5deZ1L
n5FyJPJxZQ5zHok50Fs11oSqakNCn2BbWbS74oWzTGlY5Z53SktjUfISJwkqmnnx
mRcnCOYkUk353q4BgNaQA6/VJ273+CHjq8EHsX+tX5csjdH12gQXoIdi8Xbo+2Vy
JqiSgyk1KL7arY3wdPNa2/FNeuq3/+80qoHfbnTG3XcTMZV20LM=
=lno1
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
