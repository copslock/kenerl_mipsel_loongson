Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2005 05:19:41 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:57560 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S8133576AbVLEFTJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2005 05:19:09 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Sun, 04 Dec 2005 21:18:40 -0800
  id 00098008.4393CDB1.00007037
Message-ID: <4393CD9F.3090305@jg555.com>
Date:	Sun, 04 Dec 2005 21:18:23 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_server-28727-1133759921-0001-2"
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Tulip RaQ2 64 Bit Fix
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_server-28727-1133759921-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch allows the tulip driver to work with the RaQ2's 
network adapter. Without the patch under a 64 bit build, it will never 
negotiate and will drop packets. This driver is part of Linux Parisc, by 
Grant Grundler. It's currently in -mm, but Jeff Garzick will not apply 
it to the main tree.

When Grant modified this driver, he used the manufactures specs on the 
tulip chip.


-- 
----
Jim Gifford
maillist@jg555.com


--=_server-28727-1133759921-0001-2
Content-Type: text/x-diff; name="tulip.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tulip.patch"

diff -Naur linux-mips-2.6.14.orig/drivers/net/tulip/21142.c linux-mips-2.6.14/drivers/net/tulip/21142.c
--- linux-mips-2.6.14.orig/drivers/net/tulip/21142.c	2005-11-17 11:43:12.000000000 -0800
+++ linux-mips-2.6.14/drivers/net/tulip/21142.c	2005-11-17 21:52:47.000000000 -0800
@@ -172,7 +172,7 @@
 			int i;
 			for (i = 0; i < tp->mtable->leafcount; i++)
 				if (tp->mtable->mleaf[i].media == dev->if_port) {
-					int startup = ! ((tp->chip_id == DC21143 && (tp->revision == 48 || tp->revision == 65)));
+					int startup = ! ((tp->chip_id == DC21143 && tp->revision == 65));
 					tp->cur_index = i;
 					tulip_select_media(dev, startup);
 					setup_done = 1;
diff -Naur linux-mips-2.6.14.orig/drivers/net/tulip/media.c linux-mips-2.6.14/drivers/net/tulip/media.c
--- linux-mips-2.6.14.orig/drivers/net/tulip/media.c	2005-11-17 11:43:13.000000000 -0800
+++ linux-mips-2.6.14/drivers/net/tulip/media.c	2005-11-17 21:52:47.000000000 -0800
@@ -44,8 +44,10 @@
 
 /* MII transceiver control section.
    Read and write the MII registers using software-generated serial
-   MDIO protocol.  See the MII specifications or DP83840A data sheet
-   for details. */
+   MDIO protocol.
+   See IEEE 802.3-2002.pdf (Section 2, Chapter "22.2.4 Management functions")
+   or DP83840A data sheet for more details.
+   */
 
 int tulip_mdio_read(struct net_device *dev, int phy_id, int location)
 {
@@ -261,24 +263,56 @@
 				u16 *reset_sequence = &((u16*)(p+3))[init_length];
 				int reset_length = p[2 + init_length*2];
 				misc_info = reset_sequence + reset_length;
-				if (startup)
+				if (startup) {
+					int timeout = 10;	/* max 1 ms */
 					for (i = 0; i < reset_length; i++)
 						iowrite32(get_u16(&reset_sequence[i]) << 16, ioaddr + CSR15);
+				
+					/* flush posted writes */
+					ioread32(ioaddr + CSR15);
+
+					/* Sect 3.10.3 in DP83840A.pdf (p39) */
+					udelay(500);
+
+					/* Section 4.2 in DP83840A.pdf (p43) */
+					/* and IEEE 802.3 "22.2.4.1.1 Reset" */
+					while (timeout-- &&
+						(tulip_mdio_read (dev, phy_num, MII_BMCR) & BMCR_RESET))
+						udelay(100);
+				}
 				for (i = 0; i < init_length; i++)
 					iowrite32(get_u16(&init_sequence[i]) << 16, ioaddr + CSR15);
+
+				ioread32(ioaddr + CSR15);	/* flush posted writes */
 			} else {
 				u8 *init_sequence = p + 2;
 				u8 *reset_sequence = p + 3 + init_length;
 				int reset_length = p[2 + init_length];
 				misc_info = (u16*)(reset_sequence + reset_length);
 				if (startup) {
+					int timeout = 10;	/* max 1 ms */
 					iowrite32(mtable->csr12dir | 0x100, ioaddr + CSR12);
 					for (i = 0; i < reset_length; i++)
 						iowrite32(reset_sequence[i], ioaddr + CSR12);
+
+					/* flush posted writes */
+					ioread32(ioaddr + CSR12);
+
+					/* Sect 3.10.3 in DP83840A.pdf (p39) */
+					udelay(500);
+
+					/* Section 4.2 in DP83840A.pdf (p43) */
+					/* and IEEE 802.3 "22.2.4.1.1 Reset" */
+					while (timeout-- &&
+						(tulip_mdio_read (dev, phy_num, MII_BMCR) & BMCR_RESET))
+						udelay(100);
 				}
 				for (i = 0; i < init_length; i++)
 					iowrite32(init_sequence[i], ioaddr + CSR12);
+
+				ioread32(ioaddr + CSR12);	/* flush posted writes */
 			}
+
 			tmp_info = get_u16(&misc_info[1]);
 			if (tmp_info)
 				tp->advertising[phy_num] = tmp_info | 1;
diff -Naur linux-mips-2.6.14.orig/drivers/net/tulip/tulip_core.c linux-mips-2.6.14/drivers/net/tulip/tulip_core.c
--- linux-mips-2.6.14.orig/drivers/net/tulip/tulip_core.c	2005-11-17 11:43:13.000000000 -0800
+++ linux-mips-2.6.14/drivers/net/tulip/tulip_core.c	2005-11-17 21:52:47.000000000 -0800
@@ -22,7 +22,7 @@
 #else
 #define DRV_VERSION	"1.1.13"
 #endif
-#define DRV_RELDATE	"May 11, 2002"
+#define DRV_RELDATE	"December 15, 2004"
 
 
 #include <linux/module.h>
@@ -148,7 +148,7 @@
 	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM | HAS_PCI_MWI, tulip_timer },
 
   /* DC21142, DC21143 */
-  { "Digital DS21143 Tulip", 128, 0x0801fbff,
+  { "Digital DS21142/DS21143 Tulip", 128, 0x0801fbff,
 	HAS_MII | HAS_MEDIA_TABLE | ALWAYS_CHECK_MII | HAS_ACPI | HAS_NWAY
 	| HAS_INTR_MITIGATION | HAS_PCI_MWI, t21142_timer },
 
diff -Naur linux-mips-2.6.14.orig/drivers/net/tulip/tulip.h linux-mips-2.6.14/drivers/net/tulip/tulip.h
--- linux-mips-2.6.14.orig/drivers/net/tulip/tulip.h	2005-11-17 11:43:13.000000000 -0800
+++ linux-mips-2.6.14/drivers/net/tulip/tulip.h	2005-11-17 21:52:47.000000000 -0800
@@ -474,8 +474,11 @@
 			udelay(10);
 
 		if (!i)
-			printk(KERN_DEBUG "%s: tulip_stop_rxtx() failed\n",
-					pci_name(tp->pdev));
+			printk(KERN_DEBUG "%s: tulip_stop_rxtx() failed"
+					" (CSR5 0x%x CSR6 0x%x)\n",
+					pci_name(tp->pdev),
+					ioread32(ioaddr + CSR5),
+					ioread32(ioaddr + CSR6));
 	}
 }
 

--=_server-28727-1133759921-0001-2--
