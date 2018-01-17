Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 00:59:07 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:60572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994702AbeAQX67j8qTV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Jan 2018 00:58:59 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9000220C09;
        Wed, 17 Jan 2018 23:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9000220C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 17 Jan 2018 23:58:47 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] MIPS: mscc: Add initial support for Microsemi MIPS
 SoCs
Message-ID: <20180117235846.GA25314@saruman>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-10-alexandre.belloni@free-electrons.com>
 <20171128160137.GF27409@jhogan-linux.mipstec.com>
 <20171128165359.GJ21126@piout.net>
 <20171128173151.GD5027@jhogan-linux.mipstec.com>
 <20171128195002.dcq7i2wqmstkn3rr@pburton-laptop>
 <20171129163819.GN21126@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20171129163819.GN21126@piout.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62226
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


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 05:38:19PM +0100, Alexandre Belloni wrote:
> Hi Paul,
>=20
> On 28/11/2017 at 11:50:02 -0800, Paul Burton wrote:
> > On Tue, Nov 28, 2017 at 05:31:51PM +0000, James Hogan wrote:
> > > On Tue, Nov 28, 2017 at 05:53:59PM +0100, Alexandre Belloni wrote:
> > > > On 28/11/2017 at 16:01:38 +0000, James Hogan wrote:
> > > > > On Tue, Nov 28, 2017 at 04:26:39PM +0100, Alexandre Belloni wrote:
> > > > > > Introduce support for the MIPS based Microsemi Ocelot SoCs.
> > > > > > As the plan is to have all SoCs supported only using device tre=
e, the
> > > > > > mach directory is simply called mscc.
> > > > >=20
> > > > > Nice. Have you considered adding this to the existing multiplatfo=
rm
> > > > > "generic" platform? See for example commit b35565bb16a5 ("MIPS: g=
eneric:
> > > > > Add support for MIPSfpga") for the latest platform to be converte=
d.
> > > > >=20
> > > >=20
> > > > I didn't because we are currently booting using an old redboot with=
 its
> > > > own boot protocol and at boot, the register read by the sead3 code =
is
> > > > completely random (it actually matched once).
> > > >=20
> > > > Do you consider that mandatory to get the platform upstream?
> > >=20
> > > No, however if it is practical to do so I think it might be the best =
way
> > > forward (even if generic+YAMON support is mutually exclusive of
> > > generic+redboot, though hopefully there is some way to avoid that).
> > >=20
> > > Paul on Cc, he may have thoughts on this one.
> >=20
> > We could certainly look at tightening the checks in the SEAD-3 code to
> > avoid the false positive.
> >=20
> > Could you share any details of the boot protocol you're using with
> > redboot? One option might be for the SEAD-3 code to check that the
> > arguments the bootloader provided look "YAMON-like", so long as the 2
> > protocols differ sufficiently.
> >=20
>=20
> I didn't look closely at the redboot code yet but it ends up with
> something like:
>  - argc =3D=3D fw_arg0
>  - argv =3D=3D fw_arg1
>     - not sure yet what is in argv[0]
>     - kernel commande line in argv[1]
>  - fw_arg2 is a pointer to a structure like:
>         struct parmblock {
>             t_env_var memsize;
>         };
>     with:
>         typedef struct
>         {
>             char *name;
>             char *val;
>         } t_env_var;
>    this is the size of the RAM but I'm not using it because it is in the
>    device tree.
>=20
> Does that help?

That basically matches what YAMON provides. I can't see a nice way to
support both in the same kernel.

Processor ID is no good since Malta (not yet mainline added to
"generic") uses the same address for the ID, and can support a much
bigger range of cores.

Poking at random I/O always feels a bit risky.

Some safety checked environment checking (Paul says modetty0 should
always be in there for YAMON) might work.

Does Ocelot have a read-only ID register with a specific value? We'd
have to add prioritisation of the legacy board detection to rely on
that.

If all else fails, we could still make them mutually exclusive,
something roughly like below would work but its a bit clumsy as all the
ocelot config options would still get enabled when sead3 is enabled,
even though some of the drivers may not be useful. The detection &
co-existence can always be improved later. What do you think?

We can't #require CONFIG_LEGACY_BOARD_SEAD3=3Dn unfortunately since it
only checks the base config, not the already merged board configs.

Cheers
James

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 0f20f84de53b..bfdefc013358 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -537,6 +537,10 @@ generic_defconfig:
 # now that the boards have been converted to use the generic kernel they a=
re
 # wrappers around the generic rules above.
 #
+.PHONY: ocelot_defconfig
+ocelot_defconfig:
+	$(Q)$(MAKE) -f $(srctree)/Makefile 32r2el_defconfig BOARDS=3Docelot
+
 .PHONY: sead3_defconfig
 sead3_defconfig:
 	$(Q)$(MAKE) -f $(srctree)/Makefile 32r2el_defconfig BOARDS=3Dsead-3
diff --git a/arch/mips/configs/generic/board-ocelot.config b/arch/mips/conf=
igs/generic/board-ocelot.config
new file mode 100644
index 000000000000..b22a4570d05c
--- /dev/null
+++ b/arch/mips/configs/generic/board-ocelot.config
@@ -0,0 +1,3 @@
+# require CONFIG_32BIT=3Dy
+
+CONFIG_LEGACY_BOARD_OCELOT=3Dy
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index 52e0286a1612..fac8b936c468 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -27,6 +27,14 @@ config LEGACY_BOARD_SEAD3
 	  Enable this to include support for booting on MIPS SEAD-3 FPGA-based
 	  development boards, which boot using a legacy boot protocol.
=20
+comment "MSCC Ocelot doesn't work with SEAD3 enabled"
+	depends on LEGACY_BOARD_SEAD3
+
+config LEGACY_BOARD_OCELOT
+	bool "Support MSCC Ocelot boards"
+	depends on LEGACY_BOARD_SEAD3=3Dn
+	select LEGACY_BOARDS
+
 comment "FIT/UHI Boards"
=20
 config FIT_IMAGE_FDT_BOSTON

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpf4zAACgkQbAtpk944
dnp8kxAAr7BOza7uM5gnOI2ZV8h33mFLHyWUnZLdWpXhNOkZnzRhISlZ+aHLc5Bh
I7zql+D4wGELgTtTbd352GuOTzXSkCBM2AwME8fcyD5PmhErFpamngL3GKBmY/Mp
n74Q9x0W/P6ZtOTiVytRJP8t0BsbC4MBw4GsR0Y6mjjUSsreHF89V7Q9hyQfxE6Z
O6G19tD/FK4PoGcCVw65/91i3A3Pjtl5jMwGOg58kCbBE2B3p9E7T6dkXgklay8W
KjitKRDBBYb1zjqh+NHsXj0rizcqSkU23DzOQYslYkDUej3nx0ItwB9iJJ+hj/5T
Ygisiek7r6h6+cU+lxl28U7ML70/4EkshlMO9pCtO3nTSc+OJ1wQnCcFA1AcGwSM
StneSoeaBGuGpb5Ny7DuFoAO6Ttmh1KaEQNU+S4bss+AJ8STjj8w5bRYrGmbInW2
Lm3k0xJRg2E9fBGEMr2Np1W133ryPT1VTjJjgBEjxbQFc8Py2z459sLsMosPT6RE
hCRZBSGOtaNivkqAugIyqcxO9r8Bl/JhrxZr7ZJShURKxrF2YkqpgpnpCgzI27rj
TfhDud+OQpM3foqUQZ8yndeBxerJmRJ+VmeBwt+U7TOZpt0o16AOXCCMH2GuqEVK
mYj2CgxBN6sXkd6N8qJzyUxkusqa9cASFo+CexOEhQQ0HjJjW/g=
=EmHX
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
