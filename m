Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Sep 2017 20:12:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1692 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993858AbdIUSMAXAKuR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Sep 2017 20:12:00 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C3C1E6ADDD5FE;
        Thu, 21 Sep 2017 19:11:49 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Thu, 21 Sep 2017 19:11:53 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Sep
 2017 19:11:53 +0100
Received: from np-p-burton.localnet (10.20.79.123) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 21 Sep
 2017 11:11:51 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>,
        Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Date:   Thu, 21 Sep 2017 11:11:45 -0700
Message-ID: <6075527.JN7xhOrQ8g@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
References: <20170911151737.GA2265@localhost.localdomain> <20170916133423.GB32582@localhost.localdomain> <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7609025.S680p0rXS8";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.79.123]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart7609025.S680p0rXS8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Maciej/Fredrik,

On Monday, 18 September 2017 10:05:56 PDT Maciej W. Rozycki wrote:
> Hi Fredrik,
> 
> > >  For the initial R5900 support I think there are two options here,
> > > 
> > > depending on what hardware supports:
> > > 
> > > 1. If (for binary compatibility reasons) 128-bit GPR support can somehow
> > > 
> > >    be disabled in hardware, by flipping a CP0 register bit or suchlike,
> > >    then I suggest doing that in the first stage.
> > 
> > Unfortunately I haven't found such a switch. There is also a set of
> > 128-bit
> > multimedia instructions to consider (GCC is perhaps unlikely to generate
> > those but assembly code is an option too).
> 
>  The usual minimal approach is to have compiler intrinsics implemented.
> 
> > > 2. Otherwise I think that the context initialisation/switch code has to
> > > be
> > > 
> > >    adjusted such that the upper GPR halves are set to a known state,
> > >    either zeroed or sign-extended from bit #63 (or #31 really, given the
> > >    initial 32-bit port only) according to hardware requirements, so as
> > >    to
> > >    make execution stable and prevent data from leaking between contexts.
> > > 
> > > Later on proper 128-bit support can be added, though for that to make
> > > sense you need to have compiler support too, which AFAICT is currently
> > > missing.  Myself I'd rather defer commenting on that further support
> > > until
> > > we get to it, although of course someone else might be willing to sketch
> > > an idea.
> > 
> > I have a working 32-bit kernel now, except that BusyBox randomly crashes
> > unless the kernel saves/restores 64-bit GPRs. The executables and
> > libraries
> > declare "ELF 32-bit LSB, MIPS, MIPS-III version 1" so in theory, I
> > suppose,
> > they ought to be 32-bit only. It is possible that the error lies in the
> > kernel handling of the GPRs but I have double-checked this in several
> > ways.
> 
>  Virtually all 64-bit MIPS processors have the CP0.Status.UX bit, which
> the Linux kernel keeps clear for o32 processes (CP0.Status.PX is currently
> unsupported and is kept clear as well), which means that an attempt to use
> any instruction that affects register bits beyond bit #31 will cause a
> Reserved Instruction exception, and in turn SIGILL being sent to the
> program.

This isn't actually true - we currently set ST0_UX unconditionally if the 
kernel is built with CONFIG_64BIT=y. It doesn't matter whether a user program 
is MIPS32 or MIPS64 code, it always runs with UX=1. We also always save all 64 
bits of each GPR - not just the least significant 32 bits when running an o32 
program.

This means 32 bit user code could try using MIPS64 instructions if it wanted 
to, it would just probably be a bad idea.

I think this would be nice to change such that we had UX=PX=0 for o32 
programs, UX=0 PX=1 for n32 programs, UX=1 PX=x for n64 programs, but right 
now we just have UX=1 always for 64 bit kernels.

> > Are there other Linux MIPS implementations that reset GPRs like this?
> 
>  No, because keeping CP0.Status.UX clear guarantees that only instructions
> which sign-extend register results from bit #31 can be used.

I agree that there are no other implementations with this issue - but the 
reason isn't the UX bit, it's that instructions sign extend into wider GPRs 
and the kernel always saves at least as much of a GPR as user code can access.

Thanks,
    Paul
--nextPart7609025.S680p0rXS8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlnEAOEACgkQgiDZ+mk8
HGXxpw/+JWmjiChTr8HVbPMgRsgeo5aZo+5iMVHpJSTZYzSV7CVVhGOilu5MPdxz
pYftkNwrAX5Opl+xqPefSx9CFjHJyUk6uA3QwpksV5kx5FyyBC/CMMPrsrTnpaAY
BNvRkRaDN/iAefGG62/ClLzALm3/f5qoBsX0kBjQIOkGqmvtXYsWGgxKZIkKgTu3
D+x3qhjAs/bTBcSEwBaV+87FGvbwRBFR0D1m0bVehIMdMOIycReEsnc6YRggya0d
Db053ywMVQ+1hu0KlYWWg+3CgAxAsXdXwRHSzKnvgzOLfS6uSxedNlVupntmsPgl
0cD0kws5UiKL022KXy1gUzlirBQcoX2PYHlKe9IMVcWoSEtrOsRTTv7F1tZeXgGH
YX3fb0ayF4MF8hhsF/3PFOg6LLASwLbrKZTy4JN/hfTE0SkIA4TWnrGY8E7kO6l6
khLnliv6TW/RpyUPROfBjhW6gXC71SDfCVMIBNoBRhE0VBMgIkHr30ZplyvmyGhO
ZY8BMpVgxT5aO8IXSZqHPkfrtRPP29lKZG4oLjJa/ZKLBxgoiSZ2T+e+1lJNO0UM
MMXYBy2qFK+1evzuNkYFhuYUN3YeobYl/nmqhgdcMvHI8TorbtVudGsynBoQdzp1
n9w1TwVMoBudximZk8/7UWGpsjOBQ1NF387L9/M6TwcjMf5UOQA=
=DEwU
-----END PGP SIGNATURE-----

--nextPart7609025.S680p0rXS8--
