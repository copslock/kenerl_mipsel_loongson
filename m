Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2016 21:53:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14352 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993232AbcKAUxvbYgFk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2016 21:53:51 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id AD9B541F8E8D;
        Tue,  1 Nov 2016 20:52:52 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 01 Nov 2016 20:52:52 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 01 Nov 2016 20:52:52 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2A0372801BE65;
        Tue,  1 Nov 2016 20:53:41 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 1 Nov
 2016 20:53:45 +0000
Date:   Tue, 1 Nov 2016 20:53:45 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Fix max_low_pfn with disabled highmem
Message-ID: <20161101205345.GA7370@jhogan-linux.le.imgtec.org>
References: <b7e353db4d5ee94b8e8dfba9f99e5ab9a7b95f65.1478008638.git-series.james.hogan@imgtec.com>
 <24d343a2-2a74-f74d-a32b-68b10ccfe5c6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7fXEoLLey27Fs/d6"
Content-Disposition: inline
In-Reply-To: <24d343a2-2a74-f74d-a32b-68b10ccfe5c6@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55646
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

--7fXEoLLey27Fs/d6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2016 at 12:50:51PM -0700, Florian Fainelli wrote:
> On 11/01/2016 06:59 AM, James Hogan wrote:
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
> > We also clip regions which overlap the highmem boundary when highmem is
> > disabled, so that max_pfn doesn't extend into highmem either.
> >=20
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@imgtec.com>
> > Cc: linux-mips@linux-mips.org
>=20
> Should this also go to -stable, if so, which kernels would be affected?

Well idle page tracking is quite a recent addition, commit 33c3fc71c8cf
("mm: introduce idle page tracking") in v4.3, but there could be other
places where pfns are walked with pfn_valid() where this problem could
break things.

But the actual code setting up max_low_pfn hasn't handled this case
properly since it was added in commit db84dc61552a ("[MIPS] Setup
min_low_pfn/max_low_pfn correctly") in v2.6.21.

At least for Malta where I saw it on QEMU however it doesn't appear
(from brief digging in history) to read ememsize environment except for
EVA kernels, except possibly since v4.4 with the new dtshim or a newish
u-boot capable of passing RAM size via DT.

So since I wasn't sure whether it really affects anybody else, and how
important it is to them, nor how far back it really matters (I was only
playing with idle page tracking since it hits the KVM_CAP_SYNC_MMU
related KVM arch callbacks), I figured I'd play it by ear. Thoughts
welcome.

Reproducing is simply a case of a 32bit kernel with CONFIG_HIGHMEM=3Dn,
CONFIG_IDLE_PAGE_TRACKING=3Dy, a platform that reports high memory regions
but with < 512MB of lowmem, then this to see if you get a kernel splat:

hexdump /sys/kernel/mm/page_idle/bitmap

Cheers
James

--7fXEoLLey27Fs/d6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYGQDSAAoJEGwLaZPeOHZ65koP/2hvvVk416QtlCIMOy8L16hV
6iaOYcewEvblu61420DbR0nPvwT7GZDbQQgPMprYvy9hZIg7Qon4NpwGpxnJmQz3
MSETkNr4H3E7Tt/fqiXVa3xXvp8ZDMXTTMFhn1pGOUY61DJJS59wCyM10WDANGXD
wMaoCaCA/o0+rUSZP8J2T+2YHquAxx877NY00jcXZRzWisvuI0YswX4OvhS7SmHu
spPFw/d7LHTVG6UP2yX+Q5X6uKRDU/fhIi4GimIzYJ8tqPbK/czDJCsS282hoCWh
hHzA+8DCsaEMagrTTYZ1+vY/mFeRWuqgUS28w+vp2eemEF/MghQv0KV0z+jjOwjE
kHVdJqOwK13VrfIO69sE5ZyQHiOhLEHD/WG7S80pGKFwjfefRhn8L24XPvCQqmSf
OCjESpuZlsK5uMrKw+No6bZ9Ixja9sXaa7VkNiiILD/fK8lifhb6uLBaHcScjSbc
G7NP/YopqXWB+bbpQno3V3vhlmw3jN3RljF/9Xy6QcDokd4tq08sQQshlQ0A9szr
flXxbyxbulY/+6nuWh0Zy3Zu/PPeBaj0hXLv9mpylCe2cT+8J8+06s2fm0FyWowW
m6ly27V00nirHDygBDj2VDL2zC6iDVbRi/JJv/oOz6xpVpwfEO6xbxqjp3jyA2Dz
IBSMv25HrnnmUw/+JSLq
=iQKI
-----END PGP SIGNATURE-----

--7fXEoLLey27Fs/d6--
