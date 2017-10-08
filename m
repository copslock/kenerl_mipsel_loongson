Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Oct 2017 23:15:02 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41808 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992312AbdJHVOzyja8H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Oct 2017 23:14:55 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1IuP-0000iY-UM; Sun, 08 Oct 2017 22:14:50 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1IuK-0004ZA-NX; Sun, 08 Oct 2017 22:14:44 +0100
Message-ID: <1507497270.2677.96.camel@decadent.org.uk>
Subject: Re: [BACKPORT 3.14.y] MIPS: KVM: Fix modular KVM under QEMU
From:   Ben Hutchings <ben@decadent.org.uk>
To:     James Hogan <james.hogan@imgtec.com>, stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rkrcmar@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
Date:   Sun, 08 Oct 2017 22:14:30 +0100
In-Reply-To: <1468430059-7958-1-git-send-email-james.hogan@imgtec.com>
References: <146827994122156@kroah.com>
         <1468430059-7958-1-git-send-email-james.hogan@imgtec.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-FEUdib+0n55yFZjHWhea"
X-Mailer: Evolution 3.26.0-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60327
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


--=-FEUdib+0n55yFZjHWhea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2016-07-13 at 18:14 +0100, James Hogan wrote:
> commit 797179bc4fe06c89e47a9f36f886f68640b423f8 upstream.
>=20
> Copy __kvm_mips_vcpu_run() into unmapped memory, so that we can never
> get a TLB refill exception in it when KVM is built as a module.
>=20
> This was observed to happen with the host MIPS kernel running under
> QEMU, due to a not entirely transparent optimisation in the QEMU TLB
> handling where TLB entries replaced with TLBWR are copied to a separate
> part of the TLB array. Code in those pages continue to be executable,
> but those mappings persist only until the next ASID switch, even if they
> are marked global.
>=20
> An ASID switch happens in __kvm_mips_vcpu_run() at exception level after
> switching to the guest exception base. Subsequent TLB mapped kernel
> instructions just prior to switching to the guest trigger a TLB refill
> exception, which enters the guest exception handlers without updating
> EPC. This appears as a guest triggered TLB refill on a host kernel
> mapped (host KSeg2) address, which is not handled correctly as user
> (guest) mode accesses to kernel (host) segments always generate address
> error exceptions.
>=20
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [james.hogan@imgtec.com: backported for stable 3.14]
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
[...]

Belatedly queued this up for 3.16.

Ben.

--=20
Ben Hutchings
compatible: Gracefully accepts erroneous data from any source


--=-FEUdib+0n55yFZjHWhea
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlnalTcACgkQ57/I7JWG
EQlhhRAAvvil9mnPeUcjes3gr8Chd7HqM2xmsMAvv0dAkKWw6Cw16AZaZz1kvGr8
UcSr/pJpKhS3Tz613sMst0cCc/+t5OGMqBqxPMrR0HR7oY9JA9XhVMw0YSxnA0l3
lkDU6kzV9p7s5e+jeVdOPqGE41NRDYtn5Qy0p0M68LqCM+FMoj36F84OujnyCzjk
YICc81uYpe0irCUa2lep/umLGug0o1IksBnTKGaSBEkWyjms5g2gHwcopaUTBPVM
YUVc/zOkwNt3jW5zjF6w17/+qa3G95cF7hG1HLnUmrOABL4+u1RUMmb2jkne8mji
0/dc5Z3buXwNEsY7capt4BsZsr1AlAZjo8FR17jOv0IzuVI+HKxRVxLW68lbN7vl
j1QYXHyKNdREy6CNhJCGtqfuexhON9xPNC9XUilnw3G4G0YsN5Tbl7VM78fLXHUO
+dkKa+oQ4qtBc3O0pNlVQxdbUXfivafTzfa6KN5TL/Io/80Q/Zv/bwrMQUGTK54z
ET9nzaMt3DRkUIKpytg6Q2GxekamM6mXb91ypJ3AzA63bcZSrL3DKDzx6BtbBXiO
OTrVreYi30m74hX781kDIiMcqNc5HhEoO1wGr3sxe0LYoqdLJ1UQv57qHwVeWQ0X
1c2SRqZWEdL5ibidexbwzgCOSLTE36TZwZ3I3jgeqJgub+V4f0E=
=s1V6
-----END PGP SIGNATURE-----

--=-FEUdib+0n55yFZjHWhea--
