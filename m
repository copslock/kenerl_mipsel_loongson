Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2015 00:53:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26658 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010827AbbDHWxa3hhWB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2015 00:53:30 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 413A441F8D78;
        Wed,  8 Apr 2015 23:53:26 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 08 Apr 2015 23:53:26 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 08 Apr 2015 23:53:26 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CF0EF3A482265;
        Wed,  8 Apr 2015 23:53:21 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 8 Apr 2015 23:53:25 +0100
Received: from localhost (192.168.159.28) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 8 Apr
 2015 23:53:25 +0100
Date:   Wed, 8 Apr 2015 23:53:24 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Lars Persson <lars.persson@axis.com>, <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Lars Persson <larper@axis.com>
Subject: Re: [PATCH 0/2] New fix for icache coherency race
Message-ID: <20150408225324.GH2896@NP-P-BURTON>
References: <1424956563-29535-1-git-send-email-larper@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <1424956563-29535-1-git-send-email-larper@axis.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.28]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2015 at 02:16:01PM +0100, Lars Persson wrote:
> This patch set proposes an improved fix for the race condition that
> originally was fixed in commit 2a4a8b1e5d9d ("MIPS: Remove race window
> in page fault handling").
>=20
> I have used the flush_icache_page API that is marked as deprecated in
> Documentation/cachetlb.txt. There are strong reasons to keep this API
> because it is not possible to implement an efficient and race-free
> lazy flushing using the other APIs.
>=20
> You can refer to a discussion about the same issue in arch/arm where
> they chose to implement the solution in set_pte_at. In arch/mips we
> could not do this because we lack information about the executability
> of the mapping in set_pte_at() and thus we would have to flush all
> pages to be safe.
>=20
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-November/03091=
5.html
>=20
> Lars Persson (2):
>   Revert "MIPS: Remove race window in page fault handling"
>   MIPS: Fix race condition in lazy cache flushing.

FYI these 2 patches prevent a linux-next based kernel booting on the
Ingenic JZ4780-based CI20 board. I've not yet tried on the in-tree
JZ4740-based qi_lb60 to see whether it's also affected, nor have I yet
figured out what's going wrong. I'll hopefully dig into it tomorrow, but
just a heads up!

The boot failure (using an initramfs, so no DMA or much I/O at all):

    [    4.618013] Freeing unused kernel memory: 5160K (803d6000 - 808e0000)
    [    4.625211] CPU 0 Unable to handle kernel paging request at virtual =
address 00000000, epc =3D=3D 80027924, ra =3D=3D 8001db10
    [    4.635881] Oops[#1]:
    [    4.638149] CPU: 0 PID: 1 Comm: init Not tainted 4.0.0-rc7-next-2015=
0408+ #334
    [    4.645354] task: 8dc39568 ti: 8dc3a000 task.ti: 8dc3a000
    [    4.650736] $ 0   : 00000000 00000001 00000001 00001000
    [    4.655965] $ 4   : 00000000 00000001 808e0000 8df0b610
    [    4.639347] $ 8   : 00000000 8d8f8160 00000000 00000000
    [    4.644575] $12   : 00000000 00000118 00000040 ffff0000
    [    4.649802] $16   : 81c649fc 77984000 00000004 8df013f8
    [    4.655030] $20   : 81c649fc 00000000 00000000 00040000
    [    4.638413] $24   : ff000000 80027920
    [    4.643642] $28   : 8dc3a000 8dc3bd38 ffffffbf 8001db10
    [    4.648871] Hi    : 3036f946
    [    4.651740] Lo    : eeea49fc
    [    4.654620] epc   : 80027924 r4k_blast_dcache_page_dc32+0x4/0x9c
    [    4.638763]     Not tainted
    [    4.641550] ra    : 8001db10 __update_cache+0xa4/0xd0
    [    4.646585] Status: 10000403 KERNEL EXL IE
    [    4.650767] Cause : 00800008
    [    4.653634] BadVA : 00000000
    [    4.656503] PrId  : 3ee1024f (Ingenic JZRISC)
    [    4.639002] Process init (pid: 1, threadinfo=3D8dc3a000, task=3D8dc3=
9568, tls=3D00000000)
    [    4.646636] Stack : 3f916478 67caba37 58047621 77984000 58047621 779=
84000 8df0b610 800b777c
              00400000 00031ec0 00000001 00400000 8d8f8178 8ddae840 8de8fbd=
c 81c649fc
              8df013f8 8dc3be00 8de8fbe0 8008f7ac 8df09e38 8de9be40 fffffff=
8 8deeb000
              00000000 00000000 00000000 00000040 803b9924 8dcd9000 7798400=
0 800e2200
              803ca320 800e1474 8df013f8 00000610 77984b50 00000000 8df0077=
8 8df0b610
              ...
    [    4.638523] Call Trace:
    [    4.640962] [<80027924>] r4k_blast_dcache_page_dc32+0x4/0x9c
    [    4.646608] [<8001db10>] __update_cache+0xa4/0xd0
    [    4.651305] [<800b777c>] do_set_pte+0x14c/0x174
    [    4.655826] [<8008f7ac>] filemap_map_pages+0x2ac/0x384
    [    4.639107] [<800b7a54>] handle_mm_fault+0x2b0/0x1020
    [    4.644148] [<8001f460>] __do_page_fault+0x160/0x470
    [    4.649102] [<80013e24>] resume_userspace_check+0x0/0x10
    [    4.654395]
    [    4.655876]
    Code: 03e00008  00000000  24831000 <bc950000> bc950020  bc950040  bc950=
060  bc950080  bc9500a0
    [    4.643978] ---[ end trace 672ef517bf5944f0 ]---
    [    4.648581] Fatal exception: panic in 5 seconds

The next-20140408 based CI20 branch (currently including reverts of
these 2 patches) if anyone wants to reproduce:

    https://github.com/paulburton/linux/tree/wip-ci20-v4.1

Thanks,
    Paul

>  arch/mips/include/asm/cacheflush.h |   35 ++++++++++++++++++++----------=
-----
>  arch/mips/include/asm/pgtable.h    |   10 ++++++----
>  arch/mips/mm/cache.c               |   27 ++++++++-------------------
>  3 files changed, 34 insertions(+), 38 deletions(-)
>=20
> --=20
> 1.7.10.4
>=20

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVJbFdAAoJENzvn0paErs5t2oQAMArTEIc4NDqOPAh9leBBV2L
ykBsDeuX/kdC/1W1FYOJl1knYReW84ryvfPwUGrXykvcRXLtC4kROoBqh/iEv6x3
x19rTdFJQTgYbT/aIDNe4S3cYHrbfTA4o8frO8GcEqdo44Ui7aWR1KssNZwqCF46
N9G1WlNjl4EldfIjJE9Y+oT2Ud/14BjE1IGSqTVbtYxrNE4MlLeUtEJ1MtcJXnhl
PfMW2GqGbhp2xeGLurernuaneocReRLPKyIDm2do90Qi9XaecDoZb8Tkza6Ng6X4
YjppHYRLdXADwq1tiaBpazsgNYLRIzR0YF69EAavJk62bEkoznsNzQ9flmoqhc4e
4+xuPgTYD5lQ68pxInz55wzuRUVzrhM+9qwS0hd1ifEQp76G+gB/+WNEtUl7IVLc
duQW+wXyRYz98DKPmamK/eNQ1ZfSIXirEw185Zf6Y8Y8tKelEGX3TJ3Olz+/9+zS
rvBsK7v2/s8jsKpCawMWObutAVB9qjI3e/hGTGKtKx/Dgzu2bcg03Q3lYb7kz49c
zzCpzJ9kyLI/yiuMFt7GJhLVITFuHQlqpWQDH2LB1t/1Km1QV/lcYNaxgGs5TXGH
y+P0bPa46NEhM8J7hgKKy5hk0vg/WvMbMqueYXBD+majOIo/RAa39d1DFKCQP+Q6
6pwEKy8tny4E3X/WMFDI
=yu4f
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
