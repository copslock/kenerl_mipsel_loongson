Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2009 11:19:30 +0100 (BST)
Received: from sitar.i-cable.com ([203.83.115.100]:51323 "HELO
	sitar.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S20024086AbZEHKTZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2009 11:19:25 +0100
Received: (qmail 19935 invoked by uid 508); 8 May 2009 10:19:17 -0000
Received: from 203.83.114.121 by sitar (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/8786.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.087373 secs); 08 May 2009 10:19:17 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 8 May 2009 10:19:17 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n48AJGLA022996;
	Fri, 8 May 2009 18:19:16 +0800 (HKT)
Date:	Fri, 8 May 2009 18:18:48 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	yanh <yanh@lemote.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] MIPS: handle write_combine in pci_mmap_page_range
Message-ID: <20090508101848.GD7434@adriano.hkcable.com.hk>
Mail-Followup-To: yanh <yanh@lemote.com>, linux-mips@linux-mips.org
References: <cover.1241764064.git.r0bertz@gentoo.org> <a1356a5b181a188435ff569b4f7abe57cf8fd7eb.1241764065.git.r0bertz@gentoo.org> <fb705e2eb405eea04853ae53639457a295a7dd90.1241764065.git.r0bertz@gentoo.org> <a892c7470d85f9563cc74c766fb4dd7f2fa0b801.1241764065.git.r0bertz@gentoo.org> <1241772887.9177.139.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline
In-Reply-To: <1241772887.9177.139.camel@localhost.localdomain>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16:54 Fri 08 May     , yanh wrote:
>=20
> =E5=9C=A8 2009-05-08=E4=BA=94=E7=9A=84 14:30 +0800=EF=BC=8CZhang Le=E5=86=
=99=E9=81=93=EF=BC=9A
> > Signed-off-by: Zhang Le <r0bertz@gentoo.org>
> > ---
> >  arch/mips/pci/pci.c |    8 ++++++--
> >  1 files changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> > index b0eb9e7..4ca53ef 100644
> > --- a/arch/mips/pci/pci.c
> > +++ b/arch/mips/pci/pci.c
> > @@ -346,10 +346,14 @@ int pci_mmap_page_range(struct pci_dev *dev, stru=
ct vm_area_struct *vma,
> >  		return -EINVAL;
> > =20
> >  	/*
> > -	 * Ignore write-combine; for now only return uncached mappings.
> > +	 * For write-combine, return uncached accelerated mappings if CPU
> > +	 * supports; otherwise, return uncached mappings.
> >  	 */
> >  	prot =3D pgprot_val(vma->vm_page_prot);
> > -	prot =3D (prot & ~_CACHE_MASK) | _CACHE_UNCACHED;
> > +	if (write_combine && cpu_has_uncached_accelerated)
> > +		prot =3D (prot & ~_CACHE_MASK) | _CACHE_UNCACHED_ACCELERATED;
> > +	else
> > +		prot =3D (prot & ~_CACHE_MASK) | _CACHE_UNCACHED;
> >  	vma->vm_page_prot =3D __pgprot(prot);
> This should be definietely wrong for MMIOs.
> uncache accelleration should only be enabled for addresses which have no
> side effect when doing write combine such as video memory.

Actually, currently write_combine is true only for prefetchable pci memory:
http://lxr.linux.no/linux+v2.6.29/drivers/pci/pci-sysfs.c#L711

And currently on fuloong 2f box, there is only one prefetchable pci memory
region, which just belongs to video card:

zhangle@2f /sys/devices/pci0000:00 (n32) $ find -name "*wc" -exec ls -l {} =
\;
-rw------- 1 root root 256M 2009-05-08 03:25 ./0000:00:08.0/resource0_wc

So, are we talking about the same thing?=20

Also, I have observed that this region is larger than the actual video ram =
size
32M. However, libpciaccess only mapped 32M into X's address space:

zhangle@2f ~ (n32) $ sudo cat /proc/$(pidof X)/maps | grep wc$
2b354000-2d354000 rw-s 50000000 00:00 1882 /sys/devices/pci0000:00/0000:00:=
08.0/resource0_wc

So, I guess this should be just ok, right?

Any other risks?

> > =20
> >  	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
>=20

--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkoEBwgACgkQvFHICB5OKXMkNgCffaddidHjvGGbTrggHCUKnxNv
w9IAmQH0FCt3DOK8iN5sKttL+D9bhEio
=U+rx
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
