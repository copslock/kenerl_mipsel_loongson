Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2018 00:02:56 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:40280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994661AbeDRWCsx8617 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Apr 2018 00:02:48 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1549321781;
        Wed, 18 Apr 2018 22:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1549321781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 18 Apr 2018 23:02:37 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] MIPS: memset.S: Fix clobber of v1 in last_fixup
Message-ID: <20180418220237.GC16439@saruman>
References: <1523979603-492-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
In-Reply-To: <1523979603-492-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63601
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


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 04:40:00PM +0100, Matt Redfearn wrote:
> The label .Llast_fixup\@ is jumped to on page fault within the final
> byte set loop of memset (on < MIPSR6 architectures). For some reason, in
> this fault handler, the v1 register is randomly set to a2 & STORMASK.
> This clobbers v1 for the calling function. This can be observed with the
> following test code:
>=20
> static int __init __attribute__((optimize("O0"))) test_clear_user(void)
> {
>   register int t asm("v1");
>   char *test;
>   int j, k;
>=20
>   pr_info("\n\n\nTesting clear_user\n");
>   test =3D vmalloc(PAGE_SIZE);
>=20
>   for (j =3D 256; j < 512; j++) {
>     t =3D 0xa5a5a5a5;
>     if ((k =3D clear_user(test + PAGE_SIZE - 256, j)) !=3D j - 256) {
>         pr_err("clear_user (%px %d) returned %d\n", test + PAGE_SIZE - 25=
6, j, k);
>     }
>     if (t !=3D 0xa5a5a5a5) {
>        pr_err("v1 was clobbered to 0x%x!\n", t);
>     }
>   }
>=20
>   return 0;
> }
> late_initcall(test_clear_user);
>=20
> Which demonstrates that v1 is indeed clobbered (MIPS64):
>=20
> Testing clear_user
> v1 was clobbered to 0x1!
> v1 was clobbered to 0x2!
> v1 was clobbered to 0x3!
> v1 was clobbered to 0x4!
> v1 was clobbered to 0x5!
> v1 was clobbered to 0x6!
> v1 was clobbered to 0x7!
>=20
> Since the number of bytes that could not be set is already contained in
> a2, the andi placing a value in v1 is not necessary and actively
> harmful in clobbering v1.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: James Hogan <jhogan@kernel.org>
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks, Patches 1 & 2 applied to my fixes branch.

Cheers
James

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrXwHwACgkQbAtpk944
dnrHag/+IUrJMlxzFTrTonbr0bNVombMS6zD7ZSDJ/bBAJnm6Y4xE4iTFXOVISXS
F4LVlo3zwJNwzTIrjXCb1tMgZPNeqeYykVZ9xyotAtriPQAFcfGyISeyhkTxwb1o
B5yXVcpEHdrZIf0QYD5SyAFlUNXD7nDFq421UmdXtEnzNp/6Wgjrak5oGjyNRhu8
1ZiWmL8BlH/Qh0gVSj2RnAsX9VpNkJJ7jWqm52xI32uqU4njbz+iTLt8Y9ulypVO
kuArCI3CWgmi+2ABT1xnvil6Vdi/gRW2nH4NzMxJCtMd4NQju88+YnJwMjO5ki9A
fOOdzi5C5pm0+ArxnMvfjZR+7JOf7x/c9VAqJdMSiNGCY/FnLMdwMqcZ2B+FEG9q
HMMDDizsi4PdCXICHEAREMnDhrSTlUMi+u2ib/uMy3EKuxYIKLIt6Fe7ONe3T+Nh
mBMTWs2zzrG6VkhAB5MBD5ksoSw9/uoHFHysJkKzptNeE8sp/0EqLFl7erWk4Ivm
5YH120f8YidC75fNCR6dXdhV15ejPScrwdo1jkEGginVP/rK7WR8LZPjbl8RVRnl
HX8qIL76bR8ThEHVopBaY1JhurkmFxaOfrPpMsw4DEMkf3EQgNAW1dBT/lAI6djh
BxFZ4jpQA3k4V0+8xOAUi+1EUaGAVKUcuiafdOcO8+Dyg10jQPg=
=S1hV
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
