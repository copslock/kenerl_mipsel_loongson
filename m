Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2017 10:40:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33031 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991957AbdBJJkR5Qc0g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Feb 2017 10:40:17 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 6D38F41F8D87;
        Fri, 10 Feb 2017 10:43:58 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 10 Feb 2017 10:43:58 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 10 Feb 2017 10:43:58 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 90202F6C7296C;
        Fri, 10 Feb 2017 09:40:09 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 10 Feb
 2017 09:40:11 +0000
Date:   Fri, 10 Feb 2017 09:40:11 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Justin Chen <justinpopo6@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>,
        <linux-mips@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Crash in -next due to 'MIPS: Add cacheinfo support'
Message-ID: <20170210094011.GB24226@jhogan-linux.le.imgtec.org>
References: <20170208234523.GA13263@roeck-us.net>
 <CAJx26kWDuH2AbibrOdHi7yh9YG314T7J5Zz7CwgTrZCfwDGuYw@mail.gmail.com>
 <eee97bba-5386-9d78-1c82-9e9753a28920@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <eee97bba-5386-9d78-1c82-9e9753a28920@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56753
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

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Thu, Feb 09, 2017 at 08:50:04PM -0800, Guenter Roeck wrote:
> On 02/09/2017 04:01 PM, Justin Chen wrote:
> > Hello Guenter,
> >
> > I am unable to reproduce the problem. May you give me more details?
> >
> The scripts I am using are available at
>=20
> https://github.com/groeck/linux-build-test/tree/master/rootfs
>=20
> in the mips and mipsel subdirectories (both crash). Individual
> build logs are always available at kerneltests.org/builders,
> in the 'next' column.

Did you find it 100% reproducible? I was trying to reproduce yesterday
evening, and did hit it a few times, but then it stopped happening
before I could try and figure out what was going wrong.

I presume from your run-qemu-mipsel.sh script its a vanilla 2.7
qemu-system-mipsel?

Cheers
James

>=20
> Note: If I build the image with my configuration, and run
> your qemu command, I get a different crash:
>=20
> ...
> ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0x1088 irq 15
> CPU 0 Unable to handle kernel paging request at virtual address fffffffc,=
 epc =3D=3D 80341d68, ra =3D=3D 803eae70
