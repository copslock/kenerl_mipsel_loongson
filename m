Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 13:08:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45719 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993179AbdASMIpXQnuB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2017 13:08:45 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 243AF41F8E6A;
        Thu, 19 Jan 2017 13:11:26 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 19 Jan 2017 13:11:26 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 19 Jan 2017 13:11:26 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 20EC3DB1070D2;
        Thu, 19 Jan 2017 12:08:36 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 19 Jan
 2017 12:08:39 +0000
Date:   Thu, 19 Jan 2017 12:08:38 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     SF Markus Elfring <elfring@users.sourceforge.net>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf =?utf-8?Q?B=C3=A4chle?= <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: KVM: Return directly after a failed
 copy_from_user() in kvm_arch_vcpu_ioctl()
Message-ID: <20170119120838.GF31545@jhogan-linux.le.imgtec.org>
References: <87aac8b8-4f30-2edd-4688-42d32d815cd1@users.sourceforge.net>
 <88b008c5-552b-7314-94d8-02214f38a456@redhat.com>
 <7a6b5858-9137-9d20-78fe-6b466081920f@users.sourceforge.net>
 <a1af7ad2-4f3c-36c8-37e8-940e96810cd2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Content-Disposition: inline
In-Reply-To: <a1af7ad2-4f3c-36c8-37e8-940e96810cd2@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56418
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

--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 11:27:52AM +0100, Paolo Bonzini wrote:
>=20
>=20
> On 19/01/2017 11:20, SF Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Thu, 19 Jan 2017 11:10:26 +0100
> >=20
> > * Return directly after a call of the function "copy_from_user" failed
> >   in a case block.
> >=20
> > * Delete the jump label "out" which became unnecessary with
> >   this refactoring.
> >=20
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >=20
> > V2:
> > A label was also removed at the end.
> >=20
> >  arch/mips/kvm/mips.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> > index 06a60b19acfb..3534a0b9efed 100644
> > --- a/arch/mips/kvm/mips.c
> > +++ b/arch/mips/kvm/mips.c
> > @@ -1152,10 +1152,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsi=
gned int ioctl,
> >  		{
> >  			struct kvm_mips_interrupt irq;
> > =20
> > -			r =3D -EFAULT;
> >  			if (copy_from_user(&irq, argp, sizeof(irq)))
> > -				goto out;
> > -
> > +				return -EFAULT;
> >  			kvm_debug("[%d] %s: irq: %d\n", vcpu->vcpu_id, __func__,
> >  				  irq.irq);
> > =20
> > @@ -1165,17 +1163,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp, uns=
igned int ioctl,
> >  	case KVM_ENABLE_CAP: {
> >  		struct kvm_enable_cap cap;
> > =20
> > -		r =3D -EFAULT;
> >  		if (copy_from_user(&cap, argp, sizeof(cap)))
> > -			goto out;
> > +			return -EFAULT;
> >  		r =3D kvm_vcpu_ioctl_enable_cap(vcpu, &cap);
> >  		break;
> >  	}
> >  	default:
> >  		r =3D -ENOIOCTLCMD;
> >  	}
> > -
> > -out:
> >  	return r;
> >  }
> > =20
> >=20
>=20
> Removing the label makes the patch worthwhile.
>=20
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks Markus & Paolo. Looks better now. I'll apply for 4.11.

Cheers
James

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYgKw9AAoJEGwLaZPeOHZ6D4AQAJQdEBH6ZT270B+aHG6nr8tK
ewVWMWaAqBvaErWIBKqbvvQ9sGWLcCZDLa/b1bUC0vJjLzEHfqa70ngncTg0PDji
ryCmg4PjnMb96eFhRbVZb9geL9wBDTqQDEz2sLbPOExfxpyKGv1kelddSzfepsR7
qY3Gfc1o0i2N+vKtn+Q8aZu1FwArkMx9uilqUqf1j2ty+wN2OKhi4hSNAkfRCWtv
/GrPbpB+SyDJI3N87/ecn3uWfNWN0kaxZk6q1/FKrCvdb5PNfgiXNdQt8rzJSHM+
5T13smShdIv7NT14Uj/puT/Xr8nVZxdqCZu8ZTX7crq6wkXos4luPjBJTi+p660m
LsimiM51NdMMl3jQCy4EnLmnum4q5yEkDMEQv8CMTjOsvwvJgmoYKtswPgISjMeT
DuYKlNXplTbThtBwr1sU/FfoVSso1Zjx7jSmU5fHvyYWB3IYBH3RpVB1LjRGdxgS
x7v1WTku8juklW1zXbJdEfu0pg8UBiMw1RJq+cyMokUbg8vs4Glci4BBsFCY1nfz
SYhIaAsX30Egzr8BXb1QQWh8ldx7XwNHX1XXimJv4+6ubBcmuIG7v8kztsS3USdp
EdRlBnr4PASOoUjWqz/MlkDhmlaOfZHCPwJyqN4akHxUaxoCsp7R/xE/4L159bzs
n+jWCIWkTECxGJmhsxVi
=xVVV
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
