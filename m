Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 15:53:14 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57094 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006155AbbCZOxL6n4lg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 15:53:11 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 08EAC41F8D96;
        Thu, 26 Mar 2015 14:53:07 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 26 Mar 2015 14:53:07 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 26 Mar 2015 14:53:07 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0E36A9AB895F;
        Thu, 26 Mar 2015 14:53:04 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 26 Mar 2015 14:53:06 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 26 Mar
 2015 14:53:06 +0000
Message-ID: <55141D4B.5000605@imgtec.com>
Date:   Thu, 26 Mar 2015 14:52:59 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, Gleb Natapov <gleb@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-api@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 20/20] MIPS: KVM: Wire up MSA capability
References: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com> <1426085096-12932-21-git-send-email-james.hogan@imgtec.com> <5514108F.9060905@redhat.com>
In-Reply-To: <5514108F.9060905@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="Srp1x3I1E3q62d0go2K5rOdckBSKtIUx6"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46548
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

--Srp1x3I1E3q62d0go2K5rOdckBSKtIUx6
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 26/03/15 13:58, Paolo Bonzini wrote:
>=20
>=20
> On 11/03/2015 15:44, James Hogan wrote:
>> Now that the code is in place for KVM to support MIPS SIMD Architecutr=
e
>> (MSA) in MIPS guests, wire up the new KVM_CAP_MIPS_MSA capability.
>>
>> For backwards compatibility, the capability must be explicitly enabled=

>> in order to detect or make use of MSA from the guest.
>>
>> The capability is not supported if the hardware supports MSA vector
>> partitioning, since the extra support cannot be tested yet and it
>> extends the state that the userland program would have to save.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: Gleb Natapov <gleb@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-mips@linux-mips.org
>> Cc: kvm@vger.kernel.org
>> Cc: linux-api@vger.kernel.org
>> Cc: linux-doc@vger.kernel.org
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> ---
>>  Documentation/virtual/kvm/api.txt | 12 ++++++++++++
>>  arch/mips/kvm/mips.c              | 24 ++++++++++++++++++++++++
>>  include/uapi/linux/kvm.h          |  1 +
>>  3 files changed, 37 insertions(+)
>>
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual=
/kvm/api.txt
>> index 47ddf0475211..97dd9ee69ca8 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -3224,6 +3224,18 @@ done the KVM_REG_MIPS_FPR_* and KVM_REG_MIPS_FC=
R_* registers can be accessed
>>  Config5.FRE bits are accessible via the KVM API and also from the gue=
st,
>>  depending on them being supported by the FPU.
>> =20
>> +6.10 KVM_CAP_MIPS_MSA
>> +
>> +Architectures: mips
>> +Target: vcpu
>> +Parameters: args[0] is reserved for future use (should be 0).
>> +
>> +This capability allows the use of the MIPS SIMD Architecture (MSA) by=
 the guest.
>> +It allows the Config3.MSAP bit to be set to enable the use of MSA by =
the guest.
>> +Once this is done the KVM_REG_MIPS_VEC_* and KVM_REG_MIPS_MSA_* regis=
ters can be
>> +accessed, and the Config5.MSAEn bit is accessible via the KVM API and=
 also from
>> +the guest.
>> +
>>  7. Capabilities that can be enabled on VMs
>>  ------------------------------------------
>> =20
>> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
>> index 9319c4360285..3b3530f493eb 100644
>> --- a/arch/mips/kvm/mips.c
>> +++ b/arch/mips/kvm/mips.c
>> @@ -880,6 +880,15 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_v=
cpu *vcpu,
>>  			return -EINVAL;
>>  		vcpu->arch.fpu_enabled =3D true;
>>  		break;
>> +	case KVM_CAP_MIPS_MSA:
>> +		/*
>> +		 * MSA vector partitioning not supported,
>> +		 * see kvm_vm_ioctl_check_extension().
>> +		 */
>> +		if (!cpu_has_msa || boot_cpu_data.msa_id & MSA_IR_WRPF)
>> +			return -EINVAL;
>=20
> Perhaps you can call kvm_vm_ioctl_check_extension directly, outside the=

