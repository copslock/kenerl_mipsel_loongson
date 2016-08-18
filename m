Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 14:31:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3857 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993262AbcHRMbiQQDDL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 14:31:38 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id DDC3A41F8ECC;
        Thu, 18 Aug 2016 13:31:32 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 18 Aug 2016 13:31:32 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 18 Aug 2016 13:31:32 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 03940169CA0C4;
        Thu, 18 Aug 2016 13:31:30 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 18 Aug
 2016 13:31:32 +0100
Date:   Thu, 18 Aug 2016 13:31:32 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Levin, Alexander" <alexander.levin@verizon.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH BACKPORT 3.17-4.4 2/4] MIPS: KVM: Add missing gfn range
 check
Message-ID: <20160818123132.GF19514@jhogan-linux.le.imgtec.org>
References: <cover.6970eb00e72f05828fc82d97b7283d20eac8951e.1471018436.git-series.james.hogan@imgtec.com>
 <5ae3371dc11534460b722864ea8c6ef27e8506d1.1471018436.git-series.james.hogan@imgtec.com>
 <8ae95d49-3491-02cd-9ce6-fd876df1fe4d@verizon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ruyc9IU5x/hZJuxv"
Content-Disposition: inline
In-Reply-To: <8ae95d49-3491-02cd-9ce6-fd876df1fe4d@verizon.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: cee91754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54615
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

--Ruyc9IU5x/hZJuxv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

On Thu, Aug 18, 2016 at 07:45:33AM -0400, Levin, Alexander wrote:
> On 08/18/2016 05:05 AM, James Hogan wrote:
> > commit 8985d50382359e5bf118fdbefc859d0dbf6cebc7 upstream.
> >=20
> > kvm_mips_handle_mapped_seg_tlb_fault() calculates the guest frame number
> > based on the guest TLB EntryLo values, however it is not range checked
> > to ensure it lies within the guest_pmap. If the physical memory the
> > guest refers to is out of range then dump the guest TLB and emit an
> > internal error.
> >=20
> > Fixes: 858dd5d45733 ("KVM/MIPS32: MMU/TLB operations for the Guest.")
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: "Radim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: kvm@vger.kernel.org
> > Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> > [james.hogan@imgtec.com: Backport to v3.17.y - v4.4.y]
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
>=20
> Hey James,
>=20
> Thanks for the backport!
>=20
> Applying this one seems to fail with:
>=20
> $ git apply --reject [PATCH BACKPORT 3.17-4.4 1_4] MIPS: KVM: Fix mapped
> fault broken commpage handling - James Hogan <james.hogan@imgtec.com> -
> 2016-08-18 0505.eml
> Checking patch arch/mips/kvm/tlb.c...
> error: while searching for:
> 	unsigned long entryhi =3D 0, entrylo0 =3D 0, entrylo1 =3D 0;
> 	struct kvm *kvm =3D vcpu->kvm;
> 	pfn_t pfn0, pfn1;
> 	long tlb_lo[2];
>=20
> 	tlb_lo[0] =3D tlb->tlb_lo0;
>=20
> error: patch failed: arch/mips/kvm/tlb.c:361
> error: while searching for:
> 			VPN2_MASK & (PAGE_MASK << 1)))
> 		tlb_lo[(KVM_GUEST_COMMPAGE_ADDR >> PAGE_SHIFT) & 1] =3D 0;
>=20
> 	if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb_lo[0])
> 				   >> PAGE_SHIFT) < 0)
> 		return -1;
>=20
> 	if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb_lo[1])
> 				   >> PAGE_SHIFT) < 0)
> 		return -1;
>=20
> 	pfn0 =3D kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb_lo[0])
> 				    >> PAGE_SHIFT];
> 	pfn1 =3D kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb_lo[1])
> 				    >> PAGE_SHIFT];
>=20
> 	if (hpa0)
> 		*hpa0 =3D pfn0 << PAGE_SHIFT;
>=20
> error: patch failed: arch/mips/kvm/tlb.c:374
> Applying patch arch/mips/kvm/tlb.c with 2 rejects...
> Rejected hunk #1.
> Rejected hunk #2.

This works for me (on 558ba5fd7d8d Linux 4.1.30) as long as 1/4 is
applied first. Are you applying them in the right order?

Cheers
James


--Ruyc9IU5x/hZJuxv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXtaqkAAoJEGwLaZPeOHZ6+zcP/0FxbvC2YHM037ut03VR+VqS
KEUbWt/X4csa3Ag/WC634atmDeIC3THEJUieDMbldofENESm/UUFEwdwFsk8yG1o
3aj3p/XphFOQdTyM+zFyu1XoYn8FnyMDANMNaOtVtkLWq8LF1QhbcV9cNLB4hRFn
BGDygBASlHqzqTVl2OGYMk7Ep8q5QctOX2ajZEo56bRpo0vQ9GV1JdXDOlRzqyjN
wzVR43+YvZAHSYAIpm2XUeX79/Mr62WcIOPfF65hYT1HmtBAZcRHWw/qL3yPO9F/
UxVscDCNJQxJ2ORgqqsv/uYc/3Eqk3rY8vsqyHQhMoQ7RzJVspQU93A6t51Whfqt
sp41eNK4JUvkFovaBIzyEZ6kqerO46Of0HpBcQgPHfdoQ7jTdX/M51eXXOgqDuIl
e3j6bYTGYSMpgBUysknE1u59fQEXuyY21U54fM68zAoohq62Jj2h9hsNdiF5EHOd
F6A1IgzdJ43D/6Gt637uKh/W456Q2CGvncysDmeF+7f1z0Vhh4lp9lRPZ8qUBhgV
UA+3ka1WJxojR2U9ktZuhnVLAhXykDH+EIfrQ/oywIjlGGst8mhMMfmZmtc+Y1zI
vnqP86GuiIJbG/cdNFVxb2MtsGus21tlWXA47KGKNo8aqqPIC7SaQ5Co3YbGyikN
v8bW3vW3zEF37gC9967Q
=KOAt
-----END PGP SIGNATURE-----

--Ruyc9IU5x/hZJuxv--
