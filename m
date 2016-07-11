Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2016 20:08:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7743 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993370AbcGKSIESU0PV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jul 2016 20:08:04 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 336E441F8DAD;
        Mon, 11 Jul 2016 19:07:56 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 11 Jul 2016 19:07:56 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 11 Jul 2016 19:07:56 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 56259306CC434;
        Mon, 11 Jul 2016 19:07:52 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 11 Jul
 2016 19:07:55 +0100
Date:   Mon, 11 Jul 2016 19:07:55 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     <yhb@ruijie.com.cn>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>
Subject: Re: MIPS: We need to clear MMU contexts of all other processes when
 asid_cache(cpu) wraps to 0.
Message-ID: <20160711180755.GA29839@jhogan-linux.le.imgtec.org>
References: <80B78A8B8FEE6145A87579E8435D78C30205D5F3@fzex.ruijie.com.cn>
 <5783DF18.1080408@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <5783DF18.1080408@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: cee91754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54285
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

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Leonid,

On Mon, Jul 11, 2016 at 11:02:00AM -0700, Leonid Yegoshin wrote:
> On 07/10/2016 06:04 AM, yhb@ruijie.com.cn wrote:
> > Subject: [PATCH] MIPS: We need to clear MMU contexts of all other proce=
sses
> >   when asid_cache(cpu) wraps to 0.
> >
> > Suppose that asid_cache(cpu) wraps to 0 every n days.
> > case 1:
> > (1)Process 1 got ASID 0x101.
> > (2)Process 1 slept for n days.
> > (3)asid_cache(cpu) wrapped to 0x101, and process 2 got ASID 0x101.
> > (4)Process 1 is woken,and ASID of process 1 is same as ASID of process =
2.
> >
> > case 2:
> > (1)Process 1 got ASID 0x101 on CPU 1.
> > (2)Process 1 migrated to CPU 2.
> > (3)Process 1 migrated to CPU 1 after n days.
> > (4)asid_cache on CPU 1 wrapped to 0x101, and process 2 got ASID 0x101.
> > (5)Process 1 is scheduled, and ASID of process 1 is same as ASID of pro=
cess 2.
> >
> > So we need to clear MMU contexts of all other processes when asid_cache=
(cpu) wraps to 0.
> >
> > Signed-off-by: yhb <yhb@ruijie.com.cn>
> >
> I think a more clear description should be given here - there is no=20
> indication that wrap happens over 32bit integer.
>=20
> And taking into account "n days" frequency - can we just kill all local=
=20
> ASIDs in all processes (additionally to local_flush_tlb_all) and enforce=
=20
> reassignment if wrap happens? It should be a very rare event, you are=20
> first to hit this.
>=20
> It seems to be some localized stuff in get_new_mmu_context() instead of=
=20
> widespread patching.

That is what this patch does, but to do so it appears you need to lock
the other tasks one by one, and that must be doable from a context
switch, i.e. hardirq context, and that requires the task lock to be of
the _irqsave variant, hence the widespread changes and the relatively
tiny MIPS change hidden in the middle.

Cheers
James

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXg+B7AAoJEGwLaZPeOHZ6e0cP/AlRpCj9+QI8wBK5AZ2dF1XN
ouLPKF465mpLxGbFGH00GYRkjk3d0JyqL10gH9k2FmOABW14JqSkMlmgVHltdwQX
3Qr55m8UHgAE6q1pOi8LaxhP/YH7ySaAHKCXfTwPEteJQOWZo19brAK4wFfOVPAZ
LbSZr5+8DOj/wCDtwzOm6fRlgZwVguUlLogZPgjqabuuZ5vvuGngwyYO1SAq0jj8
Mp2HDtaM7waoTxUgnGh6R7noBaKQF3sT3pxhPPlvQAxLyj5u2JbO/wYb1rg+YHGK
BNzr166pwWWEEPYoorHuTGfCSWhC8XmyJt0BDRT7Dp1uvdSa4Lqhw/xTZ5JOwN08
aa/IrMJhXAoCjYBjLCc4yUqGaq+9qC0rPrLx9GnoOh1p5GVTI12/iqzOhv4lNHDG
9ATJoW25aodIExIbE3eDvF42EmmoiJ34I3wWdMq/r90B7aprm6EveC1obSJ8vZNd
HW1nJCgcp6dzgwvFSXevdAc5W8Cd+N85nR5rsVTz0hkz7q258BpbqHiPVwlA9SsQ
SWJcc0Cs6BGVOXTkKFwND4HDFUjYNWddpcADz6AA7Zq2a/LYQ7b+uWfEgi8X0fFp
DqIGBjLXHoMuOytAg5gFx1GnoKC6XPUgHrH4xhLktSndReuEX0TbiXOWOD5VJKFF
XjAOhuhp2nSPWL5/8CHg
=mFTU
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
