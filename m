Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Dec 2004 11:13:57 +0000 (GMT)
Received: from dhcp-1285-65.blizz.at ([IPv6:::ffff:213.143.126.4]:31388 "EHLO
	cervus.intra") by linux-mips.org with ESMTP id <S8225011AbULaLNu>;
	Fri, 31 Dec 2004 11:13:50 +0000
Received: from xterm.intra ([10.49.1.10])
	by cervus.intra with esmtp (Exim 4.34)
	id 1CkKit-0000wa-UH; Fri, 31 Dec 2004 12:13:35 +0100
Subject: [PATCH] au1000_eth fixes/improvemetns for 2.6.x
From: Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
To: Pete Popov <ppopov@embeddedalley.com>
Cc: linux-mips@linux-mips.org
Content-Type: multipart/mixed; boundary="=-SbjMchTOA+UP6PYTb4TX"
Organization: Research Group for Industrial Software @ Vienna University of
	Technology
Date: Fri, 31 Dec 2004 12:13:33 +0100
Message-Id: <1104491614.9902.11.camel@xterm.intra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Return-Path: <hvr@inso.tuwien.ac.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@inso.tuwien.ac.at
Precedence: bulk
X-list: linux-mips


--=-SbjMchTOA+UP6PYTb4TX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

the following patch 

*) removes 'inline' for 'extern' declarations

*) fixes some nasty buffer overflow due to 
 sizeof (dev->dev_addr) > sizeof(au1000_mac_addr)' at least in 2.6.x

*) removes some unused symbols

*) generates random "local assigned" mac addresses instead of using the
hardcoded one

*) prints out the finally selected mac address on initialization

*) marks a few structs 'const'

*) doesn't segfault when no MII is detected...

regards,
-- 
Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
Research Group for Industrial Software @ Vienna University of Technology

--=-SbjMchTOA+UP6PYTb4TX
Content-Disposition: attachment; filename=au1000_eth.patch
Content-Type: text/x-patch; name=au1000_eth.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Index: au1000_eth.c
===================================================================
RCS file: /home/cvs/linux/drivers/net/au1000_eth.c,v
retrieving revision 1.39
diff -u -u -r1.39 au1000_eth.c
--- au1000_eth.c	26 Nov 2004 08:45:17 -0000	1.39
+++ au1000_eth.c	31 Dec 2004 11:12:00 -0000
@@ -95,11 +95,9 @@
 static void dump_mii(struct net_device *dev, int phy_id);
 
 // externs
-extern  void ack_rise_edge_irq(unsigned int);
 extern int get_ethernet_addr(char *ethernet_addr);
-extern inline void str2eaddr(unsigned char *ea, unsigned char *str);
-extern inline unsigned char str2hexnum(unsigned char c);
-extern char * __init prom_getcmdline(void);
+extern void str2eaddr(unsigned char *ea, unsigned char *str);
+extern char *__init prom_getcmdline(void);
 
 /*
  * Theory of operation
@@ -120,7 +118,7 @@
  * the mac address is, and the mac address is not passed on the
  * command line.
  */
