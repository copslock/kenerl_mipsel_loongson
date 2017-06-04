Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jun 2017 19:24:20 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:48772 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993875AbdFDRYJuUCmn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Jun 2017 19:24:09 +0200
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v54HMeoH021403
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Jun 2017 17:22:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v54HMVpW026719
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sun, 4 Jun 2017 17:22:31 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v54HMGlV032078;
        Sun, 4 Jun 2017 17:22:19 GMT
Received: from localhost.localdomain (/77.138.186.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 04 Jun 2017 10:22:15 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     klassert@mathematik.tu-chemnitz.de, pcnet32@frontier.com,
        hsweeten@visionengravers.com, jeffrey.t.kirsher@intel.com,
        cooldavid@cooldavid.org, mcuos.com@gmail.com, nic_swsd@realtek.com,
        ralf@linux-mips.org, romieu@fr.zoreil.com, nico@fluxnic.net,
        oneukum@suse.com, davem@davemloft.net, tremyfr@gmail.com,
        paul.gortmaker@windriver.com, yuval.shaia@oracle.com,
        jarod@redhat.com, green.hu@gmail.com, f.fainelli@gmail.com,
        edumazet@google.com, shchers@gmail.com, stephen.boyd@linaro.org,
        fgao@48lvckh6395k16k5.yundunddos.com, tklauser@distanz.ch,
        jay.vosburgh@canonical.com, robert.jarzmik@free.fr,
        jeremy.linton@arm.com, rmk+kernel@armlinux.org.uk,
        stephen@networkplumber.org, arnd@arndb.de, gerg@linux-m68k.org,
        allan@asix.com.tw, chris.roth@usask.ca, hayeswang@realtek.com,
        mario_limonciello@dell.com, netdev@vger.kernel.org,
        linux-parisc@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Subject: [PATCH] net/{mii,smsc}: Make mii_ethtool_get_link_ksettings and smc_netdev_get_ecmd return void
Date:   Sun,  4 Jun 2017 20:22:00 +0300
Message-Id: <20170604172200.4177-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.9.4
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <yuval.shaia@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuval.shaia@oracle.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Make return value void since functions never returns meaningfull value.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 drivers/net/cris/eth_v10.c                              |  5 ++---
 drivers/net/ethernet/3com/3c59x.c                       |  4 +++-
 drivers/net/ethernet/amd/pcnet32.c                      |  5 +----
 drivers/net/ethernet/cirrus/ep93xx_eth.c                |  5 ++++-
 drivers/net/ethernet/dec/tulip/winbond-840.c            |  5 ++---
 drivers/net/ethernet/faraday/ftmac100.c                 |  5 ++++-
 drivers/net/ethernet/fealnx.c                           |  5 ++---
 drivers/net/ethernet/intel/e100.c                       |  5 ++++-
 drivers/net/ethernet/jme.c                              |  5 ++---
 drivers/net/ethernet/korina.c                           |  5 ++---
 drivers/net/ethernet/micrel/ks8851.c                    |  5 ++++-
 drivers/net/ethernet/micrel/ks8851_mll.c                |  5 ++++-
 drivers/net/ethernet/nuvoton/w90p910_ether.c            |  5 ++++-
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c |  6 +++---
 drivers/net/ethernet/realtek/8139cp.c                   |  5 ++---
 drivers/net/ethernet/realtek/r8169.c                    |  4 +++-
 drivers/net/ethernet/sgi/ioc3-eth.c                     |  5 ++---
 drivers/net/ethernet/sis/sis190.c                       |  4 +++-
 drivers/net/ethernet/smsc/epic100.c                     |  5 ++---
 drivers/net/ethernet/smsc/smc911x.c                     |  7 +++----
 drivers/net/ethernet/smsc/smc91c92_cs.c                 | 13 +++++--------
 drivers/net/ethernet/smsc/smc91x.c                      |  7 ++-----
 drivers/net/ethernet/tundra/tsi108_eth.c                |  5 ++---
 drivers/net/ethernet/via/via-rhine.c                    |  5 ++---
 drivers/net/mii.c                                       |  8 ++------
 drivers/net/usb/ax88179_178a.c                          |  5 ++++-
 drivers/net/usb/r8152.c                                 |  2 +-
 drivers/net/usb/usbnet.c                                |  4 +++-
 include/linux/mii.h                                     |  2 +-
 29 files changed, 78 insertions(+), 73 deletions(-)

diff --git a/drivers/net/cris/eth_v10.c b/drivers/net/cris/eth_v10.c
index da02041..017f48c 100644
--- a/drivers/net/cris/eth_v10.c
+++ b/drivers/net/cris/eth_v10.c
@@ -1417,10 +1417,9 @@ static int e100_get_link_ksettings(struct net_device *dev,
 {
 	struct net_local *np = netdev_priv(dev);
 	u32 supported;
-	int err;
 
 	spin_lock_irq(&np->lock);
-	err = mii_ethtool_get_link_ksettings(&np->mii_if, cmd);
+	mii_ethtool_get_link_ksettings(&np->mii_if, cmd);
 	spin_unlock_irq(&np->lock);
 
 	/* The PHY may support 1000baseT, but the Etrax100 does not.  */
@@ -1432,7 +1431,7 @@ static int e100_get_link_ksettings(struct net_device *dev,
 	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
 						supported);
 
-	return err;
+	return 0;
 }
 
 static int e100_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/3com/3c59x.c b/drivers/net/ethernet/3com/3c59x.c
index e41245a..14cff60 100644
--- a/drivers/net/ethernet/3com/3c59x.c
+++ b/drivers/net/ethernet/3com/3c59x.c
@@ -2912,7 +2912,9 @@ static int vortex_get_link_ksettings(struct net_device *dev,
 {
 	struct vortex_private *vp = netdev_priv(dev);
 
-	return mii_ethtool_get_link_ksettings(&vp->mii, cmd);
+	mii_ethtool_get_link_ksettings(&vp->mii, cmd);
+
+	return 0;
 }
 
 static int vortex_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 86369d7..7f60d17 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -731,12 +731,10 @@ static int pcnet32_get_link_ksettings(struct net_device *dev,
 {
 	struct pcnet32_private *lp = netdev_priv(dev);
 	unsigned long flags;
-	int r = -EOPNOTSUPP;
 
 	spin_lock_irqsave(&lp->lock, flags);
 	if (lp->mii) {
 		mii_ethtool_get_link_ksettings(&lp->mii_if, cmd);
-		r = 0;
 	} else if (lp->chip_version == PCNET32_79C970A) {
 		if (lp->autoneg) {
 			cmd->base.autoneg = AUTONEG_ENABLE;
@@ -753,10 +751,9 @@ static int pcnet32_get_link_ksettings(struct net_device *dev,
 		ethtool_convert_legacy_u32_to_link_mode(
 						cmd->link_modes.supported,
 						SUPPORTED_TP | SUPPORTED_AUI);
-		r = 0;
 	}
 	spin_unlock_irqrestore(&lp->lock, flags);
-	return r;
+	return 0;
 }
 
 static int pcnet32_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
index 7a7c02f..e2a7029 100644
--- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
+++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
@@ -702,7 +702,10 @@ static int ep93xx_get_link_ksettings(struct net_device *dev,
 				     struct ethtool_link_ksettings *cmd)
 {
 	struct ep93xx_priv *ep = netdev_priv(dev);
-	return mii_ethtool_get_link_ksettings(&ep->mii, cmd);
+
+	mii_ethtool_get_link_ksettings(&ep->mii, cmd);
+
+	return 0;
 }
 
 static int ep93xx_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/dec/tulip/winbond-840.c b/drivers/net/ethernet/dec/tulip/winbond-840.c
index d1f2f3c..32d7229 100644
--- a/drivers/net/ethernet/dec/tulip/winbond-840.c
+++ b/drivers/net/ethernet/dec/tulip/winbond-840.c
@@ -1395,13 +1395,12 @@ static int netdev_get_link_ksettings(struct net_device *dev,
 				     struct ethtool_link_ksettings *cmd)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	int rc;
 
 	spin_lock_irq(&np->lock);
-	rc = mii_ethtool_get_link_ksettings(&np->mii_if, cmd);
+	mii_ethtool_get_link_ksettings(&np->mii_if, cmd);
 	spin_unlock_irq(&np->lock);
 
-	return rc;
+	return 0;
 }
 
 static int netdev_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethernet/faraday/ftmac100.c
index 1536356..66928a9 100644
--- a/drivers/net/ethernet/faraday/ftmac100.c
+++ b/drivers/net/ethernet/faraday/ftmac100.c
@@ -829,7 +829,10 @@ static int ftmac100_get_link_ksettings(struct net_device *netdev,
 				       struct ethtool_link_ksettings *cmd)
 {
 	struct ftmac100 *priv = netdev_priv(netdev);
-	return mii_ethtool_get_link_ksettings(&priv->mii, cmd);
+
+	mii_ethtool_get_link_ksettings(&priv->mii, cmd);
+
+	return 0;
 }
 
 static int ftmac100_set_link_ksettings(struct net_device *netdev,
diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
index 766636a..610f9c0 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -1821,13 +1821,12 @@ static int netdev_get_link_ksettings(struct net_device *dev,
 				     struct ethtool_link_ksettings *cmd)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	int rc;
 
 	spin_lock_irq(&np->lock);
-	rc = mii_ethtool_get_link_ksettings(&np->mii, cmd);
+	mii_ethtool_get_link_ksettings(&np->mii, cmd);
 	spin_unlock_irq(&np->lock);
 
-	return rc;
+	return 0;
 }
 
 static int netdev_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 2b7323d..4d10270 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2430,7 +2430,10 @@ static int e100_get_link_ksettings(struct net_device *netdev,
 				   struct ethtool_link_ksettings *cmd)
 {
 	struct nic *nic = netdev_priv(netdev);
-	return mii_ethtool_get_link_ksettings(&nic->mii, cmd);
+
+	mii_ethtool_get_link_ksettings(&nic->mii, cmd);
+
+	return 0;
 }
 
 static int e100_set_link_ksettings(struct net_device *netdev,
diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index f580b49..a70440b 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -2652,12 +2652,11 @@ jme_get_link_ksettings(struct net_device *netdev,
 		       struct ethtool_link_ksettings *cmd)
 {
 	struct jme_adapter *jme = netdev_priv(netdev);
-	int rc;
 
 	spin_lock_bh(&jme->phy_lock);
-	rc = mii_ethtool_get_link_ksettings(&jme->mii_if, cmd);
+	mii_ethtool_get_link_ksettings(&jme->mii_if, cmd);
 	spin_unlock_bh(&jme->phy_lock);
-	return rc;
+	return 0;
 }
 
 static int
diff --git a/drivers/net/ethernet/korina.c b/drivers/net/ethernet/korina.c
index 9fae98c..3c0a645 100644
--- a/drivers/net/ethernet/korina.c
+++ b/drivers/net/ethernet/korina.c
@@ -699,13 +699,12 @@ static int netdev_get_link_ksettings(struct net_device *dev,
 				     struct ethtool_link_ksettings *cmd)
 {
 	struct korina_private *lp = netdev_priv(dev);
-	int rc;
 
 	spin_lock_irq(&lp->lock);
-	rc = mii_ethtool_get_link_ksettings(&lp->mii_if, cmd);
+	mii_ethtool_get_link_ksettings(&lp->mii_if, cmd);
 	spin_unlock_irq(&lp->lock);
 
-	return rc;
+	return 0;
 }
 
 static int netdev_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/micrel/ks8851.c b/drivers/net/ethernet/micrel/ks8851.c
index 20358f8..2fe96f1 100644
--- a/drivers/net/ethernet/micrel/ks8851.c
+++ b/drivers/net/ethernet/micrel/ks8851.c
@@ -1071,7 +1071,10 @@ static int ks8851_get_link_ksettings(struct net_device *dev,
 				     struct ethtool_link_ksettings *cmd)
 {
 	struct ks8851_net *ks = netdev_priv(dev);
-	return mii_ethtool_get_link_ksettings(&ks->mii, cmd);
+
+	mii_ethtool_get_link_ksettings(&ks->mii, cmd);
+
+	return 0;
 }
 
 static int ks8851_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/micrel/ks8851_mll.c b/drivers/net/ethernet/micrel/ks8851_mll.c
index 7647f7b..f3e9dd4 100644
--- a/drivers/net/ethernet/micrel/ks8851_mll.c
+++ b/drivers/net/ethernet/micrel/ks8851_mll.c
@@ -1315,7 +1315,10 @@ static int ks_get_link_ksettings(struct net_device *netdev,
 				 struct ethtool_link_ksettings *cmd)
 {
 	struct ks_net *ks = netdev_priv(netdev);
-	return mii_ethtool_get_link_ksettings(&ks->mii, cmd);
+
+	mii_ethtool_get_link_ksettings(&ks->mii, cmd);
+
+	return 0;
 }
 
 static int ks_set_link_ksettings(struct net_device *netdev,
diff --git a/drivers/net/ethernet/nuvoton/w90p910_ether.c b/drivers/net/ethernet/nuvoton/w90p910_ether.c
index 159564d..89ab786 100644
--- a/drivers/net/ethernet/nuvoton/w90p910_ether.c
+++ b/drivers/net/ethernet/nuvoton/w90p910_ether.c
@@ -868,7 +868,10 @@ static int w90p910_get_link_ksettings(struct net_device *dev,
 				      struct ethtool_link_ksettings *cmd)
 {
 	struct w90p910_ether *ether = netdev_priv(dev);
-	return mii_ethtool_get_link_ksettings(&ether->mii, cmd);
+
+	mii_ethtool_get_link_ksettings(&ether->mii, cmd);
+
+	return 0;
 }
 
 static int w90p910_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c
index 2109327..731ce1e 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c
@@ -85,9 +85,8 @@ static int pch_gbe_get_link_ksettings(struct net_device *netdev,
 {
 	struct pch_gbe_adapter *adapter = netdev_priv(netdev);
 	u32 supported, advertising;
-	int ret;
 
-	ret = mii_ethtool_get_link_ksettings(&adapter->mii, ecmd);
+	mii_ethtool_get_link_ksettings(&adapter->mii, ecmd);
 
 	ethtool_convert_link_mode_to_legacy_u32(&supported,
 						ecmd->link_modes.supported);
@@ -104,7 +103,8 @@ static int pch_gbe_get_link_ksettings(struct net_device *netdev,
 
 	if (!netif_carrier_ok(adapter->netdev))
 		ecmd->base.speed = SPEED_UNKNOWN;
-	return ret;
+
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
index 72233ab..e7ab23e 100644
--- a/drivers/net/ethernet/realtek/8139cp.c
+++ b/drivers/net/ethernet/realtek/8139cp.c
@@ -1410,14 +1410,13 @@ static int cp_get_link_ksettings(struct net_device *dev,
 				 struct ethtool_link_ksettings *cmd)
 {
 	struct cp_private *cp = netdev_priv(dev);
-	int rc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&cp->lock, flags);
-	rc = mii_ethtool_get_link_ksettings(&cp->mii_if, cmd);
+	mii_ethtool_get_link_ksettings(&cp->mii_if, cmd);
 	spin_unlock_irqrestore(&cp->lock, flags);
 
-	return rc;
+	return 0;
 }
 
 static int cp_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 0a8f281..bd07a15 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -2148,7 +2148,9 @@ static int rtl8169_get_link_ksettings_xmii(struct net_device *dev,
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
 
-	return mii_ethtool_get_link_ksettings(&tp->mii, cmd);
+	mii_ethtool_get_link_ksettings(&tp->mii, cmd);
+
+	return 0;
 }
 
 static int rtl8169_get_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 52ead55..b607936 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -1562,13 +1562,12 @@ static int ioc3_get_link_ksettings(struct net_device *dev,
 				   struct ethtool_link_ksettings *cmd)
 {
 	struct ioc3_private *ip = netdev_priv(dev);
-	int rc;
 
 	spin_lock_irq(&ip->ioc3_lock);
-	rc = mii_ethtool_get_link_ksettings(&ip->mii, cmd);
+	mii_ethtool_get_link_ksettings(&ip->mii, cmd);
 	spin_unlock_irq(&ip->ioc3_lock);
 
-	return rc;
+	return 0;
 }
 
 static int ioc3_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/sis/sis190.c b/drivers/net/ethernet/sis/sis190.c
index 02da106..445109b 100644
--- a/drivers/net/ethernet/sis/sis190.c
+++ b/drivers/net/ethernet/sis/sis190.c
@@ -1739,7 +1739,9 @@ static int sis190_get_link_ksettings(struct net_device *dev,
 {
 	struct sis190_private *tp = netdev_priv(dev);
 
-	return mii_ethtool_get_link_ksettings(&tp->mii_if, cmd);
+	mii_ethtool_get_link_ksettings(&tp->mii_if, cmd);
+
+	return 0;
 }
 
 static int sis190_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/smsc/epic100.c b/drivers/net/ethernet/smsc/epic100.c
index db6dcb0..6a0e1d4 100644
--- a/drivers/net/ethernet/smsc/epic100.c
+++ b/drivers/net/ethernet/smsc/epic100.c
@@ -1391,13 +1391,12 @@ static int netdev_get_link_ksettings(struct net_device *dev,
 				     struct ethtool_link_ksettings *cmd)
 {
 	struct epic_private *np = netdev_priv(dev);
-	int rc;
 
 	spin_lock_irq(&np->lock);
-	rc = mii_ethtool_get_link_ksettings(&np->mii, cmd);
+	mii_ethtool_get_link_ksettings(&np->mii, cmd);
 	spin_unlock_irq(&np->lock);
 
-	return rc;
+	return 0;
 }
 
 static int netdev_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/smsc/smc911x.c b/drivers/net/ethernet/smsc/smc911x.c
index 36307d3..0515744 100644
--- a/drivers/net/ethernet/smsc/smc911x.c
+++ b/drivers/net/ethernet/smsc/smc911x.c
@@ -1450,7 +1450,7 @@ smc911x_ethtool_get_link_ksettings(struct net_device *dev,
 				   struct ethtool_link_ksettings *cmd)
 {
 	struct smc911x_local *lp = netdev_priv(dev);
-	int ret, status;
+	int status;
 	unsigned long flags;
 	u32 supported;
 
@@ -1458,7 +1458,7 @@ smc911x_ethtool_get_link_ksettings(struct net_device *dev,
 
 	if (lp->phy_type != 0) {
 		spin_lock_irqsave(&lp->lock, flags);
-		ret = mii_ethtool_get_link_ksettings(&lp->mii, cmd);
+		mii_ethtool_get_link_ksettings(&lp->mii, cmd);
 		spin_unlock_irqrestore(&lp->lock, flags);
 	} else {
 		supported = SUPPORTED_10baseT_Half |
@@ -1480,10 +1480,9 @@ smc911x_ethtool_get_link_ksettings(struct net_device *dev,
 		ethtool_convert_legacy_u32_to_link_mode(
 			cmd->link_modes.supported, supported);
 
-		ret = 0;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int
diff --git a/drivers/net/ethernet/smsc/smc91c92_cs.c b/drivers/net/ethernet/smsc/smc91c92_cs.c
index 976aa87..92c927a 100644
--- a/drivers/net/ethernet/smsc/smc91c92_cs.c
+++ b/drivers/net/ethernet/smsc/smc91c92_cs.c
@@ -1843,8 +1843,8 @@ static int smc_link_ok(struct net_device *dev)
     }
 }
 
-static int smc_netdev_get_ecmd(struct net_device *dev,
-			       struct ethtool_link_ksettings *ecmd)
+static void smc_netdev_get_ecmd(struct net_device *dev,
+				struct ethtool_link_ksettings *ecmd)
 {
 	u16 tmp;
 	unsigned int ioaddr = dev->base_addr;
@@ -1865,8 +1865,6 @@ static int smc_netdev_get_ecmd(struct net_device *dev,
 
 	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.supported,
 						supported);
-
-	return 0;
 }
 
 static int smc_netdev_set_ecmd(struct net_device *dev,
@@ -1918,18 +1916,17 @@ static int smc_get_link_ksettings(struct net_device *dev,
 	struct smc_private *smc = netdev_priv(dev);
 	unsigned int ioaddr = dev->base_addr;
 	u16 saved_bank = inw(ioaddr + BANK_SELECT);
-	int ret;
 	unsigned long flags;
 
 	spin_lock_irqsave(&smc->lock, flags);
 	SMC_SELECT_BANK(3);
 	if (smc->cfg & CFG_MII_SELECT)
-		ret = mii_ethtool_get_link_ksettings(&smc->mii_if, ecmd);
+		mii_ethtool_get_link_ksettings(&smc->mii_if, ecmd);
 	else
-		ret = smc_netdev_get_ecmd(dev, ecmd);
+		smc_netdev_get_ecmd(dev, ecmd);
 	SMC_SELECT_BANK(saved_bank);
 	spin_unlock_irqrestore(&smc->lock, flags);
-	return ret;
+	return 0;
 }
 
 static int smc_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 91e9bd7..0d230b1 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -1539,11 +1539,10 @@ smc_ethtool_get_link_ksettings(struct net_device *dev,
 			       struct ethtool_link_ksettings *cmd)
 {
 	struct smc_local *lp = netdev_priv(dev);
-	int ret;
 
 	if (lp->phy_type != 0) {
 		spin_lock_irq(&lp->lock);
-		ret = mii_ethtool_get_link_ksettings(&lp->mii, cmd);
+		mii_ethtool_get_link_ksettings(&lp->mii, cmd);
 		spin_unlock_irq(&lp->lock);
 	} else {
 		u32 supported = SUPPORTED_10baseT_Half |
@@ -1562,11 +1561,9 @@ smc_ethtool_get_link_ksettings(struct net_device *dev,
 
 		ethtool_convert_legacy_u32_to_link_mode(
 			cmd->link_modes.supported, supported);
-
-		ret = 0;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int
diff --git a/drivers/net/ethernet/tundra/tsi108_eth.c b/drivers/net/ethernet/tundra/tsi108_eth.c
index 5ac6eaa..c2d15d9 100644
--- a/drivers/net/ethernet/tundra/tsi108_eth.c
+++ b/drivers/net/ethernet/tundra/tsi108_eth.c
@@ -1504,13 +1504,12 @@ static int tsi108_get_link_ksettings(struct net_device *dev,
 {
 	struct tsi108_prv_data *data = netdev_priv(dev);
 	unsigned long flags;
-	int rc;
 
 	spin_lock_irqsave(&data->txlock, flags);
-	rc = mii_ethtool_get_link_ksettings(&data->mii_if, cmd);
+	mii_ethtool_get_link_ksettings(&data->mii_if, cmd);
 	spin_unlock_irqrestore(&data->txlock, flags);
 
-	return rc;
+	return 0;
 }
 
 static int tsi108_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/ethernet/via/via-rhine.c b/drivers/net/ethernet/via/via-rhine.c
index 4cf41f7..acd29d6 100644
--- a/drivers/net/ethernet/via/via-rhine.c
+++ b/drivers/net/ethernet/via/via-rhine.c
@@ -2307,13 +2307,12 @@ static int netdev_get_link_ksettings(struct net_device *dev,
 				     struct ethtool_link_ksettings *cmd)
 {
 	struct rhine_private *rp = netdev_priv(dev);
-	int rc;
 
 	mutex_lock(&rp->task_lock);
-	rc = mii_ethtool_get_link_ksettings(&rp->mii_if, cmd);
+	mii_ethtool_get_link_ksettings(&rp->mii_if, cmd);
 	mutex_unlock(&rp->task_lock);
 
-	return rc;
+	return 0;
 }
 
 static int netdev_set_link_ksettings(struct net_device *dev,
diff --git a/drivers/net/mii.c b/drivers/net/mii.c
index 6d953c5..44612122 100644
--- a/drivers/net/mii.c
+++ b/drivers/net/mii.c
@@ -141,11 +141,9 @@ int mii_ethtool_gset(struct mii_if_info *mii, struct ethtool_cmd *ecmd)
  *
  * The @cmd parameter is expected to have been cleared before calling
  * mii_ethtool_get_link_ksettings().
- *
- * Returns 0 for success, negative on error.
  */
-int mii_ethtool_get_link_ksettings(struct mii_if_info *mii,
-				   struct ethtool_link_ksettings *cmd)
+void mii_ethtool_get_link_ksettings(struct mii_if_info *mii,
+				    struct ethtool_link_ksettings *cmd)
 {
 	struct net_device *dev = mii->dev;
 	u16 bmcr, bmsr, ctrl1000 = 0, stat1000 = 0;
@@ -227,8 +225,6 @@ int mii_ethtool_get_link_ksettings(struct mii_if_info *mii,
 						lp_advertising);
 
 	/* ignore maxtxpkt, maxrxpkt for now */
-
-	return 0;
 }
 
 /**
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 51cf600..793ce90 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -624,7 +624,10 @@ static int ax88179_get_link_ksettings(struct net_device *net,
 				      struct ethtool_link_ksettings *cmd)
 {
 	struct usbnet *dev = netdev_priv(net);
-	return mii_ethtool_get_link_ksettings(&dev->mii, cmd);
+
+	mii_ethtool_get_link_ksettings(&dev->mii, cmd);
+
+	return 0;
 }
 
 static int ax88179_set_link_ksettings(struct net_device *net,
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index ddc62cb..effa7a22 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3841,7 +3841,7 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
 
 	mutex_lock(&tp->control);
 
-	ret = mii_ethtool_get_link_ksettings(&tp->mii, cmd);
+	mii_ethtool_get_link_ksettings(&tp->mii, cmd);
 
 	mutex_unlock(&tp->control);
 
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 79048e7..6510e5c 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -956,7 +956,9 @@ int usbnet_get_link_ksettings(struct net_device *net,
 	if (!dev->mii.mdio_read)
 		return -EOPNOTSUPP;
 
-	return mii_ethtool_get_link_ksettings(&dev->mii, cmd);
+	mii_ethtool_get_link_ksettings(&dev->mii, cmd);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(usbnet_get_link_ksettings);
 
diff --git a/include/linux/mii.h b/include/linux/mii.h
index 1629a0c..e870bfa 100644
--- a/include/linux/mii.h
+++ b/include/linux/mii.h
@@ -31,7 +31,7 @@ struct mii_if_info {
 extern int mii_link_ok (struct mii_if_info *mii);
 extern int mii_nway_restart (struct mii_if_info *mii);
 extern int mii_ethtool_gset(struct mii_if_info *mii, struct ethtool_cmd *ecmd);
-extern int mii_ethtool_get_link_ksettings(
+extern void mii_ethtool_get_link_ksettings(
 	struct mii_if_info *mii, struct ethtool_link_ksettings *cmd);
 extern int mii_ethtool_sset(struct mii_if_info *mii, struct ethtool_cmd *ecmd);
 extern int mii_ethtool_set_link_ksettings(
-- 
2.9.4
