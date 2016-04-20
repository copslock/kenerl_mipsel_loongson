Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 17:12:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10572 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27027150AbcDTPMxu2b-x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 17:12:53 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 4512B41F8E9F;
        Wed, 20 Apr 2016 16:12:47 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 20 Apr 2016 16:12:47 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 20 Apr 2016 16:12:47 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id A53B34C5ED7FF;
        Wed, 20 Apr 2016 16:12:43 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 20 Apr 2016 16:12:46 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Wed, 20 Apr
 2016 16:12:46 +0100
Date:   Wed, 20 Apr 2016 16:12:46 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>, <mingo@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <qemu-ppc@nongnu.org>,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160420151246.GY7859@jhogan-linux.le.imgtec.org>
References: <146116487861.14909.7528002102875279653.stgit@bahia.huguette.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ELMKpCVvjiB+uwRu"
Content-Disposition: inline
In-Reply-To: <146116487861.14909.7528002102875279653.stgit@bahia.huguette.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53126
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

--ELMKpCVvjiB+uwRu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, Apr 20, 2016 at 05:07:58PM +0200, Greg Kurz wrote:
> Commit 338c7dbadd26 ("KVM: Improve create VCPU parameter (CVE-2013-4587)")
> introduced a check to prevent potential kernel memory corruption in case
> the vcpu id is too great.
>=20
> Unfortunately this check assumes vcpu ids grow in sequence with a common
> difference of 1, which is wrong: archs are free to use vcpu id as they fi=
t.
> For example, QEMU originated vcpu ids for PowerPC cpus running in boot3s_=
hv
> mode, can grow with a common difference of 2, 4 or 8: if KVM_MAX_VCPUS is
> 1024, guests may be limited down to 128 vcpus on POWER8.
>=20
> This means the check does not belong here and should be moved to some arch
> specific function: kvm_arch_vcpu_create() looks like a good candidate.
>=20
> ARM and s390 already have such a check.
>=20
> I could not spot any path in the PowerPC or common KVM code where a vcpu
> id is used as described in the above commit: I believe PowerPC can live
> without this check.
>=20
> In the end, this patch simply moves the check to MIPS and x86.
>=20
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
>  arch/mips/kvm/mips.c |    3 +++
>  arch/x86/kvm/x86.c   |    3 +++
>  virt/kvm/kvm_main.c  |    3 ---
>  3 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 70ef1a43c114..ce3f1e8a8b3f 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -251,6 +251,9 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm=
, unsigned int id)
> =20
>  	struct kvm_vcpu *vcpu =3D kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
> =20
> +	if (id >=3D KVM_MAX_VCPUS)
> +		return -EINVAL;

This needs to go before the kzalloc above, otherwise you introduce a
memory leak.

Cheers
James

> +
>  	if (!vcpu) {
>  		err =3D -ENOMEM;
>  		goto out;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9b7798c7b210..f705d57b12ed 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7358,6 +7358,9 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *k=
vm,
>  {
>  	struct kvm_vcpu *vcpu;
> =20
> +	if (id >=3D KVM_MAX_VCPUS)
> +		return -EINVAL;
> +
>  	if (check_tsc_unstable() && atomic_read(&kvm->online_vcpus) !=3D 0)
>  		printk_once(KERN_WARNING
>  		"kvm: SMP vm created on host with unstable TSC; "
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 4fd482fb9260..6b6cca3cb488 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2272,9 +2272,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm=
, u32 id)
>  	int r;
>  	struct kvm_vcpu *vcpu;
> =20
> -	if (id >=3D KVM_MAX_VCPUS)
> -		return -EINVAL;
> -
>  	vcpu =3D kvm_arch_vcpu_create(kvm, id);
>  	if (IS_ERR(vcpu))
>  		return PTR_ERR(vcpu);
>=20

--ELMKpCVvjiB+uwRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXF5xuAAoJEGwLaZPeOHZ60s0QALg9Z/BOYnfQaiJ9wDAGu90S
3lMgWV+Mff+vyMKSAKfBei0XpGAqB2rIIY0kW1tVEBisF8mIMAEfRp6Mdhh4WHQn
a/of3S5GWZiiIXnl+0BdwoReLdRKl6ewOWbPVVIDCTuuvuDEXPEzCVQDhJp9jxzG
uy1xYI5wEP6ytHsmhA4hOlwb+tnO7eZKSfIr8sz66OIeZgtPfqI9iMH259Y/Rjg3
AStvgQw4TZyItA5GXM0EYi+dyJQTEIXJPA1frFSCofyHmT+r4sSjBvQilYM3Fiic
9Sngxw2W0OHkDwnITQJw6oKp0DJbDhzHaO7+2WdGJrAK7HQUzFM8Yzem1Ufp29ni
X4min9elfJ+0xAvyrekdlWcppr2akz34Kd+GlGD0AuG+0077czNzonnHvsEF7m2n
5IKcRWeth3d1NUMLz/gFoPDPFMg+gst+T7GPGjEl4SlNP40sBshOympSa5pTYajc
O3qVUaKeNpJJoMLKOFKJYkK48yd2dF5Rft+6jc5Cg52htfnzxwOSaOqzXg5brpjd
AIQ1mdixUnq8OHsJMoZYx7NORUMf4kE7fnZBdLM8BLj8iPyGY2RWh4yCk7IESiwH
yG/YMW6HTYiM49N3+j2VPGoUeFJvPfg/A2btV80gB83FE1L5JPqfVCPg1moD1G5d
F9A+EyI/TmRVpctVWisu
=z0sT
-----END PGP SIGNATURE-----

--ELMKpCVvjiB+uwRu--
