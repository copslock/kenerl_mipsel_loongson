Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2006 16:38:49 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:65429 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133522AbWDFPii (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Apr 2006 16:38:38 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FRWhj-0000aJ-RX; Thu, 06 Apr 2006 17:47:28 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FRWkN-0007k4-Q3; Thu, 06 Apr 2006 17:50:11 +0200
Date:	Thu, 6 Apr 2006 17:50:11 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Linux MIPS <linux-mips@linux-mips.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Jordan Crouse <jordan.crouse@amd.com>,
	Pete Popov <ppopov@embeddedalley.com>
Message-ID: <20060406155011.GC23424@enneenne.com>
References: <20060405154711.GL7029@enneenne.com> <20060405222332.GO7029@enneenne.com> <20060405222620.GP7029@enneenne.com> <4435290C.50607@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline
In-Reply-To: <4435290C.50607@ru.mvista.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: [PATCH] Oops! - Re: Power management for au1000_eth.c
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--oFbHfjnMgUMsrGjO
Content-Type: multipart/mixed; boundary="lteA1dqeVaWQ9QQl"
Content-Disposition: inline


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2006 at 06:43:24PM +0400, Sergei Shtylyov wrote:
>=20
>    Actually, the network driver patches should be sent to Jeff Garzik and=
=20
> Andrew Morton.

Ok. Sorry. Hope they can get the patch from this list.

>    Funny, I've also been cooking a patch to straighten Alchemy Ethernet=
=20
> probing code a bit...

:)

