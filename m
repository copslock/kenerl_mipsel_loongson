Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2012 16:19:17 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:7022 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903536Ab2HXOTM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Aug 2012 16:19:12 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 24 Aug 2012 07:19:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,304,1344236400"; 
   d="asc'?scan'208";a="213466591"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
  by fmsmga002.fm.intel.com with ESMTP; 24 Aug 2012 07:19:04 -0700
Received: from [10.237.72.96] (sauron.fi.intel.com [10.237.72.96])
        by linux.intel.com (Postfix) with ESMTP id 2BC0E2C8001;
        Fri, 24 Aug 2012 07:18:59 -0700 (PDT)
Message-ID: <1345818230.2848.315.camel@sauron.fi.intel.com>
Subject: Re: [PATCH] kconfig: remove CONFIG_MTD_NAND_VERIFY_WRITE
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Huang Shijie <b32955@freescale.com>
Cc:     linux@arm.linux.org.uk, vapier@gentoo.org, ralf@linux-mips.org,
        benh@kernel.crashing.org, paulus@samba.org, robert.richter@amd.com,
        a.p.zijlstra@chello.nl, mingo@kernel.org, kgene.kim@samsung.com,
        wim@iguana.be, FlorianSchandinat@gmx.de, balbi@ti.com,
        linus.walleij@linaro.org, arnd@arndb.de,
        scott.jiang.linux@gmail.com, lliubbo@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
        akpm@linux-foundation.org
Date:   Fri, 24 Aug 2012 17:23:50 +0300
In-Reply-To: <1345021930-5033-1-git-send-email-b32955@freescale.com>
References: <1345021930-5033-1-git-send-email-b32955@freescale.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-1PDzJ60gc12o99kZMjzr"
X-Mailer: Evolution 3.2.3 (3.2.3-3.fc16) 
Mime-Version: 1.0
X-archive-position: 34355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>


--=-1PDzJ60gc12o99kZMjzr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-15 at 17:12 +0800, Huang Shijie wrote:
> Just as Artem suggested:
>=20
> "Both UBI and JFFS2 are able to read verify what they wrote already.
> There are also MTD tests which do this verification. So I think there
> is no reason to keep this in the NAND layer, let alone wasting RAM in
> the driver to support this feature."
>=20
> So kill MTD_NAND_VERIFY_WRITE entirely. Please see the patch:
> http://lists.infradead.org/pipermail/linux-mtd/2012-August/043189.html
>  =20
> This patch removes the CONFIG_MTD_NAND_VERIFY_WRITE in the defconfigs.
>=20
>=20
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Pushed to l2-mtd.git, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-1PDzJ60gc12o99kZMjzr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQN453AAoJECmIfjd9wqK0fygP/jeOkZF9bCO9UvLxdQWwpJ/X
H7aSPLawengL92Miwb+4/IrlXWzQ8ecyyK6I5l95AflQBT033Z/AZXMZwf7bcqu+
Y0hI1vgEnLBgqWi11NLe34N+i9W6nGch/fso4TJIteJvyk30ZsDUi/EBldo12OJc
yVW6N/kGVSY3vwqNWQEQS4rdYKHx3n0rbgG2akKg5wGRupFcsO0ZwGpf8jg8f68C
IWshWtDvz0VU4im4c3gOwwWd6Aa1J8FLnbx9nmpgGzqvvqJMpSVOvMSBHvZLOW3g
QftCwlor/KePTFApilhUG0YljPt7I/J61QeO0ALvQQZ0C+mLb1eZcVD4lZOGiY16
4zTBdQLYwJ3wSVBA1svcAmd8wLYIPX/A7lvYk+HBDvzcCWKbp5qi1BFao+WcFXmu
CaooHYF3UZxJrjlUsRvv6ouA0WuEap4Ro8axqwXuwndDTeUxukZ8x5rLc/bi0WnL
+qSFmSFcBdw8Y7AtrBKK4uDxHSI2BY9Su7fQXR1ndOAPZbOu6sl4egvBXURlQEcf
5ycYikXFJR7xe76lPxMKKmUQOIF2VRT2ZOyf+Z7EICSrLhC7nka/p11/sVFHJVYp
dlYwFuhPPyNBbrqL5f0WHXHD69QUeMK8i+qx1sE5VeeWXrn3FU13d8KuSJEJ6SPq
SBKDCFB2OQMnuymBLXHs
=YQei
-----END PGP SIGNATURE-----

--=-1PDzJ60gc12o99kZMjzr--
