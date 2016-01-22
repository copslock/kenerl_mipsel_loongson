Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 16:02:50 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41851 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014867AbcAVPCsTtCVd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 16:02:48 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id ECA7241F8DEE;
        Fri, 22 Jan 2016 15:02:42 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 22 Jan 2016 15:02:42 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 22 Jan 2016 15:02:42 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 92F1C21766BD5;
        Fri, 22 Jan 2016 15:02:40 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Fri, 22 Jan 2016 15:02:42 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 Jan
 2016 15:02:41 +0000
Date:   Fri, 22 Jan 2016 15:02:41 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: c-r4k: Sync icache when it fills from dcache
Message-ID: <20160122150241.GS24198@jhogan-linux.le.imgtec.org>
References: <1453460306-8505-1-git-send-email-james.hogan@imgtec.com>
 <1453460306-8505-2-git-send-email-james.hogan@imgtec.com>
 <CAOLZvyGeAgMt1KbmQR7c96WWXNJLr89b8hNSi9SePtjUK5K5fg@mail.gmail.com>
 <20160122121908.GG31243@jhogan-linux.le.imgtec.org>
 <CAOLZvyFi41ijxX7CrtiqqB7GcSUGLD0a5ZW3mmXzNQzcG0rN2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/KohU7xR/z4Rz7fl"
Content-Disposition: inline
In-Reply-To: <CAOLZvyFi41ijxX7CrtiqqB7GcSUGLD0a5ZW3mmXzNQzcG0rN2A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 30575414
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51310
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

--/KohU7xR/z4Rz7fl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22, 2016 at 03:30:06PM +0100, Manuel Lauss wrote:
> On Fri, Jan 22, 2016 at 1:19 PM, James Hogan <james.hogan@imgtec.com> wro=
te:
> > On Fri, Jan 22, 2016 at 01:06:14PM +0100, Manuel Lauss wrote:
> >> Hi James,
> >>
> >> On Fri, Jan 22, 2016 at 11:58 AM, James Hogan <james.hogan@imgtec.com>=
 wrote:
> >> > It is still necessary to handle icache coherency in flush_cache_rang=
e()
> >> > and copy_to_user_page() when the icache fills from the dcache, even
> >> > though the dcache does not need to be written back. However when this
> >> > handling was added in commit 2eaa7ec286db ("[MIPS] Handle I-cache
> >> > coherency in flush_cache_range()"), it did not do any icache flushing
> >> > when it fills from dcache.
> >> >
> >> > Therefore fix r4k_flush_cache_range() to run
> >> > local_r4k_flush_cache_range() without taking into account whether ic=
ache
> >> > fills from dcache, so that the icache coherency gets handled. Checks=
 are
> >> > also added in local_r4k_flush_cache_range() so that the dcache blast
> >> > doesn't take place when icache fills from dcache.
> >> >
> >> > A test to mmap a page PROT_READ|PROT_WRITE, modify code in it, and
> >> > mprotect it to VM_READ|VM_EXEC (similar to case described in above
> >> > commit) can hit this case quite easily to verify the fix.
> >> >
> >> > A similar check was added in commit f8829caee311 ("[MIPS] Fix aliasi=
ng
> >> > bug in copy_to_user_page / copy_from_user_page"), so also fix
> >> > copy_to_user_page() similarly, to call flush_cache_page() without ta=
king
> >> > into account whether icache fills from dcache, since flush_cache_pag=
e()
> >> > already takes that into account to avoid performing a dcache flush.
> >> >
> >> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> >> > Cc: Ralf Baechle <ralf@linux-mips.org>
> >> > Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
> >> > Cc: Manuel Lauss <manuel.lauss@gmail.com>
> >> > Cc: linux-mips@linux-mips.org
> >> > ---
> >> >  arch/mips/mm/c-r4k.c | 11 +++++++++--
> >> >  arch/mips/mm/init.c  |  2 +-
> >> >  2 files changed, 10 insertions(+), 3 deletions(-)
> >>
> >>
> >> I did some light testing on Alchemy and see no problems so far.
> >> If it matters:  Tested-by: Manuel Lauss <manuel.lauss@gmail.com>
> >
> > Thanks Manuel.
> >
> > FWIW, attached is the test program I mentioned, which hits the first
> > part of this patch (flush_cache_range) via mprotect(2) and checks if
> > icache seems to have been flushed (tested on mips64r6, but should be
> > portable).
>=20
> With the patch it takes almost 3 times as long to finish the test, but

Interesting... I suppose at least it brings alchemy in line with
behaviour on other cores.

> it does fix
> occasional (5 out of 20 runs) failures.

How big is your icache?

With 64KB icache it fails fairly consistently for me, but wouldn't
surprise me if smaller caches would make it much harder to hit,
especially as it only tests the first cache line in the page.

> The --loop3 test always fails, with or
> without the patch:
>=20
> db1300 ~ # ./mprotect-test --loop2
> Initial mprotect SUCCESS
> Looped { mprotect RW, modify, mprotect RX, test } SUCCESS
> mprotect.c:214: Looped mprotect(2) PROT_READ|PROT_WRITE|PROT_EXEC
> didn't sync icache, ret=3Dffffffff, expected 0

Yes, thats expected. Generic code detects that flags haven't actually
changed and doesn't do anything, so icache never gets flushed. I
disabled but didn't remove that loop.

Thanks a lot for testing!

Cheers
James

--/KohU7xR/z4Rz7fl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWokSRAAoJEGwLaZPeOHZ6/4MP/R8IhIDqMyFGSmGq1LO1h82j
PiZmSMlasM7I5vROfmuV8T5YWOL0UwP19+NJFEeMlfYnCQLX57drlOPRcF9WwKNV
k9U0ybLxeiOyTH12E8xulw7yHHRnyIQPBz1Zw7viKLELds8quaSX6J8uJNjL7vdb
K7fhOr4zEaA+y+9Hs3fTmXRTYQABol6zIeabKdSmnhImnOjjKh4BHEZKV8RXZCMN
F2IiiCG6VqTd+4nNgM7l3vklP9FC9wDVUOVRN4IVbGT+T3eWOvCf8dZkOjwkGxQx
bdamYasdQGHj1T9znizQa6aCz9C5M6mNQFisutzsuGPNKaL7ptabuXCN6DpilIyd
R/NSHbUIOUVXbRoUGY1L4Xgpv7bHkJYxA9lQHNXl737GKJWGWkFNIHEvLis/g99U
jKMPQwNpzwIv86X4/RQL2IrUUMxMV/ZHti3Hf7l+kbKnl9VEg8rfsk99QUGhDRs/
6RsQWZlTYBYGlsi66Zxrau+mO6KL3hcjnQ/LjjktR3m6jVgsQ05iljDHu3T0Xxmf
KtjTo7kSbMtoA9ue1x6KYykfbWuNk3oFf3iEHuXC9JP9nikCqEcUKFKMw9uNhtIQ
z6TghPPKKY90dXm4noauJKnX4N7ZEQ6pM0I56cBwK/n4i1UGhJS/UJA1PDFW3acm
OakbRU5jCczsVzQ/Q4ja
=PQ8r
-----END PGP SIGNATURE-----

--/KohU7xR/z4Rz7fl--