> >------------------------------------------------------------------------
> >
> >---=20
> >/home/develop/embedded/mipsel/linux/linux-mips.git/arch/mips/au1000/comm=
on/au1xxx_irqmap.c	2006-03-31 16:57:26.000000000 +0200
> >+++ arch/mips/au1000/common/au1xxx_irqmap.c	2006-04-03=20
> >17:50:49.000000000 +0200
> >@@ -118,7 +118,7 @@
> > 	{ AU1000_USB_DEV_SUS_INT, INTC_INT_RISE_EDGE, 0 },
> > 	{ AU1000_USB_HOST_INT, INTC_INT_LOW_LEVEL, 0 },
> > 	{ AU1000_ACSYNC_INT, INTC_INT_RISE_EDGE, 0 },
> >-	{ AU1500_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
> >+	{ AU1000_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
> > 	{ AU1500_MAC1_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
> > 	{ AU1000_AC97C_INT, INTC_INT_RISE_EDGE, 0 },
> >=20
> >@@ -152,7 +152,7 @@
> > 	{ AU1000_USB_DEV_SUS_INT, INTC_INT_RISE_EDGE, 0 },
> > 	{ AU1000_USB_HOST_INT, INTC_INT_LOW_LEVEL, 0 },
> > 	{ AU1000_ACSYNC_INT, INTC_INT_RISE_EDGE, 0 },
> >-	{ AU1100_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
> >+	{ AU1000_MAC0_DMA_INT, INTC_INT_HIGH_LEVEL, 0},
> > 	/*{ AU1000_GPIO215_208_INT, INTC_INT_HIGH_LEVEL, 0},*/
> > 	{ AU1100_LCD_INT, INTC_INT_HIGH_LEVEL, 0},
> > 	{ AU1000_AC97C_INT, INTC_INT_RISE_EDGE, 0 },
>=20
>    Don't think these changes are necessary.

These are necessary to group togheter CPUs that have the same
parameters.

> >---=20
> >/home/develop/embedded/mipsel/linux/linux-mips.git/arch/mips/au1000/comm=
on/platform.c	2006-04-03 18:22:05.000000000 +0200
> >+++ arch/mips/au1000/common/platform.c	2006-04-05=20
> >23:08:55.000000000 +0200
> >@@ -16,6 +16,78 @@
> >=20
> > #include <asm/mach-au1x00/au1xxx.h>
> >=20
> >+#if defined(CONFIG_MIPS_AU1X00_ENET) ||=20
> >defined(CONFIG_MIPS_AU1X00_ENET_MODULE)
> >+/* Ethernet controllers */
> >+static struct resource au1xxx_eth0_resources[] =3D {
> >+	[0] =3D {
> >+		.name	=3D "eth-base",
> >+		.start	=3D ETH0_BASE,
> >+		.end	=3D ETH0_BASE + 0x0ffff,
> > +		.flags	=3D IORESOURCE_MEM,
> > +	},
>=20
>    NAK, ETH0_BASE not defined anywhere, and that address differs between=
=20
>    SOCs.
> Note that this must be a *physical* address, not KSEG1-base.

You are right! I forgot to add the attached file... I'm very sorry but
I must work on an older Linux version which still use CVS. I can't
switch to GIT right now and I have to build my patches by hands.

In the attached file you can see that I grouped togheter CPUs that
have the same configuration parameters.

> > 	/* Setup some variables for quick register address access */
> >-	if (ioaddr =3D=3D iflist[0].base_addr)
> >+	if (port_num =3D=3D 0)
>=20
>    Yep, I disliked this code too. :-)

I just use the "id" filed instaed of using the base address. It seems
to me more readable...

> > 	{
> > 		/* check env variables first */
> > 		if (!get_ethernet_addr(ethaddr)) {=20
> >@@ -1495,7 +1426,7 @@
> > 			argptr =3D prom_getcmdline();
> > 			if ((pmac =3D strstr(argptr, "ethaddr=3D")) =3D=3D NULL) {
> > 				printk(KERN_INFO "%s: No mac address=20
> > 				found\n", -						dev->name);
> >+						ndev->name);
> > 				/* use the hard coded mac addresses */
> > 			} else {
> > 				str2eaddr(ethaddr, pmac +=20
> > 				strlen("ethaddr=3D"));
> >@@ -1504,26 +1435,26 @@
> > 			}
> > 		}
> > 			aup->enable =3D (volatile u32 *)=20
> >-				((unsigned long)iflist[0].macen_addr);
> >-		memcpy(dev->dev_addr, au1000_mac_addr,=20
> >sizeof(au1000_mac_addr));
> >+				((unsigned long) macen_addr);
>=20
>    NAK, macen_addr should have been a physical address at that point too
> (if the plarform definitions were correct :-).  Also, this could have bee=
n=20
> done
> outside of "if".

I just keeped the original structure...

> > 		setup_hw_rings(aup, MAC0_RX_DMA_ADDR, MAC0_TX_DMA_ADDR);
> > 		aup->mac_id =3D 0;
> > 		au_macs[0] =3D aup;
> > 	}
> > 		else
> >-	if (ioaddr =3D=3D iflist[1].base_addr)
> >+	if (port_num =3D=3D 1)
> > 	{
> > 			aup->enable =3D (volatile u32 *)=20
> >-				((unsigned long)iflist[1].macen_addr);
> >-		memcpy(dev->dev_addr, au1000_mac_addr,=20
> >sizeof(au1000_mac_addr));
> >-		dev->dev_addr[4] +=3D 0x10;
> >+				((unsigned long) macen_addr);
> >+		memcpy(ndev->dev_addr, au1000_mac_addr,=20
> >sizeof(au1000_mac_addr));
> >+		ndev->dev_addr[4] +=3D 0x10;
>=20
>    Actually, the DBAu15x0 boards have their Ethernet addresess differ by =
1=20
>    in the last byte, not by 0x10 in the next to last one. This code assig=
ns to=20
> the port an address different to what's printed on a port's sticker. This=
=20
> should be fixed I guess...

Yes. However this comes from the previous driver version and I'm
working on an Au1100 based board. :)

> >@@ -2255,5 +2162,232 @@
> > 	return 0;
> > }
> >=20
> >-module_init(au1000_init_module);
> >-module_exit(au1000_cleanup_module);
> >+/*
> >+ * Setup the base address and interupt of the Au1xxx ethernet macs
> >+ * based on cpu type and whether the interface is enabled in sys_pinfunc
> >+ * register. The last interface is enabled if SYS_PF_NI2 (bit 4) is 0.
> >+ */
> >+static int au1000_drv_probe(struct device *dev)
> >+{
> >+	struct platform_device *pdev =3D to_platform_device(dev);
> >+	struct net_device *ndev;
> >+	struct au1000_private *aup;
> >+	struct resource *res;
> >+	static unsigned version_printed =3D 0;
> >+	u32 base_addr, macen_addr;
> >+	int irq, ret;
> >+
> >+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "eth-base");
> >+	if (!res) {
> >+		ret =3D -ENODEV;
> >+		goto out;
> >+	}
> >+	base_addr =3D res->start;
> >+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "eth-mac");
> >+	if (!res) {
> >+		ret =3D -ENODEV;
> >+		goto out;
> >+	}
> >+	macen_addr =3D res->start;
> >+	res =3D platform_get_resource_byname(pdev, IORESOURCE_IRQ, "eth-irq");
> >+	if (!res) {
> >+		ret =3D -ENODEV;
> >+		goto out;
> >+	}
> >+	irq =3D res->start;
> >+
> >+	if (!request_mem_region(CPHYSADDR(base_addr), MAC_IOSIZE, "Au1x00=20
> >ENET")) {
>=20
>    NAK, base_addr should adready be a physical address. Also, why no=20
> request_mem_region()
> for the MAC enable register?

Yes. I forgot to add it.

Thanks for your suggestions! But I'd like to know if I have to change
something and resubmit the patch or these suggestions can be resolved
during the merging of the code...

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1000_eth-pm-2
Content-Transfer-Encoding: quoted-printable

--- /home/develop/embedded/mipsel/linux/linux-mips.git/include/asm-mips/mac=
h-au1x00/au1000.h	2006-04-03 18:24:38.000000000 +0200
+++ include/asm-mips/mach-au1x00/au1000.h	2006-04-06 17:31:04.000000000 +02=
00
@@ -606,11 +690,10 @@
 #define USB_OHCI_BASE             0x10100000 // phys addr for ioremap
 #define USB_HOST_CONFIG           0xB017fffc
=20
-#define AU1000_ETH0_BASE      0xB0500000
-#define AU1000_ETH1_BASE      0xB0510000
-#define AU1000_MAC0_ENABLE       0xB0520000
-#define AU1000_MAC1_ENABLE       0xB0520004
-#define NUM_ETH_INTERFACES 2
+#define ETH0_BASE		  0xB0500000
+#define ETH1_BASE		  0xB0510000
+#define MAC0_ENABLE		  0xB0520000
+#define MAC1_ENABLE		  0xB0520004
 #endif /* CONFIG_SOC_AU1000 */
=20
 /* Au1500 */
@@ -635,8 +718,8 @@
 #define AU1000_USB_DEV_SUS_INT    25
 #define AU1000_USB_HOST_INT       26
 #define AU1000_ACSYNC_INT         27
-#define AU1500_MAC0_DMA_INT       28
-#define AU1500_MAC1_DMA_INT       29
+#define AU1000_MAC0_DMA_INT       28
+#define AU1000_MAC1_DMA_INT       29
 #define AU1000_AC97C_INT          31
 #define AU1000_GPIO_0             32
 #define AU1000_GPIO_1             33
@@ -683,11 +766,10 @@
 #define USB_OHCI_BASE             0x10100000 // phys addr for ioremap
 #define USB_HOST_CONFIG           0xB017fffc
=20
-#define AU1500_ETH0_BASE	  0xB1500000
-#define AU1500_ETH1_BASE	  0xB1510000
-#define AU1500_MAC0_ENABLE       0xB1520000
-#define AU1500_MAC1_ENABLE       0xB1520004
-#define NUM_ETH_INTERFACES 2
+#define ETH0_BASE		  0xB1500000
+#define ETH1_BASE		  0xB1510000
+#define MAC0_ENABLE		  0xB1520000
+#define MAC1_ENABLE		  0xB1520004
 #endif /* CONFIG_SOC_AU1500 */
=20
 /* Au1100 */
@@ -713,8 +795,8 @@
 #define AU1000_USB_DEV_SUS_INT    25
 #define AU1000_USB_HOST_INT       26
 #define AU1000_ACSYNC_INT         27
-#define AU1100_MAC0_DMA_INT       28
-#define	AU1100_GPIO_208_215	29
+#define AU1000_MAC0_DMA_INT	  28
+#define	AU1100_GPIO_208_215	  29
 #define	AU1100_LCD_INT            30
 #define AU1000_AC97C_INT          31
 #define AU1000_GPIO_0             32
@@ -757,8 +839,8 @@
 #define USB_OHCI_BASE             0x10100000 // phys addr for ioremap
 #define USB_HOST_CONFIG           0xB017fffc
=20
-#define AU1100_ETH0_BASE	  0xB0500000
-#define AU1100_MAC0_ENABLE       0xB0520000
+#define ETH0_BASE		  0xB0500000
+#define MAC0_ENABLE		  0xB0520000
 #define NUM_ETH_INTERFACES 1
 #endif /* CONFIG_SOC_AU1100 */
=20
@@ -841,11 +923,10 @@
 #define USB_OHCI_LEN              0x00060000
 #define USB_HOST_CONFIG           0xB4027ffc
=20
-#define AU1550_ETH0_BASE      0xB0500000
-#define AU1550_ETH1_BASE      0xB0510000
-#define AU1550_MAC0_ENABLE       0xB0520000
-#define AU1550_MAC1_ENABLE       0xB0520004
-#define NUM_ETH_INTERFACES 2
+#define ETH0_BASE		  0xB0500000
+#define ETH1_BASE		  0xB0510000
+#define MAC0_ENABLE		  0xB0520000
+#define MAC1_ENABLE		  0xB0520004
 #endif /* CONFIG_SOC_AU1550 */
=20
 #ifdef CONFIG_SOC_AU1200

--lteA1dqeVaWQ9QQl--

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFENTizQaTCYNJaVjMRAqniAJ9Kr93sG5XQVi9foA/S4H1ts33J+wCgh7mh
YFvvcmOOa1dVrmX2DfK/8I0=
=s3LV
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
