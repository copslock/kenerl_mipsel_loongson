Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2004 10:08:21 +0000 (GMT)
Received: from mail.romat.com ([IPv6:::ffff:212.143.245.3]:24587 "EHLO
	mail.romat.com") by linux-mips.org with ESMTP id <S8225197AbUKLKIL>;
	Fri, 12 Nov 2004 10:08:11 +0000
Received: from localhost (localhost.lan [127.0.0.1])
	by mail.romat.com (Postfix) with ESMTP id D1EA9EB2E2
	for <linux-mips@linux-mips.org>; Fri, 12 Nov 2004 12:07:23 +0200 (IST)
Received: from mail.romat.com ([127.0.0.1])
 by localhost (mail.romat.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17773-04 for <linux-mips@linux-mips.org>;
 Fri, 12 Nov 2004 12:07:18 +0200 (IST)
Received: from gilad (unknown [192.168.1.167])
	by mail.romat.com (Postfix) with SMTP id 8C109EB2B6
	for <linux-mips@linux-mips.org>; Fri, 12 Nov 2004 12:07:18 +0200 (IST)
Message-ID: <093401c4c89f$7e997d00$a701a8c0@lan>
From: "Gilad Rom" <gilad@romat.com>
To: <linux-mips@linux-mips.org>
Subject: [PATCH] Support for RTL8201BL PHY on Au1000
Date: Fri, 12 Nov 2004 12:06:42 +0200
Organization: Romat Telecom
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="windows-1255";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Virus-Scanned: by amavisd-new at romat.com
Return-Path: <gilad@romat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilad@romat.com
Precedence: bulk
X-list: linux-mips

Hello All,

Attached is a patch to support the RTL8201BL Phyceiver on the
AMD Alchemy Au1x, if anyone is interested. We use it here
for our own custom design.

Thank you,
Gilad Rom
Romat Telecom

--- linux-2.4.21-mycable.orig/drivers/net/au1000_eth.c 2004-11-10 
15:54:07.000000000 +0200
+++ linux-2.4.21-mycable/drivers/net/au1000_eth.c 2004-11-12 
12:01:10.000000000 +0200
@@ -330,8 +330,98 @@
 {
  return 0;
 }

+int rtl8201_init(struct net_device *dev, int phy_addr)
+{
+        s16 data;
+
+        /* Stop auto-negotiation */
+        data = mdio_read(dev, phy_addr, MII_CONTROL);
+        mdio_write(dev, phy_addr, MII_CONTROL, data & ~MII_CNTL_AUTO);
+
+        /* Set advertisement to 10/100 and Half/Full duplex
+         * (full capabilities) */
+        data = mdio_read(dev, phy_addr, MII_ANADV);
+        data |= MII_NWAY_TX | MII_NWAY_TX_FDX | MII_NWAY_T_FDX | 
MII_NWAY_T;
+        mdio_write(dev, phy_addr, MII_ANADV, data);
+
+        /* Restart auto-negotiation */
+        data = mdio_read(dev, phy_addr, MII_CONTROL);
+        data |= MII_CNTL_RST_AUTO | MII_CNTL_AUTO;
+        mdio_write(dev, phy_addr, MII_CONTROL, data);
+
+        if (au1000_debug > 4) dump_mii(dev, phy_addr);
+        return 0;
+}
+
+int rtl8201_reset(struct net_device *dev, int phy_addr)
+{
+        s16 mii_control, timeout;
+
+        if (au1000_debug > 4) {
+                printk("rtl8201_reset\n");
+                dump_mii(dev, phy_addr);
+        }
+
+        mii_control = mdio_read(dev, phy_addr, MII_CONTROL);
+        mdio_write(dev, phy_addr, MII_CONTROL, mii_control | 
MII_CNTL_RESET);
+        mdelay(1);
+        for (timeout = 100; timeout > 0; --timeout) {
+                mii_control = mdio_read(dev, phy_addr, MII_CONTROL);
+                if ((mii_control & MII_CNTL_RESET) == 0)
+                        break;
+                mdelay(1);
+        }
+        if (mii_control & MII_CNTL_RESET) {
+                printk(KERN_ERR "%s PHY reset timeout !\n", dev->name);
+                return -1;
+        }
+        return 0;
+}
+
+int
+rtl8201_status(struct net_device *dev, int phy_addr, u16 *link, u16 *speed)
+{
+        u16 mii_data;
+        struct au1000_private *aup;
+
+        if (!dev) {
+                printk(KERN_ERR "rtl8201_status error: NULL dev\n");
+                return -1;
+        }
+
+        aup = (struct au1000_private *) dev->priv;
+        mii_data = mdio_read(dev, aup->phy_addr, MII_STATUS);
+
+        if (mii_data & MII_STAT_LINK) {
+                *link = 1;
+                mii_data = mdio_read(dev, aup->phy_addr, MII_ANLPAR);
+
+                if (mii_data & MII_RTL_PHY_STAT_SPD) {
+                        if (mii_data & MII_RTL_PHY_STAT_FDX) {
+                                *speed = IF_PORT_100BASEFX;
+                                dev->if_port = IF_PORT_100BASEFX;
+                        }
+                        else {
+                                *speed = IF_PORT_100BASETX;
+                                dev->if_port = IF_PORT_100BASETX;
+                        }
+                }
+                else {
+                        *speed = IF_PORT_10BASET;
+                        dev->if_port = IF_PORT_10BASET;
+                }
+
+        }
+        else {
+                *link = 0;
+                *speed = 0;
+                dev->if_port = IF_PORT_UNKNOWN;
+        }
+        return 0;
+}
+
 int am79c874_init(struct net_device *dev, int phy_addr)
 {
  s16 data;

@@ -627,8 +717,14 @@
  am79c874_reset,
  am79c874_status,
 };

+struct phy_ops rtl8201_ops = {
+        rtl8201_init,
+        rtl8201_reset,
+        rtl8201_status,
+};
+
 struct phy_ops am79c901_ops = {
  am79c901_init,
  am79c901_reset,
  am79c901_status,
@@ -671,8 +767,9 @@
  {"Broadcom BCM5221 10/100 BaseT PHY",0x0040,0x61e4, &bcm_5201_ops,0},
  {"Broadcom BCM5222 10/100 BaseT PHY",0x0040,0x6322, &bcm_5201_ops,1},
  {"AMD 79C901 HomePNA PHY",0x0000,0x35c8, &am79c901_ops,0},
  {"AMD 79C874 10/100 BaseT PHY",0x0022,0x561b, &am79c874_ops,0},
+ {"RealTek 8201BL 10/100 BaseT Phyceiver",0x0000,0x8201, &rtl8201_ops, 0},
  {"LSI 80227 10/100 BaseT PHY",0x0016,0xf840, &lsi_80227_ops,0},
  {"Intel LXT971A Dual Speed PHY",0x0013,0x78e2, &lxt971a_ops,0},
  {"Kendin KS8995M 10/100 BaseT PHY",0x0022,0x1450, &ks8995m_ops,0},
 #ifdef CONFIG_MIPS_BOSPORUS
@@ -801,11 +898,9 @@
 static int mii_probe (struct net_device * dev)
 {
  struct au1000_private *aup = (struct au1000_private *) dev->priv;
  int phy_addr;
-#ifdef CONFIG_MIPS_BOSPORUS
  int phy_found=0;
-#endif

  /* search for total of 32 possible mii phy addresses */
  for (phy_addr = 0; phy_addr < 32; phy_addr++) {
   u16 mii_status;
@@ -820,9 +915,9 @@
   }
   #endif

   mii_status = mdio_read(dev, phy_addr, MII_STATUS);
-  if (mii_status == 0xffff || mii_status == 0x0000)
+  if (mii_status == 0xffff || mii_status == 0x0000)
    /* the mii is not accessable, try next one */
    continue;

   phy_id0 = mdio_read(dev, phy_addr, MII_PHY_ID0);
@@ -836,11 +931,9 @@

     printk(KERN_INFO "%s: %s at phy address %d\n",
            dev->name, mii_chip_table[i].name,
            phy_addr);
-#ifdef CONFIG_MIPS_BOSPORUS
     phy_found = 1;
-#endif
     mii_phy->chip_info = mii_chip_table+i;
     aup->phy_addr = phy_addr;
     aup->phy_ops = mii_chip_table[i].phy_ops;
     aup->phy_ops->phy_init(dev,phy_addr);
@@ -932,11 +1025,15 @@
     dev->name);
   return -1;
  }

- printk(KERN_INFO "%s: Using %s as default\n",
+ if ( (!phy_found) ) {
+  printk(KERN_INFO "%s: No PHY information available!\n",
+   dev->name);
+ } else {
+  printk(KERN_INFO "%s: Using %s as default\n",
    dev->name, aup->mii->chip_info->name);
-
+ }
  return 0;
 }


@@ -1361,8 +1458,9 @@
  }
  au_sync();

  aup->phy_ops->phy_status(dev, aup->phy_addr, &link, &speed);
+
  control = MAC_DISABLE_RX_OWN | MAC_RX_ENABLE | MAC_TX_ENABLE;
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
  control |= MAC_BIG_ENDIAN;
 #endif
@@ -1428,9 +1526,8 @@
  aup->timer.expires = RUN_AT((1*HZ));
  aup->timer.data = (unsigned long)dev;
  aup->timer.function = &au1000_timer; /* timer handler */
  add_timer(&aup->timer);
-
 }

 static int au1000_open(struct net_device *dev)
 {
--- linux-2.4.21-mycable.orig/drivers/net/au1000_eth.h 2004-11-10 
15:54:07.000000000 +0200
+++ linux-2.4.21-mycable/drivers/net/au1000_eth.h 2004-11-11 
17:59:21.000000000 +0200
@@ -129,8 +129,12 @@
 /* amd phy status register */
 #define MII_AMD_PHY_STAT_FDX 0x0800
 #define MII_AMD_PHY_STAT_SPD 0x0400

+/* realtek phy status register */
+#define MII_RTL_PHY_STAT_FDX 0x0100
+#define MII_RTL_PHY_STAT_SPD 0x0080
+
 /* intel phy status register */
 #define MII_INTEL_PHY_STAT_FDX 0x0200
 #define MII_INTEL_PHY_STAT_SPD 0x4000
