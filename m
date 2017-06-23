Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2017 23:33:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47176 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993853AbdFWVdcZDv0- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2017 23:33:32 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 1DB3E41F8EC3;
        Fri, 23 Jun 2017 23:43:17 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 23 Jun 2017 23:43:17 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 23 Jun 2017 23:43:17 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 794CCE84469E0;
        Fri, 23 Jun 2017 22:33:21 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 23 Jun
 2017 22:33:26 +0100
Date:   Fri, 23 Jun 2017 22:33:26 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     Rene Nielsen <rene.nielsen@microsemi.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: clock_gettime() may return timestamps out of order
Message-ID: <20170623213325.GD31455@jhogan-linux.le.imgtec.org>
References: <478589358072764BA7A23B82543788A895AD4ECE@avsrvexchmbx1.microsemi.net>
 <1bd4bad1-5574-7b76-0cd7-d0334c08667f@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <1bd4bad1-5574-7b76-0cd7-d0334c08667f@hauke-m.de>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58770
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

--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 09:32:33PM +0200, Hauke Mehrtens wrote:
> On 06/21/2017 10:14 AM, Rene Nielsen wrote:
> > Hi folks,
> >=20
> > Let me go straight into the problem:
> > We have a multi-threaded application that runs on a MIPS 24KEc using gl=
ibc v.
> > 2.24 under kernel v. 4.9.29 both compiled with gcc v. 6.3.0.
> > Our 24KEc has a 4-way 32 KBytes dcache (and similar icache), so it's pr=
one to cache
> > aliasing (don't know if this matters...).
> >=20
> > We want to be able to do stack backtraces from a signal handler in case=
 our
> > application makes a glibc call that results in an assert(). The stack
> > backtracing is made within the signal handler with calls to _Unwind_Bac=
ktrace().
> > With the default set of glibc compiler flags, we can't trace through si=
gnal
> > handlers. Not so long ago, we used uclibc rather than glibc, and experi=
enced the
> > same problem, but we got it to work by enabling the
> > '-fasynchronous-unwind-tables' gcc flag during compilation of uclibc.
> > Using the same flag during compilation of glibc causes unexpected runti=
me
> > problems:
> >=20
> > Many of the threads in our application call clock_gettime(CLOCK_MONOTON=
IC) many
> > times per second, so we greatly appreciate the existence and utilizatio=
n of the
> > VDSO.
> >=20
> > Occassionally, however, clock_gettime(CLOCK_MONOTONIC) returns timestam=
ps out of
> > order on the same thread. It's not that the returned timestamps seem wr=
ong (they
> > are mostly off by some hundred microseconds), but they simply appear ou=
t of
> > order.
> >=20
> > Since glibc utilizes VDSO (and uclibc doesn't), my guess is that there's
> > something wrong in the interface between the two, but I can't figure ou=
t what.
> > Other glibc calls seem OK (I don't know whether there's a problem with =
the other
> > VDSO function, gettimeofday(), though). If not compiled with the infamo=
us flag,
> > we don't see this problem.
> >=20
> > I have tried with a single-threaded test-app, but haven't been able to
> > reproduce.
> >=20
> > Any help is highly appreciated. Don't hesitate to asking questions, if =
needed.
> >=20
> > Thank you very much in advance,
> > Best regards,
> > Ren=C3=A9 Nielsen
>=20
>=20
> Hi Rene
>=20
> I had a problem with the clock_gettime() call over VDSO on a MIPS BE
> 34Kc CPU, see this:
> https://www.linux-mips.org/archives/linux-mips/2016-01/msg00727.html
> It was sometimes off by 1 second.
>=20
> It is gone in the current version of LEDE (former OpenWrt), but when I
> used git bisect to find the place where it was fixed, I found a place
> which has nothing to do with MIPS internal or libc stuff.
>=20
> Makeing some pages uncached or flushing them help, but caused
> performance problems, I have never found the root cause of the problem.

Hauke: Did that platform have aliasing dcache too?

I notice that the mips_vdso_data is updated by update_vsyscall() via
kseg0, however userland will be accessing it via the mapping 1 page
below the VDSO.

If the kernel data happened to be placed such that the mips_vdso_data in
kseg0 and the user mapping had different page colours then you could
easily hit aliasing issues. A couple of well placed flushes or some more
careful placement of the VDSO data might well fix it, as could some
random patch changing the positioning of the data such that it
coincidentally lined up on the same colour.

Rene: Would you be able to try the following?
1) report the values of data_addr and &vdso_data in
arch_setup_additional_pages() (arch/mips/kernel/vdso.c)
2) apply the (completely untested) patch below and see if it helps
3) report those two values with the patch applied to check it has worked
as expected

