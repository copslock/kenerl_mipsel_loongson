Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Sep 2016 16:51:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50380 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992990AbcIIOvFhzzAs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Sep 2016 16:51:05 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 44A6D41F8E3C;
        Fri,  9 Sep 2016 15:50:59 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 09 Sep 2016 15:50:59 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 09 Sep 2016 15:50:59 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 79EAC8ABE2B40;
        Fri,  9 Sep 2016 15:50:55 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 9 Sep
 2016 15:50:58 +0100
Date:   Fri, 9 Sep 2016 15:50:58 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Sagar Borikar <sagar.borikar@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: highmem issues with 3.14.10 (LST)
Message-ID: <20160909145058.GD26885@jhogan-linux.le.imgtec.org>
References: <CAFwMWxtUHa_Av34RrzFp3Dar0y-ghQRJNeXeUqYeUo3149zOsw@mail.gmail.com>
 <20160909123652.GA1846@jhogan-linux.le.imgtec.org>
 <CAFwMWxsQ6tpj7D1NnatEeVis32pRwKRsKkPXFgGrkvyCES0yHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <CAFwMWxsQ6tpj7D1NnatEeVis32pRwKRsKkPXFgGrkvyCES0yHA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 5de3adfe
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55082
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

--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 09, 2016 at 06:17:13AM -0700, Sagar Borikar wrote:
> Thanks James.
>=20
> On Fri, Sep 9, 2016 at 5:36 AM, James Hogan <james.hogan@imgtec.com> wrot=
e:
> > Hi Sagar,
> >
> > On Thu, Sep 08, 2016 at 08:33:57PM -0700, Sagar Borikar wrote:
> >> Hello,
> >>
> >> I am upgrading kernel for a MIPS Interaptive CPU from 3.10.60 to
> >> 3.14.10 (stable) from:
> >> https://www.linux-mips.org/wiki/Malta_Linux_Repository
> >
> > Unfortunately that wiki page needs updating.
> >
> > If you're upgrading anyway, I think we'd recommend switching all the way
> > to a recent mainline kernel release / stable branch, e.g. 4.4 (LTS) or
> > 4.7 (and maybe update to 4.9 (LTS) when it is released or when 4.7 goes
> > EOL). I think all the stuff you'll need for interAptiv should be in
> > mainline now anyway.
>=20
> I see. We generally upgrade to malta repo as its maintained by mips
> (imgtec). I presume you are referring to kernel.org. I think linux-mti
> is having  4.1.7 as stable, right?

Yeh I was referring to kernel.org. 3.14 was the last linux-mti branch.
A lot of stuff in mti-3.10 got upstreamed (with a lot of changes and
clean ups made along the way), and I think as a result mti-3.14 was
mostly backported patches from mainline. That may explain this
regression.

We're now trying to focus a lot more on mainline (although we have
engineering branches in that same linux-mti repository, which are more
for supporting new architecture features & new cores before they've
found their way into mainline).

> >>  The platform has non-contiguous low memory and high memory. After the
> >> upgrade, highmem is not getting enabled due to max_low_pfn and
> >> highend_pfn not being the same.
> >>
> >> The commit cce335ae47e231398269fb05fa48e0e9cbf289e0 introduced the
> >> change apparently for sibyte platform. That change doesn't hold good
> >> for all platforms where the high memory and low memory is sparsed.
> >>
> >> If I comment out only following change in arch/mips/mm/init.c, highmem
> >> gets initialized properly.
> >>
> >> 296     if (cpu_has_dc_aliases && max_low_pfn !=3D highend_pfn) {
> >> 297         printk(KERN_WARNING "This processor doesn't support highme=
m."
> >> 298                " %ldk highmem ignored\n",
> >> 299                (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
> >> 300         max_zone_pfns[ZONE_HIGHMEM] =3D max_low_pfn;
> >> 301         lastpfn =3D max_low_pfn;
> >> 302     }
> >
> > I don't think we ever supported DCache aliasing + highmem in
> > combination.
>=20
> Interesting. We are currently running 3.10.60 and apparently it seems
> to work. Are you saying it may cause any issues? So far we haven't
> seen any problems. What kind of issues it might end up into?

Sorry, I was thinking of mainline.

Mti-3.10 seems to have had changes which didn't make it upstream which
would have made this possible, from which commit 15de36a4c3cf
("mm/highmem: make kmap cache coloring aware") was derived (which was
merged for v3.17, in August 2014). There were attempts to add the MIPS
support after this, but none of them made it upstream:

https://patchwork.linux-mips.org/project/linux-mips/list/?state=3D*&q=3Dfix=
es+for+cache+aliasing

>=20
> >
> > If you want to use that memory your options are probably:
> > - increase the page size to avoid dcache aliasing.
>=20
> Ok thanks. I would need to experiment with this but I am bit baffled
> how its working in 3.10.60.
> Generally, is there any reference platforms based on interaptiv which
> uses highmem and dcache aliasing? I might have missed but couldn't
> find any platform which comes close in both trees.

Its probably possible to configure malta in such a way (4k pages, big
cache, alias removal disabled in hardware, highmem).

>=20
> > - OR use EVA to increase the size of lowmem, which at the moment is a
> >   bit more involved. How much RAM do you have, and what does your
> >   physical memory map look like?
>=20
> Total memory is 2GB. memory map looks like this:
>=20
> low mem(~66MB) :
>=20
>  * 0x04300000 +-----------------+
>  *                    |     Linux       |
>  * 0x00043000 +-----------------+
>=20
> high mem (128MB):
>=20
>  * 0x28000000 +-----------------+
>  *                   |     linuxhi     |
>  * 0x20000000 +-----------------+
>=20
> Rest of the blocks are reserved.

It should be possible to use EVA to expand lowmem to cover these two
regions. Fitting in the whole 2GB would probably be a little trickier
depending on other stuff (how much IO memory is needed, IOCU in use,
etc).

Cheers
James

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX0sxSAAoJEGwLaZPeOHZ6Y2kQAI9tQwwfNVPaa2OFtOaNxxgt
jizUfV72FnkDcFifQWDlUqoptJdRyyxtuinYOx1JoYVZ7Lkbbym/8umAQRi7NOkk
XPXgAroI/MeKaNW08TG3DJpyrRaLsyWr2a+ISzOHtcKxzEmOuFIC+05H24jsWN3T
41ctCm2zlSCFeXyGhqLJDjPv1dd5zrur44CccIHQdaKqTUGJew/YSqOnF+xFJ2sj
H81gdJviserGUk13yAkq3Q+NzA3FxDoHiTb39n91JQEkrhjKjNvgZjsKWHbEvIDV
vR67Lkz8RI8Mdm+OSMGkgbVP4Z4AYnX3X1bZyhSS/NtDJkBW2OPsdvXB2jBOujqF
22o8H7IqRy/77lDbKtZaZRjAWLvqz0tV1TPe5z1fGS0yvkKnjYQYJBO4puP7JN/o
LzaAQlERhMCTBDBC0+VSlZQe+UjeHt0G1e1wsUjxoqGUgmbMD94kz5ECXa+yPhGZ
GjUXMiWBX0YulFqA+3ObTLTQUUWDgRgmgm07DXHG464Hz1Twl2bvppiwsXCmXAmB
XTH0RlI81ntyvn2cQiP206vNEeYsJkwcVyvPJUjqjPS7xUTnMjFth6yD929MXvS/
taGaz0zxjmPUmXlYEB+T0aBEPOPPhNkYgrTsEPiEziucGjbWG68JXt/LIdBeM9S7
hln2L3w0KP8CdgXsc+f8
=yelh
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
