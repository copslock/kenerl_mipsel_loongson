Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Nov 2016 04:08:56 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52795 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990644AbcKLDIst7pgw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Nov 2016 04:08:48 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1c5OgO-0007J1-8A; Sat, 12 Nov 2016 03:08:44 +0000
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1c5OgO-0003Zs-4w; Sat, 12 Nov 2016 03:08:44 +0000
Message-ID: <1478920119.2622.20.camel@decadent.org.uk>
Subject: Re: [BACKPORT PATCH 3.10..3.16] KVM: MIPS: Drop other CPU ASIDs on
 guest MMU changes
From:   Ben Hutchings <ben@decadent.org.uk>
To:     James Hogan <james.hogan@imgtec.com>, Jiri Slaby <jslaby@suse.cz>,
        stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Date:   Sat, 12 Nov 2016 03:08:39 +0000
In-Reply-To: <20161109144624.16683-1-james.hogan@imgtec.com>
References: <20161109144624.16683-1-james.hogan@imgtec.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-FoW6VMdVYeuwH7RFgYDj"
X-Mailer: Evolution 3.22.1-2 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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


--=-FoW6VMdVYeuwH7RFgYDj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2016-11-09 at 14:46 +0000, James Hogan wrote:
> commit 91e4f1b6073dd680d86cdb7e42d7cccca9db39d8 upstream.
>=20
> When a guest TLB entry is replaced by TLBWI or TLBWR, we only invalidate
> TLB entries on the local CPU. This doesn't work correctly on an SMP host
> when the guest is migrated to a different physical CPU, as it could pick
> up stale TLB mappings from the last time the vCPU ran on that physical
> CPU.
>=20
> Therefore invalidate both user and kernel host ASIDs on other CPUs,
> which will cause new ASIDs to be generated when it next runs on those
> CPUs.
>=20
> We're careful only to do this if the TLB entry was already valid, and
> only for the kernel ASID where the virtual address it mapped is outside
> of the guest user address range.
>=20
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
> Cc: <stable@vger.kernel.org> # 3.10.x-
> Cc: Jiri Slaby <jslaby@suse.cz>
> [james.hogan@imgtec.com: Backport to 3.10..3.16]
> Signed-off-by: James Hogan <james.hogan@imgtec.com>

Queued up for 3.16, thanks.

Ben.

