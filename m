Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2006 09:39:11 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:18879 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20043156AbWHJIjK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Aug 2006 09:39:10 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1GB54w-00061d-L5
	for linux-mips@linux-mips.org; Thu, 10 Aug 2006 09:35:43 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1GB65M-0001E8-QH
	for linux-mips@linux-mips.org; Thu, 10 Aug 2006 10:40:12 +0200
Date:	Thu, 10 Aug 2006 10:40:12 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060810084012.GI13145@enneenne.com>
References: <20060809211243.GH13145@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X+nYw8KZ/oNxZ8JS"
Content-Disposition: inline
In-Reply-To: <20060809211243.GH13145@enneenne.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: [PATCH] 7/7 AU1100 MMC support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--X+nYw8KZ/oNxZ8JS
Content-Type: multipart/mixed; boundary="smOfPzt+Qjm5bNGJ"
Content-Disposition: inline


--smOfPzt+Qjm5bNGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2006 at 11:12:43PM +0200, Rodolfo Giometti wrote:
> Power Management support for AU1100 (PIO mode) added.
>=20
> Signed-off-by: Rodolfo Giometti <giometti@linux.it>

Sorry, I forgot into this patch some debugging messages... :)

Please, use this one instead.

Ciao,

Rodolfo

Signed-off-by: Rodolfo Giometti <giometti@linux.it>

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--smOfPzt+Qjm5bNGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-mmc-pm-au1100
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
index 61acf6b..46b4fa5 100644
--- a/drivers/mmc/au1xmmc.c
+++ b/drivers/mmc/au1xmmc.c
@@ -19,6 +19,10 @@
  *     Rodolfo Giometti <giometti@linux.it>
  *     Eurotech S.p.A. <info@eurotech.it>
=20
+ *  Power Management Support for AU1100 in PIO mode by:
+ *     Rodolfo Giometti <giometti@linux.it>
+ *     Eurotech S.p.A. <info@eurotech.it>
+
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -1086,11 +1090,75 @@ #endif
 	return 0;
 }
=20
+#ifdef CONFIG_PM
+static u32 sd_txport[2];
+static u32 sd_rxport[2];
+static u32 sd_config[2];
+static u32 sd_config2[2];
+static u32 sd_blksize[2];
+static u32 sd_status[2];
+static u32 sd_cmd[2];
+static u32 sd_cmdarg[2];
+static u32 sd_timeout[2];
+
+static int au1xmmc_suspend(struct platform_device *pdev, pm_message_t stat=
e)
+{
+	struct au1xmmc_host *host =3D platform_get_drvdata(pdev);
+	struct mmc_host *mmc =3D host->mmc;
+	int ret =3D 0;
+
+	if (mmc)
+		ret =3D mmc_suspend_host(mmc, state);
+
+	sd_txport[host->id]  =3D au_readl(HOST_TXPORT(host));
+	sd_rxport[host->id]  =3D au_readl(HOST_RXPORT(host));
+	sd_config[host->id]  =3D au_readl(HOST_CONFIG(host));
+	sd_config2[host->id] =3D au_readl(HOST_CONFIG2(host));
+	sd_blksize[host->id] =3D au_readl(HOST_BLKSIZE(host));
+	sd_status[host->id]  =3D au_readl(HOST_STATUS(host));
+	sd_cmd[host->id]     =3D au_readl(HOST_CMD(host));
+	sd_cmdarg[host->id]  =3D au_readl(HOST_CMDARG(host));
+	sd_timeout[host->id] =3D au_readl(HOST_TIMEOUT(host));
+
+	au_writel(0x0, HOST_ENABLE(host));
+
+	return ret;
+}
+
+static int au1xmmc_resume(struct platform_device *pdev)
+{
+	struct au1xmmc_host *host =3D platform_get_drvdata(pdev);
+	struct mmc_host *mmc =3D host->mmc;
+	int ret =3D 0;
+
+	au1xmmc_reset_controller(host);
+
+	au_writel(sd_txport[host->id],  HOST_TXPORT(host));
+	au_writel(sd_rxport[host->id],  HOST_RXPORT(host));
+	au_writel(sd_config[host->id],  HOST_CONFIG(host));
+	au_writel(sd_config2[host->id], HOST_CONFIG2(host));
+	au_writel(sd_blksize[host->id], HOST_BLKSIZE(host));
+	au_writel(sd_status[host->id],  HOST_STATUS(host));
+	au_writel(sd_cmd[host->id],     HOST_CMD(host));
+	au_writel(sd_cmdarg[host->id],  HOST_CMDARG(host));
+	au_writel(sd_timeout[host->id], HOST_TIMEOUT(host));
+
+	if (mmc)
+		ret =3D mmc_resume_host(mmc);
+
+	return ret;
+}
+
+#else
+#define au1xmmc_suspend  NULL
+#define au1xmmc_resume   NULL
+#endif
+
 static struct platform_driver au1xmmc_driver =3D {
 	.probe         =3D au1xmmc_probe,
 	.remove        =3D au1xmmc_remove,
-	.suspend       =3D NULL,
-	.resume        =3D NULL,
+	.suspend       =3D au1xmmc_suspend,
+	.resume        =3D au1xmmc_resume,
 	.driver        =3D {
 		.name  =3D DRIVER_NAME,
 	},

--smOfPzt+Qjm5bNGJ--

--X+nYw8KZ/oNxZ8JS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFE2vDsQaTCYNJaVjMRAmwOAKC88QvquCWspIb/HeDpj4QkU3ytqQCgqoEe
21MJxaX2+Cr5azsdFrMirhQ=
=BPFf
-----END PGP SIGNATURE-----

--X+nYw8KZ/oNxZ8JS--
