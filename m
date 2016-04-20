Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 18:10:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37883 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27027161AbcDTQKIjjxJs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 18:10:08 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 1AADC41F8EBB;
        Wed, 20 Apr 2016 17:10:03 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 20 Apr 2016 17:10:03 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 20 Apr 2016 17:10:03 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 551E41A8244BC;
        Wed, 20 Apr 2016 17:09:59 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 20 Apr 2016 17:10:02 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Wed, 20 Apr
 2016 17:10:02 +0100
Date:   Wed, 20 Apr 2016 17:10:01 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>, <mingo@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <qemu-ppc@nongnu.org>,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160420161001.GZ7859@jhogan-linux.le.imgtec.org>
References: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mu4zWe6QekgCAJVd"
Content-Disposition: inline
In-Reply-To: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53133
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

--mu4zWe6QekgCAJVd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 20, 2016 at 05:44:54PM +0200, Greg Kurz wrote:
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
> v3: use ERR_PTR()
>=20
>  arch/mips/kvm/mips.c |    7 ++++++-

Acked-by: James Hogan <james.hogan@imgtec.com> [MIPS]

Cheers
James

>  arch/x86/kvm/x86.c   |    3 +++
>  virt/kvm/kvm_main.c  |    3 ---
>  3 files changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 70ef1a43c114..0278ea146db5 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -248,9 +248,14 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kv=
m, unsigned int id)
>  	int err, size, offset;
>  	void *gebase;
>  	int i;
> +	struct kvm_vcpu *vcpu;
> =20
> -	struct kvm_vcpu *vcpu =3D kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
> +	if (id >=3D KVM_MAX_VCPUS) {
> +		err =3D -EINVAL;
> +		goto out;
> +	}
> =20
> +	vcpu =3D kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
>  	if (!vcpu) {
>  		err =3D -ENOMEM;
>  		goto out;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9b7798c7b210..7738202edcce 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7358,6 +7358,9 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *k=
vm,
>  {
>  	struct kvm_vcpu *vcpu;
> =20
> +	if (id >=3D KVM_MAX_VCPUS)
> +		return ERR_PTR(-EINVAL);
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

--mu4zWe6QekgCAJVd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXF6nZAAoJEGwLaZPeOHZ6XiEP/Rv+xoVaNIxOf3F+CjLAX3xb
3PEF3r1DXfpC63fYyI0bfB1Ph+s0/lbQa4sKtcJ/vkk7b8lklW11mZK3hftQjePv
A6beLAu+Qw9Q9G4YQHfiOT8G4GQr8b5NiODEDUdRB0MWUq9/UoBQPIEvaK5XeZY7
K6ZSMRvyJ53gqa9EuesKE1zcMKOiWNA47L4kpOicVHjKhwzr/vc3PshlIEYhNXpD
wn4bJtCrPn0vaxo12KKJoy8pNnCHYdqhSbRzvQo/aIE7GgLvwnYd9WGXTr3X8iBH
MBj1xv5fJ3X1zSL6G7tycelT0glVw0gUBThzQytcLTm2alyTCcTXO4T97zztlJQ0
bgsWVHOeDG1gQwbQdX8jtLgKAd/r4AxiAjG4itD9eoo+Y6W4O2rfS6QyjLfODL5u
2/cOHCVVhpvYntmF0nLw1P+Du3DdYWv8elMekRaJFSstB2ewFM6OGGoZOUAYNF8P
jW44+jpVnfpMN//rzdJyqoljs/a8X0OmPLWYBYPEQFRllLjVmFWzrufxHYlARwHu
TH0/APHa+5LE/cdz9GpEzbZA/B9YWLEmjbE744F4StTfFEExe1ccdGPfo1SDOr6t
zDjTdRgBskmyDED/dl0v9d0fQ2/jyQesQNsz4cj9X4IGUk9h1GAQ8hrwu+0zpnXs
1RjJa5SZukrYS+QFDUL6
=I43W
-----END PGP SIGNATURE-----

--mu4zWe6QekgCAJVd--