-static unsigned char au1000_mac_addr[6] __devinitdata = { 
+static unsigned char au1000_mac_addr[ETH_ALEN] __devinitdata = { 
 	0x00, 0x50, 0xc2, 0x0c, 0x30, 0x00
 };
 
@@ -131,7 +129,7 @@
 #define cpu_to_dma32 cpu_to_be32
 #define dma32_to_cpu be32_to_cpu
 
-struct au1000_private *au_macs[NUM_ETH_INTERFACES];
+static struct au1000_private *au_macs[NUM_ETH_INTERFACES];
 
 /* FIXME 
  * All of the PHY code really should be detached from the MAC 
@@ -149,13 +147,6 @@
 	SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full | \
 	SUPPORTED_Autoneg
 
-static char *phy_link[] = 
-{	"unknown", 
-	"10Base2", "10BaseT", 
-	"AUI",
-	"100BaseT", "100BaseTX", "100BaseFX"
-};
-
 int bcm_5201_init(struct net_device *dev, int phy_addr)
 {
 	s16 data;
@@ -723,61 +714,61 @@
 }
 #endif
 
-struct phy_ops bcm_5201_ops = {
+const struct phy_ops bcm_5201_ops = {
 	bcm_5201_init,
 	bcm_5201_reset,
 	bcm_5201_status,
 };
 
-struct phy_ops am79c874_ops = {
+const struct phy_ops am79c874_ops = {
 	am79c874_init,
 	am79c874_reset,
 	am79c874_status,
 };
 
-struct phy_ops am79c901_ops = {
+const struct phy_ops am79c901_ops = {
 	am79c901_init,
 	am79c901_reset,
 	am79c901_status,
 };
 
-struct phy_ops lsi_80227_ops = { 
+const struct phy_ops lsi_80227_ops = { 
 	lsi_80227_init,
 	lsi_80227_reset,
 	lsi_80227_status,
 };
 
-struct phy_ops lxt971a_ops = { 
+const struct phy_ops lxt971a_ops = { 
 	lxt971a_init,
 	lxt971a_reset,
 	lxt971a_status,
 };
 
-struct phy_ops ks8995m_ops = {
+const struct phy_ops ks8995m_ops = {
 	ks8995m_init,
 	ks8995m_reset,
 	ks8995m_status,
 };
 
-struct phy_ops smsc_83C185_ops = {
+const struct phy_ops smsc_83C185_ops = {
 	smsc_83C185_init,
 	smsc_83C185_reset,
 	smsc_83C185_status,
 };
 
 #ifdef CONFIG_MIPS_BOSPORUS
-struct phy_ops stub_ops = {
+const struct phy_ops stub_ops = {
 	stub_init,
 	stub_reset,
 	stub_status,
 };
 #endif
 
-static struct mii_chip_info {
+const static struct mii_chip_info {
 	const char * name;
 	u16 phy_id0;
 	u16 phy_id1;
-	struct phy_ops *phy_ops;	
+	const struct phy_ops *phy_ops;	
 	int dual_phy;
 } mii_chip_table[] = {
 	{"Broadcom BCM5201 10/100 BaseT PHY",0x0040,0x6212, &bcm_5201_ops,0},
@@ -983,6 +974,10 @@
 			}
 		}
 	}
+
+	/* PHY not found */
+	printk(KERN_ERR "%s: Au1x No MII transceivers found!\n", dev->name);
+	return -1;
 found:
 
 #ifdef CONFIG_MIPS_BOSPORUS
@@ -1448,7 +1443,6 @@
 	struct net_device *dev = NULL;
 	db_dest_t *pDB, *pDBfree;
 	char *pmac, *argptr;
-	char ethaddr[6];
 	int i, err;
 
 	if (!request_mem_region(CPHYSADDR(ioaddr), MAC_IOSIZE, "Au1x00 ENET"))
@@ -1470,8 +1464,7 @@
 		return NULL;
 	}
 
-	printk("%s: Au1x Ethernet found at 0x%x, irq %d\n", 
-			dev->name, ioaddr, irq);
+	printk("%s: Au1x Ethernet found at 0x%x, irq %d\n", dev->name, ioaddr, irq);
 
 	aup = dev->priv;
 
