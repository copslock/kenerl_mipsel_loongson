Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2003 12:28:25 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.186]:37325
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225339AbTKZM2N>; Wed, 26 Nov 2003 12:28:13 +0000
Received: from [212.227.126.208] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1AOymB-0007NM-00
	for linux-mips@linux-mips.org; Wed, 26 Nov 2003 13:28:11 +0100
Received: from [80.129.142.67] (helo=create.4g)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1AOymB-0004ZP-00
	for linux-mips@linux-mips.org; Wed, 26 Nov 2003 13:28:11 +0100
From: Bruno Randolf <bruno.randolf@4g-systems.biz>
Organization: 4G Mobile Systeme
To: linux-mips@linux-mips.org
Subject: au1000_eth LEDs for mtx-1
Date: Wed, 26 Nov 2003 13:28:10 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_axJx/6DN8y7sQyC"
Message-Id: <200311261328.10840.bruno.randolf@4g-systems.biz>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:d41044fba7cf33548d8f98fdbdd6d515
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips


--Boundary-00=_axJx/6DN8y7sQyC
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi again!

please also consider this small patch for enabling the traffic indication L=
EDs=20
of au1000_eth for the mtx-1 board.

thanks!

bruno

=2D --=20
4G Systeme GmbH
Am Sandtorkai 71
20457 Hamburg
fon: +49 (0)40 / 48 40 33 28
fax: +49 (0)40 / 48 40 33 30
mail: bruno.randolf@4g-systems.biz
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/xJxafg2jtUL97G4RAuBTAJ9eujYeu4T8Vuo5sAmRTx6ARg6W4QCfQYbo
LhHUKTKuMQwfgkJu62nTsF0=3D
=3DauPq
=2D----END PGP SIGNATURE-----

--Boundary-00=_axJx/6DN8y7sQyC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="au1000_mtx_led.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="au1000_mtx_led.diff"

--- /data/kernel/mips-2.4.23-rc5/drivers/net/au1000_eth.c	2003-11-26 10:51:55.000000000 +0100
+++ drivers/net/au1000_eth.c	2003-11-26 13:16:26.000000000 +0100
@@ -241,7 +241,11 @@
 	mdelay(1);
 
 	/* set up LEDs to correct display */
+#ifdef CONFIG_MIPS_MTX1
+	mdio_write(dev, phy_addr, 17, 0xff80);
+#else
 	mdio_write(dev, phy_addr, 17, 0xffc0);
+#endif
 
 	if (au1000_debug > 4)
 		dump_mii(dev, phy_addr);

--Boundary-00=_axJx/6DN8y7sQyC--
