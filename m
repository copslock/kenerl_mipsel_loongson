Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2016 11:35:02 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10421 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993060AbcKAKey1hePZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2016 11:34:54 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 7C46141F8E8E;
        Tue,  1 Nov 2016 10:33:56 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 01 Nov 2016 10:33:56 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 01 Nov 2016 10:33:56 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B853EA846C2A9;
        Tue,  1 Nov 2016 10:34:45 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 1 Nov
 2016 10:34:48 +0000
Date:   Tue, 1 Nov 2016 10:34:48 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix max_low_pfn with disabled highmem
Message-ID: <20161101103448.GZ7370@jhogan-linux.le.imgtec.org>
References: <2438a2e32ec8b5d9a8ea053ea483534bb63364a4.1477960419.git-series.james.hogan@imgtec.com>
 <3763478.aakXA3hVDP@np-p-burton>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="glDgwcODtpHomn63"
Content-Disposition: inline
In-Reply-To: <3763478.aakXA3hVDP@np-p-burton>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55635
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

--glDgwcODtpHomn63
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2016 at 09:11:43AM +0000, Paul Burton wrote:
> On Tuesday, 1 November 2016 00:40:29 GMT James Hogan wrote:
> > When low memory doesn't reach HIGHMEM_START (e.g. up to 256MB at PA=3D0=
 is
> > common) and highmem is present above HIGHMEM_START (e.g. on Malta the
> > RAM overlayed by the IO region is aliased at PA=3D0x90000000), max_low_=
pfn
> > will be initially calculated very large and then clipped down to
> > HIGHMEM_START.
> >=20
> > This causes crashes when reading /sys/kernel/mm/page_idle/bitmap
> > (i.e. CONFIG_IDLE_PAGE_TRACKING=3Dy) when highmem is disabled. pfn_vali=
d()
> > will compare against max_mapnr which is derived from max_low_pfn when
> > there is no highend_pfn set up, and will return true for PFNs right up
> > to HIGHMEM_START, even though they are beyond the end of low memory and
> > no page structs will actually exist for these PFNs.
> >=20
> > This is fixed by skipping high memory regions when initially calculating
> > max_low_pfn if highmem is disabled, so it doesn't get clipped too high.
> >=20
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > ---
> >  arch/mips/kernel/setup.c |  9 +++++++++
> >  1 file changed, 9 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> > index 0d57909d9026..cb6e5895bb7e 100644
> > --- a/arch/mips/kernel/setup.c
> > +++ b/arch/mips/kernel/setup.c
> > @@ -368,6 +368,15 @@ static void __init bootmem_init(void)
> >  		end =3D PFN_DOWN(boot_mem_map.map[i].addr
> >  				+ boot_mem_map.map[i].size);
> >=20
> > +#ifndef CONFIG_HIGHMEM
> > +		/*
> > +		 * Skip highmem here so we get an accurate max_low_pfn if low
> > +		 * memory stops short of high memory.
> > +		 */
> > +		if (start >=3D PFN_DOWN(HIGHMEM_START))
> > +			continue;
> > +#endif
> > +
> >  		if (end > max_low_pfn)
> >  			max_low_pfn =3D end;
> >  		if (start < min_low_pfn)
>=20
> Hi James,
>=20
> Shouldn't this also clip any region which crosses the boundary from lowme=
m to=20
> highmem? (ie. start < PFN_DOWN(HIGHMEM_START) < end)

I did do this at first, but then I realised it was redundant since
max_low_pfn already gets clipped to PFN_DOWN(HIGHMEM_START) after the
loop, i.e. it already does the right thing in that case since memory
reaches up to HIGHMEM_START.

The only difference would be max_pfn:
1) At the moment max_pfn includes highmem even when highmem is disabled.
2) With this patch max_pfn would only include highmem when highmem is
   disabled if a memory region crosses the highmem boundary.
3) Clipping end to PFN_DOWN(HIGHMEM_START) in the #ifndef above would
   cause max_pfn to exclude highmem when highmem is disabled.=20

Individual pfns are usually checked with pfn_valid() anyway, however (3)
still sounds more correct (and possibly more efficient when pfns are
iterated over). It would also correct the number of pfns that can be
read in /sys/kernel/mm/page_idle/bitmap to exclude highmem when it does
overlap the boundary.

Sound about right? I'll do a v2.

Thanks for reviewing,

Cheers
James

--glDgwcODtpHomn63
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYGG/BAAoJEGwLaZPeOHZ6Y48P/308ZIEQ77mVsQZWB0ghau1K
9CAUwWjEen72f7TzBqk4qqeTmTm17DpBwN6gXQePgeqUEbLmZgJ19qa6l/wX+bxk
ePEE4EaH43idwPrYgNrbo3tl3HzBu9c363aCXAGMCHclZFp288A7/JNhrqGbMt6p
Kjxvp0icZldTCZsShdN5WffmOFBOwTbxOtf2yvH+0cHaJYDM0Ogj/CG9Tqw3h9Ga
4CLpRBWgNSlq2RtHhOIxOcyZVnd0pUz9/yvXuFz1YNinSwqQp3+RPCxMAck2lwnx
O03mcCKVBD3kQRX29GHVqY71cel7rpjsCLsx5l3LcYr9PwCbtaRPYnIG2M8wopSH
5uHwUpj1h/uA91wF+Z1mbNEp10yrXqruG+9Duded+N/XDSBGiaFBDOGIGth/NAw7
vnPFoo3OjrT2jT3drarXLg4UG69LYYXwRp1iMwa5Qq4YRdbTYogpEBwcDDjwldN0
7mt92349Vd10h9rzgiICiwr51GMyPn0BtOqY9OVHhmAIneOWa8LD3Eu+EfUZMFSJ
gLc3giZ21zcA65dbc6GZe8Zv8pFlTHS+FAdmR71FLtvSnKSPD9WvQS1ho0GdN0wb
sMwNqh9LcooRI8XF55Fr25D/KDiQ6IYfbHfcpkhgqZw35VwvwkjOMA9g85/RZb6Y
ZIidwmuFLuUfCAqfhwJw
=zhrB
-----END PGP SIGNATURE-----

--glDgwcODtpHomn63--
