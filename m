Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 23:34:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3835 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993876AbdCBWePOX1I5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 23:34:15 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 37F3941F8DED;
        Thu,  2 Mar 2017 23:38:50 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 02 Mar 2017 23:38:50 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 02 Mar 2017 23:38:50 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 06DE54697B66A;
        Thu,  2 Mar 2017 22:34:04 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 2 Mar
 2017 22:34:07 +0000
Date:   Thu, 2 Mar 2017 22:34:07 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 11/32] KVM: MIPS: Add VZ capability
Message-ID: <20170302223407.GQ996@jhogan-linux.le.imgtec.org>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
 <17827db14f848b69e8184ae80b5d63ba01b4b106.1488447004.git-series.james.hogan@imgtec.com>
 <bb40a6bb-e6b3-a37b-a08e-daccbf52bbef@redhat.com>
 <20170302113923.GC2878@jhogan-linux.le.imgtec.org>
 <1a071956-a897-a2f9-4523-e6da074568b6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kERJ49nCKmnv470N"
Content-Disposition: inline
In-Reply-To: <1a071956-a897-a2f9-4523-e6da074568b6@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57010
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

--kERJ49nCKmnv470N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2017 at 01:20:05PM +0100, Paolo Bonzini wrote:
> On 02/03/2017 12:39, James Hogan wrote:
> > It can't right now, though with relocation of the kernel now implemented
> > in MIPS Linux for KASLR, and hopes for a more generic EVA implementation
> > (which can require the kernel to be linked in a completely different
> > segment) it isn't completely infeasible.
>=20
> What about the other way round, sticking a minimal T&E stub in kernel
> space and running the kernel in userspace?  Would it be feasible or
> would it be as complex as KVM itself?

You mean have a fallback in the guest kernel to keep kernel running from
userspace addresses in kernel mode so it works in VZ guests and
non-virtualized?

Interesting idea. I think it would involve a lot of complexity. It could
forgo some of the emulation of privileged instructions that KVM T&E
does since its running in kernel mode, but memory management would be
more complex, and invasive changes would be required to the kernel.

- Memory privilege protection is on the granularity of segments, so with
  the traditional segment layout all of USeg (0x00000000..0x7FFFFFFF) is
  accessible to user mode, so you'd still need to utilise ASIDs to
  separate the address spaces of actual user programs running in
  0x00000000..0x3FFFFFFF from the kernel code running in
  0x40000000..0x7FFFFFFF.

- USeg is always TLB mapped. That means any kernel code could trigger
  TLB exceptions, which breaks existing assumptions (e.g. normally from
  unmapped kernel segments you can disable interrupts and then
  manipulate the TLB, but that isn't safe if a TLB refill exception
  could happen at any time and clobber the TLB registers). If in the
  future we manage to workaround these issues and map the kernel (for
  security/protection purposes), then it would be easier, but then we'll
  likely already have the capability to fully relocate into a different
  segment.

> > 1) QEMU, which I've implemented using the kvm_type machine callback.
> > This allows the KVM type to be specified with e.g.
> >   "-machine malta,accel=3Dkvm,kvm-type=3DTE"
> > Otherwise it defaults to using KVM_VM_MIPS_DEFAULT.
> >=20
> > When you try and load a kernel (which happens after kvm_init() has
> > already passed the kvm type into KVM_CREATE_VM) it will check that it
> > supports the current kernel type.
> >
> > 2) My kvm test application, which uses KVM_VM_MIPS_DEFAULT by default
> > and hackily maps itself into the guest physical address space to run C
> > code test cases.
>=20
> So this one would work for both TE and VZ because the guest is not a
> Linux kernel.

Yes, the test code is position independent and careful to avoid direct
references to any symbols. The GPA mappings are set up the same, but the
virtual addresses (PC, stack pointer etc) are set up slightly
differently depending on whether the VZ capability is present.

> I don't know...  Instinctively I would think that it's easy to get
> KVM_VM_MIPS_DEFAULT wrong and place the VZ-and-fall-back-to-TE policy in
> userspace, but I can be convinced otherwise if the failure mode is good
> enough.

Yeh, I think I agree. It isn't really necessary to have that decision
making in the kernel, and to use a particular KVM type userspace needs
to be aware about it, so it can always figure out from capabilities
which one to use prior to KVM_CREATE_VM.

I suppose the exception is T&E. It shouldn't assume that just because VZ
is available that T&E isn't (even if that is the case right now). It
could always just try KVM_CREATE_VM with kvm type 0 and detect the error
I suppose, but capabilities are nicer.

Maybe I'll redefine KVM_CAP_MIPS_VZ a bit, such that the value returned
+ 1 is a bitmask of supported kvm types:
has T&E =3D !!( (v + 1) & BIT(KVM_VM_MIPS_TE) )
has VZ  =3D !!( (v + 1) & BIT(KVM_VM_MIPS_VZ) )

That way old kernels which return 0 are consistent, and other
implementations could be added if really necessary without confusing
userland (but fingers crossed it'll never ever be necessary).

> For example, what happens if you use KVM_SET_USER_MEMORY_REGION
> for a kernel address in TE mode?

That deals with physical addresses and user/kernel memory is
distinguished by the virtual address, so the KVM mode (T&E vs VZ)
doesn't make a difference here.

Cheers
James

--kERJ49nCKmnv470N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYuJ3NAAoJEGwLaZPeOHZ6J5QP/01Lwednrmj3unBqDXY2xSfe
4iFUwSB1XE2uW3D53sdHlah/wyG479w/gxR5g5qbgnRHZeiCSloUEDmCPlx5R68O
S0DSj8w0Jlsay6CiE0pUj+u1dpyNPHzjRCQUtvnBUJ+ljTrkhdU4A88n51+D4xhL
BWhNioZ+o2FhWyoGquDasQr9TmkkGjvRdEeV53doGi6Usaz84ZxOKqvvtzDqBiS5
EPedr2DJ7R3BE45RL58YdoE7Z5pdHbYSQ8+JTLJf7pX2KINCxJWOQwDQdepwSnNR
vDaQUp+73eA+tdapfVJpmKRNJ6DfDSfxsNaDtA39Bt+7QrNmQ0lp9km0T8GUNTQ9
/vuTkYBiR4RQWGmDNTTr4nZIIivKmL8xmoFULH07sElRhLbVS2nsK3nzNceqxJ1/
1avlYj+n/57Q66M+fFkKviJxfa3o/b3DC2RAx79qhmGNNABv0ADzmKO8cqyYSLib
mT2dbbFwt3uc4UlFnwxDRldpioLadBRO0k2/h9gYfRuuBHr6DLKIyqztlRVKIe1l
tJKIoaftipROwlG6e75P35ER1hwDN3ZQnO6b0I6v9n9J5QoXKDsv73PYSzxPmR6+
akm/zRRkyU1a3TaHH7xkTdqKHWONO6Ocu2OPaU/GyOsLzwk9AhzVZ9PGw9KH9cRx
8hmWq2P6MwbQExEZXbux
=KTxe
-----END PGP SIGNATURE-----

--kERJ49nCKmnv470N--
