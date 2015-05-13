Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 18:01:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8553 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013241AbbEMQBubYgYJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 18:01:50 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 3D2F341F8D88;
        Wed, 13 May 2015 17:01:47 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 13 May 2015 17:01:47 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 13 May 2015 17:01:47 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8A24FE6FC6CB;
        Wed, 13 May 2015 17:01:44 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 13 May 2015 17:01:46 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 13 May
 2015 17:01:46 +0100
Message-ID: <55537563.5080904@imgtec.com>
Date:   Wed, 13 May 2015 17:01:39 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: cpu: Convert MIPS_CPU_* defs to (1ull << x)
References: <1431530234-32460-1-git-send-email-james.hogan@imgtec.com> <1431530234-32460-3-git-send-email-james.hogan@imgtec.com> <55536FFA.2040801@vanguardiasur.com.ar>
In-Reply-To: <55536FFA.2040801@vanguardiasur.com.ar>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="RwBbkJKewX6Lg73n6GXdnmr4gHfk3cTrV"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47379
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

--RwBbkJKewX6Lg73n6GXdnmr4gHfk3cTrV
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Ezequiel,

On 13/05/15 16:38, Ezequiel Garcia wrote:
>=20
>=20
> On 05/13/2015 12:17 PM, James Hogan wrote:
>> The MIPS_CPU_* definitions have now filled the first 32-bits, and are
>> getting longer since they're written in hex without zero padding. Addi=
ng
>> my 8 extra MIPS_CPU_* definitions which I haven't upstreamed yet this =
is
>> getting increasingly ugly as the comments get shifted progressively to=

>> the right. Its also error prone, and I've seen this cause mistakes on =
3
>> separate occasions now, not helped by it being a conflict hotspot.
>>
>> Convert all the MIPS_CPU_* definitions to the form (1ull << x). Humans=

>> are better at incrementing than shifting.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> ---
>>  arch/mips/include/asm/cpu.h | 70 ++++++++++++++++++++++--------------=
---------
>>  1 file changed, 35 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h=

