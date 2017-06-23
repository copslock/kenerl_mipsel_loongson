Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 00:29:25 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:56535 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993869AbdFWW3S5mx04 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jun 2017 00:29:18 +0200
Received: from [IPv6:2003:86:2804:5500:5c4b:6402:6e3d:b83b] (p20030086280455005C4B64026E3DB83B.dip0.t-ipconnect.de [IPv6:2003:86:2804:5500:5c4b:6402:6e3d:b83b])
        by mail.hauke-m.de (Postfix) with ESMTPSA id DDE0F1001DD;
        Sat, 24 Jun 2017 00:29:14 +0200 (CEST)
Subject: Re: clock_gettime() may return timestamps out of order
To:     James Hogan <james.hogan@imgtec.com>
References: <478589358072764BA7A23B82543788A895AD4ECE@avsrvexchmbx1.microsemi.net>
 <1bd4bad1-5574-7b76-0cd7-d0334c08667f@hauke-m.de>
 <20170623213325.GD31455@jhogan-linux.le.imgtec.org>
Cc:     Rene Nielsen <rene.nielsen@microsemi.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <61651815-2650-30f0-8240-7cb1c3d20e23@hauke-m.de>
Date:   Sat, 24 Jun 2017 00:29:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170623213325.GD31455@jhogan-linux.le.imgtec.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="34NP37de5e4uCfkgovQtvowRD08FOI00R"
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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
--34NP37de5e4uCfkgovQtvowRD08FOI00R
Content-Type: multipart/mixed; boundary="WRVeBubGGd1goe5ro7JhNHcA80vqCAEgr";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: James Hogan <james.hogan@imgtec.com>
Cc: Rene Nielsen <rene.nielsen@microsemi.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Message-ID: <61651815-2650-30f0-8240-7cb1c3d20e23@hauke-m.de>
Subject: Re: clock_gettime() may return timestamps out of order
References: <478589358072764BA7A23B82543788A895AD4ECE@avsrvexchmbx1.microsemi.net>
 <1bd4bad1-5574-7b76-0cd7-d0334c08667f@hauke-m.de>
 <20170623213325.GD31455@jhogan-linux.le.imgtec.org>
In-Reply-To: <20170623213325.GD31455@jhogan-linux.le.imgtec.org>

