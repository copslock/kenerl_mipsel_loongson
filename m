Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2011 11:05:19 +0200 (CEST)
Received: from mailout-de.gmx.net ([213.165.64.22]:38318 "HELO
        mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1491051Ab1I3JFL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Sep 2011 11:05:11 +0200
Received: (qmail invoked by alias); 30 Sep 2011 09:05:05 -0000
Received: from g225033181.adsl.alicedsl.de (EHLO mosquito.pool.gmx.de) [92.225.33.181]
  by mail.gmx.net (mp038) with SMTP; 30 Sep 2011 11:05:05 +0200
X-Authenticated: #4121607
X-Provags-ID: V01U2FsdGVkX1/AF4pQ1M/AR+eZ8tpW5u5hINQIfDnO1gbXNO2Yj8
        T1OcvyPsfG3sp0
From:   David Kuehling <dvdkhlng@gmx.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] add MIPS assembler version of twofish crypto algorithm
References: <87ty9c743i.fsf@snail.Pool>
        <20110928133241.GA30192@linux-mips.org>
Date:   Fri, 30 Sep 2011 11:04:57 +0200
In-Reply-To: <20110928133241.GA30192@linux-mips.org> (Ralf Baechle's message
        of "Wed, 28 Sep 2011 15:32:41 +0200")
Message-ID: <871uuycsee.fsf@mosquito.pool>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
X-Y-GMX-Trusted: 0
X-archive-position: 31186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvdkhlng@gmx.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thought that patch went unnoticed and almost forgot about it myself...
Nice to see that it didn't slip through, and thanks for taking the time
to review.

About your comments:

>>>>> "Ralf" =3D=3D Ralf Baechle <ralf@linux-mips.org> writes:

> On Sat, Aug 20, 2011 at 12:46:25PM +0200, David Kuehling wrote:
>> this patch adds a MIPS assembler version of the twofish cipher
>> algorithm.  x86(_64) had an assembler version of twofish for some
>> time now, giving it an "unfair" advantage against the not so common
>> architectures.
[..]
> Lots of trailing whitespace in that patch.  scripts/checkpatch.pl
> would have warned about those =E2=80=A6

> +#if __mips64 +# define HAVE_64BIT +#endif

> s/HAVE_64BIT/CONFIG_64BIT/

> +#if _MIPS_SZPTR =3D=3D 32 +# define PTRADD addu=20
[..]
> PTR_ADDU from <asm/asm.h> does the same thing as PTRADDU so the entire
> ifdefery above can go away.

Good point, that'll neatly clean the patch up.

> Finally the use of register names starting with $ is a bit obscure.
> Kernel code needs to build for N64 and O32 but of those only N64 has
> registers called $ta0 .. $ta3 which are the equivalent to registers $8
> .. $11.

> And in O32 registers $t0 ... $t3 also aliases for $8 .. $11.  I
> haven't fully analyzed the code to ensure that there is no register
> conflict arising from that.

Didn't find another way to make the code work with O32 and N64.
$ta0..$ta3 can replace registers $t4..$t7 that are missing on N64 to
make room for additional argument registers $a4..$a7.  This works as
long as $a4..$a7 aren't used as well.

Looking at asm/regdef.h I see that #define ta0 etc. is missing for O32,
making that trick impossible.  Maybe we should add them there as well?

> I was surprised that gas assembles the code at all.  $ta0 .. $ta3 are
> N32 / N64 register names and consider gas permitting the use of these
> registers in O32 a bug - but see my other posting to the binutils list
> for that.

Yes, that feature may be obscure, had to grep through binutil sources to
find out about it...

> Improvment suggestion for le32_fromto_cpu - MIPS 32/64 R2 CPUs can use
> the wsbh instruction to faster endianess swapping:
[..]

I completely missed the wsbh opcode.  Knew about rotr, but given that
even the recent Loongson-2f doesn't support it, I was reluctant to add
code for it (plus i won't be able to benchmark it anyways).

> This code fragment is from <asm/swab.h>.

> + /* if we turned this into 64-bit ops, we get endianess issues on +
> big-endian mips, plus alignment problems */

> Some CPUs (Cavium Octeon) handle unaligned loads in hardware, on
> others a combination of LDL / LDR and SDL / SDR could be used to
> handle the unaligned loads and DSBH / DSHD (see __arch_swab64 in
> swab.h) could be used on MIPS64 R2 CPUs to handle the alignment
> issues.  Or a rotate - have to think about it.

There is an alignmask field in the crypto_alg struct, that might prevent
alignment issues.  Didn't have an in-depth look at how that works
though.  Still there would be endianess issues, given that twofish is
designed to work on words of 32-bit.

I think the load/store code of the crypto routine does not have much
influence on performance, as it is outside the main loop (including the
endianess conversion).  There is a rotation operation within the loop,
that could be sped up using rotr opcode, giving maybe 2% performance
gain.  Not sure whether that's worth another round of #ifdefs and twice
the testing.

What'd be the best way to check for rot opcode support?  Use
CONFIG_CPU_MIPSR2?  Check gcc define __mips>=3D32 && __mips_isa_rev>=3D2
(grepping through kernel asm files, I don't find any asm sources that
include kconfig.h)?

I'm currently a little swamped with work, btw, might take me a few days
to prepare an updated patch.

cheers,

David
=2D-=20
GnuPG public key: http://dvdkhlng.users.sourceforge.net/dk.gpg
Fingerprint: B17A DC95 D293 657B 4205  D016 7DEF 5323 C174 7D40

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFOhYY6fe9TI8F0fUARAqqQAJwNj3Zz/SM8qct32d6MU2ihEE3cCACfSCcW
LHcPXWRw0Rkz6QLGS9rc850=
=DgEg
-----END PGP SIGNATURE-----
--=-=-=--
