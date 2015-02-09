Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2015 23:58:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53455 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013095AbbBIW6YAom1A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Feb 2015 23:58:24 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 95AEB41F8DB6;
        Mon,  9 Feb 2015 22:58:18 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 09 Feb 2015 22:58:18 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 09 Feb 2015 22:58:18 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8B61DAAD84215;
        Mon,  9 Feb 2015 22:58:14 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 9 Feb 2015 22:58:18 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 9 Feb
 2015 22:58:16 +0000
Date:   Mon, 9 Feb 2015 22:58:16 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        "Gleb Natapov" <gleb@kernel.org>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] KVM: MIPS: Don't leak FPU/DSP to guest
Message-ID: <20150209225816.GH30459@jhogan-linux.le.imgtec.org>
References: <1423069597-8376-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BXr400anF0jyguTS"
Content-Disposition: inline
In-Reply-To: <1423069597-8376-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45785
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

--BXr400anF0jyguTS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Wed, Feb 04, 2015 at 05:06:37PM +0000, James Hogan wrote:
> The FPU and DSP are enabled via the CP0 Status CU1 and MX bits by
> kvm_mips_set_c0_status() on a guest exit, presumably in case there is
> active state that needs saving if pre-emption occurs. However neither of
> these bits are cleared again when returning to the guest.
>=20
> This effectively gives the guest access to the FPU/DSP hardware after
> the first guest exit even though it is not aware of its presence,
> allowing FP instructions in guest user code to intermittently actually
> execute instead of trapping into the guest OS for emulation. It will
> then read & manipulate the hardware FP registers which technically
> belong to the user process (e.g. QEMU), or are stale from another user
> process. It can also crash the guest OS by causing an FP exception, for
> which a guest exception handler won't have been registered.
>=20
> First lets save and disable the FPU (and MSA) state with lose_fpu(1)

Please don't apply this patch yet. lose_fpu() uses function symbols
which aren't exported for modules to use yet, so that'll need fixing
first or KVM won't build as a module.

Thanks
James

> before entering the guest. This simplifies the problem, especially for
> when guest FPU/MSA support is added in the future, and prevents FR=3D1 FPU
> state being live when the FR bit gets cleared for the guest, which
> according to the architecture causes the contents of the FPU and vector
> registers to become UNPREDICTABLE.
>=20
> We can then safely remove the enabling of the FPU in
> kvm_mips_set_c0_status(), since there should never be any active FPU or
> MSA state to save at pre-emption, which should plug the FPU leak.
>=20
> DSP state is always live rather than being lazily restored, so for that
> it is simpler to just clear the MX bit again when re-entering the guest.
>=20
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Sanjay Lal <sanjayl@kymasys.com>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # v3.10+: 044f0f03eca0: MIPS: KVM: Deliver g=
uest interrupts
> Cc: <stable@vger.kernel.org> # v3.10+
> ---
>  arch/mips/kvm/locore.S | 2 +-
>  arch/mips/kvm/mips.c   | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
> index d7279c03c517..4a68b176d6e4 100644
> --- a/arch/mips/kvm/locore.S
> +++ b/arch/mips/kvm/locore.S
> @@ -434,7 +434,7 @@ __kvm_mips_return_to_guest:
>  	/* Setup status register for running guest in UM */
>  	.set	at
>  	or	v1, v1, (ST0_EXL | KSU_USER | ST0_IE)
> -	and	v1, v1, ~ST0_CU0
> +	and	v1, v1, ~(ST0_CU0 | ST0_MX)
>  	.set	noat
>  	mtc0	v1, CP0_STATUS
>  	ehb
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index dd133ccecec4..270bbd41769e 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -15,6 +15,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/fs.h>
>  #include <linux/bootmem.h>
> +#include <asm/fpu.h>
>  #include <asm/page.h>
>  #include <asm/cacheflush.h>
>  #include <asm/mmu_context.h>
> @@ -379,6 +380,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, st=
ruct kvm_run *run)
>  		vcpu->mmio_needed =3D 0;
>  	}
> =20
> +	lose_fpu(1);
> +
>  	local_irq_disable();
>  	/* Check if we have any exceptions/interrupts pending */
>  	kvm_mips_deliver_interrupts(vcpu,
> @@ -987,9 +990,6 @@ static void kvm_mips_set_c0_status(void)
>  {
>  	uint32_t status =3D read_c0_status();
> =20
> -	if (cpu_has_fpu)
> -		status |=3D (ST0_CU1);
> -
>  	if (cpu_has_dsp)
>  		status |=3D (ST0_MX);
> =20
> --=20
> 2.0.5
>=20

--BXr400anF0jyguTS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU2TuIAAoJEGwLaZPeOHZ6ilQP/RwtJBQEgQ4UKjrgpC//ATCR
+6G+KMPwMKwpcjIX4/ncX+eMHalnDQwL4ghnURyp6im+PV9XLRmi2Yi3zRa0V7Ya
6A+AHWHE6FMtuKl8IoVLnwZrt3CdsI8AvjqHt3csSJzQR9tmHRLHk+OdeVlEwR6e
8eSX1PPMusm0kMSSnKS68xA54dIYg0JApbsxj78Mq6nyRlxeZ8MkXrz2IaxvdPH1
LXvxbqwNXdXC7nOLTR9DkVK0E5UUki6UpmUbDZhFJ5KzrRJOgAYkcOep2N4IAGeE
JSOMzhFCWLaJIMhwBApo7C6I/2FOTjBn7pWNZgfaosjADtVG2x3vyB94LlUTrrkY
X4TTodDw9KX3zvosmgwqGi0I0WmM5Jc2Cenr+ZfQLuuIFx/KlhcEvRH4j/t6k7yG
y+WGehebnylugUIabli37JUBijz7ycWiL5HNJS/FmN7Dbfi9SxdcWelVFZMoTjGh
P/tHDkG2uifUJqL2drUYn2sg7khR/TbJtQ5IXjuhNgYLMnbJDrjL5s2eKnsTO23d
ieojKAjmMOlBS+bWxjrLRWup7arofq/UqyRetfuRT0sl4stjjjYT0JknTLKMDxa7
zLp4wB1hg7FsxvLypWFRsVUF+LqPlE7+2PRZjqAT69iMs5uEyLSwg1wmoaeg2K7q
at+ECrMA4Eb1RbyL0sv6
=EJKs
-----END PGP SIGNATURE-----

--BXr400anF0jyguTS--
