Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 15:56:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58002 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27028040AbcEJN4Ka8pE0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 May 2016 15:56:10 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 591FF41F8DC1;
        Tue, 10 May 2016 14:56:02 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 10 May 2016 14:56:02 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 10 May 2016 14:56:02 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 13E0DACEE3381;
        Tue, 10 May 2016 14:55:59 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 10 May 2016 14:56:01 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 10 May
 2016 14:56:01 +0100
Date:   Tue, 10 May 2016 14:56:01 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 0/5] MIPS: KVM: A few misc fixes
Message-ID: <20160510135601.GH23699@jhogan-linux.le.imgtec.org>
References: <1461317929-4991-1-git-send-email-james.hogan@imgtec.com>
 <5731DBD3.50200@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Content-Disposition: inline
In-Reply-To: <5731DBD3.50200@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: ebfc6934
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53344
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

--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 10, 2016 at 03:02:11PM +0200, Paolo Bonzini wrote:
>=20
>=20
> On 22/04/2016 11:38, James Hogan wrote:
> > Here are a few misc fixes for KVM on MIPS, including 2 guest timer race
> > fixes, 2 preemption fixes, and missing hazard barriers after disabling
> > FPU.
> >=20
> > James Hogan (5):
> >   MIPS: KVM: Fix timer IRQ race when freezing timer
> >   MIPS: KVM: Fix timer IRQ race when writing CP0_Compare
> >   MIPS: KVM: Fix preemptable kvm_mips_get_*_asid() calls
> >   MIPS: KVM: Fix preemption warning reading FPU capability
> >   MIPS: KVM: Add missing disable FPU hazard barriers
> >=20
> >  arch/mips/include/asm/kvm_host.h |  2 +-
> >  arch/mips/kvm/emulate.c          | 89 ++++++++++++++++++++++----------=
--------
> >  arch/mips/kvm/mips.c             |  8 +++-
> >  arch/mips/kvm/tlb.c              | 32 ++++++++++-----
> >  arch/mips/kvm/trap_emul.c        |  2 +-
> >  5 files changed, 79 insertions(+), 54 deletions(-)
> >=20
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: "Radim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: kvm@vger.kernel.org
> > Cc: <stable@vger.kernel.org>
> >=20
>=20
> Queued to kvm/next, thanks.

Thanks Paolo!

Cheers
James

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMehxAAoJEGwLaZPeOHZ6CdMP/0pM//8M0Jb8bCJKqcwOXvzb
u/EA6/nd+vWN5mRDTCH8JXuQC3WJKPYvOpQn9JIvP4LcAYURTkzdslvApUMr7ixD
I9/gjndPdaEhzBo1dWPdMz7v7kWeelWOZ1Is2YnFXY7pyX23HFZTn90x0qWe811x
If8ZStBRwYWp9qgy6F0cU0zcNUzcSqHpxrCuhKayLJZmDgiULMgixoX2Ys3b4jYX
L8fjXSePcDsMF6ESroNT61mmvHLQIzDD8GjzVIVLdStPHJ/pT96ad2xCZ5pV0IAo
VzEuGOiXRYtN+T9DLXLCw19oI58UEva7ZnC3jyRPLaV0NABOUX2N0eh9jVeYBSwQ
HetIFsDC2jnCo5c52ABbn31Yv/RRHqzfpchHKRitirkPqchZKRf8lH6HAsqW6j5a
Hcf/8J+1wQxryXsv6qmGniljjLGoqW7xC6KV22yxYDjt5ZJwIU5A72acpE2hafiP
z57Tzg4ZBq7s4m+jNlIlVrJUBUi6zbsuAhrW5weAPgnomZg4D32SyIKmM/Q6lSB6
PODUp+rNNYS6eQ43OotJb8GKiXmDGY5F2SXZyk8b1+VeHQtGHWJPZiq5tmUSZ3L9
TuQh5kiOQJX7gVLAysKOhVyq8a1x/YqGKEsWjGNLTrde5zPdTkOAXuA46v7B2AN8
XyMBja24ET0uhjw0+O0K
=+p5u
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--