> ---
> Unfortunately the original commit went in to v3.12.65 as commit
> 168e5ebbd63e, without fixing up the references to tlb_lo[0/1] to
> tlb_lo0/1 which broke the MIPS KVM build, and I didn't twig that I
> already had a correct backport outstanding (sorry!). That commit should
> be reverted before applying this backport to 3.12.
> ---
> =C2=A0arch/mips/kvm/kvm_mips_emul.c | 61 ++++++++++++++++++++++++++++++++=
+++++------
> =C2=A01 file changed, 53 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.=
c
> index 1983678883c9..d0eb34279955 100644
> --- a/arch/mips/kvm/kvm_mips_emul.c
> +++ b/arch/mips/kvm/kvm_mips_emul.c
> @@ -817,6 +817,47 @@ enum emulation_result kvm_mips_emul_tlbr(struct kvm_=
vcpu *vcpu)
> > =C2=A0	return er;
> =C2=A0}
> =C2=A0
> +/**
> + * kvm_mips_invalidate_guest_tlb() - Indicates a change in guest MMU map=
.
> > + * @vcpu:	VCPU with changed mappings.
> > + * @tlb:	TLB entry being removed.
> + *
> + * This is called to indicate a single change in guest MMU mappings, so =
that we
> + * can arrange TLB flushes on this and other CPUs.
> + */
> +static void kvm_mips_invalidate_guest_tlb(struct kvm_vcpu *vcpu,
> > +					=C2=A0=C2=A0struct kvm_mips_tlb *tlb)
> +{
> > +	int cpu, i;
> > +	bool user;
> +
> > +	/* No need to flush for entries which are already invalid */
> > +	if (!((tlb->tlb_lo0 | tlb->tlb_lo1) & MIPS3_PG_V))
> > +		return;
> > +	/* User address space doesn't need flushing for KSeg2/3 changes */
> > +	user =3D tlb->tlb_hi < KVM_GUEST_KSEG0;
> +
> > +	preempt_disable();
> +
> > +	/*
> > +	=C2=A0* Probe the shadow host TLB for the entry being overwritten, if=
 one
> > +	=C2=A0* matches, invalidate it
> > +	=C2=A0*/
> > +	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
> +
> > +	/* Invalidate the whole ASID on other CPUs */
> > +	cpu =3D smp_processor_id();
> > +	for_each_possible_cpu(i) {
> > +		if (i =3D=3D cpu)
> > +			continue;
> > +		if (user)
> > +			vcpu->arch.guest_user_asid[i] =3D 0;
> > +		vcpu->arch.guest_kernel_asid[i] =3D 0;
> > +	}
> +
> > +	preempt_enable();
> +}
> +
> =C2=A0/* Write Guest TLB Entry @ Index */
> =C2=A0enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
> =C2=A0{
> @@ -838,10 +879,8 @@ enum emulation_result kvm_mips_emul_tlbwi(struct kvm=
_vcpu *vcpu)
> > =C2=A0	}
> =C2=A0
> > =C2=A0	tlb =3D &vcpu->arch.guest_tlb[index];
> -#if 1
> > -	/* Probe the shadow host TLB for the entry being overwritten, if one =
matches, invalidate it */
> > -	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
> -#endif
> +
> > +	kvm_mips_invalidate_guest_tlb(vcpu, tlb);
> =C2=A0
> > =C2=A0	tlb->tlb_mask =3D kvm_read_c0_guest_pagemask(cop0);
> > =C2=A0	tlb->tlb_hi =3D kvm_read_c0_guest_entryhi(cop0);
> @@ -880,10 +919,7 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm=
_vcpu *vcpu)
> =C2=A0
> > =C2=A0	tlb =3D &vcpu->arch.guest_tlb[index];
> =C2=A0
> -#if 1
> > -	/* Probe the shadow host TLB for the entry being overwritten, if one =
matches, invalidate it */
> > -	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
> -#endif
> > +	kvm_mips_invalidate_guest_tlb(vcpu, tlb);
> =C2=A0
> > =C2=A0	tlb->tlb_mask =3D kvm_read_c0_guest_pagemask(cop0);
> > =C2=A0	tlb->tlb_hi =3D kvm_read_c0_guest_entryhi(cop0);
> @@ -926,6 +962,7 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, ui=
nt32_t cause,
> > =C2=A0	int32_t rt, rd, copz, sel, co_bit, op;
> > =C2=A0	uint32_t pc =3D vcpu->arch.pc;
> > =C2=A0	unsigned long curr_pc;
> > +	int cpu, i;
> =C2=A0
> > =C2=A0	/*
> > =C2=A0	=C2=A0* Update PC and hold onto current PC in case there is
> @@ -1037,8 +1074,16 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,=
 uint32_t cause,
> > =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ASID_MASK,
> > =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vcpu->arch.gprs[rt] & ASID_MAS=
K);
> =C2=A0
> > +					preempt_disable();
> > =C2=A0					/* Blow away the shadow host TLBs */
> > =C2=A0					kvm_mips_flush_host_tlb(1);
> > +					cpu =3D smp_processor_id();
> > +					for_each_possible_cpu(i)
> > +						if (i !=3D cpu) {
> > +							vcpu->arch.guest_user_asid[i] =3D 0;
> > +							vcpu->arch.guest_kernel_asid[i] =3D 0;
> > +						}
> > +					preempt_enable();
> > =C2=A0				}
> > =C2=A0				kvm_write_c0_guest_entryhi(cop0,
> =C2=A0							=C2=A0=C2=A0=C2=A0vcpu->arch.gprs[rt]);
--=20
Ben Hutchings
If you seem to know what you are doing, you'll be given more to do.


--=-FoW6VMdVYeuwH7RFgYDj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYJoe3AAoJEOe/yOyVhhEJaAAQAMqtVw6FuYdXyEfih1vKB8ii
Ipzd7KwWELelZwt60ZR5jDDjy8aIIfY9muTSEbtKQg7fhwzoM5EuznuRH+P1vxyk
r4+A9COpPQJhuZLuju6l3I0Qfb6Byq7xox17saIapmpxaRviZfWihaSMPwIrMpUR
J/NV8lwucay6Wd5G03T89Fu16wSn7ELEQoQaIN3xiPMcjuOiP/U1qb3lqhFl3Yoa
+wQLh92CZ7leQnHTNqQKlWAEvR80d/cghx43zxBGQLqgWzTvH972RxZ4IWYiMHAb
70gDDLqv4qMtHfvF0YAdStOyHI6JVcaESVnv+r+XUiB4iUVA3OtrCl0KG+dARxFx
3P0aky+i+NzesI5C9LQyVuFkhrdicTvBunKJfB6rH1tnXBY3lbjoB2zO375ffT/z
l1r6UgIHRIO7wr6JyN0oRQCq7kG4gO8C5mzh+WQ2mNgoAlFrPYrIAWSN3mBVqsQR
JQzSRkLf3i5pi98ggM5D8ASdI9GL8V6N50TPod2jncLNUunfkepKFb81IKOzAthD
f30/B5qKiISL7ug62pFCDXHYac1be3b6jDdXX7UMgl6Ju9PeHQAuPGomNfc2nyPo
dDZyhiuIMQwWlaHgv1+zqTo1XNwvLjlo3L4Qhl2xK0Trop2Ema3NGSOWepb8xO7d
pJcCoDuhmD26ujJekiAB
=1In9
-----END PGP SIGNATURE-----

--=-FoW6VMdVYeuwH7RFgYDj--
