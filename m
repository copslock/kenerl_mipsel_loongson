Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2015 15:57:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3863 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011543AbbKKO5TiVlie (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2015 15:57:19 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 3B42E41F8EAA;
        Wed, 11 Nov 2015 14:57:14 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 11 Nov 2015 14:57:14 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 11 Nov 2015 14:57:14 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 437F5B1883370;
        Wed, 11 Nov 2015 14:57:11 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 11 Nov 2015 14:57:13 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 11 Nov
 2015 14:57:12 +0000
Date:   Wed, 11 Nov 2015 14:57:12 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, Gleb Natapov <gleb@kernel.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 0/3] MIPS: KVM: Misc fixes
Message-ID: <20151111145712.GX26383@jhogan-linux.le.imgtec.org>
References: <1447251680-5254-1-git-send-email-james.hogan@imgtec.com>
 <56435402.2050503@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QQ0dNM4HnH4+xgqD"
Content-Disposition: inline
In-Reply-To: <56435402.2050503@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: c13f36af
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49890
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

--QQ0dNM4HnH4+xgqD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Wed, Nov 11, 2015 at 03:43:14PM +0100, Paolo Bonzini wrote:
> On 11/11/2015 15:21, James Hogan wrote:
> > A few misc MIPS KVM fixes for issues that have been around since the
> > code was merged in v3.10.
> >=20
> > James Hogan (3):
> >   MIPS: KVM: Fix ASID restoration logic
> >   MIPS: KVM: Fix CACHE immediate offset sign extension
> >   MIPS: KVM: Uninit VCPU in vcpu_create error path
> >=20
> >  arch/mips/kvm/emulate.c |  2 +-
> >  arch/mips/kvm/locore.S  | 16 ++++++++++------
> >  arch/mips/kvm/mips.c    |  5 ++++-
> >  3 files changed, 15 insertions(+), 8 deletions(-)
> >=20
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Gleb Natapov <gleb@kernel.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: kvm@vger.kernel.org
> > Cc: <stable@vger.kernel.org>
> >=20
>=20
> Thanks, these will have to wait after the end of the merge window.

Okay, no problem. As long as they can make v4.4.

For the record do you prefer not to receive patches during merge window?

Thanks
James

--QQ0dNM4HnH4+xgqD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWQ1dIAAoJEGwLaZPeOHZ6tLgP/3aAqb39mlneKvc5UbJXPJwQ
dHwBosuIr5kpa6o0fuL2qa5SVjWAtZYNkvZTNThSm6B4bAwWv/usv2AhDEPjZKs5
qEu8I6bLYyyEdDDAv+8Rbd9VDmYsJQT/xHQpNvpPPRGlinowOEakRwApkM6SZJKa
pnbTB8q+jhY2g8y1w0/thRCnHeVLFFc4VXLEmpjmFX4Pec0cGYQYdqZkqTQdeFHY
FBjqaTds2tDT7DTUhqCIVU3YN7cQ5AqxeV4mhRen+8XuZShXpNXHKCAkpjzPM0DY
ok/o/NTAc0oXn4zXzQz2gLYp2i1x1nCF8dzHs+PcQxUCxsjvjMRpLuyR6jOnGXpk
0PaCL2EzNyPgb+bB05Etv1NcTXnSv5fN2p1ZyrwUQvKmqhm8neLi50lVi6asBnIL
ROjjVN6g9Xl9PDJjy+toogsQdFPiDgbRYUjT+s02MDSfAgqnzF4/blaAMA+IiKn9
cjbE2Ku9LyQUMNYRM967m+LdJRbTxVYf/DE0MkhSPGvzBaz3yKHsbXICfXr4ZwPm
m62rW3fJ34VI4uY0R9FtKxXiRHPaxEcdB8vKLyHpxHlip/CFKPojpMIBtDdH9v8D
cMBdshjCQgYr25Ec2/3fGUgji23fIFgRjGjJJfdgEvcjnSzyFoWQSFhVPiyLmxxn
zJRGFXv9lPJX59Xez/bP
=ZWkN
-----END PGP SIGNATURE-----

--QQ0dNM4HnH4+xgqD--
