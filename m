Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 13:18:36 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:28764 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903640Ab2EHLSb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 13:18:31 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 08 May 2012 04:18:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; 
   d="asc'?scan'208";a="163362518"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2012 04:18:24 -0700
Received: from [10.237.72.159] (sauron.fi.intel.com [10.237.72.159])
        by linux.intel.com (Postfix) with ESMTP id 7CBD96A4008;
        Tue,  8 May 2012 04:18:23 -0700 (PDT)
Message-ID: <1336476107.23308.31.camel@sauron.fi.intel.com>
Subject: Re: xway_nand does not build
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <blogic@openwrt.org>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Date:   Tue, 08 May 2012 14:21:47 +0300
In-Reply-To: <4FA8FF4C.5050400@openwrt.org>
References: <1336474838.23308.28.camel@sauron.fi.intel.com>
                 <4FA8FD24.6060908@openwrt.org>
         <1336475618.23308.30.camel@sauron.fi.intel.com>
         <4FA8FF4C.5050400@openwrt.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-cQdinkxw5GsU3SC3EaA6"
X-Mailer: Evolution 3.2.3 (3.2.3-3.fc16) 
Mime-Version: 1.0
X-archive-position: 33194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


--=-cQdinkxw5GsU3SC3EaA6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-08 at 13:11 +0200, John Crispin wrote:
> > OK, so I should drop this patch from l2-mtd.git:
> >
> > commit e4445062be41c27b2a0b4f2e1e770d24b68686f4
> > Author: John Crispin <blogic@openwrt.org>
> > Date:   Mon Apr 30 19:30:48 2012 +0200
> >
> >     mtd: mips: lantiq: add xway nand support
> >    =20
> >     Add NAND support on Lantiq XWAY SoC.
> >    =20
> >     The driver uses plat_nand. As the platform_device is loaded from DT=
, we need
> >     to lookup the node and attach our xway specific "struct platform_na=
nd_data"
> >     to it.
> >    =20
> >     Signed-off-by: John Crispin <blogic@openwrt.org>
> >     Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> >
> > Right?
> Hi,
>=20
> That would be appreciated. i will get aligned with Ralf to make sure
> this patch flow via his tree

OK, dropped. Please, add the OF dependency to the Kconfig yourself then
because I do not have this driver in my tree anymore.

Thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-cQdinkxw5GsU3SC3EaA6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPqQHLAAoJECmIfjd9wqK0PbsP/3jEzYQ3cRR6o81IufDJ8qfe
rV57e0kUp1/peaNg+njd7Yx9CYl/aac/BLszTAAebDG95kgwDePebmHfW1pOyYjs
D4DMu+E3+Sr6AszY/k45yF4eR3aGkgetj5KdaR4KTVXjf5g/nxh0l7aUg6qcrSG+
A5HDyZP98p2vtELN+FV7giEA6jsmrMnt8RYVsqpel3upg9cJQc1r13tgQ2sPYn6V
KLZUr/q4UBF4SPGRflfDyqKiQeyzALymlwgZeDGrmc4oiB8LWg4kwU2o9BWipATW
MU3eCFoi/X+sXzI88UpviFUgu1FSDvkNghbIeZpIcmYeJEu0+MqzfujR/stIK8z7
bEI+/tL5Us4qKGt8aVKgsCV2vXVfWdmMqj0UQKbYAlotXLrfBwdmWevJXt3P6jXk
W75SCZToIFAOKXGoSRjElIbwLjQzbQialAzr7X+OpGrZMUU7EAea2cRXX/FYU7GC
RpgElbFSpGxxEm/HJUJaNYdtuhskDM8fYGfsbqpVEZTwV5yWTDCcc/ndgVsALqb/
T+3+dxoQldPxFfdmOa1Sgd5eIaee3pVQhn7DkJqbqU/fLSsnanqh0B859tIvWr+m
m6XjF1CqdqBGww3iXXMiv2t20qh7xldWeoyhVsLYkqxysHCvNWK7/4BwJwm6V5r4
Csj7OAEW+lCJebnSehRW
=ONlD
-----END PGP SIGNATURE-----

--=-cQdinkxw5GsU3SC3EaA6--
