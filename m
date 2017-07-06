Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jul 2017 11:06:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46900 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990644AbdGFJGADGkCQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Jul 2017 11:06:00 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id DAD5641F8EB8;
        Thu,  6 Jul 2017 11:16:18 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 06 Jul 2017 11:16:18 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 06 Jul 2017 11:16:18 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 56AF54955CB42;
        Thu,  6 Jul 2017 10:05:51 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 6 Jul
 2017 10:05:54 +0100
Date:   Thu, 6 Jul 2017 10:05:53 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        <linux-mips@linux-mips.org>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 2/4] MIPS: VDSO: Add implementation of clock_gettime()
 fallback
Message-ID: <20170706090553.GO31455@jhogan-linux.le.imgtec.org>
References: <1498665337-28845-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1498665337-28845-3-git-send-email-aleksandar.markovic@rt-rk.com>
 <alpine.DEB.2.00.1707060055470.3339@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aTCJOP0qgkSGqHWA"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1707060055470.3339@tp.orcam.me.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59027
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

--aTCJOP0qgkSGqHWA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 01:00:34AM +0100, Maciej W. Rozycki wrote:
> On Wed, 28 Jun 2017, Aleksandar Markovic wrote:
>=20
> > diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofda=
y.c
> > index fd7d433..5f63375 100644
> > --- a/arch/mips/vdso/gettimeofday.c
> > +++ b/arch/mips/vdso/gettimeofday.c
> > @@ -20,6 +20,24 @@
> >  #include <asm/unistd.h>
> >  #include <asm/vdso.h>
> > =20
> > +static __always_inline long clock_gettime_fallback(clockid_t _clkid,
> > +					   struct timespec *_ts)
> > +{
> > +	register struct timespec *ts asm("a1") =3D _ts;
> > +	register clockid_t clkid asm("a0") =3D _clkid;
> > +	register long ret asm("v0");
> > +	register long nr asm("v0") =3D __NR_clock_gettime;
> > +	register long error asm("a3");
> > +
> > +	asm volatile(
> > +	"       syscall\n"
> > +	: "=3Dr" (ret), "=3Dr" (error)
> > +	: "r" (clkid), "r" (ts), "r" (nr)
> > +	: "memory");
> > +
> > +	return error ? -ret : ret;
> > +}
>=20
>  Hmm, are you sure it is safe nowadays WRT the syscall restart convention=
=20
> to leave out the instruction explicitly loading the syscall number that=
=20
> would normally immediately precede SYSCALL

It should be fine. syscall restart only rewinds one (32-bit)
instruction, and it preserves the syscall number in pt_regs::regs[0]
(see handle_signal() / do_signal() and this code in e.g. scall32-o32.S:)

sw      t1, PT_R0(sp)           # save it for syscall restarting

> (and would have to forcibly use the 32-bit encoding in the microMIPS
> case)?

I don't believe there is a 16-bit SYSCALL encoding in microMIPS, at
least I can't see one in the 5.04 manual.

However, the clobber list is incomplete.
The following registers are written as outputs:
	$2 (v0), $7 (a3)
The following registers are used as arguments and should be preserved:
	$4-$6 (a0-a2), [$8-$9 (a4-a5)] (n32 / n64 only)
And the following other registers are preserved:
	$16-$23, $28-$31
So assuming you already have $2 and $7 as outputs, the clobber list
should be:
	"$1", "$3", ["$8", "$9",] "$10", "$11", "$12", "$13", "$14",
	"$15", "$24", "$25", "hi", "lo", "memory"

(only o32 needs to mark $8-$9 clobbered, but no harm doing so on n32/n64
too)

Cheers
James

--aTCJOP0qgkSGqHWA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlld/WkACgkQbAtpk944
dnoitRAAjseL+PlvbC+PH3gr5tmbba2vLaBhETrgiq4sXEG8VTvKTWqaxBI5WKc8
5wX+tGmvFhjI4CUv5INF/KnrUMPoHEplGYjRxUVfGjkwL00w4wvbtLISykhAsI6t
D4jan35chJrQ59lOzwxkJ7a+equk8WUbVWsovFKJW8o6odq5TLXcmWyqM2/sMMvY
BLsxYFX96jFSbkuvw3l3WwMDHxSGIro7qNFX0uKAtrjI7H1BOxu7DvFc+Jbu9em6
5P8kn97xITaQvNNPGut/NTymykQ7ZLfnVBFMmH0lwDqEr7pTWUmMyp8zpGYgLv6T
RfmfiSz4RMu8lfbzJBxaMGjkzy4TXEHahsJgemHH0RC10ZC0K2ytBTOHLnhO6SdF
gJMG1IfcDx52+V4oxT9Xn41TwiKFELSq5br1bL/VEs3sC6z6d/ACXF215bbE9MEC
tauA/qgripHRZmBQCBHDvA0BJWH2v6XTbfTu0neeJD7YFnxBv5B7N0fguljFLSxH
cMx6u478XdTwkb1FLwNT5sPpY9S3FRidEjFsehc2thjUSZZw/ItYztdnnHJQe/nS
pJidlyGgyObPjMXzxNPbTVdANJLsFcZlo8jESiFlZDUSLfU3vCzB2vcFK8c0eV9V
NoxcIGT3rxyCcjYqQxHucs94D1i3iz7+Byj/+h5GAJqkWUhcstA=
=FDa7
-----END PGP SIGNATURE-----

--aTCJOP0qgkSGqHWA--
