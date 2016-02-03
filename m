Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 15:48:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45878 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012288AbcBCOspLw3F3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 15:48:45 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id D9C3E41F8DC8;
        Wed,  3 Feb 2016 14:48:39 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 03 Feb 2016 14:48:39 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 03 Feb 2016 14:48:39 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 717A362EE8246;
        Wed,  3 Feb 2016 14:48:37 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 14:48:39 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 14:48:39 +0000
Date:   Wed, 3 Feb 2016 14:48:39 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/15] MIPS: pm-cps: Avoid offset overflow on MIPSr6
Message-ID: <20160203144838.GG5464@jhogan-linux.le.imgtec.org>
References: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
 <1454469335-14778-4-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Content-Disposition: inline
In-Reply-To: <1454469335-14778-4-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 56f439c
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51694
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

--m972NQjnE83KvVa/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2016 at 03:15:23AM +0000, Paul Burton wrote:
> From: Markos Chandras <markos.chandras@imgtec.com>
>=20
> This is similar to commit 934c79231c1b ("MIPS: asm: r4kcache: Add MIPS
> R6 cache unroll functions"). The CACHE instruction has been redefined
> for MIPSr6 and it reduced its offset field to 8 bits. This leads to
> micro-assembler field overflow warnings when booting SMP MIPSr6 cores
> like the following one:
>=20
> Call Trace:
> [<ffffffff8010af88>] show_stack+0x68/0x88
> [<ffffffff8056ddf0>] dump_stack+0x68/0x88
> [<ffffffff801305bc>] warn_slowpath_common+0x8c/0xc8
> [<ffffffff80130630>] warn_slowpath_fmt+0x38/0x48
> [<ffffffff80125814>] build_insn+0x514/0x5c0
> [<ffffffff806ee134>] cps_gen_cache_routine.isra.3+0xe0/0x1b8
> [<ffffffff806ee570>] cps_pm_init+0x364/0x9ec
> [<ffffffff80100538>] do_one_initcall+0x90/0x1a8
> [<ffffffff806e8c14>] kernel_init_freeable+0x160/0x21c
> [<ffffffff8056b6a0>] kernel_init+0x10/0xf8
> [<ffffffff801059f8>] ret_from_kernel_thread+0x14/0x1c
>=20
> We fix this by incrementing the base register on every loop.
>=20
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>=20
>  arch/mips/kernel/pm-cps.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
> index f63a289..524ba11 100644
> --- a/arch/mips/kernel/pm-cps.c
> +++ b/arch/mips/kernel/pm-cps.c
> @@ -224,11 +224,18 @@ static void __init cps_gen_cache_routine(u32 **pp, =
struct uasm_label **pl,
>  	uasm_build_label(pl, *pp, lbl);
> =20
>  	/* Generate the cache ops */
> -	for (i =3D 0; i < unroll_lines; i++)
> -		uasm_i_cache(pp, op, i * cache->linesz, t0);
> +	for (i =3D 0; i < unroll_lines; i++) {

Maybe worth adding a comment here to mention different immediate field
size in r6 encodings, otherwise it could look a bit mysterious to the
reader.

Cheers
James

> +		if (cpu_has_mips_r6) {
> +			uasm_i_cache(pp, op, 0, t0);
> +			uasm_i_addiu(pp, t0, t0, cache->linesz);
> +		} else {
> +			uasm_i_cache(pp, op, i * cache->linesz, t0);
> +		}
> +	}
> =20
> -	/* Update the base address */
> -	uasm_i_addiu(pp, t0, t0, unroll_lines * cache->linesz);
> +	if (!cpu_has_mips_r6)
> +		/* Update the base address */
> +		uasm_i_addiu(pp, t0, t0, unroll_lines * cache->linesz);
> =20
>  	/* Loop if we haven't reached the end address yet */
>  	uasm_il_bne(pp, pr, t0, t1, lbl);
> --=20
> 2.7.0
>=20
>=20

--m972NQjnE83KvVa/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWshNGAAoJEGwLaZPeOHZ6E2oP/0k2Jqgng4sEXpZi5kCXX+0+
E8QLoGqCg9BytB0wHOtkOkSotAcmVrfYB7+rLtjzdn0DGYGoLrVTxCBhDZ/viLQQ
jZuR9UZXXveTqM6Ws+H5ZXL+Hi/uhYv0XmZolM69OUBTBh6EmNFM8aa3j1irnPzZ
rN2RCD6fh9Glu7yXju2f1R/qRyMp66gbZSOD48OSnc4DlOt3J50krRF6sFckQEdy
W0cywaE8vYKTpiHJZ3MMbFZlg6bqJ2b5Q4scD4ff+cmeqsedJsInPw6cYLBzvjCT
bWDJg5MEBHGCzMYZdVd8cq8K0ucRiB4w0fyxqs44pdEaNIQbm20191c3rb/8rHRG
IofppYgaj47HiKXnufMTl7uDtswVpH1r0ov/ntiDFMoOoD8S4I4rfsPlFPigXmj8
mnIUX5PqCvVN0Psphmi+QCgNONC+4Y+K+t9eygOyMKw3zBWkHpV+/K2ieuD0nDBr
iOPCMamJiqwV06zDVVvl5A9QmvmIecj/S4R0xYzgP/UBi3Cbmnz2s6c58N2YGE+L
PxNxZgWygTo++yrbS1uW3+nuzEI9ymJULWh1s3sZYH7dUnUQjObroY0ghvtICSXH
LGpgTaJg9kSXZmO4DftN4oxKjUy2pdEFywdAKjyponBmHOBjf+OW2dS4Jq6/2vST
n/B6A4RAyr2dkjUovVjo
=Q0sr
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--
