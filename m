Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 13:11:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62483 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23995171AbcGMLLPeXHa3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 13:11:15 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 2C6FC41F8E01;
        Wed, 13 Jul 2016 12:11:10 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 13 Jul 2016 12:11:10 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 13 Jul 2016 12:11:10 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 202E6D901BB67;
        Wed, 13 Jul 2016 12:11:07 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 13 Jul
 2016 12:11:09 +0100
Date:   Wed, 13 Jul 2016 12:11:09 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: SMP regression on MIPS 34Kc (Lantiq VRX220)
Message-ID: <20160713111109.GB29839@jhogan-linux.le.imgtec.org>
References: <7f6f4ddd-5cac-520e-2e14-1fe0d7288e6f@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <7f6f4ddd-5cac-520e-2e14-1fe0d7288e6f@nbd.name>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 5de3adfe
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54308
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

--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Felix,

On Fri, Jun 10, 2016 at 08:54:44PM +0200, Felix Fietkau wrote:
> Hi,
>=20
> commit cccf34e9411c41b0cbfb41980fe55fc8e7c98fd2
> MIPS: c-r4k: Fix cache flushing for MT cores
>=20
> This commit breaks SMP on Lantiq VRX220. When r4k_on_each_cpu is called
> for a cache flush, I get the following oops very early when user space=20
> starts:
>=20
> [    1.689913] CPU 0 Unable to handle kernel paging request at virtual ad=
dress fffd7000, epc =3D=3D 80028fd4, ra =3D=3D 80096240
> [    1.699095] Oops[#1]:
> [    1.701365] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.4.12 #2
> [    1.707280] task: 805278d8 ti: 80518000 task.ti: 80518000
> [    1.712663] $ 0   : 00000000 00000003 80530000 fffd8000
> [    1.717884] $ 4   : fffd7000 00000000 00000001 00000000
> [    1.723105] $ 8   : 1100ff00 1000001f 00000000 00000001
> [    1.728328] $12   : eac0c6e6 00000000 00000000 7748c2b0
> [    1.733551] $16   : 82e6bdb0 00000000 80029a14 fffd7000
> [    1.738773] $20   : 80499e0c 8051a140 80498424 80520000
> [    1.743995] $24   : 00000000 80028fc0                 =20
> [    1.749217] $28   : 80518000 80519d08 80520000 80096240
> [    1.754441] Hi    : 013b114e
> [    1.757316] Lo    : 6eff374b
> [    1.760209] epc   : 80028fd4 r4k_blast_dcache_page_dc32+0x14/0xb8
> [    1.766299] ra    : 80096240 generic_smp_call_function_single_interrup=
t+0x160/0x200
> [    1.773941] Status: 1100fd02 KERNEL EXL=20
> [    1.777858] Cause : 00800008 (ExcCode 02)
> [    1.781862] BadVA : fffd7000
> [    1.784734] PrId  : 00019556 (MIPS 34Kc)
> [    1.788648] Modules linked in:
> [    1.791706] Process swapper/0 (pid: 0, threadinfo=3D80518000, task=3D8=
05278d8, tls=3D00000000)
> [    1.799789] Stack : 00000001 8007d3f4 00000000 80520000 80528cc0 80530=
620 00000000 00000000
>          00000001 8000e4f0 00010000 80a922a4 00000001 80520000 00000001 8=
0071ad4
>          80490000 80071c64 00000024 00000100 8051a040 8051a068 8049844c 8=
0498460
>          8051a140 80530620 8052470c 80a922a4 00000001 80520000 00000001 8=
0520000
>          80490000 80076214 804965b0 fffedc9a 80520000 00200000 00000000 0=
0000001
>          ...
> [    1.835300] Call Trace:
> [    1.837757] [<80028fd4>] r4k_blast_dcache_page_dc32+0x14/0xb8
> [    1.843506] [<80096240>] generic_smp_call_function_single_interrupt+0x=
160/0x200
> [    1.850834] [<8000e4f0>] ipi_call_interrupt+0x10/0x20
> [    1.855874] [<80071ad4>] handle_irq_event_percpu+0x78/0x1b4
> [    1.861445] [<80076214>] handle_percpu_irq+0x88/0xb8
> [    1.866397] [<800711a0>] generic_handle_irq+0x40/0x58
> [    1.871445] [<80015528>] do_IRQ+0x1c/0x2c
> [    1.875447] [<80002430>] ret_from_irq+0x0/0x4
> [    1.879796] [<80015494>] r4k_wait_irqoff+0x18/0x20
> [    1.884606] [<80069464>] cpu_startup_entry+0x164/0x1c4
> [    1.889740] [<80542c28>] start_kernel+0x4a4/0x4c4
> [    1.894416]=20
> [    1.895878]=20
> Code: 00002821  10000026  8c46ab2c <bc950000> bc950020  bc950040  bc95006=
0  bc950080  bc9500a0=20
> [    1.905894] ---[ end trace e17f61a2b2391e19 ]---
>=20
> If I add a #ifndef CONFIG_MIPS_MT_SMP around the smp_call_function_many c=
all,
> everything works fine again. From what I can tell, we should not do any I=
PIs
> for cache flushing on that device, since there are only two threads on the
> same core.

While it seems clear (and correct) that fixing cpu_foreign_map to
exclude sibling CPUs would resolve this issue (I have a patch for that),
that still doesn't explain why the IPI call would be problematic in the
first place.

This is probably getting called via r4k_flush_data_cache_page() on the
other thread.

The virtual address is a fixmap address, and it would appear to be
fixmap index 0x9, which appears to be mapped by __kmap_pgprot() based on
a page colour of 0x7.

The case that fits that pattern is the cache alias handling in
__flush_anon_page(), which does kmap_coherent() and
flush_data_cache_page() on the resulting address. kmap_coherent disables
preemption, and directly injects a wired entry into the TLB. An IPI call
on that address is clearly unsafe as it doesn't inject an entry into the
page tables so other CPUs wouldn't pick it up.

So my prediction is that you have PREEMPT_COUNT=3Dn in your kernel config,
which is causing in_atomic() in r4k_flush_data_cache_page() to always
return false. This in_atomic() has been on my radar for a few weeks now,
but I hadn't figured out what it was meant to solve. Given that
preemption being disabled isn't technically a problem when doing the IPI
calls (we disable preemption around it anyway, it doesn't sleep), I'm
wondering if this is the case the in_atomic() is meant for.

So, should the flush_anon_page() be flushing other CPU's caches too? I
suspect it should for systems where address based cache ops aren't
globalized by hardware. MIPS/ImgTec CM based SMP systems *do* globalize
hit based cache ops in hardware, so they don't need an IPI call (I have
a patch for that too).

Does other MIPS (non MIPS Technologies / ImgTec) multi-core SMP hardware
exist which uses c-r4k.c, doesn't globalize hit cache ops in hardware,
is also vulnerable to cache aliasing, and which people care about
running with software cache alias handling?

If so, it should probably be fixed to work with IPI calls (inject into
page tables temporarily or do the kmap_coherent on each CPU).

If not, the in_atomic() should be fixed to detect this case when
PREEMPT_COUNT=3Dn, or rather the caller should call the local version
somehow to make its intentions clear.

Thanks
James

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXhiHNAAoJEGwLaZPeOHZ6fJAQAK7/ey8P0KNW2dgaxlTlOuS7
ODo/r+4cZD35DKjknSMGOHoW4HnXA/dWwmQN9fpl6gDAvJQIf74Uf2ClrNiOrkES
U9kQcpr97ESvwLKRHRU7IxL80UgN9h4HhdhNNvA4Q/eKBBO92SRJH+IJskkrkfSl
ywwnLng22OkrolcCSIgiWcq4MYavQoRDAP5Ssvj5TMDUUzS63pp/GHCvhnZ7tx6/
fgViAfXomzFos9w9mT8hjWkFljPkII3Eca+5g4ObhTQLjmIL+nAjcdSq0Xx5J3AF
ykx5+2MShfdnY4A0ltWV1bmSRIE4QqFq4UVGr6uaU/zr6+u8no4DL134yGGQlGEQ
d4/2xKVK0gMk0dv9iWIeLZh0c/U8E7AXLX55Qb+3ilh627LS9MUYmQbPKArueAtD
C5SEaHmNURNLVpe2r7tT3XkOFLYFE58yUdk9sh83Q2M3+yQhrDacclpNDtV1mJ+u
e+krCZF5ll1+R5IvT0d2ExFE0lZLC/rfWpNEdCLOqF1nNemUudxpBbmb6VTRG6H1
4ndVbUzUeIBTRpP/krjyfUDpHO89R0QKawFenWEN31k9p0dsNr//oZ7vZzNRNXby
p4RtVQB5JdYCsuTCPhbBzbA49O8hJk6P+Z09niAGbeB9nEb3I5jTH3Lb9OskigNU
O4+xZ/PZduL6DWsq/MAg
=RfdQ
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
