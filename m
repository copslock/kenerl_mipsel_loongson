Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 09:10:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37788 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006835AbbCDIKqfP5FJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 09:10:46 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 9AC0941F8E14;
        Wed,  4 Mar 2015 08:10:41 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 04 Mar 2015 08:10:41 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 04 Mar 2015 08:10:41 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9FB79FBEE5A54;
        Wed,  4 Mar 2015 08:10:39 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 4 Mar 2015 08:10:41 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 4 Mar
 2015 08:10:40 +0000
Date:   Wed, 4 Mar 2015 08:10:40 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3.14 58/73] KVM: MIPS: Dont leak FPU/DSP to guest
Message-ID: <20150304081040.GA28401@jhogan-linux.le.imgtec.org>
References: <20150304055332.344462103@linuxfoundation.org>
 <20150304055342.084533773@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20150304055342.084533773@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46146
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

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, Mar 03, 2015 at 10:13:26PM -0800, Greg Kroah-Hartman wrote:
> 3.14-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: James Hogan <james.hogan@imgtec.com>
>=20
> commit f798217dfd038af981a18bbe4bc57027a08bb182 upstream.
>=20
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

The original 3.10 and 3.12/3.14 backports had this added:
Cc: <stable@vger.kernel.org> # v3.10+: 3ce465e04bfd: MIPS: Export FP functi=
ons used by lose_fpu(1) for KVM                                        =20
Which I can't see included in the v3.10 stable queue or branch. It fixes
a build error with MIPS malta_kvm_defconfig (MIPS=3Dy, KVM=3Dm) after this
patch is applied.

Same applies to the 3.14 queue too I think.

Cheers
James

> Cc: <stable@vger.kernel.org> # v3.10+
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> This should apply to stable trees 3.12 and 3.14, but not 3.10. The files
> had been renamed since v3.14 so it cherry-picked cleanly but the patch
> didn't apply cleanly. I've also added a reference to the "MIPS: Export
> FP functions used by lose_fpu(1) for KVM" commit which is itself marked
> for stable, but is needed to avoid a build failure when KVM=3Dm.
> ---
>  arch/mips/kvm/kvm_locore.S |    2 +-
>  arch/mips/kvm/kvm_mips.c   |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> --- a/arch/mips/kvm/kvm_locore.S
> +++ b/arch/mips/kvm/kvm_locore.S
> @@ -428,7 +428,7 @@ __kvm_mips_return_to_guest:
>  	/* Setup status register for running guest in UM */
>  	.set	at
>  	or	v1, v1, (ST0_EXL | KSU_USER | ST0_IE)
> -	and	v1, v1, ~ST0_CU0
> +	and	v1, v1, ~(ST0_CU0 | ST0_MX)
>  	.set	noat
>  	mtc0	v1, CP0_STATUS
>  	ehb
> --- a/arch/mips/kvm/kvm_mips.c
> +++ b/arch/mips/kvm/kvm_mips.c
> @@ -15,6 +15,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/fs.h>
>  #include <linux/bootmem.h>
> +#include <asm/fpu.h>
>  #include <asm/page.h>
>  #include <asm/cacheflush.h>
>  #include <asm/mmu_context.h>
> @@ -418,6 +419,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
>  		vcpu->mmio_needed =3D 0;
>  	}
> =20
> +	lose_fpu(1);
> +
>  	local_irq_disable();
>  	/* Check if we have any exceptions/interrupts pending */
>  	kvm_mips_deliver_interrupts(vcpu,
> @@ -1021,9 +1024,6 @@ void kvm_mips_set_c0_status(void)
>  {
>  	uint32_t status =3D read_c0_status();
> =20
> -	if (cpu_has_fpu)
> -		status |=3D (ST0_CU1);
> -
>  	if (cpu_has_dsp)
>  		status |=3D (ST0_MX);
> =20
>=20
>=20

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU9r4AAAoJEGwLaZPeOHZ6eXoP/1cn/+qkImi8lKq1wmPEbs6E
OHU7u2tbDGRCn0Fj/eU7X5ehLfEty3v1iv7u7b+nVWyex47q3fJVJ2E5h+YswtV9
SdamZxfbz3UliLLnWj41rQJN1WUaB4sVWNS4+PTBtHB/HbyyllphcVJvsZL3n7Wh
l/ox8KGgp70UcAdQ+aH8qZ7T6RvOzw2SYg+CB5LFZMn58W1vGzzq67hYCVUsW4EZ
yaCLThYxt7vNXgFTSd2NSzvmklzwYe8GF2zu3rqrZBRw81Mhw/wc8ru5mLLNQAMt
6kFQVW637ErVRMi7PKYSdrc14sChiOaqsovd3alkd6e7VFcib27QYMpqmqHSZdhW
ITvukbXpb6T9dOsrH35PviSv2Y2n04F7T4lKuauQmFVXI3cLMHNhdP8g2yqJiz0H
piLBQNPPCE9H+jIJavkBrFm3nFVrsXRT0PMjR9JIH17mlPro0+r8C22A+CI3Ns5l
OXrgK2yypkl97HTTjcG9da8/EYiSW+KUoWRl9xYVk1C2xe0aojLjvlr/bRHTKiEr
56CkUlRKPeQ3umHxGZyIy2ypwZodx+WK4ahYDZdybSVqjfclyPyhlvE9qJSY4sRC
/6FR+u37EAFPEhI1QhqvUJGsVbXYPtZdYSVDw0HM9VeJG0qDQK6H7frJvwa9Y1xp
q9OLBqgiw8iFv9FSqnoa
=nxPA
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