> Oops[#1]:
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.10.0-rc7-next-20170209 #2
> task: 8704b8a0 task.stack: 8704c000
> $ 0   : 00000000 0000006f fffffffc 00000000
> $ 4   : 87044980 8069ee48 8069ee49 00000004
> $ 8   : 00000000 8741c990 00000000 00000040
> $12   : 00000000 00000001 00000000 fffffffe
> $16   : 8070ae14 80742fb8 80738190 00000000
> $20   : 806e0000 8071c2fc 80770000 00000008
> $24   : 00000110 00000000
> $28   : 8704c000 8704fe10 80754728 803eae70
> Hi    : 0000000f
> Lo    : 8f8f8f9f
> epc   : 80341d68 kset_find_obj+0xc/0xa4
> ra    : 803eae70 driver_find+0x1c/0x48
> Status: 1000a403	KERNEL EXL IE
> Cause : 00800008 (ExcCode 02)
> BadVA : fffffffc
> PrId  : 00019300 (MIPS 24Kc)
> Modules linked in:
> Process swapper (pid: 1, threadinfo=3D8704c000, task=3D8704b8a0, tls=3D00=
000000)
> Stack : 80710000 00000000 806e0000 8044ba18 8070ae14 803eaf10 00000000 00=
000000
>          80770000 80742fb8 80770000 80770000 80742fb8 801005dc 8708b900 8=
10017e0
>          8704fe68 806f0000 806ee894 81041c41 80600600 80141fb8 00000000 8=
0740000
>          806e0000 80720000 00000000 00000006 806765e4 00000006 00000017 8=
0670000
>          80676cf0 80680000 80770000 80742fb8 00000006 80742f98 80770000 8=
0742fb8
>          ...
> Call Trace:
> [<80341d68>] kset_find_obj+0xc/0xa4
> [<803eae70>] driver_find+0x1c/0x48
> [<803eaf10>] driver_register+0x74/0x128
> [<801005dc>] do_one_initcall+0x48/0x16c
> [<8071cd18>] kernel_init_freeable+0x170/0x22c
> [<805e1d30>] kernel_init+0x14/0x108
> [<80105e18>] ret_from_kernel_thread+0x14/0x1c
> Code: 8c830000  10830012  2462fffc <8c430000> 1060000c  00a03021  9067000=
0  90c10000  24630001
>=20
> ---[ end trace c22dffa22f0b1376 ]---
> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
>=20
> ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=3D0=
x0000000b
>=20
> Guenter
>=20
> > I rebased my patch onto of 4.10-rc7 and compiled with malta defconfig
> > with disabled SMP. Then booted with qemu. Doesn't seem to have an
> > error with the way I have it set up.
> >
> > I am using the command:
> > qemu-system-mipsel -kernel vmlinux -nographic -smp 0
> >
> > Thanks,
> > Justin
> >
> > On Wed, Feb 8, 2017 at 3:45 PM, Guenter Roeck <linux@roeck-us.net> wrot=
e:
> >> Hi Justin,
> >>
> >> The 32-bit qemu mips runtime tests for -next at kerneltests.org are cr=
ashing
> >> for non-SMP builds as follows.
> >>
> >> cacheinfo: Failed to find cpu0 device node
> >> cacheinfo: Unable to detect cache hierarchy for CPU 0
> >> CPU 0 Unable to handle kernel paging request at virtual address 000000=
04, epc =3D=3D
> >> 8013c6a8, ra =3D=3D 8013cb54
> >> Oops[#1]:
> >> CPU: 0 PID: 5 Comm: kworker/u2:0 Not tainted 4.10.0-rc7-next-20170208 =
#1
> >> Workqueue: events_unbound call_usermodehelper_exec_work
> >> task: 8704a420 task.stack: 87068000
> >> $ 0   : 00000000 80770000 873a8204 8700c214
> >> $ 4   : 00000000 873a8200 00000000 ffff00fe
> >> $ 8   : 8706bfe0 0000a400 fffffffc 8704a459
> >> $12   : 00000000 00000000 00000000 00000720
> >> $16   : 873a8200 87045880 00000000 8700c200
> >> $20   : 87014000 87014005 8700c200 8700c200
> >> $24   : 00000000 8014d1e8
> >> $28   : 87068000 8706be70 87045880 8013cb54
> >> Hi    : 00077698
> >> Lo    : ab801af8
> >> epc   : 8013c6a8 process_one_work+0xd4/0x408
> >> ra    : 8013cb54 worker_thread+0x178/0x598
> >> Status: 1000a402        KERNEL EXL
> >> Cause : 0080000c (ExcCode 03)
> >> BadVA : 00000004
> >> PrId  : 00019300 (MIPS 24Kc)
> >> Modules linked in:
> >> Process kworker/u2:0 (pid: 5, threadinfo=3D87068000, task=3D8704a420, =
tls=3D00000000)
> >> Stack : 80700000 8700c214 00000088 80700000 8700c200 8700c200 8700c200=
 87045898
> >>         80700000 8700c214 00000088 80700000 8700c200 8013cb54 8013c9dc=
 8704fe00
> >>         87045600 87045700 80700000 80700000 80700000 80676560 87045600=
 87045700
> >>         87045618 87045880 8013c9dc 8704fe00 80670000 80760000 806e0000=
 80142958
> >>         00000000 00000000 00000000 00000000 80142850 80142850 87045700=
 8704b380
> >>         ...
> >> Call Trace:
> >> [<8013c6a8>] process_one_work+0xd4/0x408
> >> [<8013cb54>] worker_thread+0x178/0x598
> >> [<80142958>] kthread+0x108/0x138
> >> [<80105e18>] ret_from_kernel_thread+0x14/0x1c
> >> Code: 8e030008  8e040004  8e150000 <ac830004> 7eb51900  ac640000  ae02=
0004 16400094  ae020008
> >>
> >> Bisect points to 'MIPS: Add cacheinfo support'; see below for details.
> >> Reverting this patch fixes te problem.
> >>
> >> Configuration is pretty much malta_defconfig with SMP disabled.
> >> I can provide more details if needed.
> >>
> >> Thanks,
> >> Guenter
> >>
> >> ---
> >> # bad: [e3e6c5f3544c5d05c6b3b309a34f4f2c3537e993] Add linux-next speci=
fic files for 20170208
> >> # good: [d5adbfcd5f7bcc6fa58a41c5c5ada0e5c826ce2c] Linux 4.10-rc7
> >> git bisect start 'HEAD' 'v4.10-rc7'
> >> # bad: [403e468309f9e2b2dbe264be1ad29b1486ed720e] Merge remote-trackin=
g branch 'crypto/master'
> >> git bisect bad 403e468309f9e2b2dbe264be1ad29b1486ed720e
> >> # bad: [44448c3f07a3ae77164de4405fa97baca4f103f5] Merge remote-trackin=
g branch 'hid/for-next'
> >> git bisect bad 44448c3f07a3ae77164de4405fa97baca4f103f5
> >> # good: [dd4318312c6fc5c00ae7619f875fb73538a2c1e6] Merge remote-tracki=
ng branch 'omap/for-next'
> >> git bisect good dd4318312c6fc5c00ae7619f875fb73538a2c1e6
> >> # bad: [2fe482530119a6d07acca625b29d527dc22435e6] Merge remote-trackin=
g branch 'powerpc/next'
> >> git bisect bad 2fe482530119a6d07acca625b29d527dc22435e6
> >> # good: [8576190cecf3370ce07ed04178cb3ecbf17dc2d9] Merge remote-tracki=
ng branch 'clk/clk-next'
> >> git bisect good 8576190cecf3370ce07ed04178cb3ecbf17dc2d9
> >> # bad: [bf0505dfeac3f7df81b62d9d81987aaef6739ffd] MIPS: Fix special ca=
se in 64 bit IP checksumming.
> >> git bisect bad bf0505dfeac3f7df81b62d9d81987aaef6739ffd
> >> # good: [e89ef66d7682f031f026eee6bba03c8c2248d2a9] MIPS: init: Ensure =
reserved memory regions are not added to bootmem
> >> git bisect good e89ef66d7682f031f026eee6bba03c8c2248d2a9
> >> # bad: [a8b3b0c94ac282628f0668d1366239a3fa72dc9d] MIPS: Netlogic: Fix =
assembler warning from smpboot.S
> >> git bisect bad a8b3b0c94ac282628f0668d1366239a3fa72dc9d
> >> # bad: [07724712bf22aec5fe44e5d399f115755f436721] MIPS: ralink: Add mi=
ssing symbol for highmem support.
> >> git bisect bad 07724712bf22aec5fe44e5d399f115755f436721
> >> # good: [856b0f591e951a234d6642cc466023df182eb51c] MIPS: kexec: add de=
bug info about the new kexec'ed image
> >> git bisect good 856b0f591e951a234d6642cc466023df182eb51c
> >> # bad: [2517caf19dbfac3b39f2db5500c5fd03c4370e81] MIPS: ralink: Add mi=
ssing I2C and I2S clocks.
> >> git bisect bad 2517caf19dbfac3b39f2db5500c5fd03c4370e81
> >> # bad: [ef462f3b64e9fb0c8e1cd5d60f5bd7f13ac2156d] MIPS: Add cacheinfo =
support
> >> git bisect bad ef462f3b64e9fb0c8e1cd5d60f5bd7f13ac2156d
> >> # good: [0014dea6b71ae3e0384c3358f632b4728c3d432e] MIPS: generic/kexec=
: add support for a DTB passed in a separate buffer
> >> git bisect good 0014dea6b71ae3e0384c3358f632b4728c3d432e
> >> # first bad commit: [ef462f3b64e9fb0c8e1cd5d60f5bd7f13ac2156d] MIPS: A=
dd cacheinfo support
> >>
> >>
> >
>=20
>=20

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIbBAEBCAAGBQJYnYp0AAoJEGwLaZPeOHZ6Ng4P9jPGFcvoorpLYbd7EzQLkS0l
30Zp/PRtg9MHDCARB8T44baIkaqWAEn8YSCOOx9B/R9x9KDsx7qFzXt5IPF2n8fy
VuSdAVNiXFwy+Na2PBA64V2GQ2SOx5hYZMINvSwlX2FpOcQ2HjQZaFfgklqRJqH6
vRfycvJGV6hcE3aF3fg4Rx8doIKEpOulDdbh3EyQMJA7qdmIeTFftSL9hf84ctcR
WxLIUVXgEFkXAkRWg3nZkgEIMDssralTBiTSS80TaJhq2nNVqrVXV4TVFWuKmbNA
BrFFIU0DRy5G3IbUIVIsrdHzDUFw7ptmcMNqPufdfb8lhLAjNsyCGfWNhBBhPVBF
EK5bxRm/CQZCSR/I+Z50SERD25eo5cBr19MIvae2GRfcwa/voY/RbijyvCFol9lM
TkJiE1Xsfi8CfIzZy7CiZJQ/qYe4ne9dLS+FZqURkY6ms2sje0ZN16zJkc+TPSbB
akCym/BC6IF3hbGsPTr/iViaiLwtXro8w8FuIfRXy9SetN2W0IBoNDG+WpKDu2V4
o2RbLVVyKmKx8md0ptvfGcsSwzeoEELomvctOT3jtEWF3QCod2k1snyKKtCISe0M
mAzh1iI7/lBaAHj10dmqWd697vJAPhrvnYsw5DLbsAcRUMJAtEe1063de6kkU8cJ
gKMb09IDi5ADXuxVdU0=
=lo64
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