>> index c45c20db460d..a80819c50e88 100644
>> --- a/arch/mips/include/asm/cpu.h
>> +++ b/arch/mips/include/asm/cpu.h
>> @@ -344,41 +344,41 @@ enum cpu_type_enum {
>>  /*
>>   * CPU Option encodings
>>   */
>> -#define MIPS_CPU_TLB		0x00000001ull /* CPU has TLB */
>> -#define MIPS_CPU_4KEX		0x00000002ull /* "R4K" exception model */
>> -#define MIPS_CPU_3K_CACHE	0x00000004ull /* R3000-style caches */
>> -#define MIPS_CPU_4K_CACHE	0x00000008ull /* R4000-style caches */
>> -#define MIPS_CPU_TX39_CACHE	0x00000010ull /* TX3900-style caches */
>> -#define MIPS_CPU_FPU		0x00000020ull /* CPU has FPU */
>> -#define MIPS_CPU_32FPR		0x00000040ull /* 32 dbl. prec. FP registers *=
/
>> -#define MIPS_CPU_COUNTER	0x00000080ull /* Cycle count/compare */
>> -#define MIPS_CPU_WATCH		0x00000100ull /* watchpoint registers */
>> -#define MIPS_CPU_DIVEC		0x00000200ull /* dedicated interrupt vector *=
/
>> -#define MIPS_CPU_VCE		0x00000400ull /* virt. coherence conflict possi=
ble */
>> -#define MIPS_CPU_CACHE_CDEX_P	0x00000800ull /* Create_Dirty_Exclusive=
 CACHE op */
>> -#define MIPS_CPU_CACHE_CDEX_S	0x00001000ull /* ... same for seconary =
cache ... */
>> -#define MIPS_CPU_MCHECK		0x00002000ull /* Machine check exception */
>> -#define MIPS_CPU_EJTAG		0x00004000ull /* EJTAG exception */
>> -#define MIPS_CPU_NOFPUEX	0x00008000ull /* no FPU exception */
>> -#define MIPS_CPU_LLSC		0x00010000ull /* CPU has ll/sc instructions */=

>> -#define MIPS_CPU_INCLUSIVE_CACHES	0x00020000ull /* P-cache subset enf=
orced */
>> -#define MIPS_CPU_PREFETCH	0x00040000ull /* CPU has usable prefetch */=

>> -#define MIPS_CPU_VINT		0x00080000ull /* CPU supports MIPSR2 vectored =
interrupts */
>> -#define MIPS_CPU_VEIC		0x00100000ull /* CPU supports MIPSR2 external =
interrupt controller mode */
>> -#define MIPS_CPU_ULRI		0x00200000ull /* CPU has ULRI feature */
>> -#define MIPS_CPU_PCI		0x00400000ull /* CPU has Perf Ctr Int indicator=
 */
>> -#define MIPS_CPU_RIXI		0x00800000ull /* CPU has TLB Read/eXec Inhibit=
 */
>> -#define MIPS_CPU_MICROMIPS	0x01000000ull /* CPU has microMIPS capabil=
ity */
>> -#define MIPS_CPU_TLBINV		0x02000000ull /* CPU supports TLBINV/F */
>> -#define MIPS_CPU_SEGMENTS	0x04000000ull /* CPU supports Segmentation =
Control registers */
>> -#define MIPS_CPU_EVA		0x08000000ull /* CPU supports Enhanced Virtual =
Addressing */
>> -#define MIPS_CPU_HTW		0x10000000ull /* CPU support Hardware Page Tabl=
e Walker */
>> -#define MIPS_CPU_RIXIEX		0x20000000ull /* CPU has unique exception co=
des for {Read, Execute}-Inhibit exceptions */
>> -#define MIPS_CPU_MAAR		0x40000000ull /* MAAR(I) registers are present=
 */
>> -#define MIPS_CPU_FRE		0x80000000ull /* FRE & UFE bits implemented */
>> -#define MIPS_CPU_RW_LLB		0x100000000ull /* LLADDR/LLB writes are allo=
wed */
>> -#define MIPS_CPU_XPA		0x200000000ull /* CPU supports Extended Physica=
l Addressing */
>> -#define MIPS_CPU_CDMM		0x400000000ull	/* CPU has Common Device Memory=
 Map */
>> +#define MIPS_CPU_TLB		(1ull <<  0) /* CPU has TLB */
>> +#define MIPS_CPU_4KEX		(1ull <<  1) /* "R4K" exception model */
>> +#define MIPS_CPU_3K_CACHE	(1ull <<  2) /* R3000-style caches */
>> +#define MIPS_CPU_4K_CACHE	(1ull <<  3) /* R4000-style caches */
>> +#define MIPS_CPU_TX39_CACHE	(1ull <<  4) /* TX3900-style caches */
>> +#define MIPS_CPU_FPU		(1ull <<  5) /* CPU has FPU */
>> +#define MIPS_CPU_32FPR		(1ull <<  6) /* 32 dbl. prec. FP registers */=

>> +#define MIPS_CPU_COUNTER	(1ull <<  7) /* Cycle count/compare */
>> +#define MIPS_CPU_WATCH		(1ull <<  8) /* watchpoint registers */
>> +#define MIPS_CPU_DIVEC		(1ull <<  9) /* dedicated interrupt vector */=

>> +#define MIPS_CPU_VCE		(1ull << 10) /* virt. coherence conflict possib=
le */
>> +#define MIPS_CPU_CACHE_CDEX_P	(1ull << 11) /* Create_Dirty_Exclusive =
CACHE op */
>> +#define MIPS_CPU_CACHE_CDEX_S	(1ull << 12) /* ... same for seconary c=
ache ... */
>> +#define MIPS_CPU_MCHECK		(1ull << 13) /* Machine check exception */
>> +#define MIPS_CPU_EJTAG		(1ull << 14) /* EJTAG exception */
>> +#define MIPS_CPU_NOFPUEX	(1ull << 15) /* no FPU exception */
>> +#define MIPS_CPU_LLSC		(1ull << 16) /* CPU has ll/sc instructions */
>> +#define MIPS_CPU_INCLUSIVE_CACHES (1ull << 17) /* P-cache subset enfo=
rced */
>> +#define MIPS_CPU_PREFETCH	(1ull << 18) /* CPU has usable prefetch */
>> +#define MIPS_CPU_VINT		(1ull << 19) /* CPU supports MIPSR2 vectored i=
nterrupts */
>> +#define MIPS_CPU_VEIC		(1ull << 20) /* CPU supports MIPSR2 external i=
nterrupt controller mode */
>> +#define MIPS_CPU_ULRI		(1ull << 21) /* CPU has ULRI feature */
>> +#define MIPS_CPU_PCI		(1ull << 22) /* CPU has Perf Ctr Int indicator =
*/
>> +#define MIPS_CPU_RIXI		(1ull << 23) /* CPU has TLB Read/eXec Inhibit =
*/
>> +#define MIPS_CPU_MICROMIPS	(1ull << 24) /* CPU has microMIPS capabili=
ty */
>> +#define MIPS_CPU_TLBINV		(1ull << 25) /* CPU supports TLBINV/F */
>> +#define MIPS_CPU_SEGMENTS	(1ull << 26) /* CPU supports Segmentation C=
ontrol registers */
>> +#define MIPS_CPU_EVA		(1ull << 27) /* CPU supports Enhanced Virtual A=
ddressing */
>> +#define MIPS_CPU_HTW		(1ull << 28) /* CPU support Hardware Page Table=
 Walker */
>> +#define MIPS_CPU_RIXIEX		(1ull << 29) /* CPU has unique exception cod=
es for {Read, Execute}-Inhibit exceptions */
>> +#define MIPS_CPU_MAAR		(1ull << 30) /* MAAR(I) registers are present =
*/
>> +#define MIPS_CPU_FRE		(1ull << 31) /* FRE & UFE bits implemented */
>> +#define MIPS_CPU_RW_LLB		(1ull << 32) /* LLADDR/LLB writes are allowe=
d */
>> +#define MIPS_CPU_XPA		(1ull << 33) /* CPU supports Extended Physical =
Addressing */
>> +#define MIPS_CPU_CDMM		(1ull << 34) /* CPU has Common Device Memory M=
ap */
>> =20
>=20
> Isn't more readable to use BIT_ULL ?
>=20

Indeed, but unfortunately including <linux/bitops.h> would give you
include recursion:

arch/mips/include/asm/cpu.h
include/linux/bitops.h
arch/mips/include/asm/bitops.h
arch/mips/include/asm/cpu-features.h
arch/mips/include/asm/cpu.h

and as a result the compiler complains that the various cpu_has_* defs
in arch/mips/include/asm/bitops.h are undeclared.

Cheers
James


--RwBbkJKewX6Lg73n6GXdnmr4gHfk3cTrV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVU3VqAAoJEGwLaZPeOHZ6a6MP/RWnzf3hVS5MRW2aTl6b7Lhs
NoGlm5nGwf4qt1MI3R+Myqm+4efjcv1T/FjGu9Z1009KYift+bcc3KIMt+/7QsO8
dF2PXrSowffprdKLZ50ry3jfNSAesOJSDeLs0GAJ7DsCe98WGrN1UScviQi7LtbK
phztE/cVA3IbXQ9tFNOWp8nY4FMQ15YcP8rpYCjG9Vjy1NA3yJhUDGa9rIz5A0hJ
vbDQcZ+L5qmtqcV/bd6BZGnGCi+4QFJxcM1mqXzJEWhv+9/c0+4QmbGqfuHV52RL
gZr61Ro5OWp5Jcu6yrmsavinWN1vywqG/bYkvE4VISy/p0uYOHl05vARK+BdUKAq
LaU7631mf/UqHaRfQRqI5d7r5j/X0QoiQ3dPniJUOlNWkIC36O1CKB3nB1QSqXFI
z+iJG3iHvGfnu5WlDVq5+88XwDGcXDTEP5Z0uupFibHfa7zNruLfqDXb7ix3aSCP
ACV4gxUm73m1bWz+AjK+rHrCXlQLHmnCweHgcjszto5ao1+AkZjfUfyE2EF7Qr4n
X0+iT97H0BI88nGBTh1juicm+NGr+idDQ0UUTT/RH/aEa7IeTAgd5/FQDzcGyH6C
OIoYpQPLDJgsPYNOnBADdoEtu7OX+ai2Cb7C4TfjwOb5mI76ZJNMtFtBODMWk2Am
8xolTvw0xv6smGU6xnav
=mAvi
-----END PGP SIGNATURE-----

--RwBbkJKewX6Lg73n6GXdnmr4gHfk3cTrV--
