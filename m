Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 14:18:23 +0200 (CEST)
Received: from mga14.intel.com ([143.182.124.37]:51082 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903662Ab2ENMSQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2012 14:18:16 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 14 May 2012 05:18:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; 
   d="asc'?scan'208";a="142814048"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
  by azsmga001.ch.intel.com with ESMTP; 14 May 2012 05:18:07 -0700
Received: from [10.237.72.78] (sauron.fi.intel.com [10.237.72.78])
        by linux.intel.com (Postfix) with ESMTP id A45A42C8001;
        Mon, 14 May 2012 05:18:06 -0700 (PDT)
Message-ID: <1336998094.2528.31.camel@sauron.fi.intel.com>
Subject: Re: [PATCH 12/14] MTD: MIPS: lantiq: implement OF support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org
Date:   Mon, 14 May 2012 15:21:34 +0300
In-Reply-To: <1336133919-26525-12-git-send-email-blogic@openwrt.org>
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org>
         <1336133919-26525-12-git-send-email-blogic@openwrt.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-AFB43rkL+BNkCNzkINHq"
X-Mailer: Evolution 3.2.3 (3.2.3-3.fc16) 
Mime-Version: 1.0
X-archive-position: 33289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


--=-AFB43rkL+BNkCNzkINHq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 14:18 +0200, John Crispin wrote:
> Adds bindings for OF and make use of module_platform_driver for lantiq
> based socs.
>=20
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-mtd@lists.infradead.org

Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

--=20
Best Regards,
Artem Bityutskiy

--=-AFB43rkL+BNkCNzkINHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPsPjOAAoJECmIfjd9wqK0xjoP/2CKbHIzmdJCS4/4hpIgr+b4
CFTcm74C01BprIeOnHmw6vWkMzG3/tug1jLCd/x3ZrvcLVjKB/HHm7DeSm36B0gH
n/enWLsT3zUMPh+p/oWPyJntVRZ73UPDaP0nnFoclI9ns+2hjhoRWMo+B3Vq0HEk
QAkjj0UJvP+QxVkFc5pxpcbGyB8msmHRcNxkpUnvPgNBoP1upLrTxiw9SrY0rOwG
26Iwd1zUrxmHgM/7iGwuFHPTwT3wuOCmRQkvo/I1vQ8+ZLp+OzMn4p7MlCXlsR0j
gFgjYiaRmhJa3tmPNVUHPGC7z/icrqsit3vhZBoeVM3elH3d3kNtx/B1sCmzGdC/
KGdvbIFiR8WMyZx9Ym2qFh9UR1dqc9SJpAURp2kPXRT+6lJwqyUPfz7RnVzdDzDc
ThUJ75IQDxQfelUB2spPW8Of8kUE9QHd2JKR/vutqYhHWRHSG07HQ2u6gTCt/R69
2KZZ0EQw+1WUZwim7HceBYwUKghoa1ni12KknFVquc+puWnzUYMnIDVtz46LgGdN
oyE6XlHQ/BZu4oG+3neHCXWE9K8+po8Ca1ctZ51rbERRF6MAISidro/R/t8dDyDd
FUZKTTr4gVqYdwl9qE5M3Q9/x9oesp9hPZA8hCKMLB+ydgt4M1kpNcNc08Z/Ae8L
x5k0LzCxibJX+LAhBE3X
=Ws/v
-----END PGP SIGNATURE-----

--=-AFB43rkL+BNkCNzkINHq--
