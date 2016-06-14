Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 11:56:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1436 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27040791AbcFNJ43lD-bn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 11:56:29 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id C21B641F8EA6;
        Tue, 14 Jun 2016 09:55:41 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 14 Jun 2016 09:55:41 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 14 Jun 2016 09:55:41 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 7A3EF9948A169;
        Tue, 14 Jun 2016 09:55:38 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 14 Jun
 2016 09:55:41 +0100
Date:   Tue, 14 Jun 2016 09:55:41 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/8] MIPS: KVM: Add kvm_aux trace event
Message-ID: <20160614085541.GA17625@jhogan-linux.le.imgtec.org>
References: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
 <1465893617-5774-3-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <1465893617-5774-3-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 5de3adfe
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54031
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

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2016 at 09:40:11AM +0100, James Hogan wrote:
> Add a MIPS specific trace event for auxiliary context operations
> (notably FPU and MSA). Unfortunately the generic kvm_fpu trace event
> isn't flexible enough to handle the range of interesting things that can
> happen with FPU and MSA context.
>=20
> The type of state being operated on is traced:
> - FPU: Just the FPU registers.
> - MSA: Just the upper half of the MSA vector registers (low half already
>        loaded with FPU state).
> - FPU & MSA: Full MSA vector state (includes FPU state).
>=20
> As is the type of operation:
> - Restore: State was enabled and restored.
> - Save: State was saved and disabled.
> - Enable: State was enabled (already loaded).
> - Disable: State was disabled (kept loaded).
> - Discard: State was discarded and disabled.
>=20
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
> ---
>  arch/mips/kvm/mips.c  | 11 +++++++++++
>  arch/mips/kvm/trace.h | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>=20
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 9093262ff3ce..c0e8f8640f2b 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -1465,6 +1465,9 @@ void kvm_own_fpu(struct kvm_vcpu *vcpu)
>  	if (!(vcpu->arch.aux_inuse & KVM_MIPS_AUX_FPU)) {
>  		__kvm_restore_fpu(&vcpu->arch);
>  		vcpu->arch.aux_inuse |=3D KVM_MIPS_AUX_FPU;
> +		trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_FPU);
> +	} else {
> +		trace_kvm_aux(vcpu, KVM_TRACE_AUX_ENABLE, KVM_TRACE_AUX_FPU);
>  	}
> =20
>  	preempt_enable();
> @@ -1513,6 +1516,7 @@ void kvm_own_msa(struct kvm_vcpu *vcpu)
>  		 */
>  		__kvm_restore_msa_upper(&vcpu->arch);
>  		vcpu->arch.aux_inuse |=3D KVM_MIPS_AUX_MSA;
> +		trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_MSA);
>  		break;
>  	case 0:
>  		/* Neither FPU or MSA already active, restore full MSA state */
> @@ -1520,8 +1524,11 @@ void kvm_own_msa(struct kvm_vcpu *vcpu)
>  		vcpu->arch.aux_inuse |=3D KVM_MIPS_AUX_MSA;
>  		if (kvm_mips_guest_has_fpu(&vcpu->arch))
>  			vcpu->arch.aux_inuse |=3D KVM_MIPS_AUX_FPU;
> +		trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE,
> +			      KVM_TRACE_AUX_FPU_MSA);
>  		break;
>  	default:
> +		trace_kvm_aux(vcpu, KVM_TRACE_AUX_ENABLE, KVM_TRACE_AUX_MSA);
>  		break;
>  	}
> =20
> @@ -1535,10 +1542,12 @@ void kvm_drop_fpu(struct kvm_vcpu *vcpu)
>  	preempt_disable();
>  	if (cpu_has_msa && vcpu->arch.aux_inuse & KVM_MIPS_AUX_MSA) {
>  		disable_msa();
> +		trace_kvm_aux(vcpu, KVM_TRACE_AUX_DISCARD, KVM_TRACE_AUX_MSA);
>  		vcpu->arch.aux_inuse &=3D ~KVM_MIPS_AUX_MSA;
>  	}
>  	if (vcpu->arch.aux_inuse & KVM_MIPS_AUX_FPU) {
>  		clear_c0_status(ST0_CU1 | ST0_FR);
> +		trace_kvm_aux(vcpu, KVM_TRACE_AUX_DISCARD, KVM_TRACE_AUX_FPU);
>  		vcpu->arch.aux_inuse &=3D ~KVM_MIPS_AUX_FPU;
>  	}
>  	preempt_enable();
> @@ -1560,6 +1569,7 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
>  		enable_fpu_hazard();
> =20
>  		__kvm_save_msa(&vcpu->arch);
> +		trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_FPU_MSA);
> =20
>  		/* Disable MSA & FPU */
>  		disable_msa();
> @@ -1574,6 +1584,7 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
> =20
>  		__kvm_save_fpu(&vcpu->arch);
>  		vcpu->arch.aux_inuse &=3D ~KVM_MIPS_AUX_FPU;
> +		trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_FPU);
> =20
>  		/* Disable FPU */
>  		clear_c0_status(ST0_CU1 | ST0_FR);
> diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
> index bd6437f67dc0..32ac7cc82e13 100644
> --- a/arch/mips/kvm/trace.h
> +++ b/arch/mips/kvm/trace.h
> @@ -38,6 +38,52 @@ TRACE_EVENT(kvm_exit,
>  		      __entry->pc)
>  );
> =20
> +#define KVM_TRACE_AUX_RESTORE		0
> +#define KVM_TRACE_AUX_SAVE		1
> +#define KVM_TRACE_AUX_ENABLE		2
> +#define KVM_TRACE_AUX_DISABLE		3
> +#define KVM_TRACE_AUX_DISCARD		4
> +
> +#define KVM_TRACE_AUX_FPU		1
> +#define KVM_TRACE_AUX_MSA		2
> +#define KVM_TRACE_AUX_FPU_MSA		3
> +
> +#define kvm_trace_symbol_fpu_msa_op		\
> +	{ KVM_TRACE_AUX_RESTORE, "restore" },	\
> +	{ KVM_TRACE_AUX_SAVE,    "save" },	\
> +	{ KVM_TRACE_AUX_ENABLE,  "enable" },	\
> +	{ KVM_TRACE_AUX_DISABLE, "disable" },	\
> +	{ KVM_TRACE_AUX_DISCARD, "discard" }
> +
> +#define kvm_trace_symbol_fpu_msa_state		\
> +	{ KVM_TRACE_AUX_FPU,     "FPU" },	\
> +	{ KVM_TRACE_AUX_MSA,     "MSA" },	\
> +	{ KVM_TRACE_AUX_FPU_MSA, "FPU & MSA" }
> +
> +TRACE_EVENT(kvm_aux,
> +	    TP_PROTO(struct kvm_vcpu *vcpu, unsigned int op,
> +		     unsigned int state),
> +	    TP_ARGS(vcpu, op, state),
> +	    TP_STRUCT__entry(
> +			__field(unsigned long, pc)
> +			__field(u8, op)
> +			__field(u8, state)
> +	    ),
> +
> +	    TP_fast_assign(
> +			__entry->pc =3D vcpu->arch.pc;
> +			__entry->op =3D op;
> +			__entry->state =3D state;
> +	    ),
> +
> +	    TP_printk("%s %s PC: 0x%08lx",
> +		      __print_symbolic(__entry->op,
> +				       kvm_trace_symbol_fpu_msa_op),
> +		      __print_symbolic(__entry->state,
> +				       kvm_trace_symbol_fpu_msa_state),

hmm, sorry, I don't know how i didn't spot when I checked these over
that fpu_msa is still referred to here instead of aux. I'll post a V2 of
this patch with s/fpu_msa/aux/.

Cheers
James

> +		      __entry->pc)
> +);
> +
>  #endif /* _TRACE_KVM_H */
> =20
>  /* This part must be outside protection */
> --=20
> 2.4.10
>=20

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXX8aNAAoJEGwLaZPeOHZ6+LcQALTltx8oE1K4Z/q0ywwf6J4Q
S3qKb28W9S8NcoUfomLvr52EIatXBoTVVQX0bJo9X7cJ31kjyJjCzXEoG93vkqdc
/+DHEX9Qm1oSLygpcVFOOoQvEcNZNxoqYThByv5GEtRbdp6eYn7Bp8263F3kNBW4
Y3B910PMKvkdn3NuA94lhoLDXc4AudliREQQ3i3jnpx52X12QBS2/ZVufPQW0UwQ
Qjj3MMkLOTOkXi5DQVdSOzf0ulHzobjei4OvT1vxBH0RUP+6vq41g/wPnDYlr7na
Yv2OkuSMP4nGrog3MsatNf8LNzmnvJ3ton7LifhWBhAqZR7/rrPAIPpdh8z+KrjP
J1e7DFJV2WG3VNBAryIS3Ouw5RLMOdVuhjvKWZ3GL0HT0KMvlhrBD11MCI6/65sf
cM2yEqctBMpzB6ZyZ/5wQ+LjPGcglJSFm4Wyv1YrdZsnDzZrgx1vqB3PAYUFe1Z4
mCLVG1Wqsgwy/o6U5z2DRMGmkeeXUlXTja62EizjnQ1Jj19Wkvttmp5I34jt4nwA
s0NUqTyekay62rZaZtOYqwruJReuq7rpg7veXz0Jb4WANzFqMdFbUfYTj4k2OOiJ
xXpWdNirKLkZXMGOBdeMR6KTIhfwofo1m3Uf71GkEonWq0JdvnDYpd8qeNXNrUeM
eGIHXl6zqebPe97VIyyz
=2gFO
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
