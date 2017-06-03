Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jun 2017 00:27:13 +0200 (CEST)
Received: from atomos.longlandclan.id.au ([IPv6:2001:44b8:21ac:7000::1]:54263
        "EHLO atomos.longlandclan.id.au" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993943AbdFCW1FgYyKY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Jun 2017 00:27:05 +0200
Received: from [IPv6:2001:44b8:21ac:7053:a64e:31ff:fe53:99cc] (rikishi.local [IPv6:2001:44b8:21ac:7053:a64e:31ff:fe53:99cc])
        by atomos.longlandclan.id.au (Postfix) with ESMTPSA id B3908208B270;
        Sun,  4 Jun 2017 08:26:35 +1000 (EST)
Subject: Re: QEMU Malta emulation using I6400: runaway loop modprobe
 binfmt-464c
To:     "Maciej W. Rozycki" <macro@imgtec.com>
References: <996c275d-d969-508e-6b4e-bef22d8e7385@longlandclan.id.au>
 <alpine.DEB.2.00.1706031310470.2590@tp.orcam.me.uk>
Cc:     linux-mips@linux-mips.org
From:   Stuart Longland <stuartl@longlandclan.id.au>
Openpgp: id=BCA11879F4F93BE3DB0DEE72F954BBBB7948D546;
 url=https://stuartl.longlandclan.id.au/key.asc
Message-ID: <81bca3a5-88dc-d6af-9c6a-3e17d9a8bda5@longlandclan.id.au>
Date:   Sun, 4 Jun 2017 08:26:00 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1706031310470.2590@tp.orcam.me.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eKDPapevvvD93eDgPBNSlj70lcJ8jGV6H"
Return-Path: <stuartl@longlandclan.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.id.au
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eKDPapevvvD93eDgPBNSlj70lcJ8jGV6H
Content-Type: multipart/mixed; boundary="SKwLMqjOX9G76OD9nLsdRdJVBsBVkq7xN"
From: Stuart Longland <stuartl@longlandclan.id.au>
To: "Maciej W. Rozycki" <macro@imgtec.com>
Cc: linux-mips@linux-mips.org
Message-ID: <81bca3a5-88dc-d6af-9c6a-3e17d9a8bda5@longlandclan.id.au>
Subject: Re: QEMU Malta emulation using I6400: runaway loop modprobe
 binfmt-464c
References: <996c275d-d969-508e-6b4e-bef22d8e7385@longlandclan.id.au>
 <alpine.DEB.2.00.1706031310470.2590@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.00.1706031310470.2590@tp.orcam.me.uk>

--SKwLMqjOX9G76OD9nLsdRdJVBsBVkq7xN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

On 03/06/17 22:43, Maciej W. Rozycki wrote:
> On Sat, 3 Jun 2017, Stuart Longland wrote:
>> Now, on a single-processor MIPS64r2 VM, this same root filesystem work=
s.
>>  It won't work though for a 8-core I6400 system.  If I try to run a SM=
P
>> MIPS64r2 VM, I get "unable to proceed without a CM", so clearly there =
is
>> a feature in the I6400 that doesn't exist in the MIPS64r2.
>=20
>  Your userland likely requires the legacy NaN encoding (as specified by=
=20
> the IEEE 754-1985 floating point standard) whereas I6400 hardware only =

> supports the 2008 NaN encoding (as specified by the IEEE 754-2008 float=
ing=20
> point standard), as per the R6 architecture requirement.  These encodin=
gs=20
> are incompatible with each other and all binaries are annotated in thei=
r=20
> ELF header as to which is required; use `readelf -h' and check `Flags:'=
=20
> for the presence of `nan2008' among the features reported.

Ahh, quite possible.  I just compiled for MIPS III, not sure if that
supports this alternate NaN encoding.  The ultimate target for this is
Loongson 2F which probably uses the old encoding.

>  There are a couple of ways to move forward.
>=20
>  First is rebuilding your userland for the 2008 NaN encoding.  I'm sure=
=20
> someone already did it, but I don't have a pointer at hand.  This might=
 be=20
> the best option however.

This will be a lengthy process, is there a particular compiler flag I
should be using for that?  `man gcc` seems to mention the following:

>        -mabs=3D2008
>        -mabs=3Dlegacy
>            These options control the treatment of the special not-a-num=
ber (NaN) IEEE 754 floating-point data with the "abs.fmt" and "neg.fmt"
>            machine instructions.
>=20
>            By default or when -mabs=3Dlegacy is used the legacy treatme=
nt is selected.  In this case these instructions are considered arithmeti=
c and
>            avoided where correct operation is required and the input op=
erand might be a NaN.  A longer sequence of instructions that manipulate =
the
>            sign bit of floating-point datum manually is used instead un=
less the -ffinite-math-only option has also been specified.
>=20
>            The -mabs=3D2008 option selects the IEEE 754-2008 treatment.=
  In this case these instructions are considered non-arithmetic and there=
fore
>            operating correctly in all cases, including in particular wh=
ere the input operand is a NaN.  These instructions are therefore always =
used
>            for the respective operations.
>=20
>        -mnan=3D2008
>        -mnan=3Dlegacy
>            These options control the encoding of the special not-a-numb=
er (NaN) IEEE 754 floating-point data.
>=20
>            The -mnan=3Dlegacy option selects the legacy encoding.  In t=
his case quiet NaNs (qNaNs) are denoted by the first bit of their trailin=
g
>            significand field being 0, whereas signalling NaNs (sNaNs) a=
re denoted by the first bit of their trailing significand field being 1.
>=20
>            The -mnan=3D2008 option selects the IEEE 754-2008 encoding. =
 In this case qNaNs are denoted by the first bit of their trailing signif=
icand
>            field being 1, whereas sNaNs are denoted by the first bit of=
 their trailing significand field being 0.
>=20
>            The default is -mnan=3Dlegacy unless GCC has been configured=
 with --with-nan=3D2008.

If I understand correctly, the right thing to do would be to use
-mnan=3D2008 then?  What's the effect on pre-2008 CPUs?

>  Second, since you're running on a simulator anyway, disabling the use =
of=20
> FPU hardware and using the Linux kernel FPU emulator should have little=
=20
> performance impact, although there surely be some for the Coprocessor=20
> Unusable exception handling overhead.  The Linux kernel FPU emulator=20
> supports both NaN encodings at once, so any userland will work=20
> irrespectively of which NaN encoding it requires and produce correct=20
> results.  Use the "nofpu" kernel parameter to activate this option.
>=20
>  Finally, you might also ask the kernel to ignore the binary=20
> incompatibility and let binaries requiring the wrong NaN encoding run=20
> anyway.  This will make IEEE 754 floating point produce incorrect resul=
ts=20
> in the uncommon case of software relying on NaN arithmetic; it may cras=
h=20
> for example.  The vast majority of software does not rely on NaN=20
> arithmetic though.  Use the "ieee754=3Drelaxed" kernel parameter to act=
ivate=20
> this option.

These might be options too=E2=80=A6 I'm basically just compiling software=
, so
not an activity that is likely to produce NaNs or floating-point
operations.  The biggest bug bear right now is compiling `gcc` which is
by far one of the biggest packages and seems to take days to compile.
(gcc-5.4.0 takes at least 2 days=E2=80=A6 6.3 takes even longer then fail=
s to
bootstrap).

>  You can have a look at Documentation/admin-guide/kernel-parameters.txt=
 in=20
> the kernel sources for some further discussion about these kernel=20
> parameters.  These will have to be added to the QEMU's `-append' comman=
d=20
> line option.

Will do, many thanks. :-)
Regards,
--=20
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.


