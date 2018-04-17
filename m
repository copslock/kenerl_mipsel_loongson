Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2018 17:43:18 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:39736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994647AbeDQPnLLDQTw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Apr 2018 17:43:11 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FAB9217D4;
        Tue, 17 Apr 2018 15:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAB9217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 17 Apr 2018 16:43:00 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MIPS: memset.S: Fix return of __clear_user from
 Lpartial_fixup
Message-ID: <20180417154259.GA21386@saruman>
References: <1523973590-23356-1-git-send-email-matt.redfearn@mips.com>
 <1523976741-29916-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <1523976741-29916-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63590
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


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 03:52:21PM +0100, Matt Redfearn wrote:
> The __clear_user function is defined to return the number of bytes that
> could not be cleared. From the underlying memset / bzero implementation
> this means setting register a2 to that number on return. Currently if a
> page fault is triggered within the memset_partial block, the value
> loaded into a2 on return is meaningless.
>=20
> The label .Lpartial_fixup\@ is jumped to on page fault. In order to work
> out how many bytes failed to copy, the exception handler should find how
> many bytes left in the partial block (andi a2, STORMASK), add that to
> the partial block end address (a2), and subtract the faulting address to
> get the remainder. Currently it incorrectly subtracts the partial block
> start address (t1), which has additionally has been clobbered to
> generate a jump target in memset_partial. Fix this by adding the block
> end address instead.
>=20
> This issue was found with the following test code:
>       int j, k;
>       for (j =3D 0; j < 512; j++) {
>         if ((k =3D clear_user(NULL, j)) !=3D j) {
>            pr_err("clear_user (NULL %d) returned %d\n", j, k);
>         }
>       }
> Which now passes on Creator Ci40 (MIPS32) and Cavium Octeon II (MIPS64).
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Suggested-by: James Hogan <jhogan@kernel.org>
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Applied, thanks
James

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrWFgMACgkQbAtpk944
dnrf1BAAmf3KlW6EcbOTuhPhsCrFWYl1zVFklbUG7arIV3Y6cMpd9WkYKZFB6fM4
mkwb9INdDK1wLiI0CAXfR/+1Sj5aPuCTMMbqmTKAcEfni6vvGG6PPybpZMiHZ7IL
X8WJJ58rCP6Mn81FYtg/rQy0zgC6u3v5PgwNg/JTz9Uv7THxJffHETO5Sz7UH5Ie
lndhniM9hNrqqZF1Xu+JWvZH2tyjvHR/fzjxIrAC9uF+hBMX0rkEoNg96e96huPj
JYCDBnfODbN/8mweoAP25/8vOSLKsIifLR/gfQBLupcaXat/PXkG5X0If3/n7kM7
5MDjl8R0XVn8ko/pspWovGghwzDc0vnOqAAmQXT1jsf11ccVpLpar/qCJs7Fn+74
e4K84skeasyhKa9VbhPAgvsKXJkm/7LyQSJtTDRTvWXqduJWBmeuYoDLmt8/21rH
H04cg0P6HojTnF1rwhiL/3V5Mv159cWE7tfLBv30J+ANdS+FbgcIUwP4OrqJwPwl
A9O0stHBqoBsF5BozXO+QnkgpHyqqsFwc15qBKAe4jAtlfmD4meJ+v99334gwylq
86qH6G+IeFGhWgakd5haXeH5x3CtiIpm/Y0MpkGXgolQvs9sU08ZTGRgM19bEkEo
9xNjFGXSmDRrkWAg1Vw1KwMOB0RCorQIEBNI8z/OsQ0eOvfBFv8=
=fP0w
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
