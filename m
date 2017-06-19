Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 23:20:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20272 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991957AbdFSVUJjBVLm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jun 2017 23:20:09 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 23FF941F8E5F;
        Mon, 19 Jun 2017 23:29:43 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 19 Jun 2017 23:29:43 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 19 Jun 2017 23:29:43 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E8B46D496C2DF;
        Mon, 19 Jun 2017 22:19:58 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 19 Jun
 2017 22:20:03 +0100
Date:   Mon, 19 Jun 2017 22:20:03 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     James Cowgill <James.Cowgill@imgtec.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: MIPS: Fix maybe-uninitialized build failure
Message-ID: <20170619212003.GQ6973@jhogan-linux.le.imgtec.org>
References: <20170616120502.2660-1-James.Cowgill@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HSfddtAs2KjjielS"
Content-Disposition: inline
In-Reply-To: <20170616120502.2660-1-James.Cowgill@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58636
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

--HSfddtAs2KjjielS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 01:05:02PM +0100, James Cowgill wrote:
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
> There is a similar error relating to "idx_user".
>=20
> As far as I can tell, it is impossible for either idx_user or idx_kernel
> to be uninitialized when they are later read in the calls to kvm_debug,
> but to satisfy the compiler, add zero initializers to both variables.

Stupid compiler (or maybe its too smart for its own good).

>=20
> Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
> Fixes: 57e3869cfaae ("KVM: MIPS/TLB: Generalise host TLB invalidate to ke=
rnel ASID")
> Cc: <stable@vger.kernel.org> # 4.11+
> ---
>  arch/mips/kvm/tlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
> index 7c6336dd2638..41d239269988 100644
> --- a/arch/mips/kvm/tlb.c
> +++ b/arch/mips/kvm/tlb.c
> @@ -166,7 +166,7 @@ static int _kvm_mips_host_tlb_inv(unsigned long entry=
hi)
>  int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va,
>  			  bool user, bool kernel)
>  {
> -	int idx_user, idx_kernel;
> +	int idx_user =3D 0, idx_kernel =3D 0;

Can you add a quick comment here to say this is to workaround a bogus
maybe-initialized warning, and the rough compiler version?

Thanks
James

>  	unsigned long flags, old_entryhi;
> =20
>  	local_irq_save(flags);
> --=20
> 2.11.0
>=20

--HSfddtAs2KjjielS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllIQAIACgkQbAtpk944
dnrfZw//VcHhPTthSipGDxy+19mRYs/MiCac8MDqbin3M2H64TN6NvnzvUU1+Jpr
Q4NABj4hJTmOM0Mhx76pyoL2DRb0wbMgnUCOayvxKb1lVnfXXIqCB347ZBOcmKcj
pA+8TLHzkGw3+2are97HX9l6t72LOPleWwGGqDKBFxqYI72BZTxR7HGTRVyh8Fvo
f/nJTKdanUJLXBjV2sfZMD/+jiyoXcWHBGAQqDBvgCbb/r4EuH0UY+2Q2qwTBkkD
+aOGkuwa0uVWQXVU++lAdap46jj2uHuyZkw+bklS7l971JbC+weoQvE3FhaTYPOJ
kTtiV8khp/2KYWyfShzIhIT/g4sIbCrXw/MOEiyFZb3DJ2j08HYT7gWzZXZLa+QX
PzHwavkEJIbvmo3hI3JMcfLBRYHaRoY1Z9fe1t/XLb5dWgSuLLjdHkq94N4JHJJR
yqimFe5SMBwmwmPUBKsJ09t9cs3PfWJSip7fUtculFncpfqltVKpm1rm/k0v2BeT
GdV/f/EvM4bdS6lwlgf8MwA6AhYZFKBWuTOi1qrhCVAJBipDlEUAG3FbCbzDf+X6
kMdCYRG1Dz7MiAwm7PaLwrgYFJ9zzOzR3b3o4rUUv/eQ/RLVJApnRFY7rfYoP3m0
Z7XFPV46bsyDE01fuupAFlXntB4blcHYvDZYXRtn6yCgvZHUtDU=
=MrKi
-----END PGP SIGNATURE-----

--HSfddtAs2KjjielS--
