Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 23:00:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23349 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993049AbcKIWAtiZ8z1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 23:00:49 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 3F53B41F8E08;
        Wed,  9 Nov 2016 21:59:35 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 09 Nov 2016 21:59:35 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 09 Nov 2016 21:59:35 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AB6D6B8C51F39;
        Wed,  9 Nov 2016 22:00:39 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 9 Nov
 2016 22:00:43 +0000
Date:   Wed, 9 Nov 2016 22:00:43 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Jiri Slaby <jslaby@suse.cz>
CC:     <stable@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [BACKPORT PATCH 3.10..3.16] KVM: MIPS: Drop other CPU ASIDs on
 guest MMU changes
Message-ID: <20161109220043.GA7075@jhogan-linux.le.imgtec.org>
References: <20161109144624.16683-1-james.hogan@imgtec.com>
 <6066667d-e62d-bfec-ca3e-f16f8bef912d@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <6066667d-e62d-bfec-ca3e-f16f8bef912d@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55762
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

On Wed, Nov 09, 2016 at 10:22:01PM +0100, Jiri Slaby wrote:
> On 11/09/2016, 03:46 PM, James Hogan wrote:
> > commit 91e4f1b6073dd680d86cdb7e42d7cccca9db39d8 upstream.
> >=20
> > When a guest TLB entry is replaced by TLBWI or TLBWR, we only invalidate
> > TLB entries on the local CPU. This doesn't work correctly on an SMP host
> > when the guest is migrated to a different physical CPU, as it could pick
> > up stale TLB mappings from the last time the vCPU ran on that physical
> > CPU.
> >=20
> > Therefore invalidate both user and kernel host ASIDs on other CPUs,
> > which will cause new ASIDs to be generated when it next runs on those
> > CPUs.
> >=20
> > We're careful only to do this if the TLB entry was already valid, and
> > only for the kernel ASID where the virtual address it mapped is outside
> > of the guest user address range.
> >=20
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: "Radim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: kvm@vger.kernel.org
> > Cc: <stable@vger.kernel.org> # 3.10.x-
> > Cc: Jiri Slaby <jslaby@suse.cz>
> > [james.hogan@imgtec.com: Backport to 3.10..3.16]
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > ---
> > Unfortunately the original commit went in to v3.12.65 as commit
> > 168e5ebbd63e, without fixing up the references to tlb_lo[0/1] to
> > tlb_lo0/1 which broke the MIPS KVM build, and I didn't twig that I
> > already had a correct backport outstanding (sorry!). That commit should
> > be reverted before applying this backport to 3.12.
>=20
> Thanks, reverted and applied. I wonder the builders didn't break given 4
> mips configurations are tested. I indeed could reproduce locally.

I'm guessing malta_kvm_defconfig isn't one of those defconfigs (and the
imgtec buildbots don't yet test stable branches). Which builders do you
use?

Thanks
James

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYI5yLAAoJEGwLaZPeOHZ6CeUP/0FlsvTqb07gUNQdyGJqcbuJ
0u5x3lUpDDmLxw+rvpvLMKoUa3kylcETWwnoLppJ/vI0LnXDDlu2OuKsyuQtvIfX
y6GV5OEmoVJ9UsFltr9hqXXOc0XSGVs+AlAAoXypot326X3khASKoVNgxoiwPZit
yoBw4ahKf2Vhy37ypNzeoeHdrnqY6dnmnkHQGTWNcAq9zZK66WYdqcu/PLYDOPII
kpsyMvNyCC3/XLcPsxvWB7T8XnqT7dkweIOAcvq/cZT7DSA5Y1pWAR+scGLxQToz
/FhCq33fgzD4zDxEdszjiLd3+eOBoa00BCW1s13qvw7QOebWDHI356U2K64ee79J
YoPxFb9WY3hq2xkPAvkdQOdugUvt7pngDuk2mIT/kX/mDX/5mqA/IiSd4TKD7vGt
lDhIjXV9wT94BLtG2a8qOyvVzi6xWegAR36eu3hWUcdlbfExehWp59wE2uPooTgb
/qNNzoz7E4CNLmN9TI4QWVapZfVm1LnCRLvrd93+BnIuF/AJ+NTzBcj0LUwsHbiY
1Wx0JTmgq6bKTzU96l8UlLoCaemeIh9NnrZ4J+sp7eBVMRSmoEccx0SkY1xncWe1
grZk74XpHRgB1fSf56RE9lSaoJaeg02d59o2En/QnuRyQQQCCWtTvHKOcvnKHvjN
iwN0NVx0MaXcG0M/WT9B
=OjtL
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
