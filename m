Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 18:14:39 +0100 (BST)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:44946
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8226126AbVDKROW>;
	Mon, 11 Apr 2005 18:14:22 +0100
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Mon, 11 Apr 2005 10:14:19 -0700
  id 001E0180.425AB06B.00004204
Message-ID: <425AB05B.4010403@jg555.com>
Date:	Mon, 11 Apr 2005 10:14:03 -0700
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_server-16900-1113239659-0001-2"
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: [Patch] : Tulip - fixes compile on MIPS64
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_server-16900-1113239659-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have been working on getting the RaQ2 to build using 64 bit. I ran 
into numerous issues. After I got the kernel to compile, the tulip 
driver didn't work. It kept showing error messages like
tulip_stop_rxtx() failed

This patch fixes the compile issue, this patch was create by Grant 
Grundler of linux-parsic. This patch matches the tulip driver follow the 
specs laid out by the manufacture. On 32 bit this patch seemed to make 
the tulip more responsive on my RaQ2 systems.


-- 
----
Jim Gifford
maillist@jg555.com


--=_server-16900-1113239659-0001-2
Content-Type: text/x-diff; name="tulip-mips.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tulip-mips.patch"

diff -Naurp linux.orig/drivers/net/tulip/de2104x.c linux/drivers/net/tulip/de2104x.c
--- linux.orig/drivers/net/tulip/de2104x.c	2005-03-18 09:37:38.000000000 -0800
+++ linux/drivers/net/tulip/de2104x.c	2005-04-01 20:10:25.323550440 -0800
@@ -1787,15 +1787,10 @@ static void __init de21041_get_srom_info
 	/* DEC now has a specification but early board makers
 	   just put the address in the first EEPROM locations. */
 	/* This does  memcmp(eedata, eedata+16, 8) */
-
-#ifndef CONFIG_MIPS_COBALT
-
 	for (i = 0; i < 8; i ++)
 		if (ee_data[i] != ee_data[16+i])
 			sa_offset = 20;
 
-#endif
-
 	/* store MAC address */
 	for (i = 0; i < 6; i ++)
 		de->dev->dev_addr[i] = ee_data[i + sa_offset];
@@ -1932,7 +1927,7 @@ bad_srom:
 	goto fill_defaults;
 }
 
-static int __init de_init_one (struct pci_dev *pdev,
+static int __devinit de_init_one (struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
 {
 	struct net_device *dev;
diff -Naurp linux.orig/drivers/net/tulip/de4x5.c linux/drivers/net/tulip/de4x5.c
--- linux.orig/drivers/net/tulip/de4x5.c	2005-03-18 09:37:38.000000000 -0800
+++ linux/drivers/net/tulip/de4x5.c	2005-04-01 20:10:25.854469728 -0800
@@ -2124,7 +2124,6 @@ static struct eisa_driver de4x5_eisa_dri
                 .remove  = __devexit_p (de4x5_eisa_remove),
         }
 };
-MODULE_DEVICE_TABLE(eisa, de4x5_eisa_ids);
 #endif
 
 #ifdef CONFIG_PCI
diff -Naurp linux.orig/drivers/net/tulip/media.c linux/drivers/net/tulip/media.c
--- linux.orig/drivers/net/tulip/media.c	2005-03-18 09:37:38.000000000 -0800
+++ linux/drivers/net/tulip/media.c	2005-04-01 20:10:26.553363480 -0800
@@ -44,8 +44,10 @@ static const unsigned char comet_miireg2
 
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
@@ -307,13 +309,29 @@ void tulip_select_media(struct net_devic
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
@@ -399,9 +417,6 @@ void tulip_select_media(struct net_devic
 	}
 
 	tp->csr6 = new_csr6 | (tp->csr6 & 0xfdff) | (tp->full_duplex ? 0x0200 : 0);
-
-	udelay(1000);
-
 	return;
 }
 
diff -Naurp linux.orig/drivers/net/tulip/tulip_core.c linux/drivers/net/tulip/tulip_core.c
--- linux.orig/drivers/net/tulip/tulip_core.c	2005-03-18 09:37:38.000000000 -0800
+++ linux/drivers/net/tulip/tulip_core.c	2005-04-01 20:10:27.003295080 -0800
@@ -22,7 +22,7 @@
 #else
 #define DRV_VERSION	"1.1.13"
 #endif
-#define DRV_RELDATE	"May 11, 2002"
+#define DRV_RELDATE	"December 15, 2004"
 
 
 #include <linux/module.h>
@@ -1514,8 +1514,8 @@ static int __devinit tulip_init_one (str
                     (PCI_SLOT(pdev->devfn) == 12))) {
                        /* Cobalt MAC address in first EEPROM locations. */
                        sa_offset = 0;
-		       /* Ensure our media table fixup get's applied */
-		       memcpy(ee_data + 16, ee_data, 8);
+                       /* No media table either */
+                       tp->flags &= ~HAS_MEDIA_TABLE;
                }
 #endif
 #ifdef CONFIG_GSC
diff -Naurp linux.orig/drivers/net/tulip/tulip.h linux/drivers/net/tulip/tulip.h
--- linux.orig/drivers/net/tulip/tulip.h	2005-03-18 09:37:38.000000000 -0800
+++ linux/drivers/net/tulip/tulip.h	2005-04-01 20:10:26.851318184 -0800
@@ -475,8 +475,11 @@ static inline void tulip_stop_rxtx(struc
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
 

--=_server-16900-1113239659-0001-2--
