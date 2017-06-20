Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 16:54:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21717 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992143AbdFTOyiwmMhi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 16:54:38 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 785C941F8EAF;
        Tue, 20 Jun 2017 17:04:14 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 20 Jun 2017 17:04:14 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 20 Jun 2017 17:04:14 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8783631A73C79;
        Tue, 20 Jun 2017 15:54:29 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 20 Jun
 2017 15:54:32 +0100
Date:   Tue, 20 Jun 2017 15:54:32 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     James Cowgill <James.Cowgill@imgtec.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v2] KVM: MIPS: Fix maybe-uninitialized build failure
Message-ID: <20170620145432.GV6973@jhogan-linux.le.imgtec.org>
References: <20170620095751.5443-1-James.Cowgill@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="32KBALpRDK42x9o9"
Content-Disposition: inline
In-Reply-To: <20170620095751.5443-1-James.Cowgill@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58689
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

--32KBALpRDK42x9o9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 10:57:51AM +0100, James Cowgill wrote:
> This commit fixes a "maybe-uninitialized" build failure in
> arch/mips/kvm/tlb.c when KVM, DYNAMIC_DEBUG and JUMP_LABEL are all
> enabled. The failure is:
>=20
> In file included from ./include/linux/printk.h:329:0,
>                  from ./include/linux/kernel.h:13,
>                  from ./include/asm-generic/bug.h:15,
>                  from ./arch/mips/include/asm/bug.h:41,
>                  from ./include/linux/bug.h:4,
>                  from ./include/linux/thread_info.h:11,
>                  from ./include/asm-generic/current.h:4,
>                  from ./arch/mips/include/generated/asm/current.h:1,
>                  from ./include/linux/sched.h:11,
>                  from arch/mips/kvm/tlb.c:13:
> arch/mips/kvm/tlb.c: In function =E2=80=98kvm_mips_host_tlb_inv=E2=80=99:
> ./include/linux/dynamic_debug.h:126:3: error: =E2=80=98idx_kernel=E2=80=
=99 may be used uninitialized in this function [-Werror=3Dmaybe-uninitializ=
ed]
>    __dynamic_pr_debug(&descriptor, pr_fmt(fmt), \
>    ^~~~~~~~~~~~~~~~~~
> arch/mips/kvm/tlb.c:169:16: note: =E2=80=98idx_kernel=E2=80=99 was declar=
ed here
>   int idx_user, idx_kernel;
>                 ^~~~~~~~~~
>=20
> There is a similar error relating to "idx_user". Both errors were
> observed with GCC 6.
>=20
> As far as I can tell, it is impossible for either idx_user or idx_kernel
> to be uninitialized when they are later read in the calls to kvm_debug,
> but to satisfy the compiler, add zero initializers to both variables.
>=20
> Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
> Fixes: 57e3869cfaae ("KVM: MIPS/TLB: Generalise host TLB invalidate to ke=
rnel ASID")
> Cc: <stable@vger.kernel.org> # 4.11+

Acked-by: James Hogan <james.hogan@imgtec.com>

Paolo / Radim: is it okay for one of you to pick this one up for 4.12?

Thanks
James

> ---
>  arch/mips/kvm/tlb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
> index 7c6336dd2638..7cd92166a0b9 100644
> --- a/arch/mips/kvm/tlb.c
> +++ b/arch/mips/kvm/tlb.c
> @@ -166,7 +166,11 @@ static int _kvm_mips_host_tlb_inv(unsigned long entr=
yhi)
>  int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va,
>  			  bool user, bool kernel)
>  {
> -	int idx_user, idx_kernel;
> +	/*
> +	 * Initialize idx_user and idx_kernel to workaround bogus
> +	 * maybe-initialized warning when using GCC 6.
> +	 */
> +	int idx_user =3D 0, idx_kernel =3D 0;
>  	unsigned long flags, old_entryhi;
> =20
>  	local_irq_save(flags);
> --=20
> 2.11.0
>=20

--32KBALpRDK42x9o9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllJNx4ACgkQbAtpk944
dnr6Pg/9HWh09LB9ENpF+7CTVyQ/tVBMaDe3o5DxHrR41jMgbyqMDrgaJz9Fpons
Jz9limbEqeUh2c6wXQ0AJl/z5PQmNJqoeiNPWrpckq1SwfiWwkder7Z8KaxfJxeg
AspKaZBmg/N/tvcDXK3dzkgAdm/acts/lN1BUTAShjiCTNGooaJdqCu1difo+h7D
tH0F9fYR5MQTLoZjStViI/tdHo9P0Y7zBWnBvOJn6ghVMb7K39hlDhT9E0AJ/dwD
0r92SlpiXu4QukmvWuKZIFYCB4H8unMvGSFi7L/CMz4/qhtgVkepsBBONvMddvXJ
x9JJ26cn7gc79wotnKw3vEIJhzcRChrsfGVet6J0Cc8Fl93M80QaE3h0h6J7msTp
kwsOikcyGHlMhnReOTeclw3dNJr/9l3+gjqPAQlZkj/OLOYJptTz7s+LxtUDDJaI
Ikmvsmz1/sO1l74mRVPBLp9gmGylCF9sWvNwEEXLvPEhT40Qn5WL3QUJGRxeIrhS
FbT2lvHvt5TftdWp85AZiR5hVe1JlSoq2QoUuGSQTnRyTMjmI0FmrMmBXKfs5dlD
/uX5Tj2NLOWeP+50UhOUwDVDSoR/7j2NZ+xvuFVxuKzNOn1NuB+4+sBCfAUYJgIi
ehRAvI59R7+wMxuhM8i3x4m8XYB+SK5STqWpTCnCdl5wBEcjGrE=
=9hU6
-----END PGP SIGNATURE-----

--32KBALpRDK42x9o9--
