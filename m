Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2005 13:04:51 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.191]:44782
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226713AbVCVNEe>; Tue, 22 Mar 2005 13:04:34 +0000
Received: from [212.227.126.155] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DDj3h-00040K-00; Tue, 22 Mar 2005 14:04:33 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DDj3g-0005gW-00; Tue, 22 Mar 2005 14:04:32 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: [patch] repair failed merges of 2.6.12 in au1000_eth.c
Date:	Tue, 22 Mar 2005 14:04:39 +0100
User-Agent: KMail/1.7.1
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503221404.40050.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Hi!

Seems a few things went wrong merging 2.6.12 into the l-m.o CVS, leading to 
code duplication. The compiler complains about an unbalanced #ifdef.

Uli

Changes:
 * repair wrong merges of changes from 2.6.12
 * remove an unused variable an an unnecessary set of brackets

---
Index: drivers/net/au1000_eth.c
===================================================================
RCS file: /home/cvs/linux/drivers/net/au1000_eth.c,v
retrieving revision 1.43
diff -u -w -r1.43 au1000_eth.c
--- drivers/net/au1000_eth.c 18 Mar 2005 17:37:32 -0000 1.43
+++ drivers/net/au1000_eth.c 22 Mar 2005 11:56:10 -0000
@@ -990,67 +990,7 @@
     the stub will be found as well as the actual PHY. However,
     the last found PHY will be used... usually at Addr 31 (Db1500). 
  */
- if ( (!phy_found) )
- {
-  u16 phy_id0, phy_id1;
-  int i;
-
-  phy_id0 = 0x1234;
-  phy_id1 = 0x5678;
-
-  /* search our mii table for the current mii */ 
-  for (i = 0; mii_chip_table[i].phy_id1; i++) {
-   if (phy_id0 == mii_chip_table[i].phy_id0 &&
-       phy_id1 == mii_chip_table[i].phy_id1) {
-    struct mii_phy * mii_phy = aup->mii;
-
-    printk(KERN_INFO "%s: %s at phy address %d\n",
-           dev->name, mii_chip_table[i].name, 
-           phy_addr);
-#ifdef CONFIG_MIPS_BOSPORUS
-    phy_found = 1;
-#endif
-    mii_phy->chip_info = mii_chip_table+i;
-    aup->phy_addr = phy_addr;
-    aup->want_autoneg = 1;
-    aup->phy_ops = mii_chip_table[i].phy_ops;
-    aup->phy_ops->phy_init(dev,phy_addr);
-
-    // Check for dual-phy and then store required 
-    // values and set indicators. We need to do 
-    // this now since mdio_{read,write} need the 
-    // control and data register addresses.
-    #ifdef CONFIG_BCM5222_DUAL_PHY
-    if ( mii_chip_table[i].dual_phy) {
-
-     /* assume both phys are controlled 
-      * through MAC0. Board specific? */
-     
-     /* sanity check */
-     if (!au_macs[0] || !au_macs[0]->mii)
-      return -1;
-     aup->mii->mii_control_reg = (u32 *)
-      &au_macs[0]->mac->mii_control;
-     aup->mii->mii_data_reg = (u32 *)
-      &au_macs[0]->mac->mii_data;
-    }
-    #endif
-    goto found;
-   }
-  }
- }
-found:
-
-#ifdef CONFIG_MIPS_BOSPORUS
- /* This is a workaround for the Micrel/Kendin 5 port switch
-    The second MAC doesn't see a PHY connected... so we need to
-    trick it into thinking we have one.
-  
-    If this kernel is run on another Au1500 development board
-    the stub will be found as well as the actual PHY. However,
-    the last found PHY will be used... usually at Addr 31 (Db1500). 
- */
- if ( (!phy_found) )
+ if ( !phy_found)
  {
   u16 phy_id0, phy_id1;
   int i;
@@ -1841,7 +1781,6 @@
 
 static int au1000_close(struct net_device *dev)
 {
- int i;
  u32 flags;
  struct au1000_private *aup = (struct au1000_private *) dev->priv;
 
@@ -2159,23 +2098,6 @@
     return crc;
 }
 
-
-static unsigned const ethernet_polynomial = 0x04c11db7U;
-static inline u32 ether_crc(int length, unsigned char *data)
-{
-    int crc = -1;
-
-    while(--length >= 0) {
-  unsigned char current_octet = *data++;
-  int bit;
-  for (bit = 0; bit < 8; bit++, current_octet >>= 1)
-   crc = (crc << 1) ^
-    ((crc < 0) ^ (current_octet & 1) ? 
-     ethernet_polynomial : 0);
-    }
-    return crc;
-}
-
 static void set_rx_mode(struct net_device *dev)
 {
  struct au1000_private *aup = (struct au1000_private *) dev->priv;
