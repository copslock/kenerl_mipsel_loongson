Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2016 17:43:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54430 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992910AbcIHPnbwVTaA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Sep 2016 17:43:31 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 52D3941F8D9E;
        Thu,  8 Sep 2016 16:26:34 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 08 Sep 2016 16:26:34 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 08 Sep 2016 16:26:34 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 29EABD4F15582;
        Thu,  8 Sep 2016 16:26:30 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 8 Sep
 2016 16:26:33 +0100
Date:   Thu, 8 Sep 2016 16:26:33 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 0/2] MIPS: KVM: Partial EVA support
Message-ID: <20160908152633.GA26885@jhogan-linux.le.imgtec.org>
References: <cover.4afb9d6281172d5a66d490da41c5ea418050dcea.1473335231.git-series.james.hogan@imgtec.com>
 <5d95c50f-b9bd-49e0-9bca-71242d9d5efd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <5d95c50f-b9bd-49e0-9bca-71242d9d5efd@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 5de3adfe
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55073
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

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Thu, Sep 08, 2016 at 03:34:59PM +0200, Paolo Bonzini wrote:
>=20
>=20
> On 08/09/2016 14:13, James Hogan wrote:
> > These patches fix a couple of problems when using MIPS KVM on a host
> > kernel with Enhanced Virtual Addressing (EVA) enabled.
> >=20
> > Patch 1 fixes the HVA error codes like s390 does, due to PAGE_OFFSET
> > potentially being as low as 0.
> >=20
> > Patch 2 allows MMIO to be emulated from TLB refill exceptions as well as
> > address error exceptions (since EVA configurations may make KSeg1
> > addresses TLB mapped to user mode).
> >=20
> > It isn't complete as there are still a couple of cases where KVM tries
> > to directly access guest memory using normal loads and stores (which
> > doesn't work with EVA's overlapping usermode & kernel mode address
> > spaces). That really needs fixing properly anyway to handle the
> > potential for TLB invalidations (and the resulting refills & page
> > faults).
> >=20
> > For KVM to work on EVA hosts also requires some MIPS architecture
> > changes, as found in my recent "MIPS: General EVA fixes & cleanups"
> > patchset.
>=20
> Since there aren't any overlaps with 4.8 patches, feel free to send a
> pull request for these and any other patches you might have in the rest
> of this cycle.

Yeh, I'd like to start working with pull requests (and topic branches
where applicable) from now on. I'd normally still post patches to the
lists even if I immediately apply them (I should perhaps move you from
To to Cc), is that okay?

Any particular times in the cycle you want pull requests, or deadlines
for new features for the next release?

Should I get a branch added to linux-next, or just rely on kvm/next
after stuff is pulled?

Any other preferences?

Thanks
James

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX0YMpAAoJEGwLaZPeOHZ6kF8P/0cl/hyTrfeUul0btJaO19Kv
mR+ASEVSibwa2DEMp9Ln3w+TX/lPawAhk/9g5mjTE0P6sA/tJAETo/st+92guVIp
tQBSP3BO6jo7n06/D043MdOBX2MTHHz753ctRegH2Hn77UwQLT//p6wCZkXlImNb
swPwJA7Kz6e2efvBpqR01P2c0+tuMJKMuy5kxZNKlkg1eHntq+leJHSw6GSXASKV
x58k4994D5AVzFrVy/9/gyGGO/YNuXd88B6/TGW9i+u4NE2Rbz7SQNcfIvJ2gUU1
2ICtaRvF3ZzbMxdtrrOr1OFgzK9ahXs9NOEEqmX5Z1b7PychSyM8Ca0g63jalRUV
ds6ZCHr0O/iMQJeHhoJaq8N9si7er/PJpEqPK3r2Lxl2o/RGkHUuSIDKKJHom5pf
J5V9ldkYbMnvxHgHEqMreOKXRPFVfe4P6KaTcpiphwIHMrFIvZHGocRHOm0oLZV5
PdEdepkSyNI6KlEovoDx9LdgrlTJdq2udpglWzsd4Dj6OZa1vc7ehBC0M4se81dG
vaO+BZ2Qn2xNCByJCt1cxD5tA2I87b6nsQNre3q/ZVLCqlyENIX/S2Ewdgtd/8yv
2VobVbf+KVCvjkU+dhKTzoQhiWIBJ4F5bVCN5IkaOiLGhM3dFgMVq4Me+B4VF+WJ
ekyqNOqizT745k7O3IiV
=ARp3
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
