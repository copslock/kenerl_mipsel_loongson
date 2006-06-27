Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2006 16:59:21 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:44998 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133417AbWF0P7M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jun 2006 16:59:12 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FvFtN-0000Pc-69
	for linux-mips@linux-mips.org; Tue, 27 Jun 2006 17:54:21 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FvFy6-0002of-5w
	for linux-mips@linux-mips.org; Tue, 27 Jun 2006 17:59:14 +0200
Date:	Tue, 27 Jun 2006 17:59:14 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060627155914.GD10595@enneenne.com>
References: <20060626221441.GA10595@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Content-Disposition: inline
In-Reply-To: <20060626221441.GA10595@enneenne.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: au1000_lowlevel_probe on au1000_eth.c
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--Ls2Gy6y7jbHLe9Od
Content-Type: multipart/mixed; boundary="IU5/I01NYhRvwH70"
Content-Disposition: inline


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2006 at 12:14:41AM +0200, Rodolfo Giometti wrote:
>=20
> I notice that during sleep/wakeup au1000_lowlevel_probe() tries to
> access to variables arcs_cmdline,prom_envp & Co.. This sometime does
> an oops.

Here my proposal to avoid oops during wake up.

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1000_eth-pm-bugfix
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
index 341fdc4..c49004a 100644
--- a/drivers/net/au1000_eth.c
+++ b/drivers/net/au1000_eth.c
@@ -84,7 +84,7 @@ MODULE_LICENSE("GPL");
 // prototypes
 static void hard_stop(struct net_device *);
 static void enable_rx_tx(struct net_device *dev);
-static int au1000_lowlevel_probe(struct net_device *ndev, void *ioaddr, vo=
id *macen_addr, int port_num);
+static int au1000_lowlevel_probe(struct net_device *ndev, void *ioaddr, vo=
id *macen_addr, int port_num, int skip_prom);
 static void au1000_lowlevel_remove(struct net_device *ndev);
 static int au1000_init(struct net_device *);
 static int au1000_open(struct net_device *);
@@ -1393,7 +1393,7 @@ static struct ethtool_ops au1000_ethtool
 };
=20
 static int=20
-au1000_lowlevel_probe(struct net_device *ndev, void *ioaddr, void *macen_a=
ddr, int port_num)
+au1000_lowlevel_probe(struct net_device *ndev, void *ioaddr, void *macen_a=
ddr, int port_num, int skip_prom)
 {
 	struct au1000_private *aup =3D ndev->priv;
 	db_dest_t *pDB, *pDBfree;
@@ -1419,24 +1419,25 @@ au1000_lowlevel_probe(struct net_device=20
 	/* Setup some variables for quick register address access */
 	if (port_num =3D=3D 0)
 	{
-		/* check env variables first */
-		if (!get_ethernet_addr(ethaddr)) {=20
-			memcpy(au1000_mac_addr, ethaddr, sizeof(au1000_mac_addr));
-		} else {
-			/* Check command line */
-			argptr =3D prom_getcmdline();
-			if ((pmac =3D strstr(argptr, "ethaddr=3D")) =3D=3D NULL) {
-				printk(KERN_INFO "%s: No mac address found\n",=20
-						ndev->name);
-				/* use the hard coded mac addresses */
+		if (!skip_prom) {
+			/* check env variables first */
+			if (!get_ethernet_addr(ethaddr)) {=20
+				memcpy(au1000_mac_addr, ethaddr, sizeof(au1000_mac_addr));
 			} else {
-				str2eaddr(ethaddr, pmac + strlen("ethaddr=3D"));
-				memcpy(au1000_mac_addr, ethaddr,=20
-						sizeof(au1000_mac_addr));
+				/* Check command line */
+				argptr =3D prom_getcmdline();
+				if ((pmac =3D strstr(argptr, "ethaddr=3D")) =3D=3D NULL) {
+					printk(KERN_INFO "%s: No mac address found\n",=20
+							ndev->name);
+					/* use the hard coded mac addresses */
+				} else {
+					str2eaddr(ethaddr, pmac + strlen("ethaddr=3D"));
+					memcpy(au1000_mac_addr, ethaddr,=20
+							sizeof(au1000_mac_addr));
+				}
 			}
 		}
-			aup->enable =3D (volatile u32 *)=20
-				((unsigned long) macen_addr);
+		aup->enable =3D (volatile u32 *) ((unsigned long) macen_addr);
 		memcpy(ndev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
 		setup_hw_rings(aup, MAC0_RX_DMA_ADDR, MAC0_TX_DMA_ADDR);
 		aup->mac_id =3D 0;
@@ -2196,7 +2197,7 @@ static int au1000_drv_probe(struct devic
=20
 	/* Force the device name to a know state... */
 	sprintf(ndev->name, "au1xxx_eth(%d)", pdev->id);
-	ret =3D au1000_lowlevel_probe(ndev, base_addr, macen_addr, pdev->id);
+	ret =3D au1000_lowlevel_probe(ndev, base_addr, macen_addr, pdev->id, 0);
 	if (ret < 0) {
 		printk (KERN_ERR "%s: low level probe failed\n", DRV_NAME); =20
 		goto out_free_netdev;
@@ -2304,7 +2305,7 @@ static int au1000_drv_resume(struct devi
 	if (!ndev)
 		return 0;
=20
-	ret =3D au1000_lowlevel_probe(ndev, (void *) aup->mac, (void *) aup->enab=
le, aup->mac_id);
+	ret =3D au1000_lowlevel_probe(ndev, (void *) aup->mac, (void *) aup->enab=
le, aup->mac_id, ~0);
 	if (ret < 0) {
 		printk (KERN_ERR "%s: low level probe failed\n", DRV_NAME); =20
 		return ret;

--IU5/I01NYhRvwH70--

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEoVXSQaTCYNJaVjMRArAqAKCH6EDPvgWf2Tst3kdXSm0Wh3WycwCdHqQz
LCdR7pGNOpM7zyPYmFLrRko=
=/Pt4
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--
