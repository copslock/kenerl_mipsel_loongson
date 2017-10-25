Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Oct 2017 10:01:49 +0200 (CEST)
Received: from 5pmail.ess.barracuda.com ([64.235.150.217]:46519 "EHLO
        5pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdJYIBmCX0WH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Oct 2017 10:01:42 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 25 Oct 2017 08:01:21 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 25 Oct
 2017 00:57:55 -0700
Date:   Wed, 25 Oct 2017 08:59:04 +0100
From:   James Hogan <james.hogan@mips.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: Question regarding atomic ops
Message-ID: <20171025075903.GA15260@jhogan-linux>
References: <eb17f62d-c347-e470-f9cf-06b18a55481e@gentoo.org>
 <4f77107c-18ba-d549-c5f2-d52d0460377b@gentoo.org>
 <20171010142306.GA24194@linux-mips.org>
 <f25e53f7-d25d-e9d8-f592-d94e988da28e@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <f25e53f7-d25d-e9d8-f592-d94e988da28e@gentoo.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1508918474-637139-24688-972503-3
X-BESS-VER: 2017.12-r1710102214
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186275
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 01:51:01AM -0400, Joshua Kinard wrote:
> The only uncertainty I have is the bottom of atomic_sub_if_positive and
> atomic64_sub_if_positive.  In R10000_LLSC_WAR case, the end of the assemb=
ler is:
>=20
> 	  "+" GCC_OFF_SMALL_ASM() (v->counter)
> 	: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)

The GCC_OFF_SMALL_ASM() (v->counter) input here looks redundant because
1) the output one has +, which means input and output
2) %4 is never referenced.

> 	: "memory");

To me this appears to be redundant since the only side effects are
writing to v->counter which is already an output, and in any case the
smp_mb__before_llsc() and smp_llsc_mb() imply memory clobber anyway.

>=20
> While the standard case is:
>=20
> 	: "=3D&r" (result), "=3D&r" (temp),
> 	  "+" GCC_OFF_SMALL_ASM() (v->counter)
> 	: "Ir" (i));

So yeh, I'd go for this unless anybody can think of a reason it wouldn't
work in the R10000_LLSC_WAR case.

Hope that helps.

Cheers
James

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlnwREEACgkQbAtpk944
dnpc3g//cfe+cgGh8+sBPvRDKpeAT5eOFKODLucpXuoHrMl7dIyHFvDYPPUU9UJw
fbWTdXhEBPIwC2iiPtBDag5C3AIf+3WakoWeBRTLUmm14CA+CYbjoh11gmFhLrLq
GLH0STcatpudsUTQW6ixBT62N1pMUyKKimHIvAc+17c/Wa3qo0h0/Ze54Oc2in3s
5pcSRG1hhFzdBuY+g6DUwZV7qIj5iDAwLtOSK3cOKNzA37rALrBs9+44YeT4Twep
4D9mJk1AKItHUK9jt2wjrHH8RlIFoBWYqTQKZQGAy68L8zejCAulDQapTfQg1qIu
awDh1oQsbHp7aO+hTpm+fy+S32eut/WpZQ2adI/4qqFb375a9tIHsSaIf0I0GfaH
QeHetxB7UKm79smhjQf6j0/EJRr/+2yfckL/MqcfLF7vnOMSFsKKwuLAy9c4equU
booimj1zbV9K7L0Bi05Tso8NdROODqeT4nP1g7jze+8+xPpwM3K0MWzgD1HOiWNm
i7xGy0NOi9GcBX+AbPDvQ2aQ3r6S4G/ImZhby83KdpTcXtS4ZixKPhDZppBjsQqp
kbdc040V2qv91I6Lx/uhmAk8l4X4lHGlhBL0xroemB4XJTkAY4/SVbE+ctp2chaQ
3+9qNCgQJqI/15L3fsedvwUTcaMOPsJ42882xK9Lihx5mUx8NjM=
=+3IR
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