> switch (it's okay if it's called for a capability other than FPU and MS=
A)?

Yes, good idea. That works nicely.

>=20
> Apart from this nit,
>=20
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Paolo

Thanks!
James

>=20
>> +		vcpu->arch.msa_enabled =3D true;
>> +		break;
>>  	default:
>>  		r =3D -EINVAL;
>>  		break;
>> @@ -1071,6 +1080,21 @@ int kvm_vm_ioctl_check_extension(struct kvm *kv=
m, long ext)
>>  	case KVM_CAP_MIPS_FPU:
>>  		r =3D !!cpu_has_fpu;
>>  		break;
>> +	case KVM_CAP_MIPS_MSA:
>> +		/*
>> +		 * We don't support MSA vector partitioning yet:
>> +		 * 1) It would require explicit support which can't be tested
>> +		 *    yet due to lack of support in current hardware.
>> +		 * 2) It extends the state that would need to be saved/restored
>> +		 *    by e.g. QEMU for migration.
>> +		 *
>> +		 * When vector partitioning hardware becomes available, support
>> +		 * could be added by requiring a flag when enabling
>> +		 * KVM_CAP_MIPS_MSA capability to indicate that userland knows
>> +		 * to save/restore the appropriate extra state.
>> +		 */
>> +		r =3D cpu_has_msa && !(boot_cpu_data.msa_id & MSA_IR_WRPF);
>> +		break;
>>  	default:
>>  		r =3D 0;
>>  		break;
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 98f6e5c653ff..5f859888e3ad 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -761,6 +761,7 @@ struct kvm_ppc_smmu_info {
>>  #define KVM_CAP_CHECK_EXTENSION_VM 105
>>  #define KVM_CAP_S390_USER_SIGP 106
>>  #define KVM_CAP_MIPS_FPU 107
>> +#define KVM_CAP_MIPS_MSA 108
>> =20
>>  #ifdef KVM_CAP_IRQ_ROUTING
>> =20
>>


--Srp1x3I1E3q62d0go2K5rOdckBSKtIUx6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVFB1SAAoJEGwLaZPeOHZ60lAP/2SmmiJ6NKZRVeWORXozzIxn
7JRSR5g/XzXUm1b8hhhXn3y4reikqrmfgVgM21rXk244IZ1kDaTS8A1WyHaGrcOD
T+SpDts/IPS7DxcCzRI8tHoPoCp2b2m4HsqPIzneb9U/uwCRpH5LmCnAfDZz7RYw
8dotZO5kkL/3xzX3XYAJnnkGr23+uvauvgDqiyeg3VYBby3jY/hdii+jHU5iki4i
LyfR1s9AQx+aOrWxzJFGaQpYXJREuATFGR+4Rvxa5wT3bi4eA9/d+soHpA8u/hKP
kRNARzZjRyG1ZlE/6tMvEHG6UeYke4BkUXKIcZnNZrcrAjOi7wLjlRSlIgkmTLve
y9A1E/EEUYzLfkAJOZ1NSWxG3OKJhr0OKIloAdgxC/JucOY1x9NsY0NgQc4Xld2W
vWAHKz+K7/T1jnxionGR1HKneKyPGrJzVhFUwR/RlOAi+uar88fYAhKMtqNhBrao
YSLTmtoKM7/HPq4gDaUdEfve26gUU7L69+d1G/gQEwS4yPhdFT2PEP7lP3kKB9Cq
21p8SwJaxBX2V9TbvEhawudZ36agI4yFKsQ8DHr5Ej64oS5LoUC+QKjbli4v/Ju7
nbPz0wjzYukaEH5PYDSyLoveVCpHOVtwjVtDdY8ycdd3Z4xRgVQZ6bR5/FJMooFG
7Um9/dIj2uH8BMJa2iJx
=re6j
-----END PGP SIGNATURE-----

--Srp1x3I1E3q62d0go2K5rOdckBSKtIUx6--
