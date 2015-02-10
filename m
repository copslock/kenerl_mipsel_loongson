Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2015 09:17:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50020 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012464AbbBJIRfkFZak (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Feb 2015 09:17:35 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 59AE941F8E16;
        Tue, 10 Feb 2015 08:17:30 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 10 Feb 2015 08:17:30 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 10 Feb 2015 08:17:30 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 213E44E3E455E;
        Tue, 10 Feb 2015 08:17:28 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 10 Feb 2015 08:17:29 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 10 Feb
 2015 08:17:28 +0000
Date:   Tue, 10 Feb 2015 08:17:28 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        "Gleb Natapov" <gleb@kernel.org>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] KVM: MIPS: Don't leak FPU/DSP to guest
Message-ID: <20150210081728.GK30459@jhogan-linux.le.imgtec.org>
References: <1423069597-8376-1-git-send-email-james.hogan@imgtec.com>
 <20150209225816.GH30459@jhogan-linux.le.imgtec.org>
 <54D9BAC3.9080300@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2feizKym29CxAecD"
Content-Disposition: inline
In-Reply-To: <54D9BAC3.9080300@redhat.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45791
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

--2feizKym29CxAecD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2015 at 09:01:07AM +0100, Paolo Bonzini wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
>=20
>=20
> On 09/02/2015 23:58, James Hogan wrote:
> >> First lets save and disable the FPU (and MSA) state with
> >> lose_fpu(1)
> >=20
> > Please don't apply this patch yet. lose_fpu() uses function
> > symbols which aren't exported for modules to use yet, so that'll
> > need fixing first or KVM won't build as a module.
>=20
> Well, too late. :)
>=20
> James/Ralf, should I revert, or can that be fixed during the RC period?

Okay no problem. I have patches ready so I'll submit today.

Sorry about that!

Cheers
James

>=20
> Paolo
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
>=20
> iQEcBAEBAgAGBQJU2brAAAoJEL/70l94x66DdXIIAImur1pdSKYWw1+FzZH+H8Xo
> 86j9EfptORk554o0a62LG9dOTY+5sJfAV9CoB7Q+8IfdLDKxpk1sLjMkiS0E0EWU
> 2ilQfjYEXLTgCW38p03ype4m6g4uSfT16dnizrwnUviFk/EvVgCWHy88tA3+Vfn/
> WgoxcXkd+hguyNaLR2oAVqyNhAETLTo4kQQqKwGbXFXf0GLno44pj7bJprCR/jlO
> 4+sUzuV5dno/GI6z8dyMmASo0QEy+IoXJ+aSw+IoRED9nlBMAS4+7uD4XfocGpca
> En5KmXVnyJoazgV3Y6w2ymS606S0JNGRcOzqr8ZbOHtjJmAsZxjuVxP6PVzZqQg=3D
> =3Dozzu
> -----END PGP SIGNATURE-----

--2feizKym29CxAecD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU2b6YAAoJEGwLaZPeOHZ6684QAIiFVdBydVIwaQ/8ua+YB58d
HJj/yOK+0bplLAkegomqLvk/JAxqWcx+GuMD9AQ6KW41p15MEGqsvaDnH5UnjwTO
h5JUzsFd1OfdeZpbyCyhzz0aBQglHe2+1pRu4vlYDUZls2PjDddfLq60FDFaerL/
dVedoMmT5bJq+g3AeAkmJREG7v6FFJZsjSNup3y9OedbZpuKB4MHbCVpwFzm6mhL
sZejax5+rKz5Zt+yJxotTepCoAgWGhOfRgruUhoi9ZTTu6m16Vh2TkJ1nxTjOYrC
hRDVziCrjP9s4gezc3pGBDxUryngC5gEdZKbBHe0HmKTb3aotVz5qHJ1e7Oc7/KH
Qo8UPO1gkneWW+qMcw6vMWBNfr8qlRSC0HLApWtbBkQpF4YbZs/dkIPMDLgHFDhH
gY8tIvTblpudllLXriCmLcVhJ43x19ugFBDoC3GCZ4E3T5MZu4ZzLWIRAkLmOuQQ
gBdXkvSZIdaIhtT+VPECZ8Mzpxyy6YrtzXGqx+ZMwVt2XSMggZkcMD7/6NbgrqXt
H/zK7ladaeFgvzzJl29G9aoMksE024Ci/rsz6YvJvgBVNEjgmeE+lL76QEeS1tAM
e4KoRXAQu3H6kS0B9DS16xKcxSJCB5WYg0mcR8jqRqxKHNKv9KsQfFlmySJOB4nA
YpjDBAEBSDZcWDIuI31c
=cnTv
-----END PGP SIGNATURE-----

--2feizKym29CxAecD--
