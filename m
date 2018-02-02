Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 13:07:18 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:56360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990406AbeBBMHLQqXrP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Feb 2018 13:07:11 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56C3921798;
        Fri,  2 Feb 2018 12:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C3921798
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 2 Feb 2018 12:06:59 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: CPS: Fix r1 .set mt assembler warning
Message-ID: <20180202120658.GA8479@saruman>
References: <079ec8f9-d2c2-9e29-278e-48e76bbb8de7@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <079ec8f9-d2c2-9e29-278e-48e76bbb8de7@linux-m68k.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Fri, Feb 02, 2018 at 01:34:20PM +1000, Greg Ungerer wrote:
> Hi James,
>=20
> James Hogan wrote:
> > From 17278a91e04f858155d54bee5528ba4fbcec6f87 Mon Sep 17 00:00:00 2001
> > From: James Hogan <jhogan@kernel.org>
> > Date: Tue, 14 Nov 2017 12:01:20 +0000
> > Subject: [PATCH] MIPS: CPS: Fix r1 .set mt assembler warning
> >=20
> > MIPS CPS has a build warning on kernels configured for MIPS32R1 or
> > MIPS64R1, due to the use of .set mt without a prior .set mips{32,64}r2:
> >=20
> > arch/mips/kernel/cps-vec.S Assembler messages:
> > arch/mips/kernel/cps-vec.S:238: Warning: the `mt' extension requires MI=
PS32 revision 2 or greater
> >=20
> > Add .set MIPS_ISA_LEVEL_RAW before .set mt to silence the warning.
>=20
> This change breaks booting for me on a MediaTek MT7621 platform:
>=20
>   ...
>   Calibrating delay loop... 586.13 BogoMIPS (lpj=3D2930688)^M
>   pid_max: default: 32768 minimum: 301^M
>   Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)^M
>   Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)^M
>   Hierarchical SRCU implementation.^M
>   smp: Bringing up secondary CPUs ...^M
>   Reserved instruction in kernel code[#1]:^M
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.0-ac0 #3^M
>   $ 0   : 00000000 00000001 00000000 00000000^M
>   $ 4   : 8501dd80 00000001 00000004 00000000^M
>   $ 8   : 00000004 00000002 00000001 ffffffff^M
>   $12   : 00000000 00000400 00000003 8501de00^M
>   $16   : 807d5ca0 8501dd80 00000000 00000001^M
>   $20   : 80842814 00000000 00000001 000000e0^M
>   $24   : fffffffc 00000001                  ^M
>   $28   : 85026000 85027de0 00000020 80013538^M
>   Hi    : 00000006^M
>   Lo    : 8e778000^M
>   epc   : 80656620 mips_cps_boot_vpes+0x4c/0x160^M
>   ra    : 80013538 cps_boot_secondary+0x280/0x440^M
>   Status: 11000403        KERNEL EXL IE ^M
>   Cause : 50800028 (ExcCode 0a)^M
>   PrId  : 0001992f (MIPS 1004Kc)^M
>=20
> If I revert the patch then I can boot up again, all works as expected.
>=20
> I am not exactly using a pure mainline 4.15 source base though.
> (I have a bunch of additional changes to make this platform actually work=
).
>=20
> But this patch certainly does trap as above when present. I am using
> a gcc-5.4.0/binutils-2.25.1 toolchain.
>=20
> Any thoughts?

Hmm, sorry about that.

If there is some more of the log which shows code around the EPC
(usually a few lines below where you stopped), that would be helpful to
see exactly whats happening. Perhaps it has used a 64-bit instruction.

When I build 32r2el_defconfig, that EPC (relative to mips_cps_boot_vpes)
is a move instruction, which is implemented with OR (which should be
safe on MIPS32 and MIPS64), both with binutils 2.28ish and 2.24ish (MTI
/ IMG toolchains, so they may have additional patches).

I'll try limiting the .set mt to code that needs it.

Thanks
James

>=20
> Regards
> Greg
>=20
>=20
> > Fixes: 245a7868d2f2 ("MIPS: smp-cps: rework core/VPE initialisation")
> > Signed-off-by: James Hogan <jhogan@kernel.org>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: James Hogan <james.hogan@mips.com>
> > Cc: James Hogan <jhogan@kernel.org>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: linux-mips@linux-mips.org
> > Patchwork: https://patchwork.linux-mips.org/patch/17699/
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> > ---
> >  arch/mips/kernel/cps-vec.S | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
> > index c7ed260..e68e6e0 100644
> > --- a/arch/mips/kernel/cps-vec.S
> > +++ b/arch/mips/kernel/cps-vec.S
> > @@ -235,6 +235,7 @@ LEAF(mips_cps_core_init)
> >         has_mt  t0, 3f
> >=20
> >         .set    push
> > +       .set    MIPS_ISA_LEVEL_RAW
> >         .set    mt
> >=20
> >         /* Only allow 1 TC per VPE to execute... */
> > @@ -388,6 +389,7 @@ LEAF(mips_cps_boot_vpes)
> >  #elif defined(CONFIG_MIPS_MT)
> >=20
> >         .set    push
> > +       .set    MIPS_ISA_LEVEL_RAW
> >         .set    mt
> >=20
> >         /* If the core doesn't support MT then return */
> > --=20
> > 1.9.1
>=20

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlp0VFsACgkQbAtpk944
dnqn9w/+MhUbudb4dr74ENOfHZ20XkdE/KjxEO3oh5sVHK4l5C106FPoQ3pHA/iq
MBaTiy8pBjGuCyoVshp3AlyBQI6ZScI+HGNIfz/8m6MCt4pDZDgJLPXfyP0c+JiU
750kKoogSpwx7yA6GhubdGF7L48SarYEaKrlCWx2paY9eD8TyYHfnWJtuZmgyv05
808byeFMXDAFhXy3C3E6XDv3NKgnJhoqNDkC6+lGPg78N6muNDNTO8f9Jcwo6xrw
dCGtt+NRQ8B4hF+OocX0pCfPK0g+U0MVerhmeL5mjfQlaIYd9DQ0POASvJNCThx/
9ubl6cHRV6ExUnrGcFgfhbWwPYQN/Iz8jaVvnE1hbnMl6d2e5J3l3zvMqlOrsNw9
NNf+rpO/AXkAyX7InBQewjW/RNPSGQotW0w3DH3FLCDS1UDHN1sdwgs1vv3KgbAX
0WhQGC+AwHvIL6rJOlJ1pp+oNwehUgs/luDWA3glWb8dpAJxm2THPA7RNqCPh7cU
KDOTIQ4dWZeEm+JC/MjoYcrX4MB/zRoVGNgxS0aYOsL5wCTCo6GSvqfmGV9o/Jz1
mBcHVdD6SYWow7piM0g71BZR3BA6c1aZpRLWEmVD67jycPthYvYXEfK6JAd5S5Pb
cqvBcfnTLg9TT5JdLecmVRCnwhmj+Ks1Wm5YVTkuzsPZhR/XtDo=
=5iAH
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
