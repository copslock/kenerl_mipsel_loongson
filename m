Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 14:28:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31931 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993889AbdAQN14cOyE0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 14:27:56 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 5B63A41F8E05;
        Tue, 17 Jan 2017 14:30:31 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 17 Jan 2017 14:30:31 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 17 Jan 2017 14:30:31 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 230C534F4FCC3;
        Tue, 17 Jan 2017 13:27:47 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 17 Jan
 2017 13:27:49 +0000
Date:   Tue, 17 Jan 2017 13:27:49 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <jiang.biao2@zte.com.cn>
CC:     <linux-mips@linux-mips.org>, <pbonzini@redhat.com>,
        <rkrcmar@redhat.com>, <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/13] KVM: MIPS: Pass type of fault down to
 kvm_mips_map_page()
Message-ID: <20170117132749.GA11733@jhogan-linux.le.imgtec.org>
References: <201701171906397244491@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <201701171906397244491@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56342
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

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 17, 2017 at 07:06:39PM +0800, jiang.biao2@zte.com.cn wrote:
> =EF=BC=9E kvm_mips_map_page() will need to know whether the fault was due=
 to a
> =EF=BC=9E read or a write in order to support dirty page tracking,
> =EF=BC=9E KVM_CAP_SYNC_MMU, and read only memory regions, so get that inf=
ormation
> =EF=BC=9E passed down to it via new bool write_fault arguments to various
> =EF=BC=9E functions.
>=20
> Hi, James,
>=20
>=20
> Maybe it's not good idea to add an argument and pass it down to various f=
unctions,  it will ,
>=20
> make the the interface more complicated,  have more possibolity, and more=
 difficult to test.
>=20

kvm_mips_map_page() needs to know is whether it is being triggered in
response to a write, but it is abstracted and independent from what host
exception triggered it. It is only really concerned with the GPA space.

>=20
>=20
>=20
> As far as I can see,  what you need is to let kvm_mips_map_page() know th=
e *reason*.
>=20
> would it be better to let kvm_mips_map_page() get *exccode* from the CP0 =
directly, or=20
>=20
>=20
> provide any interface to get the fault reason?

I presume you mean from the saved host cause register in the VCPU
context (since intervening exceptions/interrupts will clobber the actual
CP0 Cause register).

It directly needs to know whether it can get away with a read-only
mapping, and although it directly depends on a GVA segment, it doesn't
necessarily relate to a memory access made by the guest.

kvm_mips_map_page() is called via:

 - kvm_mips_handle_kseg0_tlb_fault()
   for faults in guest KSeg0

 - kvm_mips_handle_mapped_seg_tlb_fault()
   for faults in guest TLB mapped segments

=46rom these functions:

 - kvm_trap_emul_handle_tlb_mod() (write_fault =3D true)
   in response to a write to a read-only page (exccode =3D MOD)

 - kvm_trap_emul_handle_tlb_miss() (write_fault =3D true or false)
   in response to a read or write when TLB mapping absent or invalid
   (exccode =3D TLBL/TLBS)

 - via the kvm_trap_emul_gva_fault() helper when KVM needs to directly
   access GVA space:

   - kvm_get_inst() (write_fault =3D false)
     when reading an instruction from guest RAM (when BadInstr/BadInstrP
     registers unavailable) which needs to be emulated, i.e. reserved
     instruction (exccode =3D RI), cop0 unusuable (exccode =3D CPU), MMIO
     load/store (TLBL/TLBS/MOD/ADEL/ADES), branch delay slot handling
     for MMIO load/store, or debug output for an unhandled exccode
     (exccode =3D ?)

   - kvm_mips_trans_replace() (write_fault =3D true)
     to write a replacement instruction into guest memory (mainly
     exccode =3D CPU)

   - kvm_mips_guest_cache_op() (write_fault =3D false)
     cache instruction emulation (exccode =3D CPU)

So there is a many:many mapping from exccode to write_fault for these
exccodes:

 - CPU (CoProcessor Unusable)
   could be reading instruction or servicing a CACHE instruction
   (write_fault =3D false) or replacing an instruction (write_fault =3D
   true).

 - MOD, TLBS, ADES
   could be the write itself (write_fault =3D true), or a read of the
   instruction triggering the exception or the prior branch instruction
   (write_fault =3D false).

Cheers
James

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYfhvNAAoJEGwLaZPeOHZ6suEP/0w/DeLtVqw+oUaJWfx7r1Un
L6PUhdg5vkwVP4fFqwxa5DLwTiX2nxbr1k8HMyeryiZamKLCFTmyUg4Rohl+ODUp
WMouUc44TnoxeqrqIRLMy1If6h9rFjvNE8UjNOtx1uzQR1pWjpkQA+zXVW2FuPJJ
4cPGBM9GkvAvTGb1zoW0qUDgqV/brcimbJIuJ/CtkguJFGaZz0bYPnXHWHqBYOKe
HVQD7i4x0Au2GpfNnaJ434YRawkVGOCvqqhR1fn41QOl1Z4X92a8ZAt7XfkQWw9y
3owDZvQQrgR24wClp7NrcUQ1RqY4s6GCgtfvMM96ar2U9VjDta6uH3uUgm4MAekV
W9sNMfMFIkUNRRwJbZGDLTQxM6vf4aKealKG8Sem7o1fNSXYbBwpE65bo9i/D4FW
rgTCo7EmJd5Rc7Ispaa/RdjTv3dv/o4AL1gZOXT7iq+hqYaPFiUcOgRmzIBsTgPW
dgYe7XBZ3Y+Zb6UYFJKfB/W/RbsvvjryQRIjBvKXCUP8npwnaH/eYNn+7ZhSI7aS
MTkdI5B3p21HEyQ1Ph6bT5cahaOjgZFEC10Nbis7g7gwH9IkWsLe+XuQL9fIwhtj
aMwvibMsEwsFWCE2PGufWaiEHHxeJqb1b/Y+09qQSqAnmUk1rKkHxpsnrx90xJPG
fxRF5xb/Xcbp/0jXVmCq
=CEw7
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
