Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 13:10:37 +0200 (CEST)
Received: from mga03.intel.com ([143.182.124.21]:36418 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903640Ab2EHLKd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 13:10:33 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 08 May 2012 04:10:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; 
   d="asc'?scan'208";a="140282044"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
  by azsmga001.ch.intel.com with ESMTP; 08 May 2012 04:10:16 -0700
Received: from [10.237.72.159] (sauron.fi.intel.com [10.237.72.159])
        by linux.intel.com (Postfix) with ESMTP id BE3466A4008;
        Tue,  8 May 2012 04:10:14 -0700 (PDT)
Message-ID: <1336475618.23308.30.camel@sauron.fi.intel.com>
Subject: Re: xway_nand does not build
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <blogic@openwrt.org>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Date:   Tue, 08 May 2012 14:13:38 +0300
In-Reply-To: <4FA8FD24.6060908@openwrt.org>
References: <1336474838.23308.28.camel@sauron.fi.intel.com>
         <4FA8FD24.6060908@openwrt.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-6fKC/UqtgesG1WK+A/6B"
X-Mailer: Evolution 3.2.3 (3.2.3-3.fc16) 
Mime-Version: 1.0
X-archive-position: 33191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


--=-6fKC/UqtgesG1WK+A/6B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-08 at 13:01 +0200, John Crispin wrote:
> On 08/05/12 13:00, Artem Bityutskiy wrote:
> > Hi John,
> >
> > I get the following build error when building xway_nand.c:
> >
> > dedekind@blue:~/git/l2-mtd$ make ARCH=3Dmips CROSS_COMPILE=3Dmips-linux=
-
> >   CHK     include/linux/version.h
> >   CHK     include/generated/utsrelease.h
> >   UPD     include/generated/utsrelease.h
> >   CALL    scripts/checksyscalls.sh
> >   CHK     include/generated/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   CC      kernel/sys.o
> >   LD      kernel/built-in.o
> >   LD      drivers/mtd/nand/nand.o
> >   CC      drivers/mtd/nand/xway_nand.o
> > drivers/mtd/nand/xway_nand.c: In function 'xway_select_chip':
> > drivers/mtd/nand/xway_nand.c:78:3: error: implicit declaration of funct=
ion 'ltq_ebu_w32_mask' [-Werror=3Dimplicit-function-declaration]
> > cc1: some warnings being treated as errors
> > make[3]: *** [drivers/mtd/nand/xway_nand.o] Error 1
> > make[2]: *** [drivers/mtd/nand] Error 2
> > make[1]: *** [drivers/mtd] Error 2
> > make: *** [drivers] Error 2
> >
> > and I cannot figure out how to fix this. This build failure makes
> > me really unhappy and shame on me I did not notice it before, of
> > course. Would you have a fix?
>=20
> Hi,
>=20
> I should have spotted this myself infact. I split these patches out of a
> huge series and did infact check that it builds outside the series.
> looks like i missed a define. Would it be possible, that patch 4 of my
> series flows via Ralfs MIPS tree ? That way we dont need to split out a
> single "#define ltq_ebu_w32_mask" out of the bigger MIPS series ?

OK, so I should drop this patch from l2-mtd.git:

commit e4445062be41c27b2a0b4f2e1e770d24b68686f4
Author: John Crispin <blogic@openwrt.org>
Date:   Mon Apr 30 19:30:48 2012 +0200

    mtd: mips: lantiq: add xway nand support
   =20
    Add NAND support on Lantiq XWAY SoC.
   =20
    The driver uses plat_nand. As the platform_device is loaded from DT, we=
 need
    to lookup the node and attach our xway specific "struct platform_nand_d=
ata"
    to it.
   =20
    Signed-off-by: John Crispin <blogic@openwrt.org>
    Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Right?

--=20
Best Regards,
Artem Bityutskiy

--=-6fKC/UqtgesG1WK+A/6B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPqP/iAAoJECmIfjd9wqK002oQAK/GwXGDVkk1iJ8N+z7UiIaB
9akTZzB5KUOdXPU2XjN+hAtqn1pXDU1D3vcUZ5nR/epVb/YmC/drpHS0arFb/xyV
b4cUG6Z2Yw3e9zM70TKAAbDrnmZP0YERKsjv3kYTJk/z2iT0W62laLZetUqnQfdJ
W8maauUrL86iWcKpDbxBmBA4Hdhj3UGMqJHiEZaQcwWLfSPU03b7Q+VO93lQG3wK
JsXApjZQj7L+YcNIs39jsnRXT5mrZghwm3rwv2hnIYIK7fQpXlhV0N5wcOgi7qxR
qoCj9mg6WxFemtemqQN4PaQ7z6Atibg0o10AHQ3irCjabMw+klV1b6tA2Lf3Wqbv
dXL86iy5DEQCCJcxKGl2XUFtexVmKqw5E65ZR6GS7tDQCtpBUBuhLQH0rWOvFk3q
4DsRTQrtRatLsjh3z3+xgfHH66RF5VpFjfR+02hstPQU3Vy3xO+FslDlsqZSQmot
7Fp10IDajDQ31E9GNt/5OJKM/M6Achq3ldQdDDXd2RH9xVfPxMT3//Z07FIa4MSY
qrzQPVa86DANuBqwp2n6gowZyK/F3/dkiochTgoOwjMDlQcHpK5B2ZKXsjfoWPUz
+QCvUgT6808aS8picjWq9QvBpNAFwRUtIoxlHxHLdRxqUKo0AtufwgvTv5mCLCdt
oAHtfGmXdzQN8xhxi1iX
=clWZ
-----END PGP SIGNATURE-----

--=-6fKC/UqtgesG1WK+A/6B--