@@ -1492,25 +1485,25 @@
 	/* Setup some variables for quick register address access */
 	if (ioaddr == iflist[0].base_addr)
 	{
+		char ethaddr[ETH_ALEN];
+
 		/* check env variables first */
 		if (!get_ethernet_addr(ethaddr)) { 
-			memcpy(au1000_mac_addr, ethaddr, sizeof(dev->dev_addr));
+			memcpy(au1000_mac_addr, ethaddr, ETH_ALEN);
 		} else {
 			/* Check command line */
 			argptr = prom_getcmdline();
 			if ((pmac = strstr(argptr, "ethaddr=")) == NULL) {
-				printk(KERN_INFO "%s: No mac address found\n", 
-						dev->name);
-				/* use the hard coded mac addresses */
+				printk(KERN_INFO "%s: No mac address found, generating random local assigned address\n", 
+				       dev->name);
+				random_ether_addr (au1000_mac_addr);
 			} else {
 				str2eaddr(ethaddr, pmac + strlen("ethaddr="));
-				memcpy(au1000_mac_addr, ethaddr, 
-						sizeof(dev->dev_addr));
+				memcpy(au1000_mac_addr, ethaddr, ETH_ALEN);
 			}
 		}
-			aup->enable = (volatile u32 *) 
-				((unsigned long)iflist[0].macen_addr);
-		memcpy(dev->dev_addr, au1000_mac_addr, sizeof(dev->dev_addr));
+		aup->enable = (volatile u32 *)((unsigned long)iflist[0].macen_addr);
+		memcpy(dev->dev_addr, au1000_mac_addr, ETH_ALEN);
 		setup_hw_rings(aup, MAC0_RX_DMA_ADDR, MAC0_TX_DMA_ADDR);
 		aup->mac_id = 0;
 		au_macs[0] = aup;
@@ -1518,10 +1511,9 @@
 		else
 	if (ioaddr == iflist[1].base_addr)
 	{
-			aup->enable = (volatile u32 *) 
-				((unsigned long)iflist[1].macen_addr);
-		memcpy(dev->dev_addr, au1000_mac_addr, sizeof(dev->dev_addr));
-		dev->dev_addr[4] += 0x10;
+		aup->enable = (volatile u32 *)((unsigned long)iflist[1].macen_addr);
+		memcpy(dev->dev_addr, au1000_mac_addr, ETH_ALEN);
+		dev->dev_addr[5] += 0x01;
 		setup_hw_rings(aup, MAC1_RX_DMA_ADDR, MAC1_TX_DMA_ADDR);
 		aup->mac_id = 1;
 		au_macs[1] = aup;
@@ -1531,6 +1523,11 @@
 		printk(KERN_ERR "%s: bad ioaddr\n", dev->name);
 	}
 
+	printk (KERN_INFO "%s: Using mac address ", dev->name);
+	for (i = 0; i < 5; i++)
+		printk("%2.2x:", dev->dev_addr[i]);
+	printk ("%2.2x\n", dev->dev_addr[i]);
+
 	/* bring the device out of reset, otherwise probing the mii
 	 * will hang */
 	*aup->enable = MAC_EN_CLOCK_ENABLE;
Index: au1000_eth.h
===================================================================
RCS file: /home/cvs/linux/drivers/net/au1000_eth.h,v
retrieving revision 1.10
diff -u -u -r1.10 au1000_eth.h
--- au1000_eth.h	18 Sep 2004 23:16:01 -0000	1.10
+++ au1000_eth.h	31 Dec 2004 11:12:00 -0000
@@ -142,7 +142,7 @@
 
 typedef struct mii_phy {
 	struct mii_phy * next;
-	struct mii_chip_info * chip_info;
+	const struct mii_chip_info * chip_info;
 	u16 status;
 	u32 *mii_control_reg;
 	u32 *mii_data_reg;
@@ -200,7 +200,6 @@
 
 
 struct au1000_private {
-	
 	db_dest_t *pDBfree;
 	db_dest_t db[NUM_RX_BUFFS+NUM_TX_BUFFS];
 	volatile rx_dma_t *rx_dma_ring[NUM_RX_DMA];
@@ -214,7 +213,7 @@
 
 	int mac_id;
 	mii_phy_t *mii;
-	struct phy_ops *phy_ops;
+	const struct phy_ops *phy_ops;
 	
 	/* These variables are just for quick access to certain regs addresses. */
 	volatile mac_reg_t *mac;  /* mac registers                      */   

--=-SbjMchTOA+UP6PYTb4TX--
