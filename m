Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 15:23:58 +0000 (GMT)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:45330 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8225192AbUKWPXw>;
	Tue, 23 Nov 2004 15:23:52 +0000
Received: from ip6-localhost ([193.170.141.4]) by grey.subnet.at ; Tue, 23 Nov 2004 16:23:43 +0100
From: Bruno Randolf <bruno.randolf@4g-systems.biz>
To: linux-mips@linux-mips.org
Subject: patch: au1000 eth link detection
Date: Tue, 23 Nov 2004 16:15:49 +0100
User-Agent: KMail/1.7.1
Organization: 4G Systems
Cc: riemer@fokus.fraunhofer.de
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3595760.g9uP9RKyPt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411231615.53154.bruno.randolf@4g-systems.biz>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

--nextPart3595760.g9uP9RKyPt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hello!

this is actually bjoern riemer's patch, in a better diff format, which i ho=
pe=20
you will accept. it adds the "link beat detection" ioctls to the au1000=20
ethernet driver to make it work with ifplugd.

bruno

=2D-- linux/drivers/net/au1000_eth.c.orig 2004-11-23 12:01:00.551663672 +01=
00
+++ linux/drivers/net/au1000_eth.c 2004-11-23 12:08:36.795304096 +0100
@@ -6,7 +6,9 @@
  * Copyright 2002 TimeSys Corp.
  * Author: MontaVista Software, Inc.
  *          ppopov@mvista.com or source@mvista.com
=2D *
+ *         Bjoern Riemer 2004
+ *           riemer@fokus.fraunhofer.de or riemer@riemer-nt.de
+ *             // fixed the link beat detection with ioctls (SIOCGMIIPHY)
  * ########################################################################
  *
  *  This program is free software; you can distribute it and/or modify it
@@ -1383,6 +1385,10 @@
  aup->phy_ops->phy_status(dev, aup->phy_addr, &link, &speed);
  control =3D MAC_DISABLE_RX_OWN | MAC_RX_ENABLE | MAC_TX_ENABLE;
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
+ /*riemer: fix for startup without cable */
+ if (!link)=20
+  dev->flags &=3D ~IFF_RUNNING;
+
  control |=3D MAC_BIG_ENDIAN;
 #endif
  if (link && (dev->if_port =3D=3D IF_PORT_100BASEFX)) {
@@ -1841,17 +1847,35 @@
=20
 static int au1000_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
=2D //u16 *data =3D (u16 *)&rq->ifr_data;
+/*
+// This structure is used in all SIOCxMIIxxx ioctl calls=20
+struct mii_ioctl_data {
+ 0      u16             phy_id;
+ 1      u16             reg_num;
+ 2      u16             val_in;
+ 3      u16             val_out;
+};*/
+ u16 *data =3D (u16 *)&rq->ifr_data;
+ struct au1000_private *aup =3D (struct au1000_private *) dev->priv;
+ //struct mii_ioctl_data *data =3D (struct mii_ioctl_data *) & rq->ifr_dat=
a;
=20
  /* fixme */
  switch(cmd) {=20
   case SIOCDEVPRIVATE: /* Get the address of the PHY in use. */
=2D  //data[0] =3D PHY_ADDRESS;
+  case SIOCGMIIPHY:
+          if (!netif_running(dev))
+                  return -EINVAL;
+   data[0] =3D aup->phy_addr;
   case SIOCDEVPRIVATE+1: /* Read the specified MII register. */
=2D  //data[3] =3D mdio_read(ioaddr, data[0], data[1]);=20
+  case SIOCGMIIREG:
+   data[3] =3D  mdio_read(dev, data[0], data[1]);=20
+   //data->val_out =3D mdio_read(dev,data->phy_id,data->reg_num);
   return 0;
   case SIOCDEVPRIVATE+2: /* Write the specified MII register */
=2D  //mdio_write(ioaddr, data[0], data[1], data[2]);
+  case SIOCSMIIREG:=20
+   if (!capable(CAP_NET_ADMIN))
+    return -EPERM;
+   mdio_write(dev, data[0], data[1],data[2]);
   return 0;
   default:
   return -EOPNOTSUPP;

--nextPart3595760.g9uP9RKyPt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBo1Qpfg2jtUL97G4RAq40AJ4/PrdBQ8uc9kEV/V8eUF7a9xOlXACcDgcZ
eUr64nc2xR9nhszCyDgDuGU=
=GRfk
-----END PGP SIGNATURE-----

--nextPart3595760.g9uP9RKyPt--