--SKwLMqjOX9G76OD9nLsdRdJVBsBVkq7xN--

--eKDPapevvvD93eDgPBNSlj70lcJ8jGV6H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZMzd4AAoJEPlUu7t5SNVGkDgP/3I+cKyO/6oMr2RocEVDPrV5
Xiu6WawnZT92+bCjyjPsgNl0AscyFIHe5CdoyaVW5V0jL5bt/PylwpoIlp37OA59
VOixLsfq8L8KPbMysffsjkqFFbCepsh1H22Zdou3IBO704ChKbFu5uIndcOPdxBp
xrEWVI5PRMIjOaNMVimQPZNReOXbrJI/NHtbp9muBuYQmEbGIt7e3YyDgbqaMW+l
Rd3RaU2R9rWJPPf2rW6fZJX5QKx3Fzbd3pCRsxCbXKA/MTv+84i2EE48eBeiQKVa
a4qCqiKd1Ex7aPwsb8NCtBbV5IIihwrSZXs7wUSy59qYrDMzHHtS0ELhtZ3WgWa2
u5V6ru+jEEMuVqJprSe3naj3PKoVkQuDjrL3ZJYKa+Cog0pi/K7PiSIC0WoRUU1M
K7vUsAiDwpgB7kTJndyymzMU4xPol6H2C17wo7Kxo9jnCjYR8Ms2vZjV0/OTStp1
ssyZcFqFY3gcEvvnbGkieRHdji7sd+qojqPrjgacw8mckOQrXF7gEUeJ6OBvcnzs
g0DwtIe+3yz0++ERSWVNeqGYPG99WZbzzlOFVacrF0LpJ2zziNVawaiLUUc64zdD
UeoQ6KdXqsAIZL9i6pzZhhRj9ZYpw367DZ+Ich+Imc0YN79eWk+VVu8E+Xpgmt4T
kHbzbvWZt+N/JAeQg9HK
=XF4d
-----END PGP SIGNATURE-----

--eKDPapevvvD93eDgPBNSlj70lcJ8jGV6H--
