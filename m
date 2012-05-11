Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 16:03:24 +0200 (CEST)
Received: from mga03.intel.com ([143.182.124.21]:33898 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903558Ab2EKODR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 May 2012 16:03:17 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 11 May 2012 07:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; 
   d="asc'?scan'208";a="141886285"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
  by azsmga001.ch.intel.com with ESMTP; 11 May 2012 07:03:07 -0700
Received: from [10.237.72.159] (sauron.fi.intel.com [10.237.72.159])
        by linux.intel.com (Postfix) with ESMTP id DDFE36A4007;
        Fri, 11 May 2012 07:03:06 -0700 (PDT)
Message-ID: <1336745193.2625.81.camel@sauron.fi.intel.com>
Subject: Re: [PATCH 12/14] MTD: MIPS: lantiq: implement OF support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org
Date:   Fri, 11 May 2012 17:06:33 +0300
In-Reply-To: <1336133919-26525-12-git-send-email-blogic@openwrt.org>
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org>
         <1336133919-26525-12-git-send-email-blogic@openwrt.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-Br6LUzRPYqcySERHclUK"
X-Mailer: Evolution 3.2.3 (3.2.3-3.fc16) 
Mime-Version: 1.0
X-archive-position: 33258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


--=-Br6LUzRPYqcySERHclUK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 14:18 +0200, John Crispin wrote:
> Adds bindings for OF and make use of module_platform_driver for lantiq
> based socs.
>=20
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-mtd@lists.infradead.org
> ---
> This patch is part of a series moving the mips/lantiq target to OF and cl=
kdev
> support. The patch, once Acked, should go upstream via Ralf's MIPS tree.

Looks ok, but could you please send me the entire series anyway, may be
privately. I want to feed it to aiaiai and check before acking this
patch. Also, please, make sure you add dependency on OF in Kconfig.

--=20
Best Regards,
Artem Bityutskiy

--=-Br6LUzRPYqcySERHclUK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPrRzpAAoJECmIfjd9wqK0unIP/jY4ohepbSULOEHDADQaGi7Q
2nypFAYH75c6qsugGGUo7sdWWdmwDuced3N4HvzdX6EjCRcfFaQZMhOR27NYLrxA
S+Tm3JHVgXBwuIuvsaLiKEiULQqTXBMyjSEdXJf2/fH/SRtv7xtkJzCkUYljk7Aq
mnvpClwQQG7tsk0rsHRbqNevfgPHj7puA3ppImGSg/IR0TBT/qm+t17h85K78HBY
/7Zj8HdljeuiBj2e/6YtHSYZu1ba7Bhx60P5IowWyuWBNwPAgXYDbjbZrn2kRw5I
kDVZTcBF4zLZtim//XE13pPIskVywlsw4ahijEu29bz+zQIF3ReNZzukv3gj4W0Q
N3+Tdyr8+S7HEe9KmgGmgF2GTPNjHB5BJkqlsA87orH1H9p+OMAVCEgIwxJxORU+
M3DbQMuEqbsIqi4ffkwZgaE4cCxfpPDMjQjeAVznOu38CXybs3BTiDaj0h+QNHRH
AKJ6ZwN+fqU+4JtKtrR2w2SEhPe/oUBd1DB0uUHloumPoSv2UCZrR8FgNlNxAuA6
y7D2nnt47wER3oL8uY5VSL4Kk/J5jD0JDWyGJeqURX6o3ZeyAzHRsmvebR4142wS
t905w+8y4unGprQCbQJa1dhMALbhVjB0555Ume95RPvHdLislCVrezKB69Fjd1Kq
XrCDFsD+V+9oEirRioym
=TFFa
-----END PGP SIGNATURE-----

--=-Br6LUzRPYqcySERHclUK--
