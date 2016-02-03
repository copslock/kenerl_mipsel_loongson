Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 15:44:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4318 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011264AbcBCOoYF6vK3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 15:44:24 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id BEA6241F8DC8;
        Wed,  3 Feb 2016 14:44:18 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 03 Feb 2016 14:44:18 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 03 Feb 2016 14:44:18 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 4BEABED9DD12B;
        Wed,  3 Feb 2016 14:44:16 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 14:44:18 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 14:44:17 +0000
Date:   Wed, 3 Feb 2016 14:44:17 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "stable # v4 . 3" <stable@vger.kernel.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        James Cowgill <James.Cowgill@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH] MIPS: Fix MSA ld unaligned failure cases
Message-ID: <20160203144417.GI5038@jhogan-linux.le.imgtec.org>
References: <1454470549-19411-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a7XSrSxqzVsaECgU"
Content-Disposition: inline
In-Reply-To: <1454470549-19411-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 56f439c
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51693
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

--a7XSrSxqzVsaECgU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2016 at 03:35:49AM +0000, Paul Burton wrote:
> Copying the content of an MSA vector from user memory may involve TLB
> faults & mapping in pages. This will fail when preemption is disabled
> due to an inability to acquire mmap_sem from do_page_fault, which meant
> such vector loads to unmapped pages would always fail to be emulated.
> Fix this by disabling preemption later only around the updating of
> vector register state.
>=20
> This change does however introduce a race between performing the load
> into thread context & the thread being preempted, saving its current
> live context & clobbering the loaded value. This should be a rare
> occureence, so optimise for the fast path by simply repeating the load if
> we are preempted.
>=20
> Additionally if the copy failed then the failure path was taken with
> preemption left disabled, leading to the kernel typically encountering
> further issues around sleeping whilst atomic. The change to where
> preemption is disabled avoids this issue.
>=20
> Fixes: e4aa1f153add "MIPS: MSA unaligned memory access support"
> Reported-by: James Hogan <james.hogan@imgtec.com>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: stable <stable@vger.kernel.org> # v4.3

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

>=20
> ---
>=20
>  arch/mips/kernel/unaligned.c | 51 ++++++++++++++++++++++++++------------=
------
>  1 file changed, 30 insertions(+), 21 deletions(-)
>=20
> diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
> index 490cea5..5c62065 100644
> --- a/arch/mips/kernel/unaligned.c
> +++ b/arch/mips/kernel/unaligned.c
> @@ -885,7 +885,7 @@ static void emulate_load_store_insn(struct pt_regs *r=
egs,
>  {
>  	union mips_instruction insn;
>  	unsigned long value;
> -	unsigned int res;
> +	unsigned int res, preempted;
>  	unsigned long origpc;
>  	unsigned long orig31;
>  	void __user *fault_addr =3D NULL;
> @@ -1226,27 +1226,36 @@ static void emulate_load_store_insn(struct pt_reg=
s *regs,
>  			if (!access_ok(VERIFY_READ, addr, sizeof(*fpr)))
>  				goto sigbus;
> =20
> -			/*
> -			 * Disable preemption to avoid a race between copying
> -			 * state from userland, migrating to another CPU and
> -			 * updating the hardware vector register below.
> -			 */
> -			preempt_disable();
> -
> -			res =3D __copy_from_user_inatomic(fpr, addr,
> -							sizeof(*fpr));
> -			if (res)
> -				goto fault;
> -
> -			/*
> -			 * Update the hardware register if it is in use by the
> -			 * task in this quantum, in order to avoid having to
> -			 * save & restore the whole vector context.
> -			 */
> -			if (test_thread_flag(TIF_USEDMSA))
> -				write_msa_wr(wd, fpr, df);
> +			do {
> +				/*
> +				 * If we have live MSA context keep track of
> +				 * whether we get preempted in order to avoid
> +				 * the register context we load being clobbered
> +				 * by the live context as it's saved during
> +				 * preemption. If we don't have live context
> +				 * then it can't be saved to clobber the value
> +				 * we load.
> +				 */
> +				preempted =3D test_thread_flag(TIF_USEDMSA);
> +
> +				res =3D __copy_from_user_inatomic(fpr, addr,
> +								sizeof(*fpr));
> +				if (res)
> +					goto fault;
> =20
> -			preempt_enable();
> +				/*
> +				 * Update the hardware register if it is in use
> +				 * by the task in this quantum, in order to
> +				 * avoid having to save & restore the whole
> +				 * vector context.
> +				 */
> +				preempt_disable();
> +				if (test_thread_flag(TIF_USEDMSA)) {
> +					write_msa_wr(wd, fpr, df);
> +					preempted =3D 0;
> +				}
> +				preempt_enable();
> +			} while (preempted);
>  			break;
> =20
>  		case msa_st_op:
> --=20
> 2.7.0
>=20

--a7XSrSxqzVsaECgU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWshJBAAoJEGwLaZPeOHZ6UL0P/AzUrjY+WoWZvt/el0wgezW3
I0IbQ/Cf5Q9M7/RC4GtNK4bNhugyhI8XBwomtD5epXmaK+oLxiCZqTz6doL1JjKw
1m2eB+L0yfYM4SL+R+L/QrJ090bSpjrh+faMQKybQubInU/PrKaaxmlsoHtVpMce
iSLcmXZu0/mnYivGWUxiqkixGwwMf2lNNIGDBSNyir/IB0EABV1hB/8sXexhk7jX
tdc7w84WiEg0uGwRcE2pljDDk+kKMqWM09ndXowQ+8VOi9ceC4RfbA9G0aEgBVF/
v0ENYCB1iaPeAcaNMOt1Ct2qmI/6gBii8f9E1RW26fTeFqbgIEP+mTMHyRnigV1C
DbkDbrequQ+kWQccIt/aYmUn/QddkmFwv4/y9e1cmeNnaZcekf4YpOsI/oh+WFkE
AptL70odI61jdlaQuQq/5WZO/kHrKmyG/vaotgXtaDRWG6Cy5001E7xo7WvXlhQf
Eo6++V1zW3kLgipNIbHYNtm/dOgsRYF0FMFcLQ/a3gJ3R7yj8DMwPtVoAMEAqT20
wSgo8Qao4tRcdob2utI+uQU9iti4noKFKKdw3Eo8k0arWiyxRunhsuaIxhimCARn
4Fz66Ytatnna9TkH4hwJyUJEs3zuyjHfGj1w8bk0KI+sl4ptNEAPJHiLUT4iGISF
AIoETZjtussrP7eXVlO9
=SNcU
-----END PGP SIGNATURE-----

--a7XSrSxqzVsaECgU--
