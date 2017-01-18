Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 13:12:50 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23870 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992078AbdARMMnAmmre (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 13:12:43 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 4136041F8E2E;
        Wed, 18 Jan 2017 13:15:21 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 18 Jan 2017 13:15:21 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 18 Jan 2017 13:15:21 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 41DBA70CD462B;
        Wed, 18 Jan 2017 12:12:34 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 18 Jan
 2017 12:12:36 +0000
Date:   Wed, 18 Jan 2017 12:12:36 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <jiang.biao2@zte.com.cn>
CC:     <linux-mips@linux-mips.org>, <pbonzini@redhat.com>,
        <rkrcmar@redhat.com>, <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/13] KVM: MIPS: Pass type of fault down to
 kvm_mips_map_page()
Message-ID: <20170118121236.GA31545@jhogan-linux.le.imgtec.org>
References: <201701181618464411994@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <201701181618464411994@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56391
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

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 18, 2017 at 04:18:46PM +0800, jiang.biao2@zte.com.cn wrote:
> Hi,
>=20
> =EF=BC=9E I presume you mean from the saved host cause register in the VC=
PU
> =EF=BC=9E context (since intervening exceptions/interrupts will clobber t=
he actual
> =EF=BC=9E CP0 Cause register).
> =EF=BC=9E=20
> =EF=BC=9E It directly needs to know whether it can get away with a read-o=
nly
> =EF=BC=9E mapping, and although it directly depends on a GVA segment, it =
doesn't
> =EF=BC=9E necessarily relate to a memory access made by the guest.
> =EF=BC=9E=20
> =EF=BC=9E kvm_mips_map_page() is called via:
> =EF=BC=9E=20
> =EF=BC=9E - kvm_mips_handle_kseg0_tlb_fault()
> =EF=BC=9E   for faults in guest KSeg0
> =EF=BC=9E=20
> =EF=BC=9E  - kvm_mips_handle_mapped_seg_tlb_fault()
> =EF=BC=9E    for faults in guest TLB mapped segments
> =EF=BC=9E=20
> =EF=BC=9E From these functions:
> =EF=BC=9E=20
> =EF=BC=9E  - kvm_trap_emul_handle_tlb_mod() (write_fault =3D true)
> =EF=BC=9E   in response to a write to a read-only page (exccode =3D MOD)
> =EF=BC=9E=20
> =EF=BC=9E - kvm_trap_emul_handle_tlb_miss() (write_fault =3D true or fals=
e)
> =EF=BC=9E   in response to a read or write when TLB mapping absent or inv=
alid
> =EF=BC=9E   (exccode =3D TLBL/TLBS)
> =EF=BC=9E
> =EF=BC=9E=20
> =EF=BC=9E So there is a many:many mapping from exccode to write_fault for=
 these
> =EF=BC=9E exccodes:
> =EF=BC=9E=20
> =EF=BC=9E  - CPU (CoProcessor Unusable)
> =EF=BC=9E    could be reading instruction or servicing a CACHE instruction
> =EF=BC=9E    (write_fault =3D false) or replacing an instruction (write_f=
ault =3D
> =EF=BC=9E    true).
>=20
> =EF=BC=9E  - MOD, TLBS, ADES
> =EF=BC=9E   could be the write itself (write_fault =3D true), or a read o=
f the
> =EF=BC=9E   instruction triggering the exception or the prior branch inst=
ruction
> =EF=BC=9E   (write_fault =3D false).
> =EF=BC=9E=20
> Thanks for the detail, it is more complicted than I thought.
>=20
> But there may be still bad smell from the long parameters, espacially fro=
m=20
>=20
>=20
> bool type ones. =20

Whats wrong with bool parameters?

It needs a GPA mapping created, either for a read or a write depending
on the caller. bool would seem ideally suited for just such a situation,
and in fact its exactly what the KVM GPA fault code path does to pass
whether the page needs to be writable:

kvm_mips_map_page() -> gfn_to_pfn_prot() -> __gfn_to_pfn_memslot() ->
hva_to_pfn() -> hva_to_pfn_slow().

so all this really does is extend that pattern up the other way as
necessary to be able to provide that information to gfn_to_pfn_prot().

Cheers
James

>=20
>=20
> Maybe there is better way to handle that, but I can not figure it out rig=
ht now=20
>=20
>=20
> because of the complexity.

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYf1utAAoJEGwLaZPeOHZ6ftcQAL8jD4XSQweX6Ayh7FRjNyiq
Hy7ajtlGjKvH/YuidrUvkqRxjB4XOqwVfFAaGPURiA9d7PUv8UKfbKSQsxCfysM+
A+K6jbEPi1D2tQIpB3bhPlaYTmbrcCkhG5bppUgmYHU4X0Y+Iq8rHisQXl7jPxZH
D0vuEp1s4GYJky2BNodgY07gKs2iDCnY9BQNRjMVa2RkMYNh8q8MLSACJsIny6kX
eM3LtdkGU6Qz/clia7uz0yxK605FstRT5rulAwqz30jTnzJyEIzcXRAhEAWb0Lr9
iIdhiWy3UFGVQ4EoVtDvUWdHf02WtmE/FM/WRvW0I3H+9X5/U5ed1zO8HkrqGVnY
6mG/XZEYceNYr1VjnoAtafrcK8HSC8CHOGf2nvpmCbYIYF0kNYF2NmqhhWstLt13
Hx1d+YnWeTu+j5d3UrC9eJU69OXf3X4r4kAH6k3Ed+yJbRYFgDT8fTQSySGmeESD
YZDzC+lHsnev0zI8XFYeCvJOR3LzzFRu8LiiJVp8IcX/HYWY5oJ8LxXUq4WuMhwe
c4qMhWgycYA60pATdIaQ6D2rZabgRJfXAlwsrcN1XCpX6iRt4dYotHXd93ENEgrP
gvD9iAhF1cO6gnFXby31fjjzDfGDbu8oIGd9uwTCKNj13Bsm8wRQAon4+thfUnQm
YcyQKm3LiQ8X+mmecf4Q
=PrX6
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