The patch unfortunately hacks arch_get_unmapped_area_common so that it
does the colour alignment on non-shared anonymous pages, as long as
non-zero pgoff is provided. Hopefully no userland code would try
mmap'ing anonymous memory with a file offset, and so it should be
harmless.

It doesn't look like we can just pass MAP_SHARED to avoid the hack as
then pgoff will get cleared by get_unmapped_area()).

Thanks
James

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 093517e85a6c..4840b20a3756 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -129,7 +129,12 @@ int arch_setup_additional_pages(struct linux_binprm *b=
prm, int uses_interp)
 	vvar_size =3D gic_size + PAGE_SIZE;
 	size =3D vvar_size + image->size;
=20
-	base =3D get_unmapped_area(NULL, 0, size, 0, 0);
+	/*
+	 * Hack to get the user mapping of the VDSO data page matching the cache
+	 * colour of its kseg0 address.
+	 */
+	base =3D get_unmapped_area(NULL, 0, size,
+			(virt_to_phys(&vdso_data) - gic_size) >> PAGE_SHIFT, 0);
 	if (IS_ERR_VALUE(base)) {
 		ret =3D base;
 		goto out;
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index 64dd8bdd92c3..872cf1fd1744 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -81,7 +81,7 @@ static unsigned long arch_get_unmapped_area_common(struct=
 file *filp,
 	}
=20
 	do_color_align =3D 0;
-	if (filp || (flags & MAP_SHARED))
+	if (filp || (flags & MAP_SHARED) || pgoff)
 		do_color_align =3D 1;
=20
 	/* requesting a specific address */

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllNiRkACgkQbAtpk944
dnpifg/9F7xQqSTRjHum/cspA1XN/5mcUz8FJTXH4WLffAxDEgNO+kNHCHbqamle
MuG/tIZGlatGq6rZdlpsOfSfgCqLxv74R3mFgsa8vOUcMFS475DBRBjf2oIGAntg
qxuAFr7xnlW6tLH7rp4oLZ1Tb68TaEIT/z9VuyS3jL/9H+45TKRYf8SmybYMFOa3
4c1VmI7N+CSrmconCct3kGRPsqkCDk1VfHYfREBrottGPZxmp35T1WWfnhoct3Pm
OD42zHjIU92Ym2CczkLOomPNYiLJQqK8fUIGznMz3+PtUgnjWoDbuJjiLb9Ur2Xn
WklvxzeIXa1kHgEkEuAT24B4OrwY1YtWVBfn614fPD5OHzFprCakTdG8B/TTE20N
KrKzlhDuaaSjJ8+KI9a+2EkhR2oRsIFE/yW0EDqi5OaHABWdW0/lId0y7oVIwb3o
YjssfEg1hKJLIcqkW6zm2EF2rjoy/7nNXzZ7wT/iveLhsYF6mAe81VaMW/KMqzRq
AqBfvEiSCa/kPvuyUhW6pQKgM2vdiUQCrT6degSEM+/vhwJS6Ql7n/i+7kZkBbfE
LuuWb3n/I+BItb1PtWvzsStiUWEqFE0llpgL3rVUx8slS2DWy2J/oeZQB+rbRj0U
OoxadSzV8gEXnQ8Ko2wTKLzyMHtry9EIVBOC7pBMkxI1EfIrMjk=
=Eqwc
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
