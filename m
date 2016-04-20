Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 19:09:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12357 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27027144AbcDTRJcvCe-w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 19:09:32 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 9B79C41F8E9F;
        Wed, 20 Apr 2016 18:09:25 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 20 Apr 2016 18:09:25 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 20 Apr 2016 18:09:25 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id AFE86E78CDC4B;
        Wed, 20 Apr 2016 18:09:21 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 20 Apr 2016 18:09:25 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Wed, 20 Apr
 2016 18:09:24 +0100
Date:   Wed, 20 Apr 2016 18:09:24 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
CC:     Greg Kurz <gkurz@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, <mingo@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <qemu-ppc@nongnu.org>,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160420170924.GA7859@jhogan-linux.le.imgtec.org>
References: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
 <20160420170209.GA11071@potion>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Hch1Uz/zGPcHFdv8"
Content-Disposition: inline
In-Reply-To: <20160420170209.GA11071@potion>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53136
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

--Hch1Uz/zGPcHFdv8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 20, 2016 at 07:02:10PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> 2016-04-20 17:44+0200, Greg Kurz:
> > Commit 338c7dbadd26 ("KVM: Improve create VCPU parameter (CVE-2013-4587=
)")
> > introduced a check to prevent potential kernel memory corruption in case
> > the vcpu id is too great.
> >=20
> > Unfortunately this check assumes vcpu ids grow in sequence with a common
> > difference of 1, which is wrong: archs are free to use vcpu id as they =
fit.
> > For example, QEMU originated vcpu ids for PowerPC cpus running in boot3=
s_hv
> > mode, can grow with a common difference of 2, 4 or 8: if KVM_MAX_VCPUS =
is
> > 1024, guests may be limited down to 128 vcpus on POWER8.
> >=20
> > This means the check does not belong here and should be moved to some a=
rch
> > specific function: kvm_arch_vcpu_create() looks like a good candidate.
> >=20
> > ARM and s390 already have such a check.
> >=20
> > I could not spot any path in the PowerPC or common KVM code where a vcpu
> > id is used as described in the above commit: I believe PowerPC can live
> > without this check.
> >=20
> > In the end, this patch simply moves the check to MIPS and x86.
> >=20
> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > ---
> > v3: use ERR_PTR()
> >=20
> >  arch/mips/kvm/mips.c |    7 ++++++-
> >  arch/x86/kvm/x86.c   |    3 +++
> >  virt/kvm/kvm_main.c  |    3 ---
> >  3 files changed, 9 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> > index 70ef1a43c114..0278ea146db5 100644
> > --- a/arch/mips/kvm/mips.c
> > +++ b/arch/mips/kvm/mips.c
> > @@ -248,9 +248,14 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *=
kvm, unsigned int id)
> >  	int err, size, offset;
> >  	void *gebase;
> >  	int i;
> > +	struct kvm_vcpu *vcpu;
> > =20
> > -	struct kvm_vcpu *vcpu =3D kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL=
);
> > +	if (id >=3D KVM_MAX_VCPUS) {
> > +		err =3D -EINVAL;
> > +		goto out;
>=20
> 'vcpu' looks undefined at this point, so kfree in 'out:' may bug.

Thats out_free_cpu I think?

Cheers
James

> Just 'return ERR_PTR(-EINVAL)'?
>=20
> > +	}
> > =20
> > +	vcpu =3D kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
> >  	if (!vcpu) {
> >  		err =3D -ENOMEM;
> >  		goto out;

--Hch1Uz/zGPcHFdv8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXF7fEAAoJEGwLaZPeOHZ63FwP/jutTp81tD+zSkNw91jiEcN1
UYzpau7orGcqXVXLCd0QLiSQEnOm9uIqdok8misKnD5IQ5L8fjJS6FGtCE1WAtHk
6xXTLeVq0zT03Qsukpk3QXPcf9+ImVYfQZ7CbzmnLEA/qn1soDDnjc9mCkcONSpz
TKdGP7itqBnK3p3e1Iy1MXaTfM9jNqg7sz0XdqvxxPuI3gAAkjoMKgAEtTo/XYwC
ILtuSc3Z+RaOECthdzG5NiO0EjMYLFAMWKN2EMcW4Wqc6x/t9M1XZi7Hyrql+7HW
RP4g1cymst9x4W2jTuWM2JrV/INAnygLaxZdy4XNjGwLjSKdWf4zNs8fi6KN7iJp
bp90L7USzT8C9cMpEIgz2yi7aXv6WltxWmh/lTbUgVc4KlyGSxTsxX3ibc8ZtoWI
dcIXG5OUxje/UCtTOKqgpNRnbn8cBHfDqVIKyUWcYA9kiTkPpV/FylWko8+IAApq
jof3nxtBsWOcFYKgTFYCWR5jPTIuFRJBdjIci8peXSunLscGaloc4V8AW9kXHf3j
fzOf4tPl26NglxmdkzD35UFd9Vgj3wAUxoYe07h59tEmcWTo2ALD7QC5Be9f0eAL
nAoBaj5XvL/5CHlJulXdUl9OeRHzjlgbVTW/WDJVZfhfkkUeTbzUNeUSSTwvQlGy
ML1hCvSC5flqjsg0J4Rk
=zzda
-----END PGP SIGNATURE-----

--Hch1Uz/zGPcHFdv8--