--WRVeBubGGd1goe5ro7JhNHcA80vqCAEgr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/23/2017 11:33 PM, James Hogan wrote:
> On Thu, Jun 22, 2017 at 09:32:33PM +0200, Hauke Mehrtens wrote:
>> On 06/21/2017 10:14 AM, Rene Nielsen wrote:
>>> Hi folks,
>>>
>>> Let me go straight into the problem:
>>> We have a multi-threaded application that runs on a MIPS 24KEc using =
glibc v.
>>> 2.24 under kernel v. 4.9.29 both compiled with gcc v. 6.3.0.
>>> Our 24KEc has a 4-way 32 KBytes dcache (and similar icache), so it's =
prone to cache
>>> aliasing (don't know if this matters...).
>>>
>>> We want to be able to do stack backtraces from a signal handler in ca=
se our
>>> application makes a glibc call that results in an assert(). The stack=

>>> backtracing is made within the signal handler with calls to _Unwind_B=
acktrace().
>>> With the default set of glibc compiler flags, we can't trace through =
signal
>>> handlers. Not so long ago, we used uclibc rather than glibc, and expe=
rienced the
>>> same problem, but we got it to work by enabling the
>>> '-fasynchronous-unwind-tables' gcc flag during compilation of uclibc.=

>>> Using the same flag during compilation of glibc causes unexpected run=
time
>>> problems:
>>>
>>> Many of the threads in our application call clock_gettime(CLOCK_MONOT=
ONIC) many
>>> times per second, so we greatly appreciate the existence and utilizat=
ion of the
>>> VDSO.
>>>
>>> Occassionally, however, clock_gettime(CLOCK_MONOTONIC) returns timest=
amps out of
>>> order on the same thread. It's not that the returned timestamps seem =
wrong (they
>>> are mostly off by some hundred microseconds), but they simply appear =
out of
>>> order.
>>>
>>> Since glibc utilizes VDSO (and uclibc doesn't), my guess is that ther=
e's
>>> something wrong in the interface between the two, but I can't figure =
out what.
>>> Other glibc calls seem OK (I don't know whether there's a problem wit=
h the other
>>> VDSO function, gettimeofday(), though). If not compiled with the infa=
mous flag,
>>> we don't see this problem.
>>>
>>> I have tried with a single-threaded test-app, but haven't been able t=
o
>>> reproduce.
>>>
>>> Any help is highly appreciated. Don't hesitate to asking questions, i=
f needed.
>>>
>>> Thank you very much in advance,
>>> Best regards,
>>> Ren=C3=A9 Nielsen
>>
>>
>> Hi Rene
>>
>> I had a problem with the clock_gettime() call over VDSO on a MIPS BE
>> 34Kc CPU, see this:
>> https://www.linux-mips.org/archives/linux-mips/2016-01/msg00727.html
>> It was sometimes off by 1 second.
>>
>> It is gone in the current version of LEDE (former OpenWrt), but when I=

>> used git bisect to find the place where it was fixed, I found a place
>> which has nothing to do with MIPS internal or libc stuff.
>>
>> Makeing some pages uncached or flushing them help, but caused
>> performance problems, I have never found the root cause of the problem=
=2E
>=20
> Hauke: Did that platform have aliasing dcache too?

Yes my platform has an aliasing 32 KByte, 4-way associative dcache too.

> I notice that the mips_vdso_data is updated by update_vsyscall() via
> kseg0, however userland will be accessing it via the mapping 1 page
> below the VDSO.
>=20
> If the kernel data happened to be placed such that the mips_vdso_data i=
n
> kseg0 and the user mapping had different page colours then you could
> easily hit aliasing issues. A couple of well placed flushes or some mor=
e
> careful placement of the VDSO data might well fix it, as could some
> random patch changing the positioning of the data such that it
> coincidentally lined up on the same colour.
>=20
> Rene: Would you be able to try the following?
> 1) report the values of data_addr and &vdso_data in
> arch_setup_additional_pages() (arch/mips/kernel/vdso.c)
> 2) apply the (completely untested) patch below and see if it helps
> 3) report those two values with the patch applied to check it has worke=
d
> as expected
>=20
> The patch unfortunately hacks arch_get_unmapped_area_common so that it
> does the colour alignment on non-shared anonymous pages, as long as
> non-zero pgoff is provided. Hopefully no userland code would try
> mmap'ing anonymous memory with a file offset, and so it should be
> harmless.
>=20
> It doesn't look like we can just pass MAP_SHARED to avoid the hack as
> then pgoff will get cleared by get_unmapped_area()).
>=20
> Thanks
> James
>=20
> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
> index 093517e85a6c..4840b20a3756 100644
> --- a/arch/mips/kernel/vdso.c
> +++ b/arch/mips/kernel/vdso.c
> @@ -129,7 +129,12 @@ int arch_setup_additional_pages(struct linux_binpr=
m *bprm, int uses_interp)
>  	vvar_size =3D gic_size + PAGE_SIZE;
>  	size =3D vvar_size + image->size;
> =20
> -	base =3D get_unmapped_area(NULL, 0, size, 0, 0);
> +	/*
> +	 * Hack to get the user mapping of the VDSO data page matching the ca=
che
> +	 * colour of its kseg0 address.
> +	 */
> +	base =3D get_unmapped_area(NULL, 0, size,
> +			(virt_to_phys(&vdso_data) - gic_size) >> PAGE_SHIFT, 0);
>  	if (IS_ERR_VALUE(base)) {
>  		ret =3D base;
>  		goto out;
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> index 64dd8bdd92c3..872cf1fd1744 100644
> --- a/arch/mips/mm/mmap.c
> +++ b/arch/mips/mm/mmap.c
> @@ -81,7 +81,7 @@ static unsigned long arch_get_unmapped_area_common(st=
ruct file *filp,
>  	}
> =20
>  	do_color_align =3D 0;
> -	if (filp || (flags & MAP_SHARED))
> +	if (filp || (flags & MAP_SHARED) || pgoff)
>  		do_color_align =3D 1;
> =20
>  	/* requesting a specific address */
>=20



--WRVeBubGGd1goe5ro7JhNHcA80vqCAEgr--

--34NP37de5e4uCfkgovQtvowRD08FOI00R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEEyByTt/kEznHNdZethnSnH1g9EzIFAllNljkRHGhhdWtlQGhh
dWtlLW0uZGUACgkQhnSnH1g9EzI+Bw//b6FCerSsPxiLeIZOScrPjgItvd7/wsZ+
/wI4efeDZnSNUwH3iZXzdwTL9Armo+qrTn2TL0eRcqxGo113u+vu0NVS4Do8ezJh
fOhnX0ZW1wj6n77KEpVk/4VFwNzkD4JvLLqfZ2Nw4LrTMr6aFpWehlwawBx8v37P
zzZCg//T556W27TqTfx3w2LUnSvoZM6g+JUPcqdtijSVviaO2DL9FeSASAFe7WOb
GIEL6QP2m5QAQg8ClaMsNcLi3vSQTXQhoM3Lwes6K6PdF6OF4MFHkUB9GlIAWtQf
cmlZ935D+hmWumw18pCKHHg7O3wZZXClbd3vmCP1VzSnJkCMdBnb8LeKroALwKOB
+zVE4ZpwPHmZ5eEfEtkFDhrbr1lDpqG7nwEiaTDpS3PlNO6yfWfJNEHzu6tgWNXd
Xo/RkITBY88lPIWRPWvvN9jznfMnbl7noQqOZ7f3at4Q1i3HNJrW4h+1fA8IzF0l
AsH1GfZ6kMUb2K4eZoTfAgpGhGKVJzE4arF2GuXIEOHIsgHfMJQXSj2iMkXcm1I3
skvIfuXWPiHcegih/uD/YnkMQcCCLXsUClN3I+P5fNk65PheNVhvPFWCU7Q2ItL5
eez//OsYEpp4y1Xn1cEZRSPqROMSCDcygksNXySHr/Bu1/EhWnEZSs49v+d7f7VO
Pit0Y7PuuSc=
=0rkS
-----END PGP SIGNATURE-----

--34NP37de5e4uCfkgovQtvowRD08FOI00R--
