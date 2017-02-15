Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2017 10:38:20 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15225 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991532AbdBOJiOFRkGg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Feb 2017 10:38:14 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 2664641F8E91;
        Wed, 15 Feb 2017 10:42:08 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 15 Feb 2017 10:42:08 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 15 Feb 2017 10:42:08 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id D3001D25DA14F;
        Wed, 15 Feb 2017 09:38:05 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 15 Feb
 2017 09:38:08 +0000
Date:   Wed, 15 Feb 2017 09:38:07 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     kernelci.org bot <bot@kernelci.org>,
        <kernel-build-reports@lists.linaro.org>, Linux Kernel Mailing List
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>, Ralf Baechle
        <ralf@linux-mips.org>, Alex Deucher <alexander.deucher@amd.com>, Christian
 =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        <amd-gfx@lists.freedesktop.org>, Hauke Mehrtens <hauke@hauke-m.de>, Jiri
 Pirko <jiri@mellanox.com>, Jamal Hadi Salim <jhs@mojatatu.com>, "David S.
 Miller" <davem@davemloft.net>
Subject: Re: next build: 208 builds: 3 failed, 205 passed, 5 errors, 23
 warnings (next-20170215)
Message-ID: <20170215093807.GV24226@jhogan-linux.le.imgtec.org>
References: <58a41194.828bdf0a.685a.3c15@mx.google.com>
 <CAK8P3a3XSBzVoM02sdehxDmrX3qM5NFqTgz2s2hyCqE203VzOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JNs4m2JFMNhdiK2v"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3XSBzVoM02sdehxDmrX3qM5NFqTgz2s2hyCqE203VzOw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56823
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

--JNs4m2JFMNhdiK2v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2017 at 09:56:48AM +0100, Arnd Bergmann wrote:
> On Wed, Feb 15, 2017 at 9:30 AM, kernelci.org bot <bot@kernelci.org> wrot=
e:
> > bcm47xx_defconfig (mips) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section=
 mismatches
> >
> > Errors:
> > /home/buildslave/workspace/khilman-kbuilder/next/build-mips/../net/sche=
d/sch_fq_codel.c:468:
> > undefined reference to `tcf_destroy_chain'
>=20
> I have not looked at this one yet, appears to be caused by commit
> cf1facda2f61 ("sched: move tcf_proto_destroy and tcf_destroy_chain
> helpers into cls_api")

So effectively CONFIG_NET_SCH_FQ_CODEL (which bcm47xx_defconfig sets
=3Dy), and just over half of the other packet schedulers now implicitly
depend on CONFIG_NET_CLS (which bcm47xx_defconfig doesn't set =3Dy).

Perhaps revert would be best since the change looks of questionable
value to me, as all the users of it are in sch_*.c anyway.

> > ip27_defconfig (mips) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 section m=
ismatches
> >
> > Errors:
> > drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: error: insn does n=
ot
> > satisfy its constraints:
> > drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: internal compiler
> > error: in extract_constrain_insn, at recog.c:2190
>=20
> broken gcc release, apparently fixed in gcc-7 (can't reproduce here at le=
ast).
> I suggested a workaround, but got no reply so far:
>=20
> http://www.spinics.net/lists/mips/msg66465.html

I'll look into that.

>=20
> > xway_defconfig (mips) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 section m=
ismatches
> >
> > Errors:
> > (.text+0x14e10): undefined reference to `physical_memsize'
> > (.text+0x14e14): undefined reference to `physical_memsize'
>=20
> Hauke already did a patch in December, but it has't made it into linux-mi=
ps
> so far:
>=20
> https://marc.info/?l=3Dlinux-mips&m=3D148612428414708&w=3D3

Hauke: you mentioned sending a new version of this patch. I'll apply the
original patch for now, as looking at the VPE loader, zero doesn't sound
entirely unreasonable:

/*
 * The sde-kit passes 'memsize' to __start in $a3, so set something
 * here...  Or set $a3 to zero and define DFLT_STACK_SIZE and
 * DFLT_HEAP_SIZE when you compile your program
 */
mttgpr(6, v->ntcs);
mttgpr(7, physical_memsize);

Cheers
James

--JNs4m2JFMNhdiK2v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYpCF5AAoJEGwLaZPeOHZ63MMQAJR2Hq6HFcrWsmtKSnON1t9X
1m1SfvSFSvluUoMrRdOLZFdAO6QwkP8FSTN6VDDA+KV5P9/JM1qQS13k4Md/yJLD
JMbFvc5/mGGvOzhcmJ6vaSEqLm6xOLy0dDDACsbHmnMUQiHXhooRz4PwLOYidhVK
gn79Md8NGEcZWkBzLde26yZZPT960Vk8GzHevuds8K9oErpUOxt6sFtrQiRsHS2b
qm4pmi7eiAbql6CSMpiaKJ8a+7NG8UzP+bdahyc8xJaATdGeJDlLcjer9WBE7xR2
d4Jizxrmu1tIkNY4NWrHwKQ372STL3zdz2myGC5Rk/QKLDEQqQUjiOj6pkuyDHDp
GRZQRTh/JXr6BDZlVuXnM3KJvChhsKzTziQQSQu9hi3Wcph01OXTU9qeZlqA+1Nu
cVSpEr17cqCMaspFThE6cARzBbj+wShAQ+529ILKHYncx+YKNcq/XhdoMEmaa2Zu
bpc5iSc8+0uDzBnKVCrWYMwAZHG8DeX1pBPvu3V8x1Wq0aILUpl9ZSPA5XZaVRaX
FlnWnrSgLCcS43HWZgSzFNI0HbOzO0iYJee9qGKYugwNfcOoaiNCrGFfM1sThPso
lmr+tpvBOidfatTzHLsk7i/O6CHhqDrBrFsPRowhQkUL64i48Upgfg+4T1Dw25Ei
8V+eqQIqK5ImCIb43+he
=Hrbz
-----END PGP SIGNATURE-----

--JNs4m2JFMNhdiK2v--
