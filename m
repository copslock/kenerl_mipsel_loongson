Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Jan 2005 11:50:47 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.189]:56569
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224844AbVA3Lub>; Sun, 30 Jan 2005 11:50:31 +0000
Received: from [212.227.126.160] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CvDb1-0007IV-00
	for linux-mips@linux-mips.org; Sun, 30 Jan 2005 12:50:27 +0100
Received: from [80.171.38.219] (helo=d038219.adsl.hansenet.de)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1CvDb1-0007Pf-00
	for linux-mips@linux-mips.org; Sun, 30 Jan 2005 12:50:27 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
To:	linux-mips@linux-mips.org
Subject: Re: bitrot in drivers/net/au1000_eth.c
Date:	Sun, 30 Jan 2005 12:50:53 +0100
User-Agent: KMail/1.7.1
References: <200501281501.19162.eckhardt@satorlaser.com>
In-Reply-To: <200501281501.19162.eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501301250.54188.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

I received a private reply from Herbert Valerio Riedel with a patch that falls 
into category

> 3. Split off the MII handling code or, better, reuse the facility already
> provided by drivers/net/mii.c. 

with the permission to forward the patch here. Here comes the code and some 
comments by him...

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>code>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

there's a nasty bug in the code, which triggers a kernel freeze when
performing MII ioctl's w/ mii-tool on a device which is down;

the following code fixes that, and uses the generic mii ioctl helper in
order to use proven code...

hope it's welcomed or useful :-)


Index: drivers/net/au1000_eth.c
===================================================================
--- drivers/net/au1000_eth.c (revision 25)
+++ drivers/net/au1000_eth.c (working copy)
@@ -91,7 +91,7 @@
 static void au1000_timer(unsigned long);
 static int au1000_ioctl(struct net_device *, struct ifreq *, int);
 static int mdio_read(struct net_device *, int, int);
-static void mdio_write(struct net_device *, int, int, u16);
+static void mdio_write(struct net_device *, int, int, int);
 static void dump_mii(struct net_device *dev, int phy_id);
 
 // externs
@@ -846,7 +846,7 @@
  return (int)*mii_data_reg;
 }
 
-static void mdio_write(struct net_device *dev, int phy_id, int reg, u16 
value)
+static void mdio_write(struct net_device *dev, int phy_id, int reg, int 
value)
 {
  struct au1000_private *aup = (struct au1000_private *) dev->priv;
  volatile u32 *mii_control_reg;
@@ -951,6 +951,10 @@
     aup->phy_ops = mii_chip_table[i].phy_ops;
     aup->phy_ops->phy_init(dev,phy_addr);
 
+    aup->mii_if.phy_id = phy_addr;
+    aup->mii_if.phy_id_mask = 0x1f;    
+    aup->mii_if.reg_num_mask = 0x1f;
+
     // Check for dual-phy and then store required 
     // values and set indicators. We need to do 
     // this now since mdio_{read,write} need the 
@@ -1544,6 +1548,10 @@
  aup->mii->mii_control_reg = 0;
  aup->mii->mii_data_reg = 0;
 
+        aup->mii_if.dev = dev;
+        aup->mii_if.mdio_read = mdio_read;
+        aup->mii_if.mdio_write = mdio_write;
+
  if (mii_probe(dev) != 0) {
   goto err_out;
  }
@@ -1592,6 +1600,7 @@
  dev->tx_timeout = au1000_tx_timeout;
  dev->watchdog_timeo = ETH_TX_TIMEOUT;
 
+
  /* 
   * The boot code uses the ethernet controller, so reset it to start 
   * fresh.  au1000_init() expects that the device is in reset state.
@@ -2127,24 +2136,17 @@
 
 static int au1000_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
- struct au1000_private *aup = (struct au1000_private *)dev->priv;
- u16 *data = (u16 *)&rq->ifr_ifru;
+ struct au1000_private *const aup = netdev_priv(dev);
+ int rc;
+ unsigned long flags;
 
- switch(cmd) { 
- case SIOCGMIIPHY:
-  data[0] = aup->phy_addr;
-  /* Fall through */
- case SIOCGMIIREG:
-  data[3] = mdio_read(dev, aup->phy_addr, data[1]);
-  return 0;
- case SIOCSMIIREG:
-  if (!capable(CAP_NET_ADMIN))
-   return -EPERM;
-  mdio_write(dev, aup->phy_addr, data[1], data[2]);
-  return 0;
- default:
-  return -EOPNOTSUPP;
- }
+ if (!netif_running(dev))
+  return -EINVAL;
+
+ spin_lock_irqsave(&aup->lock, flags);
+        rc = generic_mii_ioctl(&aup->mii_if, if_mii(rq), cmd, NULL);
+        spin_unlock_irqrestore(&aup->lock, flags);
+        return rc;
 }
 
 
Index: drivers/net/au1000_eth.h
===================================================================
--- drivers/net/au1000_eth.h (revision 25)
+++ drivers/net/au1000_eth.h (working copy)
@@ -214,6 +214,7 @@
  int mac_id;
  mii_phy_t *mii;
  struct phy_ops *phy_ops;
+ struct mii_if_info mii_if;
  
  /* These variables are just for quick access to certain regs addresses. */
  volatile mac_reg_t *mac;  /* mac registers                      */   
Index: drivers/net/Kconfig
===================================================================
--- drivers/net/Kconfig (revision 25)
+++ drivers/net/Kconfig (working copy)
@@ -467,6 +467,7 @@
  bool "MIPS AU1000 Ethernet support"
  depends on NET_ETHERNET && SOC_AU1X00
  select CRC32
+ select MII
  help
    If you have an Alchemy Semi AU1X00 based system
    say Y.  Otherwise, say N.
