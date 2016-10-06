Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2016 22:19:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54253 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992181AbcJFUTuQLHZ1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Oct 2016 22:19:50 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 324FB41F8D64;
        Thu,  6 Oct 2016 21:19:41 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 06 Oct 2016 21:19:41 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 06 Oct 2016 21:19:41 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 77B6D95F8B5FE;
        Thu,  6 Oct 2016 21:19:40 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 6 Oct 2016
 21:19:44 +0100
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 6 Oct
 2016 21:19:43 +0100
Date:   Thu, 6 Oct 2016 21:19:43 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/9] MIPS: traps: 64bit kernels should read CP0_EBase
 64bit
Message-ID: <20161006201943.GI19354@jhogan-linux.le.imgtec.org>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
 <e826225b15736539cd96a1b6b2a99e2bb2b4eb87.1472747205.git-series.james.hogan@imgtec.com>
 <20160921130852.GA10899@linux-mips.org>
 <73eede89-af68-eb17-b0b3-2537084da819@imgtec.com>
 <alpine.LFD.2.20.1610021038190.25303@eddie.linux-mips.org>
 <20161005155653.GG15578@jhogan-linux.le.imgtec.org>
 <alpine.LFD.2.20.1610061709400.1794@eddie.linux-mips.org>
 <20161006180525.GG19354@jhogan-linux.le.imgtec.org>
 <alpine.LFD.2.20.1610062054500.1794@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YhFoJY/gx7awiIuK"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1610062054500.1794@eddie.linux-mips.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1cc78754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55359
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

--YhFoJY/gx7awiIuK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 06, 2016 at 08:56:50PM +0100, Maciej W. Rozycki wrote:
> On Thu, 6 Oct 2016, James Hogan wrote:
>=20
> > >  ISTR a while ago we had a rather lengthy discussion as to how to det=
ect=20
> > > the presence of the upper 32 bits without triggering undefined behavi=
our=20
> > > implied by 64-bit CP0 accesses to 32-bit CP0 registers.  As I believe=
 we=20
> > > set EBase ourselves I think we are able to make the necessary checks =
and=20
> > > have an accurate condition here, still remembering however that it ma=
y go=20
> > > back as far as MIPSr3.
> >=20
> > We only set ebase under certain circumstances, otherwise leaving it as
> > already set.
>=20
>  How can we install a handler then when we don't know what the upper 32=
=20
> bits of EBase are?

Right now its assumed the default upper 32 bits are sign extension of
bit 31 in that case (i.e. thats what upper 32bits are clobbered to). I
think the only case where that might not be true would be where WG is
implemented and the bootloader has changed them to e.g. somewhere in
XKPhys, and then cleared WG. We could catch that most of the time by
detecting changed bits 31:30 (as I think you suggested before), but it
still isn't watertight (e.g. xkphys+0x80000000), so if in doubt we
should probably be sure to allocate our own exception vector instead of
guessing at the boot one. What a mess :-(.

Cheers
James

--YhFoJY/gx7awiIuK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX9rHfAAoJEGwLaZPeOHZ6tLwP/0eOEch7X6E+cbLBwKyPMuDE
jPZWYGLl6DiRBl7JEX1oOMc/qrMb9pWZhEX2ULo1q04zORWhSRQrwbP8677UUg2c
dp/IZnfPALbOQbZV/UFxb8xLVVhBO1iU9rXj97BwiEw04lljwTyJbZAYkIO3T5jR
iLd/5kJlSsU9O50lg6hZh2OmO/YGjykjvTKcTjKEVF5bFgP/3PWS5hOaqE7M2e6p
twocaCvAcS00OVL9IEtc2uHuQlHpPppKBl7lcd4O2cr6vAFTgZE0EkmTPWylQoRR
6eZzJXhkeq/naFWcMVCwRqQZ2/nBEPEuj+uX4m6pDzmypJxe15o/07x8ZGTeG0wq
kSpsKp1i2aVbhZ3yS22iuTloh4buEt3ZOSQ6bf4WmzFa9t1SY3yNkengGmI3enXE
1GOjUD92whKHxwA/83QK800eow8ozUJIqOwSKrWTHLdLo5KxhEW5chI+GI2daRWp
VfAsDXBftZYLLq1Yoh84wn7rjVeE/NOgHFxIEEc3rr940rDlFxaR0U5TBExM0Uel
TFAVCj6Rt1oEAqKlA/OZzKpYdn/8f8wD/VYvnrXBGcOUwK5DvbbQwSiv29wUAYsC
obsKf1rPS1AoORau7QschqnP8Bj2hG0Z1F1sRrQNwIxt9OBYPpjOelG7gH+oeO4M
q/Qwy+rWDrsZpYVwFU6u
=BSQx
-----END PGP SIGNATURE-----

--YhFoJY/gx7awiIuK--
